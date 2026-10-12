/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung - DWH / MIS
#----------------------------------------------------------------------------
# Script: ldl_fact_fraud_detection_return_same_receipt.sql
#----------------------------------------------------------------------------
# History:
#  1.0  30.09.2024  Mihail Ivanov  - ZKP GF_1 - Initial implementation
		UserStory 
			https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-INTEGER/_workitems/edit/33405/
			"ZKP: Mehrfache Geldrückgabe mit gleichem Originalbon"
		Setting the following flags:
			RETURN_SAME_RECEIPT_FG
			
#  1.1  21.11.2024  Mihail Ivanov  - added filter TURNOVER_RELEVANT_FG = TRUE -- this eliminates cancelled (aborted) and suspended receipts too

#  1.2  17.01.2025  Mihail Ivanov  - First return is not marked as suspicious. Only the following returns
									requetest here: https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-INTEGER/_workitems/edit/63029
									
#  1.3  18.03.2025  Mihail Ivanov  - bugfix: https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-INTEGER/_workitems/edit/67057
										threshold for return amount is compared now to the sum of retail_lines -  RETAIL_LINE_GROSS_VAL (instead of the amount in the header - TXN_GROSS_VAL)
										also if one of the returns passes the threshold, all returns with this purchase event are evaluated

#  1.4  27.03.2025  Mihail Ivanov  - Changes:
						- added logic to set the flag only in scenario is enabled in a country_1 (and remove the flag if scenario is disabled)
							https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-INTEGER/_workitems/edit/63803
						- removed columns that were only relevant for "storno" scenarios

#  1.5  03.04.2025  Mihail Ivanov  - Changes:
						Removing flag if scenario is disabled is moved out of this script to the main script

#  1.6  23.04.2025  Kamil Roszczyk - Changes:
						- added 'all return items are not on the follow-up receipt after the return' logic
							https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-INTEGER/_workitems/edit/68261
*/ 
/* it is possible that one return happend in the delta period, but long before there was another return with same original receipt */ /* so first we take returns in the delta, get their original purchase,  and then look for other retuns with  same original purchase */ /*  I do this in separate temporary table, because I want this part to be executed first */ /* 		and use the result as filter for "All Returns" in T_PRODUCT_RETAIL_LINE_1 */ /*  When I put everything in one query, the optiimizer sometimes starts first with T_PRODUCT_RETAIL_LINE_1 ("All returns") */ /*		And it applies no filter to it, so all partitions read (nothing is pruned) */ /*  This is very ineffective and we want to avoid it. */
 
DECLARE SV_PURCH_MIN_DT STRING; 
CREATE OR REPLACE TEMPORARY TABLE t_tmp_orig_purchase AS
SELECT DISTINCT
  purch_e.retail_event_sid,
  purch_e.bus_dt,
  purch_e.country_org_cd
FROM ${fwrk_work_db}.vt1
INNER JOIN ldl_data_production.core_rel.t_product_retail_line_1 AS ret_l
  ON ret_l.bus_dt = vt1.dwh_cal_dt
  AND ret_l.country_org_cd = vt1.country_cd
  AND ret_l.store_sid = vt1.loc_sid
INNER JOIN ldl_data_production.core_rel.t_retail_event_1 AS purch_e
  ON purch_e.retail_event_sid = ret_l.orig_sales_event_sid
WHERE
  CAST('1' AS NUMERIC) = CAST('1' AS NUMERIC)
  AND /* delta */ ret_l.bus_dt BETWEEN $min_dwh_cal_dt AND $max_dwh_cal_dt
  AND ret_l.prod_retail_line_type_cd IN ('R', 'RD')
  AND ret_l.turnover_relevant_fg = TRUE /* this eliminates cancelled (aborted) and suspended receipts too */
  AND purch_e.retail_event_type_cd = 'S';

  /* again, workaround to force snowflake to filter "All Returns" by some date, instead of reading the full table */ /* in a perfect world, optimizer would be able to do this on its own and I wouldn't have to do it manually */ /* but as of Sept 2024 we need this. */
SET sv_purch_min_dt = (
  SELECT
    format('YYYY-MM_1-% 3.0f', MIN(t_tmp_orig_purchase.bus_dt))
  FROM t_tmp_orig_purchase
);

CREATE OR REPLACE TEMPORARY TABLE t_tmp_return_receipts AS
WITH mat_params AS (
  SELECT
    * /* we will join with the Param-View several times, so we want to trick snowflake to query it once, materialize the result and reuse it */ /* we want to avoid querying the view 3 times because it involves T_INTERNAL_ORGANIZATION_1, we have a policy there, and we want to reduce how many times the policy is evaluated */
  FROM ldl_data_production.core_app_fraud_detection.v_fraud_detection_parameter_current_value_1
  WHERE
    v_fraud_detection_parameter_current_value.scenario_id = CAST('8' /* US:33405, flag: RETURN_SAME_RECEIPT_FG, "ZKP: Mehrfache Geldrückgabe mit gleichem Originalbon" */ AS NUMERIC)
)
SELECT
  ar_e.retail_event_sid AS ret_retail_event_sid,
  ANY_VALUE(ar_e.cash_register_event_nr) AS cash_register_event_nr,
  ANY_VALUE(ar_e.event_start_tmsp) AS event_start_tmsp,
  ANY_VALUE(ar_e.event_end_tmsp) AS event_end_tmsp,
  ANY_VALUE(ar_e.bus_dt) AS bus_dt,
  ANY_VALUE(ar_e.cash_register_sid) AS cash_register_sid,
  ANY_VALUE(cr.cash_register_nr) AS cash_register_nr,
  ANY_VALUE(ar_e.store_sid) AS store_sid,
  ANY_VALUE(ar_e.cashier_hash) AS cashier_hash,
  ANY_VALUE(ar_e.txn_net_val) AS txn_net_val,
  ANY_VALUE(ar_e.txn_gross_val) AS txn_gross_val,
  ANY_VALUE(ar_e.curr_cd) AS curr_cd,
  ANY_VALUE(ce.cashier_nr) AS cashier_nr,
  ANY_VALUE(ar_e.country_org_cd) AS country_org_cd,
  op.retail_event_sid AS orig_purch_retail_event_sid,
  ar_l.local_prod_nr,
  sum(ar_l.retail_line_gross_val) AS product_lines_gross_val, /* Calculating the sum of all lines of each separate product... */
  abs(sum(sum(ar_l.retail_line_gross_val)) OVER (PARTITION BY ar_e.retail_event_sid)) AS return_gross_val, /* ...and here using this calculation as a base for the sum of all products in a return receipt */
  ANY_VALUE(ret_cnt.param_val_qty) AS param_min_returns_cnt,
  ANY_VALUE(ret_val.param_val_qty) AS param_min_return_gross_val,
  IF(
    abs(sum(sum(ar_l.retail_line_gross_val)) OVER (PARTITION BY ar_e.retail_event_sid)) >= ANY_VALUE(ret_val.param_val_qty),
    CAST('1' AS NUMERIC),
    CAST('0' AS NUMERIC)
  ) AS receipt_passed_amount_threshold_fg
FROM t_tmp_orig_purchase AS op
INNER JOIN ldl_data_production.core_rel.t_product_retail_line_1 AS ar_l /* all returns (lines) with same ORIG purchase */
  ON ar_l.orig_sales_event_sid = op.retail_event_sid
  AND /* little trick for performance. After all, a return cannot happen at earlier date than the purchase date */ ar_l.bus_dt >= op.bus_dt
  AND ar_l.bus_dt >= $sv_purch_min_dt
  AND ar_l.country_org_cd = op.country_org_cd
INNER JOIN ldl_data_production.core_rel.t_retail_event_1 AS ar_e /* all retunrs (event) with same Orig Purchase */
  ON ar_e.retail_event_sid = ar_l.retail_event_sid
  AND ar_e.bus_dt = ar_l.bus_dt
  AND ar_e.country_org_cd = ar_l.country_org_cd
INNER JOIN mat_params AS ret_val /* "Return Value" - parameter how many returns with same receipt */
  ON ret_val.country_org_cd = ar_e.country_org_cd
  AND ret_val.param_id = CAST('25' AS NUMERIC)
  AND /* if scneario is not enabled all receipts from that country_1 will be eliminated in the inner join */ ret_val.is_scenario_enabled_in_country_fg = TRUE
INNER JOIN mat_params AS ret_cnt /* "Returns Count" - parameter how many returns with same receipt */
  ON ret_cnt.country_org_cd = ar_e.country_org_cd
  AND ret_cnt.param_id = CAST('24' AS NUMERIC)
  AND /* if scneario is not enabled all receipts from that country_1 will be eliminated in the inner join */ ret_cnt.is_scenario_enabled_in_country_fg = TRUE
INNER JOIN ldl_data_production.core_rel.t_cash_register_1 AS cr
  ON ar_e.cash_register_sid = cr.cash_register_sid AND cr.dwh_valid_fg = TRUE
LEFT OUTER JOIN ldl_data_production.core_app_fraud_detection.t_cashier_encryption_1 AS ce
  ON ce.cashier_hash = ar_e.cashier_hash
WHERE
  CAST('1' AS NUMERIC) = CAST('1' AS NUMERIC)
  AND ar_l.prod_retail_line_type_cd IN ('R', 'RD')
  AND ar_l.turnover_relevant_fg = TRUE
  AND ar_e.retail_event_type_cd = 'R'
  AND ar_e.turnover_relevant_fg = TRUE
GROUP BY
  1,
  15,
  16;

INSERT INTO ldl_data_production.etl.t_fact_fraud_detection_by_cash_register_event_final (
  cash_register_event_sid,
  cash_register_event_nr,
  event_start_tmsp,
  bus_dt,
  cash_register_sid,
  cash_register_nr,
  store_sid,
  cashier_hash,
  txn_net_val,
  txn_gross_val,
  curr_cd,
  return_same_receipt_fg
)
WITH all_return_headers AS (
  SELECT DISTINCT
    t_tmp_return_receipts.ret_retail_event_sid, /* T_TMP_RETURN_RECEIPTS is a table on a product level so we need distinctive receipt header information from it to avoid duplicates */
    t_tmp_return_receipts.cash_register_event_nr,
    t_tmp_return_receipts.bus_dt,
    t_tmp_return_receipts.cash_register_sid,
    t_tmp_return_receipts.cashier_nr,
    t_tmp_return_receipts.country_org_cd
  FROM t_tmp_return_receipts
), purch_day_and_register_of_return AS (
  SELECT
    re.retail_event_sid, /* Prequalifying potential followers of return receipts (sales_1 receipts of same day, cash register and country_1 as a return receipt) */
    re.cash_register_event_nr,
    re.bus_dt,
    re.cash_register_sid,
    ce.cashier_nr
  FROM ldl_data_production.core_rel.t_retail_event_1 AS re_1
  INNER JOIN ldl_data_production.core_app_fraud_detection.t_cashier_encryption_1 AS ce
    ON ce.cashier_hash = re.cashier_hash
  WHERE
    re.retail_event_type_cd = 'S'
    AND re.turnover_relevant_fg = TRUE
    AND EXISTS(
      SELECT
        CAST('1' AS NUMERIC)
      FROM all_return_headers AS arh
      WHERE
        arh.bus_dt = re.bus_dt
        AND arh.cash_register_sid = re.cash_register_sid
        AND arh.country_org_cd = re.country_org_cd
    )
), purch_event_after_return AS (
  SELECT
    arh.ret_retail_event_sid, /* Qualifying the 'purchase after return' receipt. If not available, par_retail_event_sid is null, hence the left join in the logic */
    par.retail_event_sid AS par_retail_event_sid
  FROM all_return_headers AS arh
  LEFT OUTER JOIN purch_day_and_register_of_return AS par
    ON par.bus_dt = arh.bus_dt
    AND par.cashier_nr = arh.cashier_nr
    AND par.cash_register_sid = arh.cash_register_sid
    AND par.cash_register_event_nr > arh.cash_register_event_nr
  QUALIFY
    row_number() OVER (
      PARTITION BY arh.ret_retail_event_sid
      ORDER BY IF(par.cash_register_event_nr IS NULL, 0, 1) DESC, par.cash_register_event_nr
    ) = CAST('1' AS NUMERIC)
), purch_products_after_return_event AS (
  SELECT DISTINCT
    par.ret_retail_event_sid, /* Appending the list of products in purchase after return */
    par.par_retail_event_sid,
    prl.local_prod_nr
  FROM purch_event_after_return AS par
  INNER JOIN ldl_data_production.core_rel.t_product_retail_line_1 AS prl
    ON prl.retail_event_sid = par.par_retail_event_sid
), return_events_calc AS (
  SELECT
    rr.ret_retail_event_sid,
    ANY_VALUE(rr.cash_register_event_nr) AS cash_register_event_nr,
    ANY_VALUE(rr.event_start_tmsp) AS event_start_tmsp,
    ANY_VALUE(rr.event_end_tmsp) AS event_end_tmsp,
    ANY_VALUE(rr.bus_dt) AS bus_dt,
    ANY_VALUE(rr.cash_register_sid) AS cash_register_sid,
    ANY_VALUE(rr.cash_register_nr) AS cash_register_nr,
    ANY_VALUE(rr.store_sid) AS store_sid,
    ANY_VALUE(rr.cashier_hash) AS cashier_hash,
    ANY_VALUE(rr.txn_net_val) AS txn_net_val,
    ANY_VALUE(rr.txn_gross_val) AS txn_gross_val,
    ANY_VALUE(rr.curr_cd) AS curr_cd,
    ANY_VALUE(rr.receipt_passed_amount_threshold_fg) AS receipt_passed_amount_threshold_fg,
    ANY_VALUE(rr.param_min_returns_cnt) AS param_min_returns_cnt,
    CAST(count(rr.local_prod_nr) AS BIGNUMERIC) AS ret_distinct_prod_cnt, /* T_TMP_RETURN_RECEIPTS table is already on a product level so the set provides distinctive products as it is */
    CAST(count(par_p.local_prod_nr) AS BIGNUMERIC) AS ret_and_purch_distinct_prod_cnt, /* The join to purch_products_after_return_event CTE is on a receipt ID and product number so if there is no match on a product then par_p.local_prod_nr will be null and will not be considered by COUNT function */
    rr.orig_purch_retail_event_sid,
    row_number() OVER (
      PARTITION BY rr.orig_purch_retail_event_sid
      ORDER BY IF(ANY_VALUE(rr.event_end_tmsp) IS NULL, 0, 1) DESC, ANY_VALUE(rr.event_end_tmsp)
    ) AS ret_sort_nr
  FROM t_tmp_return_receipts AS rr
  LEFT OUTER JOIN purch_products_after_return_event AS par_p
    ON rr.ret_retail_event_sid = par_p.ret_retail_event_sid
    AND rr.local_prod_nr = par_p.local_prod_nr
  GROUP BY
    1,
    17
), return_events_filtered AS (
  SELECT
    return_events_calc.ret_retail_event_sid,
    return_events_calc.cash_register_event_nr,
    return_events_calc.event_start_tmsp,
    return_events_calc.event_end_tmsp,
    return_events_calc.bus_dt,
    return_events_calc.cash_register_sid,
    return_events_calc.cash_register_nr,
    return_events_calc.store_sid,
    return_events_calc.cashier_hash,
    return_events_calc.txn_net_val,
    return_events_calc.txn_gross_val,
    return_events_calc.curr_cd,
    return_events_calc.ret_sort_nr,
    sum(return_events_calc.receipt_passed_amount_threshold_fg) OVER (PARTITION BY return_events_calc.orig_purch_retail_event_sid) AS receipts_passed_amount_threshold_cnt,
    CAST(count(return_events_calc.ret_retail_event_sid) OVER (PARTITION BY return_events_calc.orig_purch_retail_event_sid) AS BIGNUMERIC) AS returns_per_orig_purch_cnt
  FROM return_events_calc
  /* Take all return receipts being first returns associated with an original receipt chronologically */ /* For second and next return receipts apply 'all return items are not on the follow-up receipt after the return' logic */ /* If there is no option to determine the follow-up receipt due to the old cashier_hash/cashier_nr values in a return being anonymized then qualify such return anyways */ /* In such cases RET_AND_PURCH_DISTINCT_PROD_CNT column will be equal to zero for that row so then it will always be different than RET_DISTINCT_PROD_CNT which is equal or more than 1 by definition of a return - the expression will be then evaluated to True */
  WHERE
    return_events_calc.ret_sort_nr = CAST('1' AS NUMERIC)
    OR return_events_calc.ret_distinct_prod_cnt <> return_events_calc.ret_and_purch_distinct_prod_cnt
  QUALIFY
    CAST('1' AS NUMERIC) = CAST('1' AS NUMERIC)
    AND returns_per_orig_purch_cnt >= return_events_calc.param_min_returns_cnt
    AND receipts_passed_amount_threshold_cnt >= CAST('1' /* if one of the returns have amount above threshold, all returns are included */ AS NUMERIC)
)
SELECT
  return_events_filtered.ret_retail_event_sid, /* After 'all return items are not on the follow-up receipt after the return' logic is applied - filter receipts on thresholds */
  return_events_filtered.cash_register_event_nr,
  return_events_filtered.event_start_tmsp,
  return_events_filtered.bus_dt,
  return_events_filtered.cash_register_sid,
  return_events_filtered.cash_register_nr,
  return_events_filtered.store_sid,
  return_events_filtered.cashier_hash,
  return_events_filtered.txn_net_val,
  return_events_filtered.txn_gross_val,
  return_events_filtered.curr_cd,
  CASE return_events_filtered.ret_sort_nr
    WHEN CAST('1' AS NUMERIC)
    THEN CAST('0' AS NUMERIC)
    ELSE CAST('1' AS NUMERIC)
  END AS return_same_receipt_fg /* first return has a flag FALSE, only the following returns that use the same original receipt are marked as suspicious. */ /* we still want the event to be returned with explicit FALSE, to make sure the flag will be updated if it was TRUE before */
FROM return_events_filtered;