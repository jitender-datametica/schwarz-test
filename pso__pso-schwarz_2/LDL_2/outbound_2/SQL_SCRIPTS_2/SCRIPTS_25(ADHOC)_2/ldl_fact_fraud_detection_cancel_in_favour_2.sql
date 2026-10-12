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
                                       https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-INTEGER /_workitems/edit/41148

                                       Subscenarios:
                                       1. CANCEL_IN_FAVOUR_ALCOHOL_TOBACCO_FG
                                       https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-INTEGER /_workitems/edit/46537/
	
                                       2. CANCEL_IN_FAVOUR_OUTSIDE_OPENING_HR_FG
                                       https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-INTEGER /_workitems/edit/46546
									   
#  1.2	29.08.2024	Piotr Kleysa	 - ZKP GF_2 - development by Mihail Ivanov
                                       Adding two new subscenarios
                                       1. CANCEL_IN_FAVOUR_WITHOUT_AUTH_FG
                                       https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-INTEGER /_workitems/edit/46542/
                                        
                                       2. CANCEL_IN_FAVOUR_MANUAL_DISCOUNT_FG
                                       https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-INTEGER /_workitems/edit/46547/
									   
#  1.3	29.08.2024	Kamil Roszczyk   - ZKP GF_2 - Adding two new subscenarios 
                                       1. CANCEL_IN_FAVOUR_AFTER_SUBTOTAL_FG
                                       https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-INTEGER /_workitems/edit/46541
                                   
                                       2.CANCEL_IN_FAVOUR_EXACT_PAYM_FG
                                       https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-INTEGER /_workitems/edit/46540

#  1.4  12.09.2024  Mihail Ivanov	 - Update logic for scenario CANCEL_IN_FAVOUR_WITHOUT_AUTH_FG
										now we are checking the value of AUTH_BY_HASH in T_CANCELLATION_LINE_2 instead of T_PRODUCT_RETAIL_LINE_2
										
#  1.5  27.09.2024  Olexander Bezpalko - New sub-scenario
                                         CANCEL_IN_FAVOUR_HIGHEST_POS_FG
										 https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-INTEGER /_workitems/edit/46544
										 
										 Also split the logic into 3 queries (3 steps) instead of 1 to make maintenance simpler.

										 
	
#  1.6	06.11.2024	Mihail Ivanov	 -	Logic for "Doppletipper" updated - made the same as in "cancel_last_position" scenario
											To put two consequtive lines in same group they both must be "SCANNED"

#  1.7	08.11.2024	Mihail Ivanov	 -	Adjustment for column rename
											CANCEL_IN_FAVOUR_OUTSIDE_OPENING_HOURS_FG renamed to CANCEL_IN_FAVOUR_OUTSIDE_OPENING_HR_FG			

#  1.8	18.11.2024	Mihail Ivanov	 -	Added sub-scenario
											CANCEL_IN_FAVOUR_LIDL_PLUS_FG
											https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-INTEGER /_workitems/edit/57254/

										
										Added two columns to  core_dim.T_FACT_FRAUD_DETECTION_BY_CASH_REGISTER_EVENT_2
											CUST_SID
											CUST_IDENT_TYPE_CD
										The columns are taken 1:1 from core_rel.T_RETAIL_EVENT. 
										Can be used to produce a metric like "Count of [total/unique] Lidl Plus IDs (CUST_SIDs)" for every scenario

#  1.9	21.11.2024	Mihail Ivanov	 -	bugfix: Adjusted logic for "next receipt" - now taken comparing CASH_REGISTER_EVENT_NR for same CASH_REGISTER_SID, BUS_DT
												CASH_REGISTER_SID is based on Country_2,Store and RegisteNR so no need to add STORE_SID and COUNTRY_CD
												Logic explained here is relevant in general for "next receipt" evaluation: https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-INTEGER /_workitems/edit/53633
												
										bugfix: Evaluated only receipts where re.TURNOVER_RELEVANT_FG = TRUE 
												this eliminates cancelled (aborted) and suspended receipts too
												
#  1.10	09.12.2024	Mihail Ivanov	 -	bugfix: Changed product group filter, to make it sane as old world
											as requested in this bug:	https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-INTEGER /_workitems/edit/56851/
											
										bugfix: comparing threshold for "total amount of cancelled items" with the correct column 
								

#  1.11	20.01.2025	Mihail Ivanov   - ZKP GF_2 changes (requested here: https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-INTEGER /_workitems/edit/55225)
										Add filter to exclude cancellations of negative values ( for example deposit)						

#  1.12	19.02.2025	Mihail Ivanov   - ZKP GF_2 changes (requested here: https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-INTEGER /_workitems/edit/63798/)
										new sub-scenario for Stornos in receipts with only 1 retail line - CANCEL_IN_FAVOUR_SINGLE_POS_FG						

#  1.13	25.02.2025	Mihail Ivanov   - ZKP GF_2 changes (requested here: https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-INTEGER /_workitems/edit/63798/)
										Logic for implementation of CANCEL_IN_FAVOUR_SINGLE_POS_FG is changed (fixed, we had it wrong)
										The flag means that we may have many cancelled lines in the receipt and we have only 1 non-cancelled regular retail line (regular means we do not count deposit lines)
										
										Bugfix: for all sub-scenarios we were raising the flag if the group of items has as many cancelled lines as there are lines in the group.
												But if we have 3 lines with 1 bottle of vodka and 2 of these lines are cancelled this is NOT "doppletipper" and should be counted - this is fixed now and we count such groups.
										
#  1.14	18.03.2025	Andrzej Wandtke   - ZKP GF_2 changes - task 66853 - filter on standard cash registers : POS type TIL

#  1.15 26.03.2025	Kamil Roszczyk	- ZKP GF_2 changes
										- replaced filters for turnover relevant and sales_2 receipts to mimic the MIS logic
										- renamed the relevant_cancel_gross_val and relevant_cancel_line_cnt fields to synchronize with the recent data model changes
											https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-INTEGER /_workitems/edit/66945
										- added the logic for removing scenarios data when no threshold is set
											https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-INTEGER /_workitems/edit/63803


#  1.16  03.04.2025  Mihail Ivanov  - Changes:
						Removing flag if scenario is disabled is moved out of this script to the main script

#  1.17  29.04.2025  Kamil Roszczyk	- changes: changed 'TIL' filter for non selfcheckout cash registers
										- filter: "cash_register_type_cd = 'TIL'"; replaced with: "cash_register_type_cd = 'TIL' OR cash_register_type_cd IS NULL"
											https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-INTEGER /_workitems/edit/69257
											
											
#  1.18  16.05.2025  Mihail Ivanov  - Changes/Bugfixes: all requested here https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-INTEGER /_workitems/edit/70840
										
										- Change: for sub-scenario CANCEL_IN_FAVOUR_WITHOUT_AUTH_FG now none of the cancellation lines should be approved.
											Event cancellation lines that are cancelling retail lines with Obs/Gemuse/Blumen should be without approval
											
										- Bugfix: for sub-scenario CANCEL_IN_FAVOUR_AFTER_SUBTOTAL_FG now evaluating if "cancellation line" exists after "sub-total line"
												before we were looking for "cancelled retail line" after sub-total line
												
										- bugfix: for sub-scenario CANCEL_IN_FAVOUR_SINGLE_POS_FG we are now counting two line types
											"regular sales_2 line" (type = S) and "Deposit Return Line" (type D)
											and event must have in total one non-cancelled line which is one of these types
											
											
#  1.19  21.08.2025  Mihail Ivanov  - Changes: 
										Requested here: https://jira.schwarz/browse/NEOGFPL-71587 								
										- Product group "Flowers" is now considered an important product and is no longer excluded.
										- Logic for comparison with scenario threshold now uses "all" cancelled lines if event "qualifies"
											"qualifies" means that the event has AT LEAST ONE cancellation of important product (anything other than Fruits/Veggies/Bakery)
											once an event has such line, then "all" cancelled lines are considered for comparison with thresholds, including Fruits/Veggies/Bakery
										
										- Added one more acceptable option for CASH_REGISTER_TYPE_CD (value 'POS') to handle locations where OmniPos system is used
											Requested here: https://jira.schwarz/browse/NEOGFPL-71619


#  1.20  29.10.2025  Mihail Ivanov  - Changes: 
										Conditions for "Doppletipper" changed. 
										Now we look for at least one scanned line in group (instead of "all lines must be scanned") 
										requested here: https://jira.schwarz/browse/NEOGFPL-71681
*/

---------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------
--	Step1: Create temporary table T_TMP_CANCEL_FRIENDLY_LINE_FLAGS
--  	It has all (not only cancelled) retail lines for each event where we have a at least one Storno(cancelled line) 
--		For each line we calculate a flag indicating if the line is suspicious for any sub-scenario

CREATE OR REPLACE TEMPORARY TABLE t_tmp_cancel_friendly_line_flags AS WITH EVENT_AND_NEXT_EVENT AS (
  -- fastest way to map RETAIL_EVENT_SID to its following RETAIL_EVENT_SID
  -- yes, we are doing this for all receipts, not only for those that have cancellations
  -- but still we have a filter on dates because of the delta extraction, and we are using only the smaller table with events (T_RETAIL_EVENT_2)
  -- we do not need the bigger table with PRODUCT_RETAIL_LINE and we only use one window function (LEAD)
  -- Other implementation require a equi-JOIN  + two (dense_rank) window functions, or non-equi-JOIN (next.cash_register_event_nr > curr.cash_register_event_nr) + ROW_NUMBER 
  SELECT vt1.retail_event_sid,
   LEAD(vt1.retail_event_sid) OVER (PARTITION BY RE.cash_register_sid , RE.bus_dt ORDER BY RE.cash_register_event_nr
      IS NULL, RE.cash_register_event_nr) AS next_retail_event_sid,
   --additional event attributes
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
   RE.cust_sid,
   RE.cust_ident_type_cd,
   RE.turnover_relevant_fg,
   RE.retail_event_type_cd,
   RE.event_end_tmsp
  FROM ${FWRK_WORK_DB}.vt1
   INNER JOIN ldl_data_core_rel.t_retail_event_2 AS RE_2 ON vt1.country_cd = RE.country_org_cd AND vt1.dwh_cal_dt = RE.bus_dt
       AND vt1.loc_sid = RE.store_sid
  WHERE RE.bus_dt BETWEEN $min_dwh_cal_dt AND $max_dwh_cal_dt
   AND (RE.cash_register_type_cd IN ('TIL', 'POS') OR RE.cash_register_type_cd IS NULL)), EVENT_WITH_SUSPICIOUS_CANCEL
 AS (
  -- "cancel_line_seq not null" and "product groups" are very strong filters
  -- it is better to use them early to limit the RETAIL_EVENT_SIDs with which we are working
  -- and then in another step take all lines for these RETAIL_EVENT_SIDs
  SELECT -- we want only the event, 1 row for every receipt that has suspicous cancellation
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
   ene.cust_sid,
   ene.cust_ident_type_cd,
   ene.turnover_relevant_fg,
   ene.retail_event_type_cd,
   ene.event_end_tmsp
  FROM EVENT_AND_NEXT_EVENT AS ene
   INNER JOIN ldl_data_core_rel.t_product_retail_line_2 AS L ON ene.retail_event_sid = L.retail_event_sid AND ene.bus_dt =
      L.bus_dt AND ene.store_sid = L.store_sid
   INNER JOIN ldl_data_core_dim.t_dim_sales_variant_2 AS P ON L.prod_variant_sid = P.sales_variant_sid AND P.dwh_valid_fg
  WHERE 
   --delta extraction
   L.bus_dt BETWEEN $min_dwh_cal_dt AND $max_dwh_cal_dt
   --Following two filters moved here from event_and_next_event CTE to not eliminate turnover not relevant and non sales_2 receipts as main receipt's followers - in sync with receipt follower definition from MIS
   -- this eliminates cancelled (aborted) and suspended receipts too
   AND ene.turnover_relevant_fg
   --Sales_2 receipts only
   AND ene.retail_event_type_cd = 'S'
   --scenario conditions
   AND IFNULL(L.prod_variant_cnt, 0) + IFNULL(L.prod_variant_qty, 0) < 50
   -- exclude bakery
   AND P.sub_item_grp_nr <> '74'
   -- Filter to exclude cancellations of negative values (for example deposit)
   AND L.retail_line_gross_val > 0
   -- exclude Fruit/Vegetables
   AND P.int_item_grp_nr NOT IN ('10')
   AND L.cancel_line_seq IS NOT NULL
   --Item_2 within the item_2 groups in scope
   AND P.int_item_grp_nr IS NOT NULL
  GROUP BY ene.retail_event_sid,
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
   ene.cust_sid,
   ene.cust_ident_type_cd,
   ene.turnover_relevant_fg,
   ene.retail_event_type_cd,
   ene.event_end_tmsp), LAST_SUBTOTAL_BEFORE_STORNO AS (SELECT TCL.retail_event_sid,
   MAX(TSL.event_tmsp) AS last_subtotal_tmsp
  FROM ${FWRK_WORK_DB}.vt1 AS vt10
   INNER JOIN ldl_data_core_rel.t_cancellation_line_2 AS TCL ON vt10.country_cd = TCL.country_org_cd AND vt10.dwh_cal_dt =
      TCL.bus_dt AND vt10.loc_sid = TCL.store_sid
   INNER JOIN ldl_data_core_rel.t_subtotal_line_2 AS TSL ON TCL.retail_event_sid = TSL.retail_event_sid AND TCL.event_tmsp
      > TSL.event_tmsp
  WHERE TCL.bus_dt BETWEEN $min_dwh_cal_dt AND $max_dwh_cal_dt
   AND TSL.bus_dt BETWEEN $min_dwh_cal_dt AND $max_dwh_cal_dt
  GROUP BY TCL.retail_event_sid), LINES_OF_EVENT_WITH_SUSPICIOUS_CANCEL AS (SELECT t4.retail_event_sid,
   t4.next_retail_event_sid,
   t4.cash_register_event_nr,
   t4.event_start_tmsp,
   t4.bus_dt,
   t4.cash_register_sid,
   t4.store_sid,
   t4.cashier_hash,
   t4.txn_net_val,
   t4.txn_gross_val,
   t4.country_org_cd,
   t4.curr_cd,
   t4.cust_sid,
   t4.cust_ident_type_cd,
   t4.turnover_relevant_fg,
   t4.retail_event_type_cd,
   t4.event_end_tmsp,
   L0.local_prod_nr,
   L0.retail_line_gross_val,
   L0.prod_variant_sid,
   L0.retail_event_line_seq,
   L0.cancel_line_seq,
   L0.prod_variant_input_nr,
   L0.auth_by_hash,
   L0.prod_entry_method_cd,
    IFNULL(L0.prod_variant_cnt, 0) + IFNULL(L0.prod_variant_qty, 0) AS prod_variant_qtyx,
   -- redefined requirement says that none of the cancelled lines should be approved for sub-scenario CANCEL_IN_FAVOUR_WITHOUT_AUTH_FG
   -- even Obst/Gemuse/Blumen lines must be without approval
   COUNT(CL.auth_by_hash) OVER (PARTITION BY t4.retail_event_sid RANGE BETWEEN UNBOUNDED PRECEDING AND
    UNBOUNDED FOLLOWING) AS event_appr_cancellation_lines_cnt,
   MAX(L0.base_gross_val) OVER (PARTITION BY t4.retail_event_sid RANGE BETWEEN UNBOUNDED PRECEDING AND
    UNBOUNDED FOLLOWING) AS max_line_amt_per_event,
   -- for flag "CANCEL_IN_FAVOUR_SINGLE_POS_FG" we need to make sure only 1 regular retail line is not cancelled 
   -- 		lines of type D "deposit returns" are also counted, while lines of type "SD" are ignored
   SUM(IF(L0.cancel_line_seq IS NULL AND L0.prod_retail_line_type_cd IN ('S', 'D'), 1, 0)) OVER (PARTITION BY t4.retail_event_sid
      RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS event_non_cancelled_retail_line_cnt,
   ROW_NUMBER() OVER (PARTITION BY t4.retail_event_sid ORDER BY L0.event_start_tmsp IS NULL, L0.event_start_tmsp, L0.retail_event_line_seq
      IS NULL, L0.retail_event_line_seq) AS line_rn,
    /* Storno aus den Warengruppen Kühlung, Tiko, Non Food, Frischbrot (ohne die die UWG Bake Off) oder Food TS aufweisen */
    -- The redefined requirements in v1.19 say that once an event is qualified (exists in CTE "event_with_suspicious_cancel"), then we evaluate all cancelled lines. Even Flowers/Fruits/Veggies/Bakery
    CASE
    -- Filter to exclude cancellations of negative values (for example deposit)
    WHEN L0.retail_line_gross_val > 0 AND IFNULL(L0.prod_variant_cnt, 0) + IFNULL(L0.prod_variant_qty, 0) < 50 AND L0.cancel_line_seq
     IS NOT NULL
     /* *** conditions removed in v1.19
     -- exclude Fruit/Vegetables and Flowers 
     ...
     *** */
    THEN 1
    ELSE 0
    END AS gen_cancel_line_fg,
    /* Storno for Alcohol/Tabaco, SubGroups of int_item_grp_nr=60 */
    CASE
    WHEN CASE
       WHEN L0.retail_line_gross_val > 0 AND IFNULL(L0.prod_variant_cnt, 0) + IFNULL(L0.prod_variant_qty, 0) < 50 AND L0
        .cancel_line_seq IS NOT NULL
       THEN 1
       ELSE 0
       END = 1 AND P0.sub_item_grp_nr IN ('60', '61', '63', '80')
    THEN 1
    ELSE 0
    END AS alc_tbc_cancel_line_fg,
    /* Storno outside work hours */
    CASE
    WHEN CASE
       WHEN L0.retail_line_gross_val > 0 AND IFNULL(L0.prod_variant_cnt, 0) + IFNULL(L0.prod_variant_qty, 0) < 50 AND L0
        .cancel_line_seq IS NOT NULL
       THEN 1
       ELSE 0
       END = 1 AND (TIME(t4.event_start_tmsp) < SOH.open_tm OR TIME(t4.event_end_tmsp) > SOH.close_tm)
    THEN 1
    ELSE 0
    END AS outside_worktime_cancel_line_fg,
    /*Storno without approval*/
    CASE
    WHEN CASE
       WHEN L0.retail_line_gross_val > 0 AND IFNULL(L0.prod_variant_cnt, 0) + IFNULL(L0.prod_variant_qty, 0) < 50 AND L0
        .cancel_line_seq IS NOT NULL
       THEN 1
       ELSE 0
       END = 1 AND (COUNT(CL.auth_by_hash) OVER (PARTITION BY t4.retail_event_sid RANGE BETWEEN UNBOUNDED PRECEDING AND
        UNBOUNDED FOLLOWING)) = 0
    THEN 1
    ELSE 0
    END AS no_approval_cancel_line_fg,
    /* highest purchased price item_2 = highest purchased price item_2 cancelled */
    CASE
    WHEN CASE
       WHEN L0.retail_line_gross_val > 0 AND IFNULL(L0.prod_variant_cnt, 0) + IFNULL(L0.prod_variant_qty, 0) < 50 AND L0
        .cancel_line_seq IS NOT NULL
       THEN 1
       ELSE 0
       END = 1 AND L0.base_gross_val = (MAX(L0.base_gross_val) OVER (PARTITION BY t4.retail_event_sid RANGE BETWEEN
        UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING))
    THEN 1
    ELSE 0
    END AS cancel_in_favour_highest_pos_line_fg,
    /* Storno after subtotal (or otherwise said "subtotal before storno exists" */
    CASE
    WHEN CASE
       WHEN L0.retail_line_gross_val > 0 AND IFNULL(L0.prod_variant_cnt, 0) + IFNULL(L0.prod_variant_qty, 0) < 50 AND L0
        .cancel_line_seq IS NOT NULL
       THEN 1
       ELSE 0
       END = 1 AND lsbs.retail_event_sid IS NOT NULL
    THEN 1
    ELSE 0
    END AS cancel_after_subtotal_line_fg,
    /* Storno and only 1 retail line remains uncancelled */
    CASE
    WHEN CASE
       WHEN L0.retail_line_gross_val > 0 AND IFNULL(L0.prod_variant_cnt, 0) + IFNULL(L0.prod_variant_qty, 0) < 50 AND L0
        .cancel_line_seq IS NOT NULL
       THEN 1
       ELSE 0
       END = 1 AND (SUM(IF(L0.cancel_line_seq IS NULL AND L0.prod_retail_line_type_cd IN ('S', 'D'), 1, 0)) OVER (PARTITION BY
          t4.retail_event_sid RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) = 1
    THEN 1
    ELSE 0
    END AS cancel_in_favour_single_pos_line_fg
  FROM (SELECT DISTINCT *
    FROM EVENT_WITH_SUSPICIOUS_CANCEL AS ewsc) AS t4
   INNER JOIN ldl_data_core_rel.t_product_retail_line_2 AS L0 ON t4.retail_event_sid = L0.retail_event_sid AND t4.bus_dt =
       L0.bus_dt AND t4.country_org_cd = L0.country_org_cd AND t4.store_sid = L0.store_sid
   LEFT JOIN ldl_data_core_rel.t_cancellation_line_2 AS CL ON t4.retail_event_sid = CL.retail_event_sid AND L0.cancel_line_seq
       = CL.retail_event_line_seq AND CL.bus_dt BETWEEN $min_dwh_cal_dt AND $max_dwh_cal_dt
      
   LEFT JOIN LAST_SUBTOTAL_BEFORE_STORNO AS lsbs ON t4.retail_event_sid = lsbs.retail_event_sid
   LEFT JOIN ldl_data_core_rel.t_store_opening_hours_2 AS SOH ON t4.store_sid = SOH.store_sid AND EXTRACT(DAYOFWEEK FROM
        t4.bus_dt) - 1 = SOH.day_of_week AND SOH.dwh_valid_fg
   LEFT JOIN ldl_data_core_dim.t_dim_sales_variant_2 AS P0 ON L0.prod_variant_sid = P0.sales_variant_sid AND P0.dwh_valid_fg
    
  WHERE L0.bus_dt BETWEEN $min_dwh_cal_dt AND $max_dwh_cal_dt) (SELECT 
   -- event cols
   retail_event_sid,
   next_retail_event_sid,
   cash_register_event_nr,
   event_start_tmsp,
   event_end_tmsp,
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
   -- event line cols
   local_prod_nr,
   retail_line_gross_val,
   prod_variant_sid,
   retail_event_line_seq,
   cancel_line_seq,
   prod_variant_input_nr,
   auth_by_hash,
   prod_variant_qtyx,
   prod_entry_method_cd,
   -- calculated flags for event lines
   gen_cancel_line_fg,
   alc_tbc_cancel_line_fg,
   outside_worktime_cancel_line_fg,
   no_approval_cancel_line_fg,
   cancel_in_favour_highest_pos_line_fg,
   cancel_after_subtotal_line_fg,
   cancel_in_favour_single_pos_line_fg,
   line_rn
  FROM LINES_OF_EVENT_WITH_SUSPICIOUS_CANCEL);

---------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------
--	Step2: Create temporary table T_TMP_CANCEL_FRIENDLY_LINE_GROUPS
--  	For each line we calculate also a flag if it has manual discount and a GROUP_ID within the event
--		Two lines of a given event belong to same GROUP_ID if they are consecutive, for same product and same quantity
--		We use this Groups later to evaluate if we have double-tap (1 item_2 scanned twice by mistake and second scan is cancelled)

CREATE OR REPLACE TEMPORARY TABLE t_tmp_cancel_friendly_line_groups AS WITH EVENT_LINES_CHANGE_FLAG AS (SELECT retail_event_sid,
   next_retail_event_sid,
   cash_register_event_nr,
   event_start_tmsp,
   event_end_tmsp,
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
   local_prod_nr,
   retail_line_gross_val,
   prod_variant_sid,
   retail_event_line_seq,
   cancel_line_seq,
   prod_variant_input_nr,
   auth_by_hash,
   prod_variant_qtyx,
   prod_entry_method_cd,
   gen_cancel_line_fg,
   alc_tbc_cancel_line_fg,
   outside_worktime_cancel_line_fg,
   no_approval_cancel_line_fg,
   cancel_in_favour_highest_pos_line_fg,
   cancel_after_subtotal_line_fg,
   cancel_in_favour_single_pos_line_fg,
   line_rn,
    --Doppeltipper: set flag for scanned records. Doppletipper is valid if at least 1 line of the "group" is scanned
    CASE
    WHEN prod_entry_method_cd = 'SC'
    THEN 1
    ELSE 0
    END AS line_scanned_fg,
    --Doppeltipper: mark row as not changed only when the item_2 and quantity are the same as in a previous row
    CASE
    WHEN (LAG(local_prod_nr) OVER (PARTITION BY retail_event_sid ORDER BY line_rn IS NULL, line_rn))
      IS NOT DISTINCT FROM local_prod_nr AND (LAG(prod_variant_qtyx) OVER (PARTITION BY retail_event_sid ORDER BY
          line_rn IS NULL, line_rn)) IS NOT DISTINCT FROM prod_variant_qtyx
    THEN 0
    ELSE 1
    END AS change_fg
  FROM t_tmp_cancel_friendly_line_flags AS L), EVENT_LINES_GROUPS AS (SELECT retail_event_sid,
   next_retail_event_sid,
   cash_register_event_nr,
   event_start_tmsp,
   event_end_tmsp,
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
   local_prod_nr,
   retail_line_gross_val,
   prod_variant_sid,
   retail_event_line_seq,
   cancel_line_seq,
   prod_variant_input_nr,
   auth_by_hash,
   prod_variant_qtyx,
   prod_entry_method_cd,
   gen_cancel_line_fg,
   alc_tbc_cancel_line_fg,
   outside_worktime_cancel_line_fg,
   no_approval_cancel_line_fg,
   cancel_in_favour_highest_pos_line_fg,
   cancel_after_subtotal_line_fg,
   cancel_in_favour_single_pos_line_fg,
   line_rn,
   line_scanned_fg,
   change_fg,
   SUM(change_fg) OVER (PARTITION BY retail_event_sid ORDER BY line_rn IS NULL, line_rn ROWS BETWEEN UNBOUNDED PRECEDING
    AND CURRENT ROW) AS group_id
  FROM EVENT_LINES_CHANGE_FLAG AS l), MANUAL_DISCOUNT_PRODS AS (
   -- it is possible to have two discounts for same ProductRetailLine, and we just want 1 row per ProductRetailLine
   SELECT l.retail_event_sid,
   l.local_prod_nr
  FROM EVENT_LINES_GROUPS AS l
   INNER JOIN ldl_data_core_rel.t_discount_line_2 AS D ON l.retail_event_sid = D.retail_event_sid AND l.country_org_cd = D
           .country_org_cd AND l.bus_dt = D.bus_dt AND l.retail_event_line_seq = D.discounted_line_seq AND l.cancel_line_seq
       IS NULL AND D.retail_event_line_scenario_id BETWEEN 400 AND 599 AND ABS(D.discount_val) >= 0.011 AND (NOT LENGTH(l
        .prod_variant_input_nr) BETWEEN 15 AND 17 OR l.prod_variant_input_nr NOT LIKE '55%' AND l.prod_variant_input_nr
        NOT LIKE '56%')
  GROUP BY l.retail_event_sid,
   l.local_prod_nr), 
 -- lines of event with suspicious cancellation, but we have to exclude cancelled lines if they exist in next receipt or we have manual discount for same product in this receipt
 EVENT_LINES_FILTERED AS (
   -- Lines that are NOT cancelled. We need the to compare counts for double-tap 
   --    and also to check if there are manual discounts for products which are not cancelled
   SELECT l.retail_event_sid,
    l.next_retail_event_sid,
    l.cash_register_event_nr,
    l.event_start_tmsp,
    l.event_end_tmsp,
    l.bus_dt,
    l.cash_register_sid,
    l.store_sid,
    l.cashier_hash,
    l.txn_net_val,
    l.txn_gross_val,
    l.country_org_cd,
    l.curr_cd,
    l.cust_sid,
    l.cust_ident_type_cd,
    l.local_prod_nr,
    l.retail_line_gross_val,
    l.prod_variant_sid,
    l.retail_event_line_seq,
    l.cancel_line_seq,
    l.prod_variant_input_nr,
    l.auth_by_hash,
    l.prod_variant_qtyx,
    l.prod_entry_method_cd,
    l.gen_cancel_line_fg,
    l.alc_tbc_cancel_line_fg,
    l.outside_worktime_cancel_line_fg,
    l.no_approval_cancel_line_fg,
    l.cancel_in_favour_highest_pos_line_fg,
    l.cancel_after_subtotal_line_fg,
    l.cancel_in_favour_single_pos_line_fg,
    l.line_rn,
    l.line_scanned_fg,
    l.change_fg,
    l.group_id,
     CASE
     WHEN t5.retail_event_sid IS NULL
     THEN 0
     ELSE 1
     END AS is_prod_with_manual_discount_fg
   FROM EVENT_LINES_GROUPS AS l
    LEFT JOIN (SELECT DISTINCT *
     FROM MANUAL_DISCOUNT_PRODS AS mdp) AS t5 ON l.retail_event_sid = t5.retail_event_sid AND l.local_prod_nr = t5.local_prod_nr
      
   WHERE l.gen_cancel_line_fg = 0
   UNION ALL
   -- Lines that are cancelled but for the Product there is no Manual Discount and it does not exist in next receipt
   SELECT l.retail_event_sid,
    l.next_retail_event_sid,
    l.cash_register_event_nr,
    l.event_start_tmsp,
    l.event_end_tmsp,
    l.bus_dt,
    l.cash_register_sid,
    l.store_sid,
    l.cashier_hash,
    l.txn_net_val,
    l.txn_gross_val,
    l.country_org_cd,
    l.curr_cd,
    l.cust_sid,
    l.cust_ident_type_cd,
    l.local_prod_nr,
    l.retail_line_gross_val,
    l.prod_variant_sid,
    l.retail_event_line_seq,
    l.cancel_line_seq,
    l.prod_variant_input_nr,
    l.auth_by_hash,
    l.prod_variant_qtyx,
    l.prod_entry_method_cd,
    l.gen_cancel_line_fg,
    l.alc_tbc_cancel_line_fg,
    l.outside_worktime_cancel_line_fg,
    l.no_approval_cancel_line_fg,
    l.cancel_in_favour_highest_pos_line_fg,
    l.cancel_after_subtotal_line_fg,
    l.cancel_in_favour_single_pos_line_fg,
    l.line_rn,
    l.line_scanned_fg,
    l.change_fg,
    l.group_id,
    0 AS is_prod_with_manual_discount_fg
   FROM EVENT_LINES_GROUPS AS l
    LEFT JOIN (SELECT DISTINCT *
     FROM MANUAL_DISCOUNT_PRODS AS mdp) AS t14 ON l.retail_event_sid = t14.retail_event_sid AND l.local_prod_nr = t14.local_prod_nr
      
   WHERE l.gen_cancel_line_fg = 1
    AND t14.retail_event_sid IS NULL
    AND NOT EXISTS (SELECT 1
     FROM ${FWRK_WORK_DB}.vt1
      -- next event lines
      INNER JOIN ldl_data_core_rel.t_product_retail_line_2 AS NE_L ON vt1.dwh_cal_dt = NE_L.bus_dt AND vt1.country_cd =
         NE_L.country_org_cd AND vt1.loc_sid = NE_L.store_sid
     WHERE NE_L.retail_event_sid = l.next_retail_event_sid
      AND NE_L.bus_dt = l.bus_dt
      AND NE_L.country_org_cd = l.country_org_cd
      AND NE_L.local_prod_nr = l.local_prod_nr
      AND NE_L.bus_dt BETWEEN $min_dwh_cal_dt AND $max_dwh_cal_dt)) (SELECT
   -- event cols
   retail_event_sid,
   next_retail_event_sid,
   cash_register_event_nr,
   event_start_tmsp,
   event_end_tmsp,
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
   -- event line cols
   local_prod_nr,
   retail_line_gross_val,
   prod_variant_sid,
   retail_event_line_seq,
   cancel_line_seq,
   prod_variant_input_nr,
   auth_by_hash,
   prod_variant_qtyx,
   -- calculated flags for event lines
   gen_cancel_line_fg,
   alc_tbc_cancel_line_fg,
   outside_worktime_cancel_line_fg,
   no_approval_cancel_line_fg,
   cancel_in_favour_highest_pos_line_fg,
   cancel_after_subtotal_line_fg,
   cancel_in_favour_single_pos_line_fg,
   --
   is_prod_with_manual_discount_fg,
   line_scanned_fg,
   group_id
  FROM EVENT_LINES_FILTERED);

---------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------
--	Step3.1: Insert the final result for all sub-scenarios except the "single line" sub-scenario
--  	We evaluate the groups in each event and if they are NOT "double-tap",
-- 			then the group gets a Flag, and later the Event gets the flag. 

-- the way t_fact_fraud_detection_by_cash_register_event_final is processed in the end (by aggregation) allows us to insert 2 rows for same retail_event_sid in this script
-- so having second insert for another sub-scenario is not a problem

INSERT INTO ${FWRK_WORK_DB}.t_fact_fraud_detection_by_cash_register_event_final (cashier_hash, cancel_in_favour_fg,
 cash_register_sid, event_start_tmsp, bus_dt, cancel_in_favour_outside_opening_hr_fg, cancel_in_favour_gross_val,
 txn_gross_val, cash_register_event_sid, cancel_in_favour_alcohol_tobacco_fg, curr_cd, cancel_in_favour_lidl_plus_fg,
 cancel_in_favour_manual_discount_fg, cancel_in_favour_exact_paym_fg, store_sid, cancel_in_favour_line_cnt, txn_net_val
 , cancel_in_favour_highest_pos_fg, cash_register_event_nr, cust_sid, cash_register_nr, cust_ident_type_cd,
 cancel_in_favour_after_subtotal_fg, cancel_in_favour_without_auth_fg, cancel_in_favour_single_pos_fg)
WITH 
 -- we will join with the Param-View 3 times, so we want to trick snowflake to query it once, materialize the result and reuse it
 -- we want to avoid querying the view 3 times because it involves T_INTERNAL_ORGANIZATION_2, we have a policy there, and we want to reduce how many times the policy is evaluated
 MATERIALIZE_PARAM_VIEW AS (SELECT *
   FROM ldl_data_core_app_fraud_detection.v_fraud_detection_parameter_current_value_2
   WHERE scenario_id = 19), EVENT_GROUP_COUNTS AS (SELECT retail_event_sid,
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
    ANY_VALUE(cust_sid) AS cust_sid,
    ANY_VALUE(cust_ident_type_cd) AS cust_ident_type_cd,
    COUNT(*) AS lines_per_group, -- count of lines per group 
    SUM(gen_cancel_line_fg) AS gen_cancel_lines_per_group, -- count of generic cancelled lines
    SUM(retail_line_gross_val * gen_cancel_line_fg) AS cancel_gross_val_per_group,
    SUM(prod_variant_qtyx * gen_cancel_line_fg) AS cancel_qty_per_group,
     -- sub-scenario flags
     -- if at least one line in the group has this flag, then the group has the flag 
     -- and later if the group is not eliminated as doppletipper, the event will get the flag.
     CASE
     WHEN SUM(alc_tbc_cancel_line_fg) > 0
     THEN 1
     ELSE 0
     END AS group_cancel_in_favour_alcohol_tobacco_fg,
     CASE
     WHEN SUM(outside_worktime_cancel_line_fg) > 0
     THEN 1
     ELSE 0
     END AS group_cancel_in_favour_outside_opening_hr_fg,
     CASE
     WHEN SUM(no_approval_cancel_line_fg) > 0
     THEN 1
     ELSE 0
     END AS group_cancel_in_favour_without_auth_fg,
     CASE
     WHEN SUM(cancel_after_subtotal_line_fg) > 0
     THEN 1
     ELSE 0
     END AS group_cancel_in_favour_after_subtotal_fg,
     CASE
     WHEN SUM(cancel_in_favour_highest_pos_line_fg) > 0
     THEN 1
     ELSE 0
     END AS group_cancel_in_favour_highest_pos_fg,
     CASE
     WHEN SUM(cancel_in_favour_single_pos_line_fg) > 0
     THEN 1
     ELSE 0
     END AS group_cancel_in_favour_single_pos_line_fg,
    -- this is a "count" on Event level (not event+group level)
    -- but it has to be calculated here, before we eliminate groups without cancellations
    -- also we have eliminated cancelled lines with manual discounts, so here we are counting only lines with manual discounts which are not cancelled
    SUM(SUM(is_prod_with_manual_discount_fg)) OVER (PARTITION BY retail_event_sid RANGE BETWEEN UNBOUNDED PRECEDING AND
     UNBOUNDED FOLLOWING) AS event_cancel_in_favour_manual_discount_fg,
    SUM(line_scanned_fg) AS group_scanned_lines_cnt
   FROM t_tmp_cancel_friendly_line_groups
   GROUP BY retail_event_sid,
    group_id), EVENT_COUNTS AS (SELECT retail_event_sid,
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
    ANY_VALUE(cust_sid) AS cust_sid,
    ANY_VALUE(cust_ident_type_cd) AS cust_ident_type_cd,
    SUM(cancel_gross_val_per_group) AS cancel_gross_val_per_event, -- relevant_cancel_gross_val
    SUM(cancel_qty_per_group) AS cancel_qty_per_event,
    SUM(gen_cancel_lines_per_group) AS gen_cancel_lines_per_event, -- relevant_cancel_line_cnt
    1 AS cancel_in_favour_fg,
     CASE
     WHEN SUM(group_cancel_in_favour_alcohol_tobacco_fg) = 0
     THEN 0
     ELSE 1
     END AS cancel_in_favour_alcohol_tobacco_fg,
     CASE
     WHEN SUM(group_cancel_in_favour_outside_opening_hr_fg) = 0
     THEN 0
     ELSE 1
     END AS cancel_in_favour_outside_opening_hr_fg,
     CASE
     WHEN SUM(group_cancel_in_favour_without_auth_fg) = 0
     THEN 0
     ELSE 1
     END AS cancel_in_favour_without_auth_fg,
     CASE
     WHEN SUM(group_cancel_in_favour_after_subtotal_fg) = 0
     THEN 0
     ELSE 1
     END AS cancel_in_favour_after_subtotal_fg,
     CASE
     WHEN SUM(group_cancel_in_favour_highest_pos_fg) = 0
     THEN 0
     ELSE 1
     END AS cancel_in_favour_highest_pos_fg,
     CASE
     WHEN SUM(group_cancel_in_favour_single_pos_line_fg) = 0
     THEN 0
     ELSE 1
     END AS cancel_in_favour_single_pos_fg,
     -- we already calculated this on event level and have same value in all lines for the event, so we just take any of them
     CASE
     WHEN ANY_VALUE(event_cancel_in_favour_manual_discount_fg) = 0
     THEN 0
     ELSE 1
     END AS cancel_in_favour_manual_discount_fg
   FROM EVENT_GROUP_COUNTS
   WHERE gen_cancel_lines_per_group > 0
    -- eliminate "doppletipper" situation where 1 item_2 is scanned twice by mistake and remove once to fix the mistake
    -- so we exclude situations with multiple scans and 1 cancel
    -- situations more than 1 cancel are not excluded intentionally.
    -- for example scanning one item_2 3 times "by mistake" and having to remove 2 scans seems suspicious ... 
    AND (lines_per_group <= 1 OR group_scanned_lines_cnt <= 0 OR gen_cancel_lines_per_group <> 1)
   GROUP BY retail_event_sid) (SELECT ec.cashier_hash,
     ec.cancel_in_favour_fg AS cancel_in_favour_fg,
    CAST(ec.cash_register_sid AS INTEGER) AS cash_register_sid,
    ec.event_start_tmsp,
    ec.bus_dt,
     ec.cancel_in_favour_outside_opening_hr_fg AS cancel_in_favour_outside_opening_hr_fg,
    ec.cancel_gross_val_per_event AS cancel_in_favour_gross_val,
    ec.txn_gross_val,
    ec.retail_event_sid AS cash_register_event_sid,
     ec.cancel_in_favour_alcohol_tobacco_fg AS cancel_in_favour_alcohol_tobacco_fg,
    ec.curr_cd,
     IF(ec.cust_ident_type_cd IS NOT NULL, 1, 0) AS cancel_in_favour_lidl_plus_fg,
     ec.cancel_in_favour_manual_discount_fg AS cancel_in_favour_manual_discount_fg,
      CASE
      WHEN ec.txn_gross_val > 0 AND tpl.chg_aft_pay < 0 OR ec.txn_gross_val < 0 AND tpl.chg_aft_pay > 0
      THEN 1
      ELSE 0
      END AS cancel_in_favour_exact_paym_fg,
    CAST(ec.store_sid AS INTEGER) AS store_sid,
    ec.gen_cancel_lines_per_event AS cancel_in_favour_line_cnt,
    ec.txn_net_val,
     ec.cancel_in_favour_highest_pos_fg AS cancel_in_favour_highest_pos_fg,
    CAST(ec.cash_register_event_nr AS INTEGER) AS cash_register_event_nr,
    CAST(ec.cust_sid AS INTEGER) AS cust_sid,
    CR.cash_register_nr,
    ec.cust_ident_type_cd,
     ec.cancel_in_favour_after_subtotal_fg AS cancel_in_favour_after_subtotal_fg,
     ec.cancel_in_favour_without_auth_fg AS cancel_in_favour_without_auth_fg,
      CASE
      WHEN ec.cancel_in_favour_single_pos_fg <> 0 AND ec.txn_net_val <= p_sl.param_val_qty
      THEN 1
      ELSE 0
      END AS cancel_in_favour_single_pos_fg
   FROM EVENT_COUNTS AS ec
    LEFT JOIN (SELECT PL.retail_event_sid,
       COALESCE(MAX(CASE
          WHEN PL.paym_line_type_cd = 'R'
          THEN PL.retail_event_line_seq
          ELSE 0
          END), 0) - COALESCE(MAX(CASE
          WHEN PL.paym_line_type_cd = 'P'
          THEN PL.retail_event_line_seq
          ELSE 0
          END), 0) AS chg_aft_pay
     FROM ${FWRK_WORK_DB}.vt1
      INNER JOIN ldl_data_core_rel.t_payment_line_2 AS PL ON vt1.dwh_cal_dt = PL.bus_dt AND vt1.country_cd = PL.country_org_cd
          AND vt1.loc_sid = PL.store_sid
     WHERE PL.bus_dt BETWEEN $min_dwh_cal_dt AND $max_dwh_cal_dt
     GROUP BY PL.retail_event_sid) AS tpl ON ec.retail_event_sid = tpl.retail_event_sid
    INNER JOIN ldl_data_core_rel.t_cash_register_2 AS CR ON ec.cash_register_sid = CR.cash_register_sid AND CR.dwh_valid_fg
     
    INNER JOIN MATERIALIZE_PARAM_VIEW AS p_ncl -- parameter "number of cancellation lines"
     ON ec.country_org_cd = p_ncl.country_org_cd AND p_ncl.param_id = 57 AND
     -- if scenario is not enabled all receipts from that country_2 will be eliminated in this inner join
     p_ncl.is_scenario_enabled_in_country_fg
    INNER JOIN MATERIALIZE_PARAM_VIEW AS p_tci -- parameter "total amount of cancelled items"
     ON ec.country_org_cd = p_tci.country_org_cd AND p_tci.param_id = 58
    INNER JOIN MATERIALIZE_PARAM_VIEW AS p_ar -- parameter "Proportion of the total of canceled items to the receipt total" (AR stands for Amounts Ratio)
     ON ec.country_org_cd = p_ar.country_org_cd AND p_ar.param_id = 59
    INNER JOIN MATERIALIZE_PARAM_VIEW AS p_sl -- parameter "Bonsumme < X LW und nur 1 Artikel_2" 
     ON ec.country_org_cd = p_sl.country_org_cd AND p_sl.param_id = 61
   WHERE ec.gen_cancel_lines_per_event >= p_ncl.param_val_qty
    AND ec.cancel_gross_val_per_event >= p_tci.param_val_qty
    AND 100 * ec.cancel_gross_val_per_event / IF(ec.txn_gross_val = 0, NULL, ec.txn_gross_val) > p_ar.param_val_qty);