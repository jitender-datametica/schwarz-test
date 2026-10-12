/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung - DWH / MIS
#----------------------------------------------------------------------------
# Script: ldl_fact_fraud_detection_cancel_in_favour.sql
#----------------------------------------------------------------------------
# History:
#  1.0  16.08.2024  Andrzej Wandtke  - ZKP GF_2 - script for scenario Cancel in favour
#  1.1  22.08.2024  Andrzej Wandtke  - ZKP GF_2 - development by Mihail Ivanov
                                       This covers a scenario with several sub-scenarios
                                       General scenario is CANCEL_IN_FAVOUR_FG
                                       https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-INTEGER/_workitems/edit/41148

                                       Subscenarios:
                                       1. CANCEL_IN_FAVOUR_ALCOHOL_TOBACCO_FG
                                       https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-INTEGER/_workitems/edit/46537/
	
                                       2. CANCEL_IN_FAVOUR_OUTSIDE_OPENING_HR_FG
                                       https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-INTEGER/_workitems/edit/46546
									   
#  1.2	29.08.2024	Piotr Kleysa	 - ZKP GF_2 - development by Mihail Ivanov
                                       Adding two new subscenarios
                                       1. CANCEL_IN_FAVOUR_WITHOUT_AUTH_FG
                                       https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-INTEGER/_workitems/edit/46542/
                                        
                                       2. CANCEL_IN_FAVOUR_MANUAL_DISCOUNT_FG
                                       https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-INTEGER/_workitems/edit/46547/
									   
#  1.3	29.08.2024	Kamil Roszczyk   - ZKP GF_2 - Adding two new subscenarios 
                                       1. CANCEL_IN_FAVOUR_AFTER_SUBTOTAL_FG
                                       https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-INTEGER/_workitems/edit/46541
                                   
                                       2.CANCEL_IN_FAVOUR_EXACT_PAYM_FG
                                       https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-INTEGER/_workitems/edit/46540

#  1.4  12.09.2024  Mihail Ivanov	 - Update logic for scenario CANCEL_IN_FAVOUR_WITHOUT_AUTH_FG
										now we are checking the value of AUTH_BY_HASH in T_CANCELLATION_LINE_2 instead of T_PRODUCT_RETAIL_LINE_2
										
#  1.5  27.09.2024  Olexander Bezpalko - New sub-scenario
                                         CANCEL_IN_FAVOUR_HIGHEST_POS_FG
										 https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-INTEGER/_workitems/edit/46544
										 
										 Also split the logic into 3 queries (3 steps) instead of 1 to make maintenance simpler.

										 
	
#  1.6	06.11.2024	Mihail Ivanov	 -	Logic for "Doppletipper" updated - made the same as in "cancel_last_position" scenario
											To put two consequtive lines in same group they both must be "SCANNED"

#  1.7	08.11.2024	Mihail Ivanov	 -	Adjustment for column rename
											CANCEL_IN_FAVOUR_OUTSIDE_OPENING_HOURS_FG renamed to CANCEL_IN_FAVOUR_OUTSIDE_OPENING_HR_FG			

#  1.8	18.11.2024	Mihail Ivanov	 -	Added sub-scenario
											CANCEL_IN_FAVOUR_LIDL_PLUS_FG
											https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-INTEGER/_workitems/edit/57254/

										
										Added two columns to  core_dim.T_FACT_FRAUD_DETECTION_BY_CASH_REGISTER_EVENT_2
											CUST_SID
											CUST_IDENT_TYPE_CD
										The columns are taken 1:1 from LDL_DATA_PRODUCTION.core_rel.T_RETAIL_EVENT. 
										Can be used to produce a metric like "Count of [total/unique] Lidl Plus IDs (CUST_SIDs)" for every scenario

#  1.9	21.11.2024	Mihail Ivanov	 -	bugfix: Adjusted logic for "next receipt" - now taken comparing CASH_REGISTER_EVENT_NR for same CASH_REGISTER_SID, BUS_DT
												CASH_REGISTER_SID is based on Country_2,Store and RegisteNR so no need to add STORE_SID and COUNTRY_CD
												Logic explained here is relevant in general for "next receipt" evaluation: https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-INTEGER/_workitems/edit/53633
												
										bugfix: Evaluated only receipts where re.TURNOVER_RELEVANT_FG = TRUE 
												this eliminates cancelled (aborted) and suspended receipts too
												
#  1.10	09.12.2024	Mihail Ivanov	 -	bugfix: Changed product group filter, to make it sane as old world
											as requested in this bug:	https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-INTEGER/_workitems/edit/56851/
											
										bugfix: comparing threshold for "total amount of cancelled items" with the correct column 
								

#  1.11	20.01.2025	Mihail Ivanov   - ZKP GF_2 changes (requested here: https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-INTEGER/_workitems/edit/55225)
										Add filter to exclude cancellations of negative values ( for example deposit)						

#  1.12	19.02.2025	Mihail Ivanov   - ZKP GF_2 changes (requested here: https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-INTEGER/_workitems/edit/63798/)
										new sub-scenario for Stornos in receipts with only 1 retail line - CANCEL_IN_FAVOUR_SINGLE_POS_FG						

#  1.13	25.02.2025	Mihail Ivanov   - ZKP GF_2 changes (requested here: https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-INTEGER/_workitems/edit/63798/)
										Logic for implementation of CANCEL_IN_FAVOUR_SINGLE_POS_FG is changed (fixed, we had it wrong)
										The flag means that we may have many cancelled lines in the receipt and we have only 1 non-cancelled regular retail line (regular means we do not count deposit lines)
										
										Bugfix: for all sub-scenarios we were raising the flag if the group of items has as many cancelled lines as there are lines in the group.
												But if we have 3 lines with 1 bottle of vodka and 2 of these lines are cancelled this is NOT "doppletipper" and should be counted - this is fixed now and we count such groups.
										
#  1.14	18.03.2025	Andrzej Wandtke   - ZKP GF_2 changes - task 66853 - filter on standard cash registers : POS type TIL

#  1.15 26.03.2025	Kamil Roszczyk	- ZKP GF_2 changes
										- replaced filters for turnover relevant and sales_2 receipts to mimic the MIS logic
										- renamed the relevant_cancel_gross_val and relevant_cancel_line_cnt fields to synchronize with the recent data model changes
											https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-INTEGER/_workitems/edit/66945
										- added the logic for removing scenarios data when no threshold is set
											https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-INTEGER/_workitems/edit/63803


#  1.16  03.04.2025  Mihail Ivanov  - Changes:
						Removing flag if scenario is disabled is moved out of this script to the main script

#  1.17  29.04.2025  Kamil Roszczyk	- changes: changed 'TIL' filter for non selfcheckout cash registers
										- filter: "cash_register_type_cd = 'TIL'"; replaced with: "cash_register_type_cd = 'TIL' OR cash_register_type_cd IS NULL"
											https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-INTEGER/_workitems/edit/69257
											
											
#  1.18  16.05.2025  Mihail Ivanov  - Changes/Bugfixes: all requested here https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-INTEGER/_workitems/edit/70840
										
										- Change: for sub-scenario CANCEL_IN_FAVOUR_WITHOUT_AUTH_FG now none of the cancellation lines should be approved.
											Event cancellation lines that are cancelling retail lines with Obs/Gemuse/Blumen should be without approval
											
										- Bugfix: for sub-scenario CANCEL_IN_FAVOUR_AFTER_SUBTOTAL_FG now evaluating if "cancellation line" exists after "sub-total line"
												before we were looking for "cancelled retail line" after sub-total line
												
										- bugfix: for sub-scenario CANCEL_IN_FAVOUR_SINGLE_POS_FG we are now counting two line types
											"regular sales_2 line" (type = S) and "Deposit Return Line" (type D)
											and event must have in total one non-cancelled line which is one of these types
											
									
									TODO (maybe after migration): discuss with Lucas what happens if we change the definition of "gen_cancel_line_fg" and include Obst/Gemuse/Blumen once event is quallified
										what happens with sub-scenarios - for example "cacelled highest amount" if the highest amount item_2 is Flowers and it is cancelled
										what happens with sub-scenario "cancel after sub-total" if the cancellation line after sub-total cancelles flowers
										what we compare to thresholds, what we show in metrics (relevant cancelled lines cnt/gross val)
*/ /* ------------------------------------------------------------------------------------------- */ /* ------------------------------------------------------------------------------------------- */ 
/*	Step1: Create temporary table T_TMP_CANCEL_FRIENDLY_LINE_FLAGS */ /*  	It has all (not only cancelled) retail lines for each event where we have a at least one Storno(cancelled line) */ /*		For each line we calculate a flag indicating if the line is suspicious for any sub-scenario */

CREATE OR REPLACE TEMPORARY TABLE t_tmp_cancel_friendly_line_flags AS
WITH event_and_next_event AS (
  SELECT
    retail_event_sid, /* fastest way to map RETAIL_EVENT_SID to its following RETAIL_EVENT_SID */ /* yes, we are doing this for all receipts, not only for those that have cancellations */ /* but still we have a filter on dates because of the delta extraction, and we are using only the smaller table with events (T_RETAIL_EVENT_2) */ /* we do not need the bigger table with PRODUCT_RETAIL_LINE and we only use one window function (LEAD) */ /* Other implementation require a equi-JOIN  + two (dense_rank) window functions, or non-equi-JOIN (next.cash_register_event_nr > curr.cash_register_event_nr) + ROW_NUMBER */
    lead(retail_event_sid, 1) OVER (
      PARTITION BY cash_register_sid, bus_dt
      ORDER BY IF(cash_register_event_nr IS NULL, 0, 1) DESC, cash_register_event_nr
    ) AS next_retail_event_sid,
    cash_register_event_nr, /* additional event attributes */
    event_start_tmsp,
    bus_dt,
    cash_register_sid,
    store_sid,
    cashier_hash,
    txn_net_val,
    txn_gross_val,
    country_org_cd,
    curr_cd,
    cust_sid,
    cust_ident_type_cd,
    turnover_relevant_fg,
    retail_event_type_cd,
    event_end_tmsp
  FROM ${fwrk_work_db}.vt1
  INNER JOIN ldl_data_production.core_rel.t_retail_event_2 AS re_2
    ON re.country_org_cd = vt1.country_cd
    AND re.bus_dt = vt1.dwh_cal_dt
    AND re.store_sid = vt1.loc_sid
  WHERE
    bus_dt BETWEEN $min_dwh_cal_dt AND $max_dwh_cal_dt
    AND (
      re.cash_register_type_cd = 'TIL' OR re.cash_register_type_cd IS NULL
    )
) /* "cancel_line_seq not null" and "product groups" are very strong filters */ /* it is better to use them early to limit the RETAIL_EVENT_SIDs with which we are working */ /* and then in another step take all lines for these RETAIL_EVENT_SIDs */
, event_with_suspicious_cancel AS (
  SELECT DISTINCT
    ene.*
  /* we want only the event, 1 row for every receipt that has suspicous cancellation */
  FROM event_and_next_event AS ene
  INNER JOIN ldl_data_production.core_rel.t_product_retail_line_2 AS l
    ON l.retail_event_sid = ene.retail_event_sid
    AND l.bus_dt = ene.bus_dt
    AND l.store_sid = ene.store_sid
  INNER JOIN ldl_data_production.core_dim.t_dim_sales_variant_2 AS p
    ON l.prod_variant_sid = p.sales_variant_sid AND p.dwh_valid_fg = TRUE
  WHERE
    CAST('1' AS NUMERIC) = CAST('1' AS NUMERIC)
    /* delta extraction */ 
    AND l.bus_dt BETWEEN $min_dwh_cal_dt AND $max_dwh_cal_dt
     /* Following two filters moved here from event_and_next_event CTE to not eliminate turnover not relevant and non sales_2 receipts as main receipt's followers - in sync with receipt follower definition from MIS */ /* this eliminates cancelled (aborted) and suspended receipts too */ 
    AND ene.turnover_relevant_fg = TRUE
     /* Sales_2 receipts only */ 
    AND ene.retail_event_type_cd = 'S'
    /* scenario conditions */ 
    AND NOT l.cancel_line_seq IS NULL
    AND coalesce(l.prod_variant_cnt, CAST('0' AS NUMERIC)) + coalesce(l.prod_variant_qty, CAST('0' AS NUMERIC)) < CAST('50' AS NUMERIC)
     /* Item_2 within the item_2 groups in scope */ 
    AND NOT p.int_item_grp_nr IS NULL
    AND NOT p.int_item_grp_nr IN ('10', '20') /* exclude Fruit/Vegetables and Flowers */
    AND NOT p.sub_item_grp_nr IS NULL
    AND p.sub_item_grp_nr <> '74' /* exclude bakery */
    /* Filter to exclude cancellations of negative values (for example deposit) */ 
    AND l.retail_line_gross_val > CAST('0' AS NUMERIC)
), last_subtotal_before_storno AS (
  SELECT
    tcl.retail_event_sid,
    MAX(tsl.event_tmsp) AS last_subtotal_tmsp
  FROM ${fwrk_work_db}.vt1
  INNER JOIN ldl_data_production.core_rel.t_cancellation_line_2 AS tcl
    ON vt1.country_cd = tcl.country_org_cd
    AND vt1.dwh_cal_dt = tcl.bus_dt
    AND vt1.loc_sid = tcl.store_sid
  INNER JOIN ldl_data_production.core_rel.t_subtotal_line_2 AS tsl
    ON tcl.retail_event_sid = tsl.retail_event_sid AND tcl.event_tmsp > tsl.event_tmsp
  WHERE
    CAST('1' AS NUMERIC) = CAST('1' AS NUMERIC)
    AND tcl.bus_dt BETWEEN $min_dwh_cal_dt AND $max_dwh_cal_dt
    AND tsl.bus_dt BETWEEN $min_dwh_cal_dt AND $max_dwh_cal_dt
  GROUP BY
    1
), lines_of_event_with_suspicious_cancel AS (
  SELECT
    ewsc.*,
    l.local_prod_nr,
    l.retail_line_gross_val,
    l.prod_variant_sid,
    l.retail_event_line_seq,
    l.cancel_line_seq,
    l.prod_variant_input_nr,
    l.auth_by_hash,
    l.prod_entry_method_cd,
    prod_variant_qtyx AS prod_variant_qtyx,
    CAST(count(cl.auth_by_hash) OVER (PARTITION BY ewsc.retail_event_sid) AS BIGNUMERIC) AS event_appr_cancellation_lines_cnt, /* redefined requirement says that none of the cancelled lines should be approved for sub-scenario CANCEL_IN_FAVOUR_WITHOUT_AUTH_FG */ /* even Obst/Gemuse/Blumen lines must be without approval */
    MAX(l.base_gross_val) OVER (PARTITION BY ewsc.retail_event_sid) AS max_line_amt_per_event,
    sum(
      IF(
        l.cancel_line_seq IS NULL AND l.prod_retail_line_type_cd IN ('S', 'D'),
        CAST('1' AS NUMERIC),
        CAST('0' AS NUMERIC)
      )
    ) OVER (PARTITION BY ewsc.retail_event_sid) AS event_non_cancelled_retail_line_cnt, /* for flag "CANCEL_IN_FAVOUR_SINGLE_POS_FG" we need to make sure only 1 regular retail line is not cancelled */ /* 		lines of type D "deposit returns" are also counted, while lines of type "SD" are ignored */
    row_number() OVER (
      PARTITION BY ewsc.retail_event_sid
      ORDER BY IF(l.event_start_tmsp IS NULL, 0, 1) DESC, l.event_start_tmsp, IF(l.retail_event_line_seq IS NULL, 0, 1) DESC, l.retail_event_line_seq
    ) AS line_rn,
    gen_cancel_line_fg AS gen_cancel_line_fg, /* Storno aus den Warengruppen Kühlung, Tiko, Non Food, Frischbrot (ohne die die UWG Bake Off) oder Food TS aufweisen */
    CASE
      WHEN gen_cancel_line_fg = CAST('1' AS NUMERIC)
      AND p.sub_item_grp_nr IN ('60', '61', '63', '80')
      THEN CAST('1' AS NUMERIC)
      ELSE CAST('0' AS NUMERIC)
    END AS alc_tbc_cancel_line_fg, /* Storno for Alcohol/Tabaco, SubGroups of int_item_grp_nr=60 */
    CASE
      WHEN gen_cancel_line_fg = CAST('1' AS NUMERIC)
      AND (
        TIME(ewsc.event_start_tmsp) < soh.open_tm
        OR TIME(ewsc.event_end_tmsp) > soh.close_tm
      )
      THEN CAST('1' AS NUMERIC)
      ELSE CAST('0' AS NUMERIC)
    END AS outside_worktime_cancel_line_fg, /* Storno outside work hours */
    CASE
      WHEN gen_cancel_line_fg = CAST('1' AS NUMERIC)
      AND count(cl.auth_by_hash) OVER (PARTITION BY ewsc.retail_event_sid) = CAST('0' AS NUMERIC)
      THEN CAST('1' AS NUMERIC)
      ELSE CAST('0' AS NUMERIC)
    END AS no_approval_cancel_line_fg, /* Storno without approval */
    CASE
      WHEN gen_cancel_line_fg = CAST('1' AS NUMERIC)
      AND l.base_gross_val = MAX(l.base_gross_val) OVER (PARTITION BY ewsc.retail_event_sid)
      THEN CAST('1' AS NUMERIC)
      ELSE CAST('0' AS NUMERIC)
    END AS cancel_in_favour_highest_pos_line_fg, /* highest purchased price item_2 = highest purchased price item_2 cancelled */
    CASE
      WHEN gen_cancel_line_fg = CAST('1' AS NUMERIC) AND NOT lsbs.retail_event_sid IS NULL
      THEN CAST('1' AS NUMERIC)
      ELSE CAST('0' AS NUMERIC)
    END AS cancel_after_subtotal_line_fg, /* Storno after subtotal (or otherwise said "subtotal before storno exists" */
    CASE
      WHEN gen_cancel_line_fg = CAST('1' AS NUMERIC)
      AND sum(
        IF(
          l.cancel_line_seq IS NULL AND l.prod_retail_line_type_cd IN ('S', 'D'),
          CAST('1' AS NUMERIC),
          CAST('0' AS NUMERIC)
        )
      ) OVER (PARTITION BY ewsc.retail_event_sid) = CAST('1' AS NUMERIC)
      THEN CAST('1' AS NUMERIC)
      ELSE CAST('0' AS NUMERIC)
    END AS cancel_in_favour_single_pos_line_fg /* Storno and only 1 retail line remains uncancelled */
  FROM event_with_suspicious_cancel AS ewsc
  INNER JOIN ldl_data_production.core_rel.t_product_retail_line_2 AS l
    ON ewsc.retail_event_sid = l.retail_event_sid
    AND ewsc.bus_dt = l.bus_dt
    AND ewsc.country_org_cd = l.country_org_cd
    AND ewsc.store_sid = l.store_sid
  LEFT OUTER JOIN ldl_data_production.core_rel.t_cancellation_line_2 AS cl
    ON cl.retail_event_sid = ewsc.retail_event_sid
    AND cl.retail_event_line_seq = l.cancel_line_seq
    AND cl.bus_dt BETWEEN $min_dwh_cal_dt AND $max_dwh_cal_dt
  LEFT OUTER JOIN last_subtotal_before_storno AS lsbs
    ON lsbs.retail_event_sid = ewsc.retail_event_sid
  LEFT OUTER JOIN ldl_data_production.core_rel.t_store_opening_hours_2 AS soh
    ON ewsc.store_sid = soh.store_sid
    AND (
      EXTRACT(DAYOFWEEK FROM CAST(ewsc.bus_dt AS DATETIME)) - 1
    ) /* Sun0 */ = soh.day_of_week
    AND soh.dwh_valid_fg = TRUE
  LEFT OUTER JOIN ldl_data_production.core_dim.t_dim_sales_variant_2 AS p
    ON l.prod_variant_sid = p.sales_variant_sid AND p.dwh_valid_fg = TRUE
  CROSS JOIN UNNEST([
    coalesce(l.prod_variant_cnt, CAST('0' AS NUMERIC)) + coalesce(l.prod_variant_qty, CAST('0' AS NUMERIC))
  ]) AS prod_variant_qtyx
  CROSS JOIN UNNEST([
    CASE
      WHEN CAST('1' AS NUMERIC) = CAST('1' AS NUMERIC)
      AND NOT l.cancel_line_seq IS NULL
      AND prod_variant_qtyx < CAST('50' AS NUMERIC)
      AND NOT p.int_item_grp_nr IS NULL
      AND NOT p.int_item_grp_nr IN ('10', /* exclude Fruit/Vegetables and Flowers */'20')
      AND NOT p.sub_item_grp_nr IS NULL
      AND p.sub_item_grp_nr <> '74'
      AND l.retail_line_gross_val > CAST('0' AS NUMERIC)
      THEN CAST('1' AS NUMERIC)
      ELSE CAST('0' AS NUMERIC)
    END
  ]) AS gen_cancel_line_fg
  WHERE
    CAST('1' AS NUMERIC) = CAST('1' AS NUMERIC)
    AND l.bus_dt BETWEEN $min_dwh_cal_dt AND $max_dwh_cal_dt
)
SELECT
  lines_of_event_with_suspicious_cancel.retail_event_sid, /* event cols */
  lines_of_event_with_suspicious_cancel.next_retail_event_sid,
  lines_of_event_with_suspicious_cancel.cash_register_event_nr,
  lines_of_event_with_suspicious_cancel.event_start_tmsp,
  lines_of_event_with_suspicious_cancel.event_end_tmsp,
  lines_of_event_with_suspicious_cancel.bus_dt,
  lines_of_event_with_suspicious_cancel.cash_register_sid,
  lines_of_event_with_suspicious_cancel.store_sid,
  lines_of_event_with_suspicious_cancel.cashier_hash,
  lines_of_event_with_suspicious_cancel.txn_net_val,
  lines_of_event_with_suspicious_cancel.txn_gross_val,
  lines_of_event_with_suspicious_cancel.country_org_cd,
  lines_of_event_with_suspicious_cancel.curr_cd,
  lines_of_event_with_suspicious_cancel.cust_sid,
  lines_of_event_with_suspicious_cancel.cust_ident_type_cd,
  lines_of_event_with_suspicious_cancel.local_prod_nr, /* event line cols */
  lines_of_event_with_suspicious_cancel.retail_line_gross_val,
  lines_of_event_with_suspicious_cancel.prod_variant_sid,
  lines_of_event_with_suspicious_cancel.retail_event_line_seq,
  lines_of_event_with_suspicious_cancel.cancel_line_seq,
  lines_of_event_with_suspicious_cancel.prod_variant_input_nr,
  lines_of_event_with_suspicious_cancel.auth_by_hash,
  lines_of_event_with_suspicious_cancel.prod_variant_qtyx,
  lines_of_event_with_suspicious_cancel.prod_entry_method_cd,
  lines_of_event_with_suspicious_cancel.gen_cancel_line_fg, /* calculated flags for event lines */
  lines_of_event_with_suspicious_cancel.alc_tbc_cancel_line_fg,
  lines_of_event_with_suspicious_cancel.outside_worktime_cancel_line_fg,
  lines_of_event_with_suspicious_cancel.no_approval_cancel_line_fg,
  lines_of_event_with_suspicious_cancel.cancel_in_favour_highest_pos_line_fg,
  lines_of_event_with_suspicious_cancel.cancel_after_subtotal_line_fg,
  lines_of_event_with_suspicious_cancel.cancel_in_favour_single_pos_line_fg,
  lines_of_event_with_suspicious_cancel.line_rn
FROM lines_of_event_with_suspicious_cancel;

/* ------------------------------------------------------------------------------------------- */ /* ------------------------------------------------------------------------------------------- */ /* 	Step2: Create temporary table T_TMP_CANCEL_FRIENDLY_LINE_GROUPS */ /*  	For each line we calculate also a flag if it has manual discount and a GROUP_ID within the event */ /* 		Two lines of a given event belong to same GROUP_ID if they are consecutive, for same product and same quantity */ /* 		We use this Groups later to evaluate if we have double-tap (1 item_2 scanned twice by mistake and second scan is cancelled) */
CREATE OR REPLACE TEMPORARY TABLE t_tmp_cancel_friendly_line_groups AS
WITH event_lines_change_flag AS (
  SELECT
    l.*,
    CASE
      WHEN lag(l.prod_entry_method_cd, 1) OVER (
        PARTITION BY l.retail_event_sid
        ORDER BY IF(l.line_rn IS NULL, 0, 1) DESC, l.line_rn
      ) IS NOT DISTINCT FROM l.prod_entry_method_cd
      AND l.prod_entry_method_cd = 'SC'
      THEN CAST('1' AS NUMERIC)
      ELSE CAST('0' AS NUMERIC)
    END AS curr_and_prev_scanned_fg, /* Doppeltipper: mark row if this and the previous row were scanned */
    CASE
      WHEN CASE
        WHEN lag(l.prod_entry_method_cd, 1) OVER (
          PARTITION BY l.retail_event_sid
          ORDER BY IF(l.line_rn IS NULL, 0, 1) DESC, l.line_rn
        ) IS NOT DISTINCT FROM l.prod_entry_method_cd
        AND l.prod_entry_method_cd = 'SC'
        THEN CAST('1' AS NUMERIC)
        ELSE CAST('0' AS NUMERIC)
      END = CAST('1' AS NUMERIC)
      AND lag(l.local_prod_nr, 1) OVER (
        PARTITION BY l.retail_event_sid
        ORDER BY IF(l.line_rn IS NULL, 0, 1) DESC, l.line_rn
      ) IS NOT DISTINCT FROM l.local_prod_nr
      AND lag(l.prod_variant_qtyx, 1) OVER (
        PARTITION BY l.retail_event_sid
        ORDER BY IF(l.line_rn IS NULL, 0, 1) DESC, l.line_rn
      ) IS NOT DISTINCT FROM l.prod_variant_qtyx
      THEN CAST('0' AS NUMERIC)
      ELSE CAST('1' AS NUMERIC)
    END AS change_fg /* Doppeltipper: mark row as not changed only when the item_2 and quantity are the same as in a previous row and when this is the consecutive scan */
  FROM t_tmp_cancel_friendly_line_flags AS l
), event_lines_groups AS (
  SELECT
    l.*,
    sum(l.change_fg) OVER (
      PARTITION BY l.retail_event_sid
      ORDER BY l.line_rn
      ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS group_id
  FROM event_lines_change_flag AS l
), manual_discount_prods AS (
  SELECT DISTINCT
    l.retail_event_sid, /* it is possible to have two discounts for same ProductRetailLine, and we just want 1 row per ProductRetailLine */
    l.local_prod_nr
  FROM event_lines_groups AS l
  INNER JOIN ldl_data_production.core_rel.t_discount_line_2 AS d
    ON l.retail_event_sid = d.retail_event_sid
    AND l.country_org_cd = d.country_org_cd
    AND l.bus_dt = d.bus_dt
    AND l.retail_event_line_seq = d.discounted_line_seq
    AND l.cancel_line_seq IS NULL
    AND d.retail_event_line_scenario_id BETWEEN CAST('400' AS NUMERIC) AND CAST('599' AS NUMERIC)
    AND abs(d.discount_val) >= CAST('0.011' AS NUMERIC)
    AND NOT (
      length(l.prod_variant_input_nr) BETWEEN CAST('15' AS NUMERIC) AND CAST('17' AS NUMERIC)
      AND l.prod_variant_input_nr LIKE ANY ('55%', '56%')
    )
)
/* lines of event with suspicious cancellation, but we have to exclude cancelled lines if they exist in next receipt or we have manual discount for same product in this receipt */ 
, event_lines_filtered AS (
  /* Lines that are NOT cancelled. We need the to compare counts for double-tap */ /*    and also to check if there are manual discounts for products which are not cancelled */ 
  SELECT
    l.*,
    CASE
      WHEN mdp.retail_event_sid IS NOT DISTINCT FROM CAST(NULL AS STRING)
      THEN CAST('0' AS NUMERIC)
      ELSE CAST('1' AS NUMERIC)
    END AS is_prod_with_manual_discount_fg
  FROM event_lines_groups AS l
  LEFT OUTER JOIN manual_discount_prods AS mdp
    ON l.retail_event_sid = mdp.retail_event_sid AND l.local_prod_nr = mdp.local_prod_nr
  WHERE
    l.gen_cancel_line_fg = CAST('0' AS NUMERIC)
  UNION ALL
  /* Lines that are cancelled but for the Product there is no Manual Discount and it does not exist in next receipt */
  SELECT
    l.*,
    CAST('0' AS NUMERIC) AS is_prod_with_manual_discount_fg
  FROM event_lines_groups AS l
  LEFT OUTER JOIN manual_discount_prods AS mdp
    ON l.retail_event_sid = mdp.retail_event_sid AND l.local_prod_nr = mdp.local_prod_nr
  WHERE
    l.gen_cancel_line_fg = CAST('1' AS NUMERIC)
    AND mdp.retail_event_sid IS NULL
    AND NOT EXISTS(
      SELECT
        CAST('1' AS NUMERIC)
      FROM ${fwrk_work_db}.vt1
      INNER JOIN ldl_data_production.core_rel.t_product_retail_line_2 AS ne_l /* next event lines */
        ON ne_l.bus_dt = vt1.dwh_cal_dt
        AND ne_l.country_org_cd = vt1.country_cd
        AND ne_l.store_sid = vt1.loc_sid
      WHERE
        CAST('1' AS NUMERIC) = CAST('1' AS NUMERIC)
        AND ne_l.retail_event_sid = l.next_retail_event_sid
        AND ne_l.bus_dt = l.bus_dt
        AND ne_l.country_org_cd = l.country_org_cd
        AND ne_l.local_prod_nr = l.local_prod_nr
        AND ne_l.bus_dt BETWEEN $min_dwh_cal_dt AND $max_dwh_cal_dt
    )
)
SELECT
  event_lines_filtered.retail_event_sid,
  event_lines_filtered.next_retail_event_sid,
  event_lines_filtered.cash_register_event_nr,
  event_lines_filtered.event_start_tmsp,
  event_lines_filtered.event_end_tmsp,
  event_lines_filtered.bus_dt,
  event_lines_filtered.cash_register_sid,
  event_lines_filtered.store_sid,
  event_lines_filtered.cashier_hash,
  event_lines_filtered.txn_net_val,
  event_lines_filtered.txn_gross_val,
  event_lines_filtered.country_org_cd,
  event_lines_filtered.curr_cd,
  event_lines_filtered.cust_sid,
  event_lines_filtered.cust_ident_type_cd,
  event_lines_filtered.local_prod_nr, /* event line cols */
  event_lines_filtered.retail_line_gross_val,
  event_lines_filtered.prod_variant_sid,
  event_lines_filtered.retail_event_line_seq,
  event_lines_filtered.cancel_line_seq,
  event_lines_filtered.prod_variant_input_nr,
  event_lines_filtered.auth_by_hash,
  event_lines_filtered.prod_variant_qtyx,
  event_lines_filtered.gen_cancel_line_fg, /* calculated flags for event lines */
  event_lines_filtered.alc_tbc_cancel_line_fg,
  event_lines_filtered.outside_worktime_cancel_line_fg,
  event_lines_filtered.no_approval_cancel_line_fg,
  event_lines_filtered.cancel_in_favour_highest_pos_line_fg,
  event_lines_filtered.cancel_after_subtotal_line_fg,
  event_lines_filtered.cancel_in_favour_single_pos_line_fg,
  event_lines_filtered.is_prod_with_manual_discount_fg,
  event_lines_filtered.group_id
FROM event_lines_filtered;

/* ------------------------------------------------------------------------------------------- */ /* ------------------------------------------------------------------------------------------- */ /* 	Step3.1: Insert the final result for all sub-scenarios except the "single line" sub-scenario */ /*  	We evaluate the groups in each event and if they are NOT "double-tap", */ /* 			then the group gets a Flag, and later the Event gets the flag. */ /* the way t_fact_fraud_detection_by_cash_register_event_final is processed in the end (by aggregation) allows us to insert 2 rows for same retail_event_sid in this script */ /* so having second insert for another sub-scenario is not a problem */
INSERT INTO ${fwrk_work_db}.t_fact_fraud_detection_by_cash_register_event_final (
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
  cancel_in_favour_gross_val,
  curr_cd,
  cancel_in_favour_line_cnt,
  cust_sid,
  cust_ident_type_cd,
  cancel_in_favour_fg,
  cancel_in_favour_alcohol_tobacco_fg,
  cancel_in_favour_outside_opening_hr_fg,
  cancel_in_favour_without_auth_fg,
  cancel_in_favour_manual_discount_fg,
  cancel_in_favour_after_subtotal_fg,
  cancel_in_favour_highest_pos_fg,
  cancel_in_favour_single_pos_fg,
  cancel_in_favour_exact_paym_fg,
  cancel_in_favour_lidl_plus_fg
)
WITH event_group_counts /* we will join with the Param-View 3 times, so we want to trick snowflake to query it once, materialize the result and reuse it */ /* we want to avoid querying the view 3 times because it involves T_INTERNAL_ORGANIZATION_2, we have a policy there, and we want to reduce how many times the policy is evaluated */ AS (
  SELECT
    t_tmp_cancel_friendly_line_groups.retail_event_sid,
    t_tmp_cancel_friendly_line_groups.group_id,
    ANY_VALUE(t_tmp_cancel_friendly_line_groups.cash_register_event_nr) AS cash_register_event_nr,
    ANY_VALUE(t_tmp_cancel_friendly_line_groups.event_start_tmsp) AS event_start_tmsp,
    ANY_VALUE(t_tmp_cancel_friendly_line_groups.bus_dt) AS bus_dt,
    ANY_VALUE(t_tmp_cancel_friendly_line_groups.cash_register_sid) AS cash_register_sid,
    ANY_VALUE(t_tmp_cancel_friendly_line_groups.store_sid) AS store_sid,
    ANY_VALUE(t_tmp_cancel_friendly_line_groups.cashier_hash) AS cashier_hash,
    ANY_VALUE(t_tmp_cancel_friendly_line_groups.txn_net_val) AS txn_net_val,
    ANY_VALUE(t_tmp_cancel_friendly_line_groups.txn_gross_val) AS txn_gross_val,
    ANY_VALUE(t_tmp_cancel_friendly_line_groups.country_org_cd) AS country_org_cd,
    ANY_VALUE(t_tmp_cancel_friendly_line_groups.curr_cd) AS curr_cd,
    ANY_VALUE(t_tmp_cancel_friendly_line_groups.cust_sid) AS cust_sid,
    ANY_VALUE(t_tmp_cancel_friendly_line_groups.cust_ident_type_cd) AS cust_ident_type_cd,
    CAST(count(*) AS BIGNUMERIC) AS lines_per_group, /* count of lines per group */
    sum(t_tmp_cancel_friendly_line_groups.gen_cancel_line_fg) AS gen_cancel_lines_per_group, /* count of generic cancelled lines */
    sum(
      t_tmp_cancel_friendly_line_groups.retail_line_gross_val * t_tmp_cancel_friendly_line_groups.gen_cancel_line_fg
    ) AS cancel_gross_val_per_group,
    sum(
      t_tmp_cancel_friendly_line_groups.prod_variant_qtyx * t_tmp_cancel_friendly_line_groups.gen_cancel_line_fg
    ) AS cancel_qty_per_group,
    sum(t_tmp_cancel_friendly_line_groups.alc_tbc_cancel_line_fg) /* sub-scenario flags */ /* if at least one line in the group has this flag, then the group has the flag */ /* and later if the group is not eliminated as doppletipper, the event will get the flag. */ > CAST('0' AS NUMERIC) AS group_cancel_in_favour_alcohol_tobacco_fg,
    sum(t_tmp_cancel_friendly_line_groups.outside_worktime_cancel_line_fg) > CAST('0' AS NUMERIC) AS group_cancel_in_favour_outside_opening_hr_fg,
    sum(t_tmp_cancel_friendly_line_groups.no_approval_cancel_line_fg) > CAST('0' AS NUMERIC) AS group_cancel_in_favour_without_auth_fg,
    sum(t_tmp_cancel_friendly_line_groups.cancel_after_subtotal_line_fg) > CAST('0' AS NUMERIC) AS group_cancel_in_favour_after_subtotal_fg,
    sum(t_tmp_cancel_friendly_line_groups.cancel_in_favour_highest_pos_line_fg) > CAST('0' AS NUMERIC) AS group_cancel_in_favour_highest_pos_fg,
    sum(t_tmp_cancel_friendly_line_groups.cancel_in_favour_single_pos_line_fg) > CAST('0' AS NUMERIC) AS group_cancel_in_favour_single_pos_line_fg,
    sum(sum(t_tmp_cancel_friendly_line_groups.is_prod_with_manual_discount_fg)) OVER (PARTITION BY t_tmp_cancel_friendly_line_groups.retail_event_sid) AS event_cancel_in_favour_manual_discount_fg /* this is a "count" on Event level (not event+group level) */ /* but it has to be calculated here, before we eliminate groups without cancellations */ /* also we have eliminated cancelled lines with manual discounts, so here we are counting only lines with manual discounts which are not cancelled */
  FROM t_tmp_cancel_friendly_line_groups
  GROUP BY
    1,
    2
), event_counts AS (
  SELECT
    event_group_counts.retail_event_sid,
    ANY_VALUE(event_group_counts.cash_register_event_nr) AS cash_register_event_nr,
    ANY_VALUE(event_group_counts.event_start_tmsp) AS event_start_tmsp,
    ANY_VALUE(event_group_counts.bus_dt) AS bus_dt,
    ANY_VALUE(event_group_counts.cash_register_sid) AS cash_register_sid,
    ANY_VALUE(event_group_counts.store_sid) AS store_sid,
    ANY_VALUE(event_group_counts.cashier_hash) AS cashier_hash,
    ANY_VALUE(event_group_counts.txn_net_val) AS txn_net_val,
    ANY_VALUE(event_group_counts.txn_gross_val) AS txn_gross_val,
    ANY_VALUE(event_group_counts.country_org_cd) AS country_org_cd,
    ANY_VALUE(event_group_counts.curr_cd) AS curr_cd,
    ANY_VALUE(event_group_counts.cust_sid) AS cust_sid,
    ANY_VALUE(event_group_counts.cust_ident_type_cd) AS cust_ident_type_cd,
    sum(event_group_counts.cancel_gross_val_per_group) AS cancel_gross_val_per_event, /* relevant_cancel_gross_val */
    sum(event_group_counts.cancel_qty_per_group) AS cancel_qty_per_event,
    sum(event_group_counts.gen_cancel_lines_per_group) AS gen_cancel_lines_per_event, /* relevant_cancel_line_cnt */
    CAST('1' AS NUMERIC) AS cancel_in_favour_fg,
    CASE sum(event_group_counts.group_cancel_in_favour_alcohol_tobacco_fg)
      WHEN CAST('0' AS NUMERIC)
      THEN CAST('0' AS NUMERIC)
      ELSE CAST('1' AS NUMERIC)
    END AS cancel_in_favour_alcohol_tobacco_fg,
    CASE sum(event_group_counts.group_cancel_in_favour_outside_opening_hr_fg)
      WHEN CAST('0' AS NUMERIC)
      THEN CAST('0' AS NUMERIC)
      ELSE CAST('1' AS NUMERIC)
    END AS cancel_in_favour_outside_opening_hr_fg,
    CASE sum(event_group_counts.group_cancel_in_favour_without_auth_fg)
      WHEN CAST('0' AS NUMERIC)
      THEN CAST('0' AS NUMERIC)
      ELSE CAST('1' AS NUMERIC)
    END AS cancel_in_favour_without_auth_fg,
    CASE sum(event_group_counts.group_cancel_in_favour_after_subtotal_fg)
      WHEN CAST('0' AS NUMERIC)
      THEN CAST('0' AS NUMERIC)
      ELSE CAST('1' AS NUMERIC)
    END AS cancel_in_favour_after_subtotal_fg,
    CASE sum(event_group_counts.group_cancel_in_favour_highest_pos_fg)
      WHEN CAST('0' AS NUMERIC)
      THEN CAST('0' AS NUMERIC)
      ELSE CAST('1' AS NUMERIC)
    END AS cancel_in_favour_highest_pos_fg,
    CASE sum(event_group_counts.group_cancel_in_favour_single_pos_line_fg)
      WHEN CAST('0' AS NUMERIC)
      THEN CAST('0' AS NUMERIC)
      ELSE CAST('1' AS NUMERIC)
    END AS cancel_in_favour_single_pos_fg,
    CASE ANY_VALUE(event_group_counts.event_cancel_in_favour_manual_discount_fg)
      WHEN CAST('0' AS NUMERIC)
      THEN CAST('0' AS NUMERIC)
      ELSE CAST('1' AS NUMERIC)
    END AS cancel_in_favour_manual_discount_fg /* we already calculated this on event level and have same value in all lines for the event, so we just take any of them */
  FROM event_group_counts
  WHERE
    CAST('1' AS NUMERIC) = CAST('1' AS NUMERIC)
    AND event_group_counts.gen_cancel_lines_per_group > CAST('0' AS NUMERIC)
    AND /* eliminate "doppletipper" situation where 1 item_2 is scanned twice by mistake and remove once to fix the mistake */ /* so we exclude situations with multiple scans and 1 cancel */ /* situations more than 1 cancel are not excluded intentionally. */ /* for example scanning one item_2 3 times "by mistake" and having to remove 2 scans seems suspicious ... */ NOT (
      event_group_counts.lines_per_group > CAST('1' AS NUMERIC)
      AND event_group_counts.gen_cancel_lines_per_group = CAST('1' AS NUMERIC)
    )
  GROUP BY
    1
), materialize_param_view AS (
  SELECT
    *
  FROM ldl_data_production.core_app_fraud_detection.v_fraud_detection_parameter_current_value_2
  WHERE
    v_fraud_detection_parameter_current_value.scenario_id = CAST('19' AS NUMERIC)
)
SELECT
  ec.retail_event_sid AS cash_register_event_sid,
  ec.cash_register_event_nr,
  ec.event_start_tmsp,
  ec.bus_dt,
  ec.cash_register_sid,
  cr.cash_register_nr,
  ec.store_sid,
  ec.cashier_hash,
  ec.txn_net_val,
  ec.txn_gross_val,
  ec.cancel_gross_val_per_event AS cancel_in_favour_gross_val,
  ec.curr_cd,
  ec.gen_cancel_lines_per_event AS cancel_in_favour_line_cnt,
  ec.cust_sid,
  ec.cust_ident_type_cd,
  ec.cancel_in_favour_fg,
  ec.cancel_in_favour_alcohol_tobacco_fg,
  ec.cancel_in_favour_outside_opening_hr_fg,
  ec.cancel_in_favour_without_auth_fg,
  ec.cancel_in_favour_manual_discount_fg,
  ec.cancel_in_favour_after_subtotal_fg,
  ec.cancel_in_favour_highest_pos_fg,
  CASE
    WHEN ec.cancel_in_favour_single_pos_fg <> CAST('0' AS NUMERIC)
    AND ec.txn_net_val <= p_sl.param_val_qty
    THEN CAST('1' AS NUMERIC)
    ELSE CAST('0' AS NUMERIC)
  END AS cancel_in_favour_single_pos_fg,
  CASE
    WHEN ec.txn_gross_val > CAST('0' AS NUMERIC)
    AND tpl.chg_aft_pay < CAST('0' AS NUMERIC)
    OR ec.txn_gross_val < CAST('0' AS NUMERIC)
    AND tpl.chg_aft_pay > CAST('0' AS NUMERIC)
    THEN CAST('1' AS NUMERIC)
    ELSE CAST('0' AS NUMERIC)
  END AS cancel_in_favour_exact_paym_fg,
  IF(NOT ec.cust_ident_type_cd IS NULL, CAST('1' AS NUMERIC), CAST('0' AS NUMERIC)) AS cancel_in_favour_lidl_plus_fg
FROM event_counts AS ec
LEFT OUTER JOIN (
  SELECT
    retail_event_sid,
    coalesce(
      MAX(
        CASE paym_line_type_cd
          WHEN 'R'
          THEN retail_event_line_seq
          ELSE CAST('0' AS NUMERIC)
        END
      ),
      CAST('0' AS NUMERIC)
    ) - coalesce(
      MAX(
        CASE paym_line_type_cd
          WHEN 'P'
          THEN retail_event_line_seq
          ELSE CAST('0' AS NUMERIC)
        END
      ),
      CAST('0' AS NUMERIC)
    ) AS chg_aft_pay
  FROM ${fwrk_work_db}.vt1
  INNER JOIN ldl_data_production.core_rel.t_payment_line_2 AS pl
    ON pl.bus_dt = vt1.dwh_cal_dt
    AND pl.country_org_cd = vt1.country_cd
    AND pl.store_sid = vt1.loc_sid
  WHERE
    bus_dt BETWEEN $min_dwh_cal_dt AND $max_dwh_cal_dt
  GROUP BY
    1
) AS tpl
  ON ec.retail_event_sid = tpl.retail_event_sid
INNER JOIN ldl_data_production.core_rel.t_cash_register_2 AS cr
  ON cr.cash_register_sid = ec.cash_register_sid AND cr.dwh_valid_fg = TRUE
INNER JOIN materialize_param_view AS p_ncl /* parameter "number of cancellation lines" */
  ON ec.country_org_cd = p_ncl.country_org_cd
  AND p_ncl.param_id = CAST('57' AS NUMERIC)
  AND /* if scenario is not enabled all receipts from that country_2 will be eliminated in this inner join */ p_ncl.is_scenario_enabled_in_country_fg = TRUE
INNER JOIN materialize_param_view AS p_tci /* parameter "total amount of cancelled items" */
  ON ec.country_org_cd = p_tci.country_org_cd
  AND p_tci.param_id = CAST('58' AS NUMERIC)
INNER JOIN materialize_param_view AS p_ar /* parameter "Proportion of the total of canceled items to the receipt total" (AR stands for Amounts Ratio) */
  ON ec.country_org_cd = p_ar.country_org_cd AND p_ar.param_id = CAST('59' AS NUMERIC)
INNER JOIN materialize_param_view AS p_sl /* parameter "Bonsumme < X LW und nur 1 Artikel_2" */
  ON ec.country_org_cd = p_sl.country_org_cd AND p_sl.param_id = CAST('61' AS NUMERIC)
WHERE
  CAST('1' AS NUMERIC) = CAST('1' AS NUMERIC)
  AND ec.gen_cancel_lines_per_event >= p_ncl.param_val_qty
  AND ec.cancel_gross_val_per_event >= p_tci.param_val_qty
  AND CAST('100' AS NUMERIC) * ec.cancel_gross_val_per_event / nullif(ec.txn_gross_val, CAST('0' AS NUMERIC)) > p_ar.param_val_qty;
;
