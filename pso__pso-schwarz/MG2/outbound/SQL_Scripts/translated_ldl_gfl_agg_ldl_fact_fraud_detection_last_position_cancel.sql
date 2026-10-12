
/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung - DWH / MIS
#----------------------------------------------------------------------------
# Script: ldl_fact_fraud_detection_last_position_cancel.sql
#----------------------------------------------------------------------------
# History:
#  1.0  16.08.2024  Andrzej Wandtke  - ZKP GF - script for scenario Cancel on last position 
						flag CANCEL_LAST_POS_FG

#  1.1	05.09.2024  Kamil Roszczyk   - ZKP GF - Modified the script to fit to the updated data model
						Added the code for two subscenarios
						1. CANCEL_LAST_POS_AFTER_SUBTOTAL_FG
						https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-INTEGER /_workitems/edit/46541
										   
						2. CANCEL_LAST_POS_EXACT_PAYM_FG
						https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-INTEGER /_workitems/edit/46540

#  1.2	23.09.2024	Kamil Roszczyk   - ZKP GF - Added the code for subscenario
						CANCEL_LAST_POS_ALCOHOL_TOBACCO_FG
						https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-INTEGER /_workitems/edit/51848
						

#  1.3	05.11.2024	Mihail Ivanov   - ZKP GF
						Code Refactoring - The huge query with ~10 CTEs is split into 2 queries
							First we create temp table with all lines of the suspicious events, and calculate(evaluate) scenario flags for each line
							Then we put these lines in groups to exclude "Doppeltipper"
							
						Added the code for 3 sub-scenarios:
							CANCEL_LAST_POS_HIGHEST_POS_FG
							,CANCEL_LAST_POS_OUTSIDE_OPENING_HR_FG
							,CANCEL_LAST_POS_MULTI_LINES_FG
						https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-INTEGER /_workitems/edit/56050

#  1.4	09.12.2024	Mihail Ivanov   - ZKP GF bugfixes:
							filter for Cash-Only payments fixed
							Now taking ALL cancellation lines after the retail lines (if more than 1, we take all - not only last)
							Threshold compared with sum of ALL cancelled lines after last retail line
							Changed product group filter, to make it sane as old world
								as requested in this bug:	https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-INTEGER /_workitems/edit/56843/
								
#  1.5	20.01.2025	Mihail Ivanov   - ZKP GF changes (requested here: https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-INTEGER /_workitems/edit/55225)
							Add filter to exclude cancellations of negative values ( for example deposit)
							
							
#  1.6	19.02.2025	Mihail Ivanov   - ZKP GF changes (requested here: https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-INTEGER /_workitems/edit/63798/)
										new sub-scenario for Stornos in receipts with only 1 retail line - CANCEL_LAST_POS_SINGLE_POS_FG
										new sub-scenario for Storno in last position without authorization - CANCEL_LAST_POS_WITHOUT_AUTH_FG
										
#  1.7	25.02.2025	Mihail Ivanov   - ZKP GF changes (requested here: https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-INTEGER /_workitems/edit/63798/)
										Logic for implementation of CANCEL_LAST_POS_SINGLE_POS_FG is changed (fixed, we had it wrong)
										The flag means that we may have many cancelled lines in the receipt and we have only 1 non-cancelled regular retail line (regular means we do not count deposit lines)
										
										Bugfix: for all sub-scenarios we were raising the flag if the group of items has as many cancelled lines as there are lines in the group.
												But if we have 3 lines with 1 bottle of vodka and 2 of these lines are cancelled this is NOT "doppletipper" and should be counted - this is fixed now and we count such groups.

#  1.8  19.03.2025  Kamil Roszczyk  - bugfixing: https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-INTEGER /_workitems/edit/66945
										- changed the threshold comparison for cancelled item values - from comparing of each single item separately to comparing the total amount of all items being in receipt's last position
										- changed the threshold comparison for "Bonsumme < X LW und nur 1 Artikel" subscenario - from comparing net value to comparing gross values
										
#  1.9	25.03.2025	Andrzej Wandtke   - ZKP GF changes - task 66853 - filter on standard cash registers : POS type TIL

#  1.10 26.03.2025	Kamil Roszczyk	- ZKP GF changes
										- replaced filters for turnover relevant and sales receipts to mimic the MIS logic
										- renamed the relevant_cancel_gross_val and relevant_cancel_line_cnt fields to synchronize with the recent data model changes
											https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-INTEGER /_workitems/edit/66945
										- added the logic for removing scenarios data when no threshold is set
											https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-INTEGER /_workitems/edit/63803
											
#  1.11 03.04.2025  Mihail Ivanov  - Changes:
						Removing flag if scneario is disabled is moved out of this script to the main script


#  1.12 04.04.2025	Kamil Roszczyk	- bugfixing
										- changed the calculation method for cancel_last_pos_gross_val and cancel_last_pos_line_cnt
											https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-INTEGER /_workitems/edit/66945
										- modified the filtering on total cancelled items' value

#  1.13 29.04.2025  Kamil Roszczyk	- changes: changed 'TIL' filter for non selfcheckout cash registers
										- filter: "cash_register_type_cd = 'TIL'"; replaced with: "cash_register_type_cd = 'TIL' OR cash_register_type_cd IS NULL"
											https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-INTEGER /_workitems/edit/69257


#  1.14 14.05.2025  Mihail Ivanov  - Changes:
										- Logic for CANCEL_LAST_POS_WITHOUT_AUTH_FG changed. Now set to TRUE only if NONE of the "tail" cancellation lines is approved.
												So evaluating only Cancellation Lines for approval (event approval does not play a role). And only lines that are at the end/last positions of the event ("tail")
										- Logic for CANCEL_LAST_AND_OTHER_POS_FG changed. Now set to TRUE only if we have multiple cancellations at last ("tail") positions.
												Cacenllation Lines that are not at the end (there is retail line after them), are not considered.
										
										Both changes are requested here: https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-INTEGER /_workitems/edit/69530
										
											
	, cancel_last_pos_without_auth_fg
*/


CREATE OR REPLACE TEMPORARY TABLE t_tmp_lines_of_event_with_suspicious_cancel AS WITH event_and_next_event AS (SELECT re.retail_event_sid,
   LEAD(re.retail_event_sid) OVER (PARTITION BY re.bus_dt, CAST(re.cash_register_sid AS STRING) ORDER BY re.cash_register_event_nr
      IS NULL, re.cash_register_event_nr) AS next_retail_event_sid,
   re.cash_register_event_nr,
   re.event_start_tmsp,
   re.bus_dt,
   re.cash_register_sid,
   re.store_sid,
   re.cashier_hash,
   re.txn_net_val,
   re.txn_gross_val,
   re.country_org_cd,
   re.curr_cd,
   re.event_end_tmsp,
   re.turnover_relevant_fg,
   re.retail_event_type_cd
  FROM ${fwrk_work_db}.vt1
   INNER JOIN ldl_data_production_core_rel.t_retail_event AS re ON vt1.loc_sid = re.store_sid AND vt1.dwh_cal_dt = re.bus_dt
       AND vt1.country_cd = re.country_org_cd
       --Delta extraction
  WHERE re.bus_dt BETWEEN $min_dwh_cal_dt AND $max_dwh_cal_dt
      --Standard cash register only
   AND (re.cash_register_type_cd IS NULL OR re.cash_register_type_cd = 'TIL'))
   -- "Tail" in the meaning that these cancellation lines are at the end of receipts
-- after them there are no more regular (product_retail) lines
   , tail_position_cancel AS 
   (SELECT ene.retail_event_sid,
   ene.next_retail_event_sid,
   ene.cash_register_event_nr,
   ene.event_start_tmsp,
   ene.bus_dt,
   ene.cash_register_sid,
   ene.store_sid,
   ene.cashier_hash,
   ene.txn_net_val,
   ene.txn_gross_val,
   ene.country_org_cd,
   ene.curr_cd,
   ene.event_end_tmsp,
   ene.turnover_relevant_fg,
   ene.retail_event_type_cd,
   cl.retail_event_line_seq AS tail_cancel_line_seq,
   cl.event_tmsp AS tail_cancel_tmsp,
   cl.auth_by_hash
  FROM event_and_next_event AS ene
   INNER JOIN ldl_data_production_core_rel.t_cancellation_line AS cl ON ene.retail_event_sid = cl.retail_event_sid AND
       ene.store_sid = cl.store_sid AND ene.bus_dt = cl.bus_dt AND ene.country_org_cd = cl.country_org_cd
   LEFT JOIN ldl_data_production_core_rel.t_product_retail_line AS prl ON ene.retail_event_sid = prl.retail_event_sid
       AND ene.store_sid = prl.store_sid AND ene.bus_dt = prl.bus_dt AND ene.country_org_cd = prl.country_org_cd AND (cl
       .event_tmsp < prl.event_start_tmsp OR cl.event_tmsp = prl.event_start_tmsp AND cl.retail_event_line_seq < prl.retail_event_line_seq
        )
  WHERE prl.retail_event_sid IS NULL
  --Following two filters moved here from event_and_next_event CTE to not eliminate turnover not relevant and non sales receipts as main receipt's followers - in sync with receipt follower definition from MIS
	-- this eliminates cancelled (aborted) and suspended receipts too
   AND ene.turnover_relevant_fg
   AND ene.retail_event_type_cd = 'S'), event_with_suspicious_cancel AS (SELECT
   -- we want only the event, 1 row for every receipt that has suspicous cancellation
 tpc.retail_event_sid,
   tpc.next_retail_event_sid,
   tpc.cash_register_event_nr,
   tpc.event_start_tmsp,
   tpc.bus_dt,
   tpc.cash_register_sid,
   tpc.store_sid,
   tpc.cashier_hash,
   tpc.txn_net_val,
   tpc.txn_gross_val,
   tpc.country_org_cd,
   tpc.curr_cd,
   tpc.event_end_tmsp,
   MAX(tpc.tail_cancel_tmsp) AS last_cancel_tmsp,
   -- how many cancellation lines exist after the last retail line (at the "tail" end of the receipt)
   COUNT(DISTINCT tpc.tail_cancel_line_seq) AS tail_cancel_lines_cnt,
   -- how many of the "tail" cancellation lines are approved for the given event
   COUNT(tpc.auth_by_hash) AS tail_cancel_approved_cnt
  FROM tail_position_cancel AS tpc
   INNER JOIN ldl_data_production_core_rel.t_product_retail_line AS prl0 ON tpc.retail_event_sid = prl0.retail_event_sid
         AND tpc.tail_cancel_line_seq = prl0.cancel_line_seq AND tpc.store_sid = prl0.store_sid AND tpc.bus_dt = prl0.bus_dt
       AND tpc.country_org_cd = prl0.country_org_cd
   INNER JOIN ldl_data_production_core_dim.t_dim_sales_variant AS p ON prl0.prod_variant_sid = p.sales_variant_sid AND p
    .dwh_valid_fg
    --Item quantity lower than 50
  WHERE IFNULL(prl0.prod_variant_cnt, 0) + IFNULL(prl0.prod_variant_qty, 0) < 50
    -- Item within the item groups in scope

   AND p.sub_item_grp_nr <> '74'    -- exclude bakery
   AND prl0.retail_line_gross_val > 0
   AND p.int_item_grp_nr NOT IN ('10', '20')  -- exclude Fruit/Vegetables and Flowers 
   -- cancelled product is not on next receipt
   AND NOT EXISTS (SELECT 1
    FROM ldl_data_production_core_rel.t_product_retail_line AS n_prl
    WHERE retail_event_sid = tpc.next_retail_event_sid
     AND local_prod_nr = prl0.local_prod_nr
     AND bus_dt = tpc.bus_dt
     AND country_org_cd = tpc.country_org_cd)

   --Cash payments only
   AND NOT EXISTS (SELECT 1
    FROM ldl_data_production_core_rel.t_payment_line AS pl
    WHERE retail_event_sid = tpc.retail_event_sid
     AND paym_type_id <> 11
     AND bus_dt = tpc.bus_dt
     AND country_org_cd = tpc.country_org_cd
     AND bus_dt BETWEEN $min_dwh_cal_dt AND $max_dwh_cal_dt)
   
   -- Filter to exclude cancellations of negative values (for example deposit)
   AND p.int_item_grp_nr IS NOT NULL
  GROUP BY tpc.retail_event_sid,
   tpc.next_retail_event_sid,
   tpc.cash_register_event_nr,
   tpc.event_start_tmsp,
   tpc.bus_dt,
   tpc.cash_register_sid,
   tpc.store_sid,
   tpc.cashier_hash,
   tpc.txn_net_val,
   tpc.txn_gross_val,
   tpc.country_org_cd,
   tpc.curr_cd,
   tpc.event_end_tmsp), materialize_param_view AS (SELECT param_id,
   scenario_id,
   scenario_type_cd,
   param_name,
   country_org_cd,
   param_default_val_qty,
   param_country_val_qty,
   param_val_qty,
   param_last_update_tmsp,
   is_scenario_enabled_in_country_fg
  FROM ldl_data_production_core_app_fraud_detection.v_fraud_detection_parameter_current_value
  WHERE scenario_id = 18) 
  (


-- lines_of_event_with_suspicious_cancel
  SELECT ewsc.retail_event_sid,
   ewsc.next_retail_event_sid,
   ewsc.cash_register_event_nr,
   ewsc.event_start_tmsp,
   ewsc.bus_dt,
   ewsc.cash_register_sid,
   ewsc.store_sid,
   ewsc.cashier_hash,
   ewsc.txn_net_val,
   ewsc.txn_gross_val,
   ewsc.country_org_cd,
   ewsc.curr_cd,
   ewsc.event_end_tmsp,
   ewsc.last_cancel_tmsp,
   ewsc.tail_cancel_lines_cnt,
   ewsc.tail_cancel_approved_cnt,
   tprl.local_prod_nr,
   tprl.retail_line_gross_val,
   tprl.prod_variant_sid,
   tprl.retail_event_line_seq,
   tprl.cancel_line_seq,
   tprl.prod_variant_input_nr,
   tprl.auth_by_hash,
   tprl.prod_entry_method_cd,
    IFNULL(tprl.prod_variant_cnt, 0) + IFNULL(tprl.prod_variant_qty, 0) AS prod_variant_qtyx,
   MAX(tprl.base_gross_val) OVER (PARTITION BY CAST(ewsc.retail_event_sid AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING
    AND UNBOUNDED FOLLOWING) AS max_line_amt_per_event
    -- for flag "CANCEL_LAST_POS_SINGLE_POS_FG" we need to make sure only 1 regular retail line (excl. deposits) is not cancelled.
    ,SUM(IF(tprl.cancel_line_seq IS NULL AND tprl.prod_retail_line_type_cd = 'S', 1, 0)) OVER (PARTITION BY CAST(ewsc.retail_event_sid AS STRING)
      RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS event_non_cancelled_retail_line_cnt,
   ROW_NUMBER() OVER (PARTITION BY CAST(ewsc.retail_event_sid AS STRING) ORDER BY tprl.event_start_tmsp IS NULL, tprl.event_start_tmsp
      , tprl.retail_event_line_seq IS NULL, tprl.retail_event_line_seq) AS line_rn,
   --Cancellation at last position
    CASE
    WHEN tpc.retail_event_sid IS NOT NULL AND tprl.retail_line_gross_val > 0
    THEN 1
    ELSE 0
    END AS last_pos_cancel_line_fg,

    --Cancellation at last position after subtotal
    CASE
    WHEN CASE
       WHEN tpc.retail_event_sid IS NOT NULL AND tprl.retail_line_gross_val > 0
       THEN 1
       ELSE 0
       END = 1 AND tsl.retail_event_sid IS NOT NULL
    THEN 1
    ELSE 0
    END AS last_pos_after_subtotal_cancel_fg,

    --Cancellation of alcohol/tobacco at last position
    CASE
    WHEN CASE
       WHEN tpc.retail_event_sid IS NOT NULL AND tprl.retail_line_gross_val > 0
       THEN 1
       ELSE 0
       END = 1 AND p0.sub_item_grp_nr IN ('60', '61', '63', '80')
    THEN 1
    ELSE 0
    END AS last_pos_alc_tbc_cancel_fg,

    -- Line with the biggest amount is cancelled by "last cancel"
    CASE
    WHEN CASE
       WHEN tpc.retail_event_sid IS NOT NULL AND tprl.retail_line_gross_val > 0
       THEN 1
       ELSE 0
       END = 1 AND tprl.base_gross_val = (MAX(tprl.base_gross_val) OVER (PARTITION BY CAST(ewsc.retail_event_sid AS STRING)
          RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING))
    THEN 1
    ELSE 0
    END AS last_pos_highest_pos_fg,
    
    -- Cancellation (Storno) is outside work hours
    CASE
    WHEN CASE
       WHEN tpc.retail_event_sid IS NOT NULL AND tprl.retail_line_gross_val > 0
       THEN 1
       ELSE 0
       END = 1 AND (TIME(ewsc.event_start_tmsp) < soh.open_tm OR TIME(ewsc.event_end_tmsp) > soh.close_tm)
    THEN 1
    ELSE 0
    END AS last_pos_outside_opening_hr_fg,

    -- Cancellation of multiple lines which are at last(tail) position - meaning not retail lines after them
    CASE
    WHEN CASE
       WHEN tpc.retail_event_sid IS NOT NULL AND tprl.retail_line_gross_val > 0
       THEN 1
       ELSE 0
       END = 1 AND ewsc.tail_cancel_lines_cnt > 1
    THEN 1
    ELSE 0
    END AS last_and_other_pos_fg,

    -- Cancellations at last position without approval - None of the "tail" cancelation lines is approved (other cancellation lines that are at "regular" position might still be approved, but we do not care for this situation)
    CASE
    WHEN CASE
       WHEN tpc.retail_event_sid IS NOT NULL AND tprl.retail_line_gross_val > 0
       THEN 1
       ELSE 0
       END = 1 AND ewsc.tail_cancel_approved_cnt = 0
    THEN 1
    ELSE 0
    END AS no_approval_cancel_line_fg,

    /* Storno of the only retail line */
    CASE
    WHEN CASE
        WHEN tpc.retail_event_sid IS NOT NULL AND tprl.retail_line_gross_val > 0
        THEN 1
        ELSE 0
        END = 1 AND (SUM(IF(tprl.cancel_line_seq IS NULL AND tprl.prod_retail_line_type_cd = 'S', 1, 0)) OVER (PARTITION BY CAST(ewsc.retail_event_sid AS STRING)
           RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) = 1 AND ewsc.txn_gross_val <= p_sl.param_val_qty
    THEN 1
    ELSE 0
    END AS cancel_single_pos_line_fg
  FROM event_with_suspicious_cancel AS ewsc
   INNER JOIN ldl_data_production_core_rel.t_product_retail_line AS tprl ON ewsc.retail_event_sid = tprl.retail_event_sid
        AND ewsc.store_sid = tprl.store_sid AND ewsc.bus_dt = tprl.bus_dt AND ewsc.country_org_cd = tprl.country_org_cd
   INNER JOIN materialize_param_view AS p_sl -- parameter "Bonsumme < X LW und nur 1 Artikel" 
   ON ewsc.country_org_cd = p_sl.country_org_cd AND p_sl.param_id = 56
      -- if scenario is not enabled all receipts from that country will be eliminated in this inner join
 AND p_sl.is_scenario_enabled_in_country_fg
    
   LEFT JOIN ldl_data_production_core_rel.t_cancellation_line AS cl0 ON ewsc.retail_event_sid = cl0.retail_event_sid AND
      tprl.cancel_line_seq = cl0.retail_event_line_seq AND cl0.bus_dt BETWEEN $min_dwh_cal_dt AND $max_dwh_cal_dt
   LEFT JOIN tail_position_cancel AS tpc ON ewsc.retail_event_sid = tpc.retail_event_sid AND tprl.cancel_line_seq = tpc
     .tail_cancel_line_seq
   LEFT JOIN ldl_data_production_core_dim.t_dim_sales_variant AS p0 ON tprl.prod_variant_sid = p0.sales_variant_sid AND
    p0.dwh_valid_fg
   LEFT JOIN ldl_data_production_core_rel.t_store_opening_hours AS soh ON ewsc.store_sid = soh.store_sid AND EXTRACT(DAYOFWEEK
        FROM ewsc.bus_dt) - 1 = soh.day_of_week AND soh.dwh_valid_fg
   
   --Joining to t_subtotal_line to find subtotal rows appearing before cancellation
	-- we just need to check if sub-total line exists before the storno (which is in last position in this case), so we take the earliest sub-total line

   LEFT JOIN (SELECT sl.retail_event_sid,
     MIN(sl.event_tmsp) AS first_subtotal_line_tmsp
    FROM ${fwrk_work_db}.vt1 AS vt11
     INNER JOIN ldl_data_production_core_rel.t_subtotal_line AS sl ON vt11.loc_sid = sl.store_sid AND vt11.dwh_cal_dt =
        sl.bus_dt AND vt11.country_cd = sl.country_org_cd
    WHERE sl.bus_dt BETWEEN $min_dwh_cal_dt AND $max_dwh_cal_dt
    GROUP BY sl.retail_event_sid) AS tsl ON ewsc.retail_event_sid = tsl.retail_event_sid AND ewsc.last_cancel_tmsp > tsl
     .first_subtotal_line_tmsp);



INSERT INTO ${fwrk_work_db}.t_fact_fraud_detection_by_cash_register_event_final (cashier_hash,
 txn_net_val, cash_register_event_nr, cash_register_sid, curr_cd, cash_register_nr, txn_gross_val, event_start_tmsp,
 cash_register_event_sid, bus_dt, store_sid, cancel_last_pos_without_auth_fg, cancel_last_pos_single_pos_fg,
 cancel_last_and_other_pos_fg, cancel_last_pos_fg, cancel_last_pos_exact_paym_fg, cancel_last_pos_line_cnt,
 cancel_last_pos_gross_val, cancel_last_pos_alcohol_tobacco_fg, cancel_last_pos_after_subtotal_fg,
 cancel_last_pos_highest_pos_fg, cancel_last_pos_outside_opening_hr_fg)
WITH event_lines_change_flag AS (SELECT 
    --Doppeltipper: mark row if this and the previous row were scanned
    retail_event_sid,
    next_retail_event_sid,
    cash_register_event_nr,
    event_start_tmsp,
    bus_dt,
    cash_register_sid,
    store_sid,
    cashier_hash,
    txn_net_val,
    txn_gross_val,
    country_org_cd,
    curr_cd,
    event_end_tmsp,
    last_cancel_tmsp,
    tail_cancel_lines_cnt,
    tail_cancel_approved_cnt,
    local_prod_nr,
    retail_line_gross_val,
    prod_variant_sid,
    retail_event_line_seq,
    cancel_line_seq,
    prod_variant_input_nr,
    auth_by_hash,
    prod_entry_method_cd,
    prod_variant_qtyx,
    max_line_amt_per_event,
    event_non_cancelled_retail_line_cnt,
    line_rn,
    last_pos_cancel_line_fg,
    last_pos_after_subtotal_cancel_fg,
    last_pos_alc_tbc_cancel_fg,
    last_pos_highest_pos_fg,
    last_pos_outside_opening_hr_fg,
    last_and_other_pos_fg,
    no_approval_cancel_line_fg,
    cancel_single_pos_line_fg,
     CASE
     WHEN (LAG(prod_entry_method_cd) OVER (PARTITION BY CAST(retail_event_sid AS STRING) ORDER BY line_rn IS NULL,
           line_rn)) IS NOT DISTINCT FROM prod_entry_method_cd AND prod_entry_method_cd = 'SC'
     THEN 1
     ELSE 0
     END AS curr_and_prev_scanned_fg,
     --Doppeltipper: mark row as not changed only when the item and quantity are the same as in a previous row and when this is the consecutive scan
     CASE
     WHEN CASE
         WHEN (LAG(prod_entry_method_cd) OVER (PARTITION BY CAST(retail_event_sid AS STRING) ORDER BY line_rn IS NULL,
               line_rn)) IS NOT DISTINCT FROM prod_entry_method_cd AND prod_entry_method_cd = 'SC'
         THEN 1
         ELSE 0
         END = 1 AND (LAG(local_prod_nr) OVER (PARTITION BY CAST(retail_event_sid AS STRING) ORDER BY line_rn IS NULL,
            line_rn)) IS NOT DISTINCT FROM local_prod_nr AND (LAG(prod_variant_qtyx) OVER (PARTITION BY CAST(retail_event_sid AS STRING)
           ORDER BY line_rn IS NULL, line_rn)) IS NOT DISTINCT FROM prod_variant_qtyx
     THEN 0
     ELSE 1
     END AS doppeltipper_change_fg
   FROM t_tmp_lines_of_event_with_suspicious_cancel), event_lines_groups AS (SELECT retail_event_sid,
    next_retail_event_sid,
    cash_register_event_nr,
    event_start_tmsp,
    bus_dt,
    cash_register_sid,
    store_sid,
    cashier_hash,
    txn_net_val,
    txn_gross_val,
    country_org_cd,
    curr_cd,
    event_end_tmsp,
    last_cancel_tmsp,
    tail_cancel_lines_cnt,
    tail_cancel_approved_cnt,
    local_prod_nr,
    retail_line_gross_val,
    prod_variant_sid,
    retail_event_line_seq,
    cancel_line_seq,
    prod_variant_input_nr,
    auth_by_hash,
    prod_entry_method_cd,
    prod_variant_qtyx,
    max_line_amt_per_event,
    event_non_cancelled_retail_line_cnt,
    line_rn,
    last_pos_cancel_line_fg,
    last_pos_after_subtotal_cancel_fg,
    last_pos_alc_tbc_cancel_fg,
    last_pos_highest_pos_fg,
    last_pos_outside_opening_hr_fg,
    last_and_other_pos_fg,
    no_approval_cancel_line_fg,
    cancel_single_pos_line_fg,
    curr_and_prev_scanned_fg,
    doppeltipper_change_fg,
    SUM(doppeltipper_change_fg) OVER (PARTITION BY CAST(retail_event_sid AS STRING) ORDER BY line_rn IS NULL, line_rn
     ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS group_id
   FROM event_lines_change_flag AS t0), event_group_counts AS (SELECT retail_event_sid,
    group_id,
    ANY_VALUE(cash_register_event_nr) AS cash_register_event_nr,
    ANY_VALUE(event_start_tmsp) AS event_start_tmsp,
    ANY_VALUE(bus_dt) AS bus_dt,
    ANY_VALUE(cash_register_sid) AS cash_register_sid,
    ANY_VALUE(store_sid) AS store_sid,
    ANY_VALUE(cashier_hash) AS cashier_hash,
    ANY_VALUE(txn_net_val) AS txn_net_val,
    ANY_VALUE(txn_gross_val) AS txn_gross_val,
    ANY_VALUE(country_org_cd) AS country_org_cd,
    ANY_VALUE(curr_cd) AS curr_cd,
    COUNT(*) AS lines_per_group,
    SUM(last_pos_cancel_line_fg) AS last_pos_cancel_lines_per_group,

    --Still calculating cancelled gross value per group - this will be compared with "Total value of cancelled items" threshold and should be filtered out by Doppeltipper logic before compared as per requirement
    SUM(retail_line_gross_val * last_pos_cancel_line_fg) AS cancel_gross_val_per_group,
    --Calculating final values for cancel_last_pos_line_cnt and cancel_last_pos_gross_val here
		--In MIS the report metrics that use fields corresponding to these two contain aggregated values for all lines being at last positions, regardless they could fall into Doppeltipper exclusion or not
		--So if we have two cancellations in last positions from which one should be excluded by Doppeltipper and another following cancellation that should not be affected by Doppeltipper then the metric for gross value of last position cancellations should aggregate both these lines
		--Then, to avoid affection by Doppeltipper filter in next event_counts CTE, both these fields are calculated here using window functions
    SUM(SUM(last_pos_cancel_line_fg)) OVER (PARTITION BY CAST(retail_event_sid AS STRING) RANGE BETWEEN
     UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS last_pos_cancel_lines_per_event,
    SUM(SUM(retail_line_gross_val * last_pos_cancel_line_fg)) OVER (PARTITION BY CAST(retail_event_sid AS STRING)
     RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS cancel_gross_val_per_event,
     -- sub-scenario flags
		-- if at least one line in the group has this flag, then the group has the flag 
		-- and later if the group is not eliminated as doppletipper, the event will get the flag.
     CASE
     WHEN SUM(last_pos_after_subtotal_cancel_fg) > 0
     THEN 1
     ELSE 0
     END AS group_last_pos_after_subtotal_cancel_fg,
     CASE
     WHEN SUM(last_pos_alc_tbc_cancel_fg) > 0
     THEN 1
     ELSE 0
     END AS group_last_pos_alc_tbc_cancel_fg,
     CASE
     WHEN SUM(last_pos_highest_pos_fg) > 0
     THEN 1
     ELSE 0
     END AS group_last_pos_highest_pos_cancel_fg,
     CASE
     WHEN SUM(last_pos_outside_opening_hr_fg) > 0
     THEN 1
     ELSE 0
     END AS group_last_pos_outside_opening_hr_cancel_fg,
     CASE
     WHEN SUM(last_and_other_pos_fg) > 0
     THEN 1
     ELSE 0
     END AS group_last_and_other_pos_cancel_fg,
     CASE
     WHEN SUM(no_approval_cancel_line_fg) > 0
     THEN 1
     ELSE 0
     END AS group_no_approval_cancel_fg,
     CASE
     WHEN SUM(cancel_single_pos_line_fg) > 0
     THEN 1
     ELSE 0
     END AS group_cancel_single_pos_line_fg
   FROM event_lines_groups AS t2
   GROUP BY retail_event_sid,
    group_id), materialize_param_view AS (SELECT param_id,
    scenario_id,
    scenario_type_cd,
    param_name,
    country_org_cd,
    param_default_val_qty,
    param_country_val_qty,
    param_val_qty,
    param_last_update_tmsp,
    is_scenario_enabled_in_country_fg
   FROM ldl_data_production_core_app_fraud_detection.v_fraud_detection_parameter_current_value
   WHERE scenario_id = 18), event_counts AS (SELECT egc.retail_event_sid,
    ANY_VALUE(egc.cash_register_event_nr) AS cash_register_event_nr,
    ANY_VALUE(egc.event_start_tmsp) AS event_start_tmsp,
    ANY_VALUE(egc.bus_dt) AS bus_dt,
    ANY_VALUE(egc.cash_register_sid) AS cash_register_sid,
    ANY_VALUE(egc.store_sid) AS store_sid,
    ANY_VALUE(egc.cashier_hash) AS cashier_hash,
    ANY_VALUE(egc.txn_net_val) AS txn_net_val,
    ANY_VALUE(egc.txn_gross_val) AS txn_gross_val,
    ANY_VALUE(egc.country_org_cd) AS country_org_cd,
    ANY_VALUE(egc.curr_cd) AS curr_cd,

    --Passing any value from groups CTE as these two fields were already calculated on receipt level
    ANY_VALUE(egc.cancel_gross_val_per_event) AS cancel_gross_val_per_event,
    ANY_VALUE(egc.last_pos_cancel_lines_per_event) AS last_position_cancel_lines_per_event,
    1 AS cancel_last_pos_fg,
     CASE
     WHEN SUM(egc.group_last_pos_after_subtotal_cancel_fg) = 0
     THEN 0
     ELSE 1
     END AS cancel_last_pos_after_subtotal_fg,
     CASE
     WHEN SUM(egc.group_last_pos_alc_tbc_cancel_fg) = 0
     THEN 0
     ELSE 1
     END AS cancel_last_pos_alcohol_tobacco_fg,
     CASE
     WHEN SUM(egc.group_last_pos_highest_pos_cancel_fg) = 0
     THEN 0
     ELSE 1
     END AS cancel_last_pos_highest_pos_fg,
     CASE
     WHEN SUM(egc.group_last_pos_outside_opening_hr_cancel_fg) = 0
     THEN 0
     ELSE 1
     END AS cancel_last_pos_outside_opening_hr_fg,
     CASE
     WHEN SUM(egc.group_last_and_other_pos_cancel_fg) = 0
     THEN 0
     ELSE 1
     END AS cancel_last_and_other_pos_fg,
     CASE
     WHEN SUM(egc.group_no_approval_cancel_fg) = 0
     THEN 0
     ELSE 1
     END AS cancel_last_pos_without_auth_fg,
     CASE
     WHEN SUM(egc.group_cancel_single_pos_line_fg) = 0
     THEN 0
     ELSE 1
     END AS cancel_last_pos_single_pos_fg
   FROM event_group_counts AS egc

   --Parameter "Total value of cancelled items"
    INNER JOIN materialize_param_view AS p_tcl ON egc.country_org_cd = p_tcl.country_org_cd -- take only groups for which we have cancellation by the last position
    AND p_tcl.param_id = 55
   WHERE egc.last_pos_cancel_lines_per_group > 0
     -- Doppeltipper: filter out groups where there are two or more consecutively scanned items with only one corresponding line cancel

     
    AND (egc.lines_per_group <= 1 OR egc.last_pos_cancel_lines_per_group <> 1)
   GROUP BY egc.retail_event_sid
   HAVING a18 > a19) (SELECT ec.cashier_hash,
    ec.txn_net_val,
    ec.cash_register_event_nr,
    ec.cash_register_sid,
    ec.curr_cd,
    CAST(cr.cash_register_nr AS STRING) AS cash_register_nr,
    ec.txn_gross_val,
    ec.event_start_tmsp,
    ec.retail_event_sid AS cash_register_event_sid,
    ec.bus_dt,
    ec.store_sid,
     ec.cancel_last_pos_without_auth_fg <> 0 AS cancel_last_pos_without_auth_fg,
     ec.cancel_last_pos_single_pos_fg <> 0 AS cancel_last_pos_single_pos_fg,
     ec.cancel_last_and_other_pos_fg <> 0 AS cancel_last_and_other_pos_fg,
     ec.cancel_last_pos_fg <> 0 AS cancel_last_pos_fg,
      CASE
      WHEN ec.txn_gross_val > 0 AND tpl.chg_aft_pay < 0 OR ec.txn_gross_val < 0 AND tpl.chg_aft_pay > 0
      THEN 1
      ELSE 0
      END <> 0 AS cancel_last_pos_exact_paym_fg,
    ec.last_position_cancel_lines_per_event AS cancel_last_pos_line_cnt,
    ec.cancel_gross_val_per_event AS cancel_last_pos_gross_val,
     ec.cancel_last_pos_alcohol_tobacco_fg <> 0 AS cancel_last_pos_alcohol_tobacco_fg,
     ec.cancel_last_pos_after_subtotal_fg <> 0 AS cancel_last_pos_after_subtotal_fg,
     ec.cancel_last_pos_highest_pos_fg <> 0 AS cancel_last_pos_highest_pos_fg,
     ec.cancel_last_pos_outside_opening_hr_fg <> 0 AS cancel_last_pos_outside_opening_hr_fg
   FROM event_counts AS ec
    INNER JOIN ldl_data_production_core_rel.t_cash_register AS cr ON ec.cash_register_sid = cr.cash_register_sid AND cr
     .dwh_valid_fg
    LEFT JOIN (SELECT retail_event_sid,
       COALESCE(MAX(CASE
          WHEN paym_line_type_cd = 'R'
          THEN retail_event_line_seq
          ELSE 0
          END), 0) - COALESCE(MAX(CASE
          WHEN paym_line_type_cd = 'P'
          THEN retail_event_line_seq
          ELSE 0
          END), 0) AS chg_aft_pay
     FROM ldl_data_production_core_rel.t_payment_line
     WHERE bus_dt BETWEEN $min_dwh_cal_dt AND $max_dwh_cal_dt
      AND (country_org_cd, bus_dt, CAST(store_sid AS BIGNUMERIC)) IN (SELECT (country_cd, dwh_cal_dt, loc_sid)
        FROM ${fwrk_work_db}.vt1)
     GROUP BY retail_event_sid) AS tpl ON ec.retail_event_sid = tpl.retail_event_sid)

   --Doppeltipper: filter out receipts with no more last position cancellations after Doppeltipper groups being removed in a previous subquery
	-- NOT NEEDED - only 1 group can have items cancelled by "last cancel" and this is the group we take in the previous sub-query
	--ec.last_position_cancel_lines_per_event > 0  
     ;