/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung - DWH / MIS
#----------------------------------------------------------------------------
# Script: ldl_fact_fraud_detection_last_position_cancel.sql
#----------------------------------------------------------------------------
# History:
#  1.0  16.08.2024  Andrzej Wandtke  - ZKP GF_2 - script for scenario Cancel on last position 
						flag CANCEL_LAST_POS_FG

#  1.1	05.09.2024  Kamil Roszczyk   - ZKP GF_2 - Modified the script to fit to the updated data model
						Added the code for two subscenarios
						1. CANCEL_LAST_POS_AFTER_SUBTOTAL_FG
						https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/46541
										   
						2. CANCEL_LAST_POS_EXACT_PAYM_FG
						https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/46540

#  1.2	23.09.2024	Kamil Roszczyk   - ZKP GF_2 - Added the code for subscenario
						CANCEL_LAST_POS_ALCOHOL_TOBACCO_FG
						https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/51848
						

#  1.3	05.11.2024	Mihail Ivanov   - ZKP GF_2
						Code Refactoring - The huge query with ~10 CTEs is split into 2 queries
							First we create temp table with all lines of the suspicious events, and calculate(evaluate) scenario flags for each line
							Then we put these lines in groups to exclude "Doppeltipper"
							
						Added the code for 3 sub-scenarios:
							CANCEL_LAST_POS_HIGHEST_POS_FG
							,CANCEL_LAST_POS_OUTSIDE_OPENING_HR_FG
							,CANCEL_LAST_POS_MULTI_LINES_FG
						https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/56050

#  1.4	09.12.2024	Mihail Ivanov   - ZKP GF_2 bugfixes:
							filter for Cash-Only payments fixed
							Now taking ALL cancellation lines after the retail lines (if more than 1, we take all - not only last)
							Threshold compared with sum of ALL cancelled lines after last retail line
							Changed product group filter, to make it same as old world
								as requested in this bug:	https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/56843/
								
#  1.5	20.01.2025	Mihail Ivanov   - ZKP GF_2 changes (requested here: https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/55225)
							Add filter to exclude cancellations of negative values ( for example deposit)
							
							
#  1.6	19.02.2025	Mihail Ivanov   - ZKP GF_2 changes (requested here: https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/63798/)
										new sub-scenario for Stornos in receipts with only 1 retail line - CANCEL_LAST_POS_SINGLE_POS_FG
										new sub-scenario for Storno in last position without authorization - CANCEL_LAST_POS_WITHOUT_AUTH_FG
										
#  1.7	25.02.2025	Mihail Ivanov   - ZKP GF_2 changes (requested here: https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/63798/)
										Logic for implementation of CANCEL_LAST_POS_SINGLE_POS_FG is changed (fixed, we had it wrong)
										The flag means that we may have many cancelled lines in the receipt and we have only 1 non-cancelled regular retail line (regular means we do not count deposit lines)
										
										Bugfix: for all sub-scenarios we were raising the flag if the group of items has as many cancelled lines as there are lines in the group.
												But if we have 3 lines with 1 bottle of vodka and 2 of these lines are cancelled this is NOT "doppletipper" and should be counted - this is fixed now and we count such groups.

#  1.8  19.03.2025  Kamil Roszczyk  - bugfixing: https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/66945
										- changed the threshold comparison for cancelled item_2 values - from comparing of each single item_2 separately to comparing the total amount of all items being in receipt's last position
										- changed the threshold comparison for "Bonsumme < X LW und nur 1 Artikel_2" subscenario - from comparing net value to comparing gross values
										
#  1.9	25.03.2025	Andrzej Wandtke   - ZKP GF_2 changes - task 66853 - filter on standard cash registers : POS type TIL

#  1.10 26.03.2025	Kamil Roszczyk	- ZKP GF_2 changes
										- replaced filters for turnover relevant and sales_2 receipts to mimic the MIS logic
										- renamed the relevant_cancel_gross_val and relevant_cancel_line_cnt fields to synchronize with the recent data model changes
											https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/66945
										- added the logic for removing scenarios data when no threshold is set
											https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/63803
											
#  1.11 03.04.2025  Mihail Ivanov  - Changes:
						Removing flag if scneario is disabled is moved out of this script to the main script


#  1.12 04.04.2025	Kamil Roszczyk	- bugfixing
										- changed the calculation method for cancel_last_pos_gross_val and cancel_last_pos_line_cnt
											https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/66945
										- modified the filtering on total cancelled items' value

#  1.13 29.04.2025  Kamil Roszczyk	- changes: changed 'TIL' filter for non selfcheckout cash registers
										- filter: "cash_register_type_cd = 'TIL'"; replaced with: "cash_register_type_cd = 'TIL' OR cash_register_type_cd IS NULL"
											https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/69257


#  1.14 14.05.2025  Mihail Ivanov  - Changes:
										- Logic for CANCEL_LAST_POS_WITHOUT_AUTH_FG changed. Now set to TRUE only if NONE of the "tail" cancellation lines is approved.
												So evaluating only Cancellation Lines for approval (event approval does not play a role). And only lines that are at the end/last positions of the event ("tail")
										- Logic for CANCEL_LAST_AND_OTHER_POS_FG changed. Now set to TRUE only if we have multiple cancellations at last ("tail") positions.
												Cacenllation Lines that are not at the end (there is retail line after them), are not considered.
										
										Both changes are requested here: https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/69530
										
#  1.15 21.08.2025  Mihail Ivanov  - Changes:
										- Product group "Flowers" is now considered an important product and is no longer excluded.
											Requested here: https://jira.schwarz/browse/NEOGFPL-71587
										- Added one more acceptable option for CASH_REGISTER_TYPE_CD (value 'POS') to handle locations where OmniPos system is used
											Requested here: https://jira.schwarz/browse/NEOGFPL-71619
											
	
#  1.16 15.09.2025  Mihail Ivanov  - Changes:	
										- counts of "tail cancel" lines and how much of them are approved now includes all product types.
											Fruits, Veggies, Bakery are now included but only for event that have tail cancel line of other products too.
											https://jira.schwarz/browse/NEOGFPL-71587
											
											
#  1.17  29.10.2025  Mihail Ivanov  - Changes: 
										Conditions for "Doppeltipper" changed. 
										Now we look for at least one scanned line in group (instead of "all lines must be scanned") 
										requested here: https://jira.schwarz/browse/NEOGFPL-71681

#  1.18  03.03.2026  Andrzej Wandtke  - Changes: 
										Include the 'D' type in the list of codes in PROD_RETAIL_LINE_TYPE_CD as to add return deposits for the flag CANCEL_LAST_POS_SINGLE_POS_FG
										requested here: https://jira.schwarz/browse/NEOGFPL-71875
#  1.19  09.03.2026  Andrzej Wandtke  - Changes: 
										 When a payment line is there and no line with change after it (meaning that no change was paid back to the customer) 
										-> set the flag CANCEL_LAST_POS_EXACT_PAYM_FG to True, even if gross value is 0
										Technically: Use condition ec.txn_gross_val >= 0 instead of ec.txn_gross_val > 0
										requested here: https://jira.schwarz/browse/NEOGFPL-71889

*/



CREATE OR REPLACE TEMPORARY TABLE t_tmp_lines_of_event_with_suspicious_cancel AS WITH EVENT_AND_NEXT_EVENT AS (SELECT RE.retail_event_sid,
   LEAD(RE.retail_event_sid) OVER (PARTITION BY RE.bus_dt, RE.cash_register_sid ORDER BY RE.cash_register_event_nr
      IS NULL, RE.cash_register_event_nr) AS next_retail_event_sid,
   RE.cash_register_event_nr,
   RE.event_start_tmsp,
   RE.bus_dt,
   RE.cash_register_sid,
   RE.store_sid,
   RE.cashier_hash,
   RE.txn_net_val,
   RE.txn_gross_val,
   RE.country_org_cd,
   RE.curr_cd,
   RE.event_end_tmsp,
   RE.turnover_relevant_fg,
   RE.retail_event_type_cd
  FROM ${FWRK_WORK_DB}.vt1
   INNER JOIN ldl_data_core_rel.t_retail_event_2 AS RE_2 ON vt1.loc_sid = RE.store_sid AND vt1.dwh_cal_dt = RE.bus_dt AND
     vt1.country_cd = RE.country_org_cd
  WHERE 
   -- Delta extraction
   RE.bus_dt BETWEEN $min_dwh_cal_dt AND $max_dwh_cal_dt
   AND (RE.cash_register_type_cd IN ('TIL', 'POS') OR RE.cash_register_type_cd IS NULL)), TAIL_POSITION_CANCEL AS (SELECT
   ene.retail_event_sid,
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
   CL.retail_event_line_seq AS tail_cancel_line_seq,
   CL.event_tmsp AS tail_cancel_tmsp,
   CL.auth_by_hash,
   -- The following calculations are done here ( not in "event_with_suspicious_cancel") because we want to include all cancellations in tail positions
   -- even those with "unimportant products" (Fruits/Veggies)
   COUNT( CL.retail_event_line_seq) OVER (PARTITION BY ene.retail_event_sid RANGE BETWEEN
    UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS tail_cancel_lines_cnt,
   COUNT(CL.auth_by_hash) OVER (PARTITION BY ene.retail_event_sid RANGE BETWEEN UNBOUNDED PRECEDING AND
    UNBOUNDED FOLLOWING) AS tail_cancel_approved_cnt
  FROM EVENT_AND_NEXT_EVENT AS ene
   INNER JOIN ldl_data_core_rel.t_cancellation_line_2 AS CL ON ene.retail_event_sid = CL.retail_event_sid AND ene.store_sid
        = CL.store_sid AND ene.bus_dt = CL.bus_dt AND ene.country_org_cd = CL.country_org_cd
   LEFT JOIN ldl_data_core_rel.t_product_retail_line_2 AS PRL ON ene.retail_event_sid = PRL.retail_event_sid AND ene.store_sid
         = PRL.store_sid AND ene.bus_dt = PRL.bus_dt AND ene.country_org_cd = PRL.country_org_cd AND (CL.event_tmsp <
       PRL.event_start_tmsp OR CL.event_tmsp = PRL.event_start_tmsp AND CL.retail_event_line_seq < PRL.retail_event_line_seq
        )
  WHERE PRL.retail_event_sid IS NULL
   -- Following two filters moved here from event_and_next_event CTE to not eliminate turnover not relevant and non sales_2 receipts as main receipt's followers - in sync with receipt follower definition from MIS
   -- this eliminates cancelled (aborted) and suspended receipts too
   AND ene.turnover_relevant_fg
   -- Sales_2 receipts only
   AND ene.retail_event_type_cd = 'S'), EVENT_WITH_SUSPICIOUS_CANCEL AS (SELECT
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
   ANY_VALUE(tpc.tail_cancel_lines_cnt) AS tail_cancel_lines_cnt,
   ANY_VALUE(tpc.tail_cancel_approved_cnt) AS tail_cancel_approved_cnt
  FROM TAIL_POSITION_CANCEL AS tpc
   INNER JOIN ldl_data_core_rel.t_product_retail_line_2 AS PRL0 ON tpc.retail_event_sid = PRL0.retail_event_sid AND tpc.tail_cancel_line_seq
         = PRL0.cancel_line_seq AND tpc.store_sid = PRL0.store_sid AND tpc.bus_dt = PRL0.bus_dt AND tpc.country_org_cd =
     PRL0.country_org_cd
   INNER JOIN ldl_data_core_dim.t_dim_sales_variant_2 AS P ON PRL0.prod_variant_sid = P.sales_variant_sid AND P.dwh_valid_fg
    
  WHERE 
   -- Item_2 quantity lower than 50
   IFNULL(PRL0.prod_variant_cnt, 0) + IFNULL(PRL0.prod_variant_qty, 0) < 50
   -- exclude bakery
   AND P.sub_item_grp_nr <> '74'
   -- Filter to exclude cancellations of negative values (for example deposit)
   AND PRL0.retail_line_gross_val > 0
   -- exclude Fruit/Vegetables
   AND P.int_item_grp_nr NOT IN ('10')
   -- cancelled product is not on next receipt
   AND NOT EXISTS (SELECT 1
    FROM ldl_data_core_rel.t_product_retail_line_2 AS N_PRL
    WHERE retail_event_sid = tpc.next_retail_event_sid
     AND local_prod_nr = PRL0.local_prod_nr
     AND bus_dt = tpc.bus_dt
     AND country_org_cd = tpc.country_org_cd)
   -- Cash payments only
   AND NOT EXISTS (SELECT 1
    FROM ldl_data_core_rel.t_payment_line_2 AS PL
    WHERE retail_event_sid = tpc.retail_event_sid
     AND paym_type_id <> 11
     AND bus_dt = tpc.bus_dt
     AND country_org_cd = tpc.country_org_cd
     AND bus_dt BETWEEN $min_dwh_cal_dt AND $max_dwh_cal_dt)
   -- Item_2 within the item_2 groups in scope
   AND P.int_item_grp_nr IS NOT NULL
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
   tpc.event_end_tmsp), MATERIALIZE_PARAM_VIEW AS (SELECT param_id,
   scenario_id,
   scenario_type_cd,
   param_name,
   country_org_cd,
   param_default_val_qty,
   param_country_val_qty,
   param_val_qty,
   param_last_update_tmsp,
   is_scenario_enabled_in_country_fg
  FROM ldl_data_core_app_fraud_detection.v_fraud_detection_parameter_current_value_2
  WHERE scenario_id = 18) (
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
   TPRL.local_prod_nr,
   TPRL.retail_line_gross_val,
   TPRL.prod_variant_sid,
   TPRL.retail_event_line_seq,
   TPRL.cancel_line_seq,
   TPRL.prod_variant_input_nr,
   TPRL.auth_by_hash,
   TPRL.prod_entry_method_cd,
    IFNULL(TPRL.prod_variant_cnt, 0) + IFNULL(TPRL.prod_variant_qty, 0) AS prod_variant_qtyx,
   MAX(TPRL.base_gross_val) OVER (PARTITION BY ewsc.retail_event_sid  RANGE BETWEEN UNBOUNDED PRECEDING
    AND UNBOUNDED FOLLOWING) AS max_line_amt_per_event,
   -- for flag "CANCEL_LAST_POS_SINGLE_POS_FG" we need to make sure only 1 regular retail line (excl. deposits) is not cancelled.
   -- It can be 1 sale line or 1 deposit return line, but deposit SALE is not included ('SD' type)
   SUM(IF(TPRL.cancel_line_seq IS NULL AND TPRL.prod_retail_line_type_cd IN ('D', 'S'), 1, 0)) OVER (PARTITION BY ewsc.retail_event_sid 
      RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS event_non_cancelled_retail_line_cnt,
   ROW_NUMBER() OVER (PARTITION BY ewsc.retail_event_sid  ORDER BY TPRL.event_start_tmsp IS NULL, TPRL.event_start_tmsp
      , TPRL.retail_event_line_seq IS NULL, TPRL.retail_event_line_seq) AS line_rn,
    -- Cancellation at last/tail position
    CASE
    WHEN tpc.retail_event_sid IS NOT NULL AND TPRL.retail_line_gross_val > 0
    THEN 1
    ELSE 0
    END AS last_pos_cancel_line_fg,
    -- Cancellation at last position after subtotal
    CASE
    WHEN CASE
       WHEN tpc.retail_event_sid IS NOT NULL AND TPRL.retail_line_gross_val > 0
       THEN 1
       ELSE 0
       END = 1 AND tsl.retail_event_sid IS NOT NULL
    THEN 1
    ELSE 0
    END AS last_pos_after_subtotal_cancel_fg,
    -- Cancellation of alcohol/tobacco at last position
    CASE
    WHEN CASE
       WHEN tpc.retail_event_sid IS NOT NULL AND TPRL.retail_line_gross_val > 0
       THEN 1
       ELSE 0
       END = 1 AND P0.sub_item_grp_nr IN ('60', '61', '63', '80')
    THEN 1
    ELSE 0
    END AS last_pos_alc_tbc_cancel_fg,
    -- Line with the biggest amount is cancelled by "last cancel"
    CASE
    WHEN CASE
       WHEN tpc.retail_event_sid IS NOT NULL AND TPRL.retail_line_gross_val > 0
       THEN 1
       ELSE 0
       END = 1 AND TPRL.base_gross_val = (MAX(TPRL.base_gross_val) OVER (PARTITION BY ewsc.retail_event_sid
          RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING))
    THEN 1
    ELSE 0
    END AS last_pos_highest_pos_fg,
    -- Cancellation (Storno) is outside work hours
    CASE
    WHEN CASE
       WHEN tpc.retail_event_sid IS NOT NULL AND TPRL.retail_line_gross_val > 0
       THEN 1
       ELSE 0
       END = 1 AND (TIME(ewsc.event_start_tmsp) < SOH.open_tm OR TIME(ewsc.event_end_tmsp) > SOH.close_tm)
    THEN 1
    ELSE 0
    END AS last_pos_outside_opening_hr_fg,
    -- Cancellation of multiple lines which are at last(tail) position - meaning not retail lines after them
    CASE
    WHEN CASE
       WHEN tpc.retail_event_sid IS NOT NULL AND TPRL.retail_line_gross_val > 0
       THEN 1
       ELSE 0
       END = 1 AND ewsc.tail_cancel_lines_cnt > 1
    THEN 1
    ELSE 0
    END AS last_and_other_pos_fg,
    -- Cancellations at last position without approval - None of the "tail" cancelation lines is approved (other cancellation lines that are at "regular" position might still be approved, but we do not care for this situation)
    CASE
    WHEN CASE
       WHEN tpc.retail_event_sid IS NOT NULL AND TPRL.retail_line_gross_val > 0
       THEN 1
       ELSE 0
       END = 1 AND ewsc.tail_cancel_approved_cnt = 0
    THEN 1
    ELSE 0
    END AS no_approval_cancel_line_fg,
    /* Storno of the only retail line */
    CASE
    WHEN CASE
        WHEN tpc.retail_event_sid IS NOT NULL AND TPRL.retail_line_gross_val > 0
        THEN 1
        ELSE 0
        END = 1 AND (SUM(IF(TPRL.cancel_line_seq IS NULL AND TPRL.prod_retail_line_type_cd IN ('D', 'S'), 1, 0)) OVER (PARTITION BY ewsc.retail_event_sid 
           RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) = 1 AND ewsc.txn_gross_val <= p_sl.param_val_qty
    THEN 1
    ELSE 0
    END AS cancel_single_pos_line_fg
  FROM EVENT_WITH_SUSPICIOUS_CANCEL AS ewsc
   INNER JOIN ldl_data_core_rel.t_product_retail_line_2 AS TPRL ON ewsc.retail_event_sid = TPRL.retail_event_sid AND ewsc
       .store_sid = TPRL.store_sid AND ewsc.bus_dt = TPRL.bus_dt AND ewsc.country_org_cd = TPRL.country_org_cd
   INNER JOIN MATERIALIZE_PARAM_VIEW AS p_sl -- parameter "Bonsumme < X LW und nur 1 Artikel_2"
        ON ewsc.country_org_cd = p_sl.country_org_cd AND p_sl.param_id = 56
      -- if scenario is not enabled all receipts from that country_2 will be eliminated in this inner join
 AND p_sl.is_scenario_enabled_in_country_fg
    
   LEFT JOIN TAIL_POSITION_CANCEL AS tpc ON ewsc.retail_event_sid = tpc.retail_event_sid AND TPRL.cancel_line_seq = tpc
     .tail_cancel_line_seq
   LEFT JOIN ldl_data_core_dim.t_dim_sales_variant_2 AS P0 ON TPRL.prod_variant_sid = P0.sales_variant_sid AND P0.dwh_valid_fg
    
   LEFT JOIN ldl_data_core_rel.t_store_opening_hours_2 AS SOH ON ewsc.store_sid = SOH.store_sid AND EXTRACT(DAYOFWEEK FROM
        ewsc.bus_dt) - 1 = SOH.day_of_week AND SOH.dwh_valid_fg
   -- Joining to t_subtotal_line_2 to find subtotal rows appearing before cancellation
   -- we just need to check if sub-total line exists before the storno (which is in last position in this case), so we take the earliest sub-total line
   LEFT JOIN (SELECT SL.retail_event_sid,
     MIN(SL.event_tmsp) AS first_subtotal_line_tmsp
    FROM ${FWRK_WORK_DB}.vt1 AS vt11
     INNER JOIN ldl_data_core_rel.t_subtotal_line_2 AS SL ON vt11.loc_sid = SL.store_sid AND vt11.dwh_cal_dt = SL.bus_dt
      AND vt11.country_cd = SL.country_org_cd
    WHERE SL.bus_dt BETWEEN $min_dwh_cal_dt AND $max_dwh_cal_dt
    GROUP BY SL.retail_event_sid) AS tsl ON ewsc.retail_event_sid = tsl.retail_event_sid AND ewsc.last_cancel_tmsp > tsl
     .first_subtotal_line_tmsp);






INSERT INTO ${FWRK_WORK_DB}.t_fact_fraud_detection_by_cash_register_event_final (cash_register_event_sid
 , cash_register_event_nr, event_start_tmsp, bus_dt, cash_register_sid, cash_register_nr, store_sid, cashier_hash,
 txn_net_val, txn_gross_val, cancel_last_pos_gross_val, curr_cd, cancel_last_pos_line_cnt, cancel_last_pos_fg,
 cancel_last_pos_after_subtotal_fg, cancel_last_pos_exact_paym_fg, cancel_last_pos_alcohol_tobacco_fg,
 cancel_last_pos_highest_pos_fg, cancel_last_pos_outside_opening_hr_fg, cancel_last_and_other_pos_fg,
 cancel_last_pos_without_auth_fg, cancel_last_pos_single_pos_fg)
WITH EVENT_LINES_CHANGE_FLAG AS (SELECT retail_event_sid,
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
     -- Doppeltipper: set flag for scanned records. Doppletipper is valid if at least 1 line of the "group" is scanned
     CASE
     WHEN prod_entry_method_cd = 'SC'
     THEN 1
     ELSE 0
     END AS line_scanned_fg,
     -- Doppeltipper: mark row as not changed only when the item_2 and quantity are the same as in a previous row
     CASE
     WHEN (LAG(local_prod_nr) OVER (PARTITION BY retail_event_sid ORDER BY line_rn IS NULL, line_rn))
       IS NOT DISTINCT FROM local_prod_nr AND (LAG(prod_variant_qtyx) OVER (PARTITION BY retail_event_sid 
           ORDER BY line_rn IS NULL, line_rn)) IS NOT DISTINCT FROM prod_variant_qtyx
     THEN 0
     ELSE 1
     END AS doppeltipper_change_fg
   FROM t_tmp_lines_of_event_with_suspicious_cancel), EVENT_LINES_GROUPS AS (SELECT retail_event_sid,
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
    line_scanned_fg,
    doppeltipper_change_fg,
    SUM(doppeltipper_change_fg) OVER (PARTITION BY retail_event_sid  ORDER BY line_rn IS NULL, line_rn
     ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS group_id
   FROM EVENT_LINES_CHANGE_FLAG AS t0), EVENT_GROUP_COUNTS AS (SELECT retail_event_sid,
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
    -- Still calculating cancelled gross value per group - this will be compared with "Total value of cancelled items" threshold and should be filtered out by Doppeltipper logic before compared as per requirement
    SUM(retail_line_gross_val * last_pos_cancel_line_fg) AS cancel_gross_val_per_group,
    -- Calculating final values for cancel_last_pos_line_cnt and cancel_last_pos_gross_val here
    -- In MIS the report metrics that use fields corresponding to these two contain aggregated values for all lines being at last positions, regardless they could fall into Doppeltipper exclusion or not
    -- So if we have two cancellations in last positions from which one should be excluded by Doppeltipper and another following cancellation that should not be affected by Doppeltipper then the metric for gross value of last position cancellations should aggregate both these lines
    -- Then, to avoid affection by Doppeltipper filter in next event_counts CTE, both these fields are calculated here using window functions
    SUM(SUM(last_pos_cancel_line_fg)) OVER (PARTITION BY retail_event_sid  RANGE BETWEEN
     UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS last_pos_cancel_lines_per_event,
    SUM(SUM(retail_line_gross_val * last_pos_cancel_line_fg)) OVER (PARTITION BY retail_event_sid 
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
     END AS group_cancel_single_pos_line_fg,
    SUM(line_scanned_fg) AS group_scanned_lines_cnt
   FROM EVENT_LINES_GROUPS AS t2
   GROUP BY retail_event_sid,
    group_id), MATERIALIZE_PARAM_VIEW AS (SELECT param_id,
    scenario_id,
    scenario_type_cd,
    param_name,
    country_org_cd,
    param_default_val_qty,
    param_country_val_qty,
    param_val_qty,
    param_last_update_tmsp,
    is_scenario_enabled_in_country_fg
   FROM ldl_data_core_app_fraud_detection.v_fraud_detection_parameter_current_value_2
   WHERE scenario_id = 18), EVENT_COUNTS AS (SELECT egc.retail_event_sid,
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
    -- Passing any value from groups CTE as these two fields were already calculated on receipt level
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
   FROM EVENT_GROUP_COUNTS AS egc
    -- Parameter "Total value of cancelled items"
    INNER JOIN MATERIALIZE_PARAM_VIEW AS p_tcl ON egc.country_org_cd = p_tcl.country_org_cd AND p_tcl.param_id = 55
   WHERE 
    -- take only groups for which we have cancellation by the last position
    egc.last_pos_cancel_lines_per_group > 0
    -- Doppeltipper: filter out groups where there are two or more consecutive lines items with only one corresponding line cancel
    -- and at least one of the retail lines is created with "scan" (not manually with keyboard input)
    AND (egc.lines_per_group <= 1 OR egc.group_scanned_lines_cnt <= 0 OR egc.last_pos_cancel_lines_per_group <> 1)
   GROUP BY egc.retail_event_sid
   HAVING sum(egc.cancel_gross_val_per_group)   >  any_value(p_tcl.param_val_qty)) (SELECT ec.retail_event_sid AS cash_register_event_sid,
    ec.cash_register_event_nr,
    CAST(ec.event_start_tmsp AS DATETIME) AS event_start_tmsp,
    ec.bus_dt,
    ec.cash_register_sid,
    CAST(CR.cash_register_nr AS STRING) AS cash_register_nr,
    ec.store_sid,
    ec.cashier_hash,
    CAST(ec.txn_net_val AS NUMERIC) AS txn_net_val,
    CAST(ec.txn_gross_val AS NUMERIC) AS txn_gross_val,
    CAST(ec.cancel_gross_val_per_event AS NUMERIC) AS cancel_last_pos_gross_val,
    ec.curr_cd,
    ec.last_position_cancel_lines_per_event AS cancel_last_pos_line_cnt,
    ec.cancel_last_pos_fg,
    ec.cancel_last_pos_after_subtotal_fg,
     CASE
     WHEN ec.txn_gross_val >= 0 AND tpl.chg_aft_pay < 0 OR ec.txn_gross_val < 0 AND tpl.chg_aft_pay > 0
     THEN 1
     ELSE 0
     END AS cancel_last_pos_exact_paym_fg,
    ec.cancel_last_pos_alcohol_tobacco_fg,
    ec.cancel_last_pos_highest_pos_fg,
    ec.cancel_last_pos_outside_opening_hr_fg,
    ec.cancel_last_and_other_pos_fg,
    ec.cancel_last_pos_without_auth_fg,
    ec.cancel_last_pos_single_pos_fg
   FROM EVENT_COUNTS AS ec
    INNER JOIN ldl_data_core_rel.t_cash_register_2 AS CR ON ec.cash_register_sid = CR.cash_register_sid AND CR.dwh_valid_fg
     
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
          -- difference of last position of payment and last position of return (change)
     FROM ldl_data_core_rel.t_payment_line_2
     WHERE bus_dt BETWEEN $min_dwh_cal_dt AND $max_dwh_cal_dt 
      AND (country_org_cd, bus_dt, store_sid) IN (SELECT (country_cd, dwh_cal_dt, CAST(loc_sid AS BIGNUMERIC))
        FROM ${FWRK_WORK_DB}.vt1)
     GROUP BY retail_event_sid) AS tpl ON ec.retail_event_sid = tpl.retail_event_sid);