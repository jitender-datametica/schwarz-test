/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung - DWH / MIS
#----------------------------------------------------------------------------
# Script: ldl_fact_fraud_detection_cancel_in_favour.sql
#----------------------------------------------------------------------------
# History:
#  1.0  16.08.2024  Andrzej Wandtke  - ZKP GF - script for scenario Cancel in favour
#  1.1  22.08.2024  Andrzej Wandtke  - ZKP GF - development by Mihail Ivanov
                                       This covers a scenario with several sub-scenarios
                                       General scenario is CANCEL_IN_FAVOUR_FG
                                       https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/41148

                                       Subscenarios:
                                       1. CANCEL_IN_FAVOUR_ALCOHOL_TOBACCO_FG
                                       https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/46537/
	
                                       2. CANCEL_IN_FAVOUR_OUTSIDE_OPENING_HR_FG
                                       https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/46546
									   
#  1.2	29.08.2024	Piotr Kleysa	 - ZKP GF - development by Mihail Ivanov
                                       Adding two new subscenarios
                                       1. CANCEL_IN_FAVOUR_WITHOUT_AUTH_FG
                                       https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/46542/
                                        
                                       2. CANCEL_IN_FAVOUR_MANUAL_DISCOUNT_FG
                                       https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/46547/
									   
#  1.3	29.08.2024	Kamil Roszczyk   - ZKP GF - Adding two new subscenarios 
                                       1. CANCEL_IN_FAVOUR_AFTER_SUBTOTAL_FG
                                       https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/46541
                                   
                                       2.CANCEL_IN_FAVOUR_EXACT_PAYM_FG
                                       https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/46540

#  1.4  12.09.2024  Mihail Ivanov	 - Update logic for scenario CANCEL_IN_FAVOUR_WITHOUT_AUTH_FG
										now we are checking the value of AUTH_BY_HASH in T_CANCELLATION_LINE instead of T_PRODUCT_RETAIL_LINE
										
#  1.5  27.09.2024  Olexander Bezpalko - New sub-scenario
                                         CANCEL_IN_FAVOUR_HIGHEST_POS_FG
										 https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/46544
										 
										 Also split the logic into 3 queries (3 steps) instead of 1 to make maintenance simpler.

										 
	
#  1.6	06.11.2024	Mihail Ivanov	 -	Logic for "Doppletipper" updated - made the same as in "cancel_last_position" scenario
											To put two consequtive lines in same group they both must be "SCANNED"

#  1.7	08.11.2024	Mihail Ivanov	 -	Adjustment for column rename
											CANCEL_IN_FAVOUR_OUTSIDE_OPENING_HOURS_FG renamed to CANCEL_IN_FAVOUR_OUTSIDE_OPENING_HR_FG			

#  1.8	18.11.2024	Mihail Ivanov	 -	Added sub-scenario
											CANCEL_IN_FAVOUR_LIDL_PLUS_FG
											https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/57254/

										
										Added two columns to  core_dim.T_FACT_FRAUD_DETECTION_BY_CASH_REGISTER_EVENT
											CUST_SID
											CUST_IDENT_TYPE_CD
										The columns are taken 1:1 from core_rel.T_RETAIL_EVENT. 
										Can be used to produce a metric like "Count of [total/unique] Lidl Plus IDs (CUST_SIDs)" for every scenario

#  1.9	21.11.2024	Mihail Ivanov	 -	bugfix: Adjusted logic for "next receipt" - now taken comparing CASH_REGISTER_EVENT_NR for same CASH_REGISTER_SID, BUS_DT
												CASH_REGISTER_SID is based on Country,Store and RegisteNR so no need to add STORE_SID and COUNTRY_CD
												Logic explained here is relevant in general for "next receipt" evaluation: https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/53633
												
										bugfix: Evaluated only receipts where re.TURNOVER_RELEVANT_FG = TRUE 
												this eliminates cancelled (aborted) and suspended receipts too
												
#  1.10	09.12.2024	Mihail Ivanov	 -	bugfix: Changed product group filter, to make it sane as old world
											as requested in this bug:	https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/56851/
											
										bugfix: comparing threshold for "total amount of cancelled items" with the correct column 
								

#  1.11	20.01.2025	Mihail Ivanov   - ZKP GF changes (requested here: https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/55225)
										Add filter to exclude cancellations of negative values ( for example deposit)						

#  1.12	19.02.2025	Mihail Ivanov   - ZKP GF changes (requested here: https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/63798/)
										new sub-scenario for Stornos in receipts with only 1 retail line - CANCEL_IN_FAVOUR_SINGLE_POS_FG						

#  1.13	25.02.2025	Mihail Ivanov   - ZKP GF changes (requested here: https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/63798/)
										Logic for implementation of CANCEL_IN_FAVOUR_SINGLE_POS_FG is changed (fixed, we had it wrong)
										The flag means that we may have many cancelled lines in the receipt and we have only 1 non-cancelled regular retail line (regular means we do not count deposit lines)
										
										Bugfix: for all sub-scenarios we were raising the flag if the group of items has as many cancelled lines as there are lines in the group.
												But if we have 3 lines with 1 bottle of vodka and 2 of these lines are cancelled this is NOT "doppletipper" and should be counted - this is fixed now and we count such groups.
										
#  1.14	18.03.2025	Andrzej Wandtke   - ZKP GF changes - task 66853 - filter on standard cash registers : POS type TIL

#  1.15 26.03.2025	Kamil Roszczyk	- ZKP GF changes
										- replaced filters for turnover relevant and sales receipts to mimic the MIS logic
										- renamed the relevant_cancel_gross_val and relevant_cancel_line_cnt fields to synchronize with the recent data model changes
											https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/66945
										- added the logic for removing scenarios data when no threshold is set
											https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/63803


#  1.16  03.04.2025  Mihail Ivanov  - Changes:
						Removing flag if scenario is disabled is moved out of this script to the main script

#  1.17  29.04.2025  Kamil Roszczyk	- changes: changed 'TIL' filter for non selfcheckout cash registers
										- filter: "cash_register_type_cd = 'TIL'"; replaced with: "cash_register_type_cd = 'TIL' OR cash_register_type_cd IS NULL"
											https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/69257
											
											
#  1.18  16.05.2025  Mihail Ivanov  - Changes/Bugfixes: all requested here https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/70840
										
										- Change: for sub-scenario CANCEL_IN_FAVOUR_WITHOUT_AUTH_FG now none of the cancellation lines should be approved.
											Event cancellation lines that are cancelling retail lines with Obs/Gemuse/Blumen should be without approval
											
										- Bugfix: for sub-scenario CANCEL_IN_FAVOUR_AFTER_SUBTOTAL_FG now evaluating if "cancellation line" exists after "sub-total line"
												before we were looking for "cancelled retail line" after sub-total line
												
										- bugfix: for sub-scenario CANCEL_IN_FAVOUR_SINGLE_POS_FG we are now counting two line types
											"regular sales line" (type = S) and "Deposit Return Line" (type D)
											and event must have in total one non-cancelled line which is one of these types
											
									
									TODO (maybe after migration): discuss with Lucas what happens if we change the definition of "gen_cancel_line_fg" and include Obst/Gemuse/Blumen once event is quallified
										what happens with sub-scenarios - for example "cacelled highest amount" if the highest amount item is Flowers and it is cancelled
										what happens with sub-scenario "cancel after sub-total" if the cancellation line after sub-total cancelles flowers
										what we compare to thresholds, what we show in metrics (relevant cancelled lines cnt/gross val)
*/



---------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------
--	Step1: Create temporary table T_TMP_CANCEL_FRIENDLY_LINE_FLAGS
--  	It has all (not only cancelled) retail lines for each event where we have a at least one Storno(cancelled line) 
--		For each line we calculate a flag indicating if the line is suspicious for any sub-scenario

CREATE OR REPLACE TEMPORARY TABLE ${FWRK_WORK_DB}.T_TMP_CANCEL_FRIENDLY_LINE_FLAGS
DATA_RETENTION_TIME_IN_DAYS = 0
AS
WITH
-- fastest way to map RETAIL_EVENT_SID to its following RETAIL_EVENT_SID
-- yes, we are doing this for all receipts, not only for those that have cancellations
-- but still we have a filter on dates because of the delta extraction, and we are using only the smaller table with events (T_RETAIL_EVENT)
-- we do not need the bigger table with PRODUCT_RETAIL_LINE and we only use one window function (LEAD)
-- Other implementation require a equi-JOIN  + two (dense_rank) window functions, or non-equi-JOIN (next.cash_register_event_nr > curr.cash_register_event_nr) + ROW_NUMBER 
event_and_next_event AS
(
    SELECT 
        retail_event_sid
        ,lead(retail_Event_sid) over (partition BY cash_register_sid, bus_dt ORDER BY cash_register_event_nr) AS next_retail_event_sid

        --additional event attributes
        ,cash_register_event_nr
        ,event_start_tmsp
        ,bus_dt
        ,cash_register_sid
        ,store_sid
        ,cashier_hash
        ,txn_net_val
        ,txn_gross_val
        ,country_org_cd
        ,curr_cd
		,cust_sid
		,cust_ident_type_cd
		,turnover_relevant_fg
		,retail_event_type_cd
		
        ,event_end_tmsp

    FROM ${FWRK_WORK_DB}.VT1
        JOIN core_rel.T_RETAIL_EVENT re
            ON re.COUNTRY_ORG_CD = vt1.COUNTRY_CD
            AND re.BUS_DT = vt1.DWH_CAL_DT
            AND re.STORE_SID = vt1.LOC_SID
    WHERE bus_dt BETWEEN $min_dwh_cal_dt AND $max_dwh_cal_dt
		and (re.CASH_REGISTER_TYPE_CD = 'TIL'
			OR re.CASH_REGISTER_TYPE_CD IS NULL)
)
-- "cancel_line_seq not null" and "product groups" are very strong filters
-- it is better to use them early to limit the RETAIL_EVENT_SIDs with which we are working
-- and then in another step take all lines for these RETAIL_EVENT_SIDs
,event_with_suspicious_cancel AS
(
    SELECT 
        DISTINCT 
        ene.* -- we want only the event, 1 row for every receipt that has suspicous cancellation
    FROM event_and_next_event ene
        JOIN core_rel.T_PRODUCT_RETAIL_LINE l
                ON l.RETAIL_EVENT_SID = ene.RETAIL_EVENT_SID
                AND l.BUS_DT = ene.BUS_DT
                AND l.STORE_SID = ene.STORE_SID
        JOIN core_dim.T_DIM_SALES_VARIANT p
                ON l.PROD_VARIANT_SID = p.SALES_VARIANT_SID
                AND p.DWH_VALID_FG = TRUE
    WHERE 1=1
        --delta extraction
        AND l.bus_dt BETWEEN $min_dwh_cal_dt AND $max_dwh_cal_dt
		
		--Following two filters moved here from event_and_next_event CTE to not eliminate turnover not relevant and non sales receipts as main receipt's followers - in sync with receipt follower definition from MIS
		-- this eliminates cancelled (aborted) and suspended receipts too
		and ene.TURNOVER_RELEVANT_FG = TRUE
		--Sales receipts only
		and ene.RETAIL_EVENT_TYPE_CD = 'S'

        --scenario conditions
        AND l.cancel_line_seq IS NOT NULL
        AND ZeroIfNull(l.prod_variant_cnt) + ZeroIfNull(l.prod_variant_qty) < 50
		--Item within the item groups in scope
		and p.int_item_grp_nr is not NULL 
        and p.int_item_grp_nr not in ('10', '20') -- exclude Fruit/Vegetables and Flowers 
        
        and p.sub_item_grp_nr is not NULL
		and p.sub_item_grp_nr != '74' -- exclude bakery
		
		-- Filter to exclude cancellations of negative values (for example deposit)
		and l.RETAIL_LINE_GROSS_VAL > 0
)
, last_subtotal_before_storno AS
(
	SELECT
		tcl.RETAIL_EVENT_SID
		,MAX(tsl.event_tmsp) AS last_subtotal_tmsp
	FROM ${FWRK_WORK_DB}.VT1
        JOIN core_rel.T_CANCELLATION_LINE tcl
				ON vt1.COUNTRY_CD = tcl.COUNTRY_ORG_CD
				AND vt1.DWH_CAL_DT = tcl.BUS_DT
				AND vt1.LOC_SID = tcl.STORE_SID
        JOIN core_rel.T_SUBTOTAL_LINE tsl
				ON tcl.RETAIL_EVENT_SID = tsl.RETAIL_EVENT_SID
				AND tcl.EVENT_TMSP > tsl.EVENT_TMSP
	WHERE 1=1
		AND tcl.BUS_DT BETWEEN $min_dwh_cal_dt AND $max_dwh_cal_dt
		AND tsl.BUS_DT BETWEEN $min_dwh_cal_dt AND $max_dwh_cal_dt
	GROUP BY 
		tcl.RETAIL_EVENT_SID
)
,lines_of_event_with_suspicious_cancel AS
(
    SELECT 
        ewsc.*
        ,l.local_prod_nr
        ,l.retail_line_gross_val
        ,l.prod_variant_sid
        ,l.retail_event_line_seq
        ,l.cancel_line_seq
        ,l.prod_variant_input_nr
		,l.auth_by_hash
		,l.prod_entry_method_cd
        ,ZeroIfNull(l.prod_variant_cnt) + ZeroIfNull(l.prod_variant_qty) AS prod_variant_qtyx

		-- redefined requirement says that none of the cancelled lines should be approved for sub-scenario CANCEL_IN_FAVOUR_WITHOUT_AUTH_FG
		-- even Obst/Gemuse/Blumen lines must be without approval
		,COUNT(cl.AUTH_BY_HASH) OVER (PARTITION BY ewsc.retail_event_sid) AS event_appr_cancellation_lines_cnt
		
		,MAX(l.base_gross_val) OVER (PARTITION BY ewsc.retail_event_sid) 	AS MAX_LINE_AMT_PER_EVENT
		-- for flag "CANCEL_IN_FAVOUR_SINGLE_POS_FG" we need to make sure only 1 regular retail line is not cancelled 
		-- 		lines of type D "deposit returns" are also counted, while lines of type "SD" are ignored
		,SUM(iff(l.CANCEL_LINE_SEQ is null and l.PROD_RETAIL_LINE_TYPE_CD in ('S', 'D'), 1, 0)) OVER (PARTITION BY ewsc.retail_event_sid) AS EVENT_NON_CANCELLED_RETAIL_LINE_CNT
		,ROW_NUMBER() OVER (PARTITION BY ewsc.retail_event_sid ORDER BY l.event_start_tmsp, l.retail_event_line_seq) AS line_rn
		
		/* Storno aus den Warengruppen Kühlung, Tiko, Non Food, Frischbrot (ohne die die UWG Bake Off) oder Food TS aufweisen */
		,CASE 
            WHEN 1=1
					AND l.cancel_line_seq IS NOT NULL
					AND prod_variant_qtyx < 50
					-- exclude Fruit/Vegetables and Flowers 
					and p.int_item_grp_nr is not NULL 
					and p.int_item_grp_nr not in ('10', '20') 
					-- exclude bakery
					and p.sub_item_grp_nr is not NULL 
					and p.sub_item_grp_nr != '74' 
					-- Filter to exclude cancellations of negative values (for example deposit)
					and l.RETAIL_LINE_GROSS_VAL > 0  
				THEN 1 
            ELSE 0                                  END AS gen_cancel_line_fg
			
		/* Storno for Alcohol/Tabaco, SubGroups of int_item_grp_nr=60 */
		,CASE 
            WHEN gen_cancel_line_fg = 1 
                AND p.sub_item_grp_nr in ('60', '61', '63', '80') THEN 1
            ELSE 0                                  END AS alc_tbc_cancel_line_fg

		/* Storno outside work hours */
		,CASE 
            WHEN gen_cancel_line_fg = 1 
                AND (to_time(ewsc.EVENT_START_TMSP) < soh.open_tm OR to_time(ewsc.EVENT_END_TMSP) > soh.close_tm) THEN 1
            ELSE 0                                  END AS outside_worktime_cancel_line_fg

		/*Storno without approval*/
		,CASE 
            WHEN gen_cancel_line_fg = 1 
                AND event_appr_cancellation_lines_cnt = 0 THEN 1
            ELSE 0                                  END AS no_approval_cancel_line_fg
		
		
		/* highest purchased price item = highest purchased price item cancelled */
		,CASE 
		      WHEN gen_cancel_line_fg = 1
				AND l.base_gross_val = MAX_LINE_AMT_PER_EVENT THEN 1 
		      ELSE  0 END AS cancel_in_favour_highest_pos_line_fg  
		
		/* Storno after subtotal (or otherwise said "subtotal before storno exists" */
		,CASE
				WHEN gen_cancel_line_fg = 1
					AND lsbs.RETAIL_EVENT_SID is not null THEN 1
				ELSE 0 END AS cancel_after_subtotal_line_fg
				
				
		/* Storno and only 1 retail line remains uncancelled */
		,CASE
				WHEN gen_cancel_line_fg = 1
					AND EVENT_NON_CANCELLED_RETAIL_LINE_CNT = 1 THEN 1
				ELSE 0 END AS CANCEL_IN_FAVOUR_SINGLE_POS_LINE_FG

    FROM event_with_suspicious_cancel ewsc

        JOIN core_rel.T_PRODUCT_RETAIL_LINE l
                ON ewsc.RETAIL_EVENT_SID = l.RETAIL_EVENT_SID
                AND ewsc.BUS_DT = l.BUS_DT
                AND ewsc.COUNTRY_ORG_CD = l.COUNTRY_ORG_CD
                AND ewsc.STORE_SID = l.STORE_SID
				
		LEFT JOIN core_rel.T_CANCELLATION_LINE cl 
				ON cl.RETAIL_EVENT_SID = ewsc.RETAIL_EVENT_SID
				AND cl.RETAIL_EVENT_LINE_SEQ = l.CANCEL_LINE_SEQ
				AND cl.bus_dt BETWEEN $min_dwh_cal_dt AND $max_dwh_cal_dt
			
		LEFT JOIN last_subtotal_before_storno lsbs
				ON lsbs.RETAIL_EVENT_SID = ewsc.RETAIL_EVENT_SID

        LEFT JOIN core_rel.T_STORE_OPENING_HOURS soh
                ON ewsc.store_sid = soh.store_sid
                AND dayofweek(ewsc.BUS_DT) = soh.day_of_week
                AND soh.dwh_valid_fg = true

        LEFT JOIN core_dim.T_DIM_SALES_VARIANT p
                ON l.PROD_VARIANT_SID = p.SALES_VARIANT_SID
                AND p.DWH_VALID_FG = TRUE
	WHERE 1=1
		AND l.bus_dt BETWEEN $min_dwh_cal_dt AND $max_dwh_cal_dt
)
SELECT 
	-- event cols
	retail_event_sid
	,next_retail_event_sid
	,cash_register_event_nr
	,event_start_tmsp
	,event_end_tmsp
	,bus_dt
	,cash_register_sid
	,store_sid
	,cashier_hash
	,txn_net_val
	,txn_gross_val
	,country_org_cd
	,curr_cd
	,cust_sid
	,cust_ident_type_cd
	
	-- event line cols
	,local_prod_nr
	,retail_line_gross_val
	,prod_variant_sid
	,retail_event_line_seq
	,cancel_line_seq
	,prod_variant_input_nr
	,auth_by_hash
	,prod_variant_qtyx
	,prod_entry_method_cd

	-- calculated flags for event lines
	,gen_cancel_line_fg
	,alc_tbc_cancel_line_fg
	,outside_worktime_cancel_line_fg
	,no_approval_cancel_line_fg
	,cancel_in_favour_highest_pos_line_fg  
	,cancel_after_subtotal_line_fg
	,cancel_in_favour_single_pos_line_fg
	,line_rn
FROM lines_of_event_with_suspicious_cancel
; 




---------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------
--	Step2: Create temporary table T_TMP_CANCEL_FRIENDLY_LINE_GROUPS
--  	For each line we calculate also a flag if it has manual discount and a GROUP_ID within the event
--		Two lines of a given event belong to same GROUP_ID if they are consecutive, for same product and same quantity
--		We use this Groups later to evaluate if we have double-tap (1 item scanned twice by mistake and second scan is cancelled)


CREATE OR REPLACE TEMPORARY TABLE ${FWRK_WORK_DB}.T_TMP_CANCEL_FRIENDLY_LINE_GROUPS
DATA_RETENTION_TIME_IN_DAYS = 0
AS
WITH
event_lines_change_flag AS
(
    SELECT
        l.*
				--Doppeltipper: mark row if this and the previous row were scanned
		, CASE
			WHEN EQUAL_NULL(LAG(prod_entry_method_cd) OVER(PARTITION BY retail_event_sid ORDER BY line_rn), prod_entry_method_cd)
				AND prod_entry_method_cd = 'SC'
			THEN 1
			ELSE 0
			END AS curr_and_prev_scanned_fg
		--Doppeltipper: mark row as not changed only when the item and quantity are the same as in a previous row and when this is the consecutive scan
		, CASE 
			WHEN curr_and_prev_scanned_fg = 1
				AND EQUAL_NULL(LAG(local_prod_nr) OVER(PARTITION BY retail_event_sid ORDER BY line_rn), local_prod_nr)
				AND EQUAL_NULL(LAG(prod_variant_qtyx) OVER(PARTITION BY retail_event_sid ORDER BY line_rn), prod_variant_qtyx)
			THEN 0
			ELSE 1
		END AS change_fg
    FROM ${FWRK_WORK_DB}.T_TMP_CANCEL_FRIENDLY_LINE_FLAGS l
)
,event_lines_groups AS
(
    SELECT
        l.*
        ,SUM(change_fg) OVER (
				PARTITION BY retail_event_sid 
				ORDER BY line_rn 
				ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
			) 					AS group_id
    FROM event_lines_change_flag l

)
,manual_discount_prods AS
(
    SELECT 
        DISTINCT -- it is possible to have two discounts for same ProductRetailLine, and we just want 1 row per ProductRetailLine
        l.retail_event_sid
        ,l.local_prod_nr
    FROM event_lines_groups l
        INNER JOIN core_rel.t_discount_line d
            ON  l.retail_event_sid      = d.retail_event_sid
            AND l.country_org_cd        = d.country_org_cd
            AND l.bus_dt                = d.bus_dt
            AND l.retail_event_line_seq = d.discounted_line_seq
            AND l.cancel_line_seq IS NULL
            AND d.retail_event_line_scenario_id BETWEEN 400 AND 599
            AND ABS(d.discount_val) >= 0.011
            AND NOT
              (
                  LENGTH(l.prod_variant_input_nr) BETWEEN 15 AND 17
                  AND l.prod_variant_input_nr LIKE ANY ('55%', '56%')
              )
)
-- lines of event with suspicious cancellation, but we have to exclude cancelled lines if they exist in next receipt or we have manual discount for same product in this receipt
,event_lines_filtered AS
(
    -- Lines that are NOT cancelled. We need the to compare counts for double-tap 
    --    and also to check if there are manual discounts for products which are not cancelled
    SELECT 
        l.*
        ,DECODE(mdp.RETAIL_EVENT_SID,NULL, 0, 1) is_prod_with_manual_discount_fg
    FROM event_lines_groups l
        LEFT JOIN manual_discount_prods mdp
            ON l.retail_event_sid  = mdp.retail_event_sid
            AND l.local_prod_nr     = mdp.local_prod_nr
    WHERE gen_cancel_line_fg = 0

    UNION ALL

    -- Lines that are cancelled but for the Product there is no Manual Discount and it does not exist in next receipt
    SELECT 
        l.*
        ,0  is_prod_with_manual_discount_fg
    FROM event_lines_groups l
        LEFT JOIN manual_discount_prods mdp
            ON l.retail_event_sid  = mdp.retail_event_sid
            AND l.local_prod_nr     = mdp.local_prod_nr
    WHERE gen_cancel_line_fg = 1
        
		AND mdp.RETAIL_EVENT_SID IS NULL
        AND NOT EXISTS (
            SELECT 1
            FROM ${FWRK_WORK_DB}.VT1
                JOIN core_rel.T_PRODUCT_RETAIL_LINE ne_l -- next event lines
                        ON ne_l.BUS_DT = vt1.DWH_CAL_DT
                        AND ne_l.COUNTRY_ORG_CD = vt1.COUNTRY_CD
                        AND ne_l.STORE_SID = vt1.LOC_SID
            WHERE 1=1
                AND ne_l.RETAIL_EVENT_SID = l.NEXT_RETAIL_EVENT_SID
                AND ne_l.BUS_DT = l.BUS_DT
                AND ne_l.COUNTRY_ORG_CD = l.COUNTRY_ORG_CD
                AND ne_l.LOCAL_PROD_NR = l.LOCAL_PROD_NR
                AND ne_l.bus_dt BETWEEN $min_dwh_cal_dt AND $max_dwh_cal_dt
	
            )
)
SELECT 
	retail_event_sid
	,next_retail_event_sid
	,cash_register_event_nr
	,event_start_tmsp
	,event_end_tmsp
	,bus_dt
	,cash_register_sid
	,store_sid
	,cashier_hash
	,txn_net_val
	,txn_gross_val
	,country_org_cd
	,curr_cd
	,cust_sid
	,cust_ident_type_cd
	
	-- event line cols
	,local_prod_nr
	,retail_line_gross_val
	,prod_variant_sid
	,retail_event_line_seq
	,cancel_line_seq
	,prod_variant_input_nr
	,auth_by_hash
	,prod_variant_qtyx

	-- calculated flags for event lines
	,gen_cancel_line_fg
	,alc_tbc_cancel_line_fg
	,outside_worktime_cancel_line_fg
	,no_approval_cancel_line_fg
	,cancel_in_favour_highest_pos_line_fg  
	,cancel_after_subtotal_line_fg
	,cancel_in_favour_single_pos_line_fg
	
	--
    ,is_prod_with_manual_discount_fg
	,group_id
FROM event_lines_filtered
; 



---------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------
--	Step3.1: Insert the final result for all sub-scenarios except the "single line" sub-scenario
--  	We evaluate the groups in each event and if they are NOT "double-tap",
-- 			then the group gets a Flag, and later the Event gets the flag. 

-- the way t_fact_fraud_detection_by_cash_register_event_final is processed in the end (by aggregation) allows us to insert 2 rows for same retail_event_sid in this script
-- so having second insert for another sub-scenario is not a problem

INSERT INTO
	${FWRK_WORK_DB}.t_fact_fraud_detection_by_cash_register_event_final
		(
			cash_register_event_sid
			,cash_register_event_nr
			,event_start_tmsp
			,bus_dt
			,cash_register_sid
			,cash_register_nr
			,store_sid
			,cashier_hash
			,txn_net_val
			,txn_gross_val
			,cancel_in_favour_gross_val
			,curr_cd
			,cancel_in_favour_line_cnt
			,cust_sid
			,cust_ident_type_cd

			,cancel_in_favour_fg
			,cancel_in_favour_alcohol_tobacco_fg
			,cancel_in_favour_outside_opening_hr_fg
			,cancel_in_favour_without_auth_fg
            ,cancel_in_favour_manual_discount_fg
			,cancel_in_favour_after_subtotal_fg
			,cancel_in_favour_highest_pos_fg
			,cancel_in_favour_single_pos_fg
			,cancel_in_favour_exact_paym_fg
			,cancel_in_favour_lidl_plus_fg
		)
WITH
-- we will join with the Param-View 3 times, so we want to trick snowflake to query it once, materialize the result and reuse it
-- we want to avoid querying the view 3 times because it involves T_INTERNAL_ORGANIZATION, we have a policy there, and we want to reduce how many times the policy is evaluated
materialize_param_view AS
(
    SELECT *
    FROM CORE_APP_FRAUD_DETECTION.V_FRAUD_DETECTION_PARAMETER_CURRENT_VALUE
    WHERE SCENARIO_ID = 19
)
,event_group_counts AS
(
    SELECT 
        retail_event_sid
        ,group_id
        
        ,any_value(cash_register_event_nr)		AS cash_register_event_nr
        ,any_value(event_start_tmsp) 		 	AS event_start_tmsp
        ,any_value(bus_dt) 		            	AS bus_dt
        ,any_value(cash_register_sid) 			AS cash_register_sid
        ,any_value(store_sid) 					AS store_sid
        ,any_value(cashier_hash) 				AS cashier_hash
        ,any_value(txn_net_val) 				AS txn_net_val
        ,any_value(txn_gross_val) 				AS txn_gross_val
        ,any_value(country_org_cd) 				AS country_org_cd
        ,any_value(curr_cd) 					AS curr_cd
        ,any_value(cust_sid) 				   	AS cust_sid
        ,any_value(cust_ident_type_cd) 			AS cust_ident_type_cd
        
        ,count(*)								AS lines_per_group 		-- count of lines per group 
        ,SUM(gen_cancel_line_fg) 	    		AS gen_cancel_lines_per_group		-- count of generic cancelled lines
        ,SUM(retail_line_gross_val*gen_cancel_line_fg) 	AS cancel_gross_val_per_group
        ,SUM(prod_variant_qtyx*gen_cancel_line_fg)	   	AS cancel_qty_per_group

		-- sub-scenario flags
		-- if at least one line in the group has this flag, then the group has the flag 
		-- and later if the group is not eliminated as doppletipper, the event will get the flag.
        ,(SUM(alc_tbc_cancel_line_fg) > 0)::NUMBER 					AS group_cancel_in_favour_alcohol_tobacco_fg
        ,(SUM(outside_worktime_cancel_line_fg) > 0)::NUMBER 		AS group_cancel_in_favour_outside_opening_hr_fg
        ,(SUM(no_approval_cancel_line_fg) > 0)::NUMBER 				AS group_cancel_in_favour_without_auth_fg
		,(SUM(cancel_after_subtotal_line_fg) > 0)::NUMBER 			AS group_cancel_in_favour_after_subtotal_fg
	    ,(SUM(cancel_in_favour_highest_pos_line_fg) > 0)::NUMBER 	AS group_cancel_in_favour_highest_pos_fg
	    ,(SUM(cancel_in_favour_single_pos_line_fg) > 0)::NUMBER 	AS group_cancel_in_favour_single_pos_line_fg

        -- this is a "count" on Event level (not event+group level)
        -- but it has to be calculated here, before we eliminate groups without cancellations
        -- also we have eliminated cancelled lines with manual discounts, so here we are counting only lines with manual discounts which are not cancelled
        ,SUM(SUM(is_prod_with_manual_discount_fg)) OVER (PARTITION BY retail_event_sid) event_cancel_in_favour_manual_discount_fg
    FROM ${FWRK_WORK_DB}.T_TMP_CANCEL_FRIENDLY_LINE_GROUPS
    GROUP BY
        retail_event_sid
        ,group_id

)
,event_counts AS
(
    SELECT 
        retail_event_sid
        ,any_value(cash_register_event_nr)		AS cash_register_event_nr
        ,any_value(event_start_tmsp) 		 	AS event_start_tmsp
        ,any_value(bus_dt) 		            	AS bus_dt
        ,any_value(cash_register_sid) 			AS cash_register_sid
        ,any_value(store_sid) 					AS store_sid
        ,any_value(cashier_hash) 				AS cashier_hash
        ,any_value(txn_net_val) 				AS txn_net_val
        ,any_value(txn_gross_val) 				AS txn_gross_val
        ,any_value(country_org_cd) 				AS country_org_cd
        ,any_value(curr_cd) 					AS curr_cd
        ,any_value(cust_sid) 				   	AS cust_sid
        ,any_value(cust_ident_type_cd) 			AS cust_ident_type_cd
        
        ,SUM(cancel_gross_val_per_group) 	       AS cancel_gross_val_per_event -- relevant_cancel_gross_val
        ,SUM(cancel_qty_per_group)			       AS cancel_qty_per_event
        ,SUM(gen_cancel_lines_per_group)	       AS gen_cancel_lines_per_event -- relevant_cancel_line_cnt

			
        ,1                  										        AS cancel_in_favour_fg
        ,DECODE(SUM(group_cancel_in_favour_alcohol_tobacco_fg),0,0,1)       AS cancel_in_favour_alcohol_tobacco_fg
        ,DECODE(SUM(group_cancel_in_favour_outside_opening_hr_fg),0,0,1) 	AS cancel_in_favour_outside_opening_hr_fg
        ,DECODE(SUM(group_cancel_in_favour_without_auth_fg),0,0,1)        	AS cancel_in_favour_without_auth_fg
		,DECODE(SUM(group_cancel_in_favour_after_subtotal_fg),0,0,1)        AS cancel_in_favour_after_subtotal_fg
		,DECODE(SUM(group_cancel_in_favour_highest_pos_fg),0,0,1)           AS cancel_in_favour_highest_pos_fg
		,DECODE(SUM(group_cancel_in_favour_single_pos_line_fg),0,0,1)    	AS cancel_in_favour_single_pos_fg
    
        -- we already calculated this on event level and have same value in all lines for the event, so we just take any of them
        ,DECODE(any_value(event_cancel_in_favour_manual_discount_fg),0,0,1) AS cancel_in_favour_manual_discount_fg 

        
    FROM event_group_counts

    WHERE 1=1
		and gen_cancel_lines_per_group > 0
        -- eliminate "doppletipper" situation where 1 item is scanned twice by mistake and remove once to fix the mistake
        -- so we exclude situations with multiple scans and 1 cancel
		-- situations more than 1 cancel are not excluded intentionally.
		-- for example scanning one item 3 times "by mistake" and having to remove 2 scans seems suspicious ... 
        and not (lines_per_group > 1 and gen_cancel_lines_per_group = 1)
    GROUP BY retail_event_sid
		
)
SELECT 
    ec.retail_event_sid                     AS cash_register_event_sid
    ,ec.cash_register_event_nr
    ,ec.event_start_tmsp
    ,ec.bus_dt
    ,ec.cash_register_sid
    ,cr.CASH_REGISTER_NR
    ,ec.store_sid
    ,ec.cashier_hash
    ,ec.txn_net_val
    ,ec.txn_gross_val
    ,ec.cancel_gross_val_per_event AS cancel_in_favour_gross_val
    ,ec.curr_cd
    ,ec.gen_cancel_lines_per_event AS cancel_in_favour_line_cnt
	,cust_sid
	,cust_ident_type_cd
    
	,ec.cancel_in_favour_fg
	,ec.cancel_in_favour_alcohol_tobacco_fg
	,ec.cancel_in_favour_outside_opening_hr_fg
	,ec.cancel_in_favour_without_auth_fg
	,ec.cancel_in_favour_manual_discount_fg
	,ec.cancel_in_favour_after_subtotal_fg
	,ec.cancel_in_favour_highest_pos_fg
	
	, CASE 
			WHEN ec.cancel_in_favour_single_pos_fg and ec.txn_net_val <= p_sl.PARAM_VAL_QTY THEN 1
			ELSE 0
		END as cancel_in_favour_single_pos_fg
    
	, CASE
            WHEN (ec.txn_gross_val > 0 AND tpl.chg_aft_pay < 0) OR (ec.txn_gross_val < 0 AND tpl.chg_aft_pay > 0) THEN 1
            ELSE 0
		END AS cancel_in_favour_exact_paym_fg
			
	,iff(cust_ident_type_cd is not null, 1, 0) as cancel_in_favour_lidl_plus_fg
    
FROM event_counts ec
	LEFT OUTER JOIN
			(
				SELECT
					retail_event_sid
					, COALESCE(MAX(DECODE(paym_line_type_cd,'R', retail_event_line_seq, 0)), 0) 
                        - COALESCE(MAX(DECODE(paym_line_type_cd,'P', retail_event_line_seq, 0)), 0) AS chg_aft_pay
				FROM ${FWRK_WORK_DB}.VT1
					JOIN core_rel.t_payment_line pl
                        ON pl.BUS_DT = vt1.DWH_CAL_DT
                        AND pl.COUNTRY_ORG_CD = vt1.COUNTRY_CD
                        AND pl.STORE_SID = vt1.LOC_SID
				WHERE
					bus_dt BETWEEN $min_dwh_cal_dt AND $max_dwh_cal_dt
				GROUP BY
					retail_event_sid
			) tpl
				ON ec.retail_event_sid = tpl.retail_event_sid
    JOIN core_rel.T_CASH_REGISTER cr
            ON cr.CASH_REGISTER_SID = ec.CASH_REGISTER_SID
            AND cr.DWH_VALID_FG = TRUE
    JOIN materialize_param_view p_ncl -- parameter "number of cancellation lines"
            ON ec.COUNTRY_ORG_CD = p_ncl.COUNTRY_ORG_CD
            AND p_ncl.PARAM_ID = 57
			-- if scenario is not enabled all receipts from that country will be eliminated in this inner join
			AND p_ncl.IS_SCENARIO_ENABLED_IN_COUNTRY_FG = TRUE 
    JOIN materialize_param_view p_tci -- parameter "total amount of cancelled items"
            ON ec.COUNTRY_ORG_CD = p_tci.COUNTRY_ORG_CD
            AND p_tci.PARAM_ID = 58
    JOIN materialize_param_view p_ar -- parameter "Proportion of the total of canceled items to the receipt total" (AR stands for Amounts Ratio)
            ON ec.COUNTRY_ORG_CD = p_ar.COUNTRY_ORG_CD
            AND p_ar.PARAM_ID = 59
	JOIN materialize_param_view p_sl -- parameter "Bonsumme < X LW und nur 1 Artikel" 
		ON ec.COUNTRY_ORG_CD = p_sl.COUNTRY_ORG_CD
		AND p_sl.PARAM_ID = 61
WHERE 1=1
    AND cancel_in_favour_line_cnt >= p_ncl.PARAM_VAL_QTY
    AND cancel_in_favour_gross_val >= p_tci.PARAM_VAL_QTY
    AND (100*cancel_in_favour_gross_val/nullifzero(ec.txn_gross_val)) > p_ar.PARAM_VAL_QTY
;

