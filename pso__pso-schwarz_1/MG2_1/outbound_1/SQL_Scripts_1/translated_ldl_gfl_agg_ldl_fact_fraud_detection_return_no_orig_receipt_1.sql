/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung - DWH / MIS
#----------------------------------------------------------------------------
# Script: ldl_fact_fraud_detection_return_no_orig_receipt.sql
#----------------------------------------------------------------------------
# History:
#  1.0  09.08.2024  Andrzej Wandtke 	- ZKP GF_1 Story 33393 development by Mihail Ivanov - script for scenario Money refund without original receipt 
#  1.1  19.08.2024  Andrzej Wandtke 	- ZKP GF_1 Story 46391 add table vt1
#  1.2  21.11.2024  Mihail Ivanov  		- added filter re.TURNOVER_RELEVANT_FG = TRUE
#  1.3  03.12.2024  Mihail Ivanov		- Products matched by LOCAL_PROD_NR instead of PROD_VARIANT_SID
#											as required for fix in this bug: https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-INTEGER /_workitems/edit/59294/
#
#										  Also added threshold evaluation of Returned Amount
#  1.4  09.12.2024  Kamil Roszczyk      - ZKP GF_1 - bugfixing: https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-INTEGER /_workitems/edit/56797
#										Change log:
#											- fixed the duplicates issue
#											- added the fix for returns with dummy_1 orig_sales_event_sid numbers
#											- changed the calculation method for both flags
#  1.5  15.01.2025  Andrzej Wandtke      - ZKP GF_1 - bug 62166 - change the logic for products_matched
#  1.6  27.02.2025  Mihail Ivanov      	 - ZKP GF_1 - bug 63924 - change the window clause for "products_matched", "total_return_cnt"

#  1.7  27.03.2025  Mihail Ivanov  - Changes:
						- added logic to set the flag only in scenario is enabled in a country_1 (and remove the flag if scenario is disabled)
							https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-INTEGER /_workitems/edit/63803
						- removed columns that were only relevant for "storno" scenarios
#  1.8  03.04.2025  Mihail Ivanov  - Changes:
						Removing flag if scenario is disabled is moved out of this script to the main script
*/
 INSERT INTO ${fwrk_work_db}.t_fact_fraud_detection_by_cash_register_event_final
(cashier_hash, txn_net_val, cash_register_event_nr, cash_register_sid, curr_cd, cash_register_nr, txn_gross_val,
 event_start_tmsp, cash_register_event_sid, bus_dt, store_sid, return_qty_invalid_fg, return_not_on_receipt_fg)
WITH returned_products AS (SELECT retail_event_sid AS ret_retail_event_sid,
    local_prod_nr AS ret_local_prod_nr,
    ANY_VALUE(bus_dt) AS ret_bus_dt,
    ANY_VALUE(orig_sales_event_sid) AS purch_retail_event_sid,-- ID of the receipt with which the ReturnedProduct was purchase
    COALESCE(SUM(prod_variant_qty), SUM(prod_variant_cnt)) AS ret_qty
   FROM ldl_data_production_core_rel.t_product_retail_line_1 AS prl
   WHERE prod_retail_line_type_cd IN ('R', 'RD')
    AND turnover_relevant_fg -- this eliminates cancelled (aborted) and suspended receipts too
    AND bus_dt BETWEEN $MIN_DWH_CAL_DT AND $MAX_DWH_CAL_DT
    AND (country_org_cd, bus_dt, CAST(store_sid AS BIGNUMERIC)) IN (SELECT (country_cd, dwh_cal_dt, loc_sid)
      FROM ${fwrk_work_db}.vt1)
   GROUP BY ret_retail_event_sid,
    ret_local_prod_nr), purchased_products AS (SELECT retail_event_sid AS purch_retail_event_sid,
    local_prod_nr AS purch_local_prod_nr,
    COALESCE(SUM(prod_variant_qty), SUM(prod_variant_cnt)) AS purch_qty
   FROM ldl_data_production_core_rel.t_product_retail_line_1 AS p_prl
   WHERE retail_event_sid IN (SELECT DISTINCT ANY_VALUE(orig_sales_event_sid) AS purch_retail_event_sid
      FROM ldl_data_production_core_rel.t_product_retail_line_1 AS prl
      WHERE prod_retail_line_type_cd IN ('R', 'RD')
       AND turnover_relevant_fg 
       AND bus_dt BETWEEN $MIN_DWH_CAL_DT -- if return is before MaxDate, then purchase must also be before MaxDate
        AND $MAX_DWH_CAL_DT -- for performance. Different laws allow return for 7,14 or 30 days. Anyway there should not be a return that happens more than 360 days after purchase
       AND (country_org_cd, bus_dt, CAST(store_sid AS BIGNUMERIC)) IN (SELECT (country_cd, dwh_cal_dt, loc_sid)
         FROM ${fwrk_work_db}.vt1)
      GROUP BY ret_retail_event_sid,
       ret_local_prod_nr)
    AND bus_dt <= $MAX_DWH_CAL_DT
    AND bus_dt >= DATE_ADD($MIN_DWH_CAL_DT, INTERVAL - 360 DAY)
    AND country_org_cd IN (SELECT country_cd
      FROM ${fwrk_work_db}.vt1)
   GROUP BY purch_retail_event_sid,
    purch_local_prod_nr), calc_flags AS (SELECT rpv.ret_retail_event_sid AS cash_register_event_sid,
    re.cash_register_event_nr,
    re.event_start_tmsp,
    rpv.ret_bus_dt,
    re.cash_register_sid,
    cr.cash_register_nr,
    re.store_sid,
    re.cashier_hash,
    re.txn_net_val,
    re.txn_gross_val,
    re.curr_cd -- checking the number of matching lines between return and sales_1 receipt

    -- count distinct is added in order not to consider the same product many times

    -- both RET_RETAIL_EVENT_SID and PURCH_RETAIL_EVENT_SID are part of the window clause in case lines of the same return receipt have different Purchase SIDs (is not expected but ... who knows)

    ,
    COUNT(CASE
      WHEN ppv.purch_local_prod_nr = rpv.ret_local_prod_nr = TRUE
      THEN ppv.purch_local_prod_nr
      ELSE NULL
      END) OVER (PARTITION BY rpv.ret_retail_event_sid, rpv.purch_retail_event_sid RANGE BETWEEN UNBOUNDED PRECEDING AND
     UNBOUNDED FOLLOWING) AS products_matched,
    -- count the total number of distinctive products in return receipt for comparison with products_matched
	  -- both RET_RETAIL_EVENT_SID and PURCH_RETAIL_EVENT_SID are part of the window clause in case lines of the same return receipt have different Purchase SIDs (is not expected but ... who knows) 
    COUNT(rpv.ret_local_prod_nr) OVER (PARTITION BY rpv.ret_retail_event_sid, rpv.purch_retail_event_sid RANGE BETWEEN
     UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS total_return_cnt,
     -- purchase receipt that contains the PV was found, but the returned quantity is bigger
     CASE
     WHEN ppv.purch_local_prod_nr = rpv.ret_local_prod_nr
     THEN ABS(rpv.ret_qty) > ppv.purch_qty
     ELSE FALSE
     END AS return_qty_invalid_fg
   FROM returned_products AS rpv
    INNER JOIN ldl_data_production_core_rel.t_retail_event_1 AS re_1 ON rpv.ret_retail_event_sid = re.retail_event_sid AND
      re.bus_dt BETWEEN $MIN_DWH_CAL_DT AND $MAX_DWH_CAL_DT
    INNER JOIN ldl_data_production_core_rel.t_cash_register_1 AS cr ON re.cash_register_sid = cr.cash_register_sid AND cr
     .dwh_valid_fg
     -- filter using threshold for param value "Returned Amount"
    INNER JOIN ldl_data_production_core_app_fraud_detection.v_fraud_detection_parameter_current_value_1 AS pv_ra ON re.country_org_cd
          = pv_ra.country_org_cd AND pv_ra.scenario_id = 10 AND pv_ra.param_id = 29 AND pv_ra.is_scenario_enabled_in_country_fg
       AND ABS(re.txn_gross_val) >= pv_ra.param_val_qty
      -- Initially this was left outer CROSS JOIN on both retail_event_sid and local_prod_nr but it was changed due to the nature of orig_sales_event_sid attribute data

      -- Sometimes cashiers mark a dummy_1 receipt number as an original receipt during proceeding the return. Such input makes orig_sales_event_sid field being populated with receipt ID but such ID has no relation to any actual receipt in t_retail_event_1

      -- We want to make sure that whatever we try to compare for both flags comes from actual receipts - inner join is used to force it but local_prod_nr condition is skipped to allow checking for return products not matched with sales_1 receipt in SELECT statement calculations

      
    INNER JOIN purchased_products AS ppv ON rpv.purch_retail_event_sid = ppv.purch_retail_event_sid) (SELECT ANY_VALUE(cashier_hash
     ) AS cashier_hash,
    ANY_VALUE(txn_net_val) AS txn_net_val,
    ANY_VALUE(cash_register_event_nr) AS cash_register_event_nr,
    ANY_VALUE(cash_register_sid) AS cash_register_sid,
    ANY_VALUE(curr_cd) AS curr_cd,
    CAST(ANY_VALUE(cash_register_nr) AS STRING) AS cash_register_nr,
    ANY_VALUE(txn_gross_val) AS txn_gross_val,
    ANY_VALUE(event_start_tmsp) AS event_start_tmsp,
    cash_register_event_sid,
    ANY_VALUE(ret_bus_dt) AS bus_dt,
    ANY_VALUE(store_sid) AS store_sid,
    -- if the number of products matched between the return and sales_1 receipt and the total number of products in return are the same then it means all returned products are in original sales_1 receipt so it's not a fraud, otherwise it's a fraud
    MAX(return_qty_invalid_fg) AS return_qty_invalid_fg,
    MAX(CASE
      WHEN products_matched = total_return_cnt
      THEN FALSE
      ELSE TRUE
      END) AS return_not_on_receipt_fg
   FROM calc_flags
   WHERE products_matched <> total_return_cnt
    OR return_qty_invalid_fg
   GROUP BY cash_register_event_sid);