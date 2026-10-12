/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung - DWH / MIS
#----------------------------------------------------------------------------
# Script: ldl_fact_fraud_detection_last_position_cancel.sql
#----------------------------------------------------------------------------
# History:
#  1.0  16.08.2024  Andrzej Wandtke  - ZKP GF_1 - script for scenario Cancel on last position 
						flag CANCEL_LAST_POS_FG

#  1.1	05.09.2024  Kamil Roszczyk   - ZKP GF_1 - Modified the script to fit to the updated data model
						Added the code for two subscenarios
						1. CANCEL_LAST_POS_AFTER_SUBTOTAL_FG
						https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/46541
										   
						2. CANCEL_LAST_POS_EXACT_PAYM_FG
						https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/46540

#  1.2	23.09.2024	Kamil Roszczyk   - ZKP GF_1 - Added the code for subscenario
						CANCEL_LAST_POS_ALCOHOL_TOBACCO_FG
						https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/51848
						

#  1.3	05.11.2024	Mihail Ivanov   - ZKP GF_1
						Code Refactoring - The huge query with ~10 CTEs is split into 2 queries
							First we create temp table with all lines of the suspicious events, and calculate(evaluate) scenario flags for each line
							Then we put these lines in groups to exclude "Doppeltipper"
							
						Added the code for 3 sub-scenarios:
							CANCEL_LAST_POS_HIGHEST_POS_FG
							,CANCEL_LAST_POS_OUTSIDE_OPENING_HR_FG
							,CANCEL_LAST_POS_MULTI_LINES_FG
						https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/56050

#  1.4	09.12.2024	Mihail Ivanov   - ZKP GF_1 bugfixes:
							filter for Cash-Only payments fixed
							Now taking ALL cancellation lines after the retail lines (if more than 1, we take all - not only last)
							Threshold compared with sum of ALL cancelled lines after last retail line
							Changed product group filter, to make it sane as old world
								as requested in this bug:	https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/56843/
								
#  1.5	20.01.2025	Mihail Ivanov   - ZKP GF_1 changes (requested here: https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/55225)
							Add filter to exclude cancellations of negative values ( for example deposit)
							
							
#  1.6	19.02.2025	Mihail Ivanov   - ZKP GF_1 changes (requested here: https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/63798/)
										new sub-scenario for Stornos in receipts with only 1 retail line - CANCEL_LAST_POS_SINGLE_POS_FG
										new sub-scenario for Storno in last position without authorization - CANCEL_LAST_POS_WITHOUT_AUTH_FG
										
#  1.7	25.02.2025	Mihail Ivanov   - ZKP GF_1 changes (requested here: https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/63798/)
										Logic for implementation of CANCEL_LAST_POS_SINGLE_POS_FG is changed (fixed, we had it wrong)
										The flag means that we may have many cancelled lines in the receipt and we have only 1 non-cancelled regular retail line (regular means we do not count deposit lines)
										
										Bugfix: for all sub-scenarios we were raising the flag if the group of items has as many cancelled lines as there are lines in the group.
												But if we have 3 lines with 1 bottle of vodka and 2 of these lines are cancelled this is NOT "doppletipper" and should be counted - this is fixed now and we count such groups.

#  1.8  19.03.2025  Kamil Roszczyk  - bugfixing: https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/66945
										- changed the threshold comparison for cancelled item_1 values - from comparing of each single item_1 separately to comparing the total amount of all items being in receipt's last position
										- changed the threshold comparison for "Bonsumme < X LW und nur 1 Artikel_1" subscenario - from comparing net value to comparing gross values
										
#  1.9	25.03.2025	Andrzej Wandtke   - ZKP GF_1 changes - task 66853 - filter on standard cash registers : POS type TIL

#  1.10 26.03.2025	Kamil Roszczyk	- ZKP GF_1 changes
										- replaced filters for turnover relevant and sales_1 receipts to mimic the MIS logic
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
										
											
	, cancel_last_pos_without_auth_fg
*/



CREATE OR REPLACE TEMPORARY TABLE ${FWRK_WORK_DB}.T_TMP_LINES_OF_EVENT_WITH_SUSPICIOUS_CANCEL
DATA_RETENTION_TIME_IN_DAYS = 0
AS 
WITH
materialize_param_view AS
(
	SELECT
		*
	FROM
		core_app_fraud_detection.v_fraud_detection_parameter_current_value_1
	WHERE
		scenario_id = 18
)
,event_and_next_event AS
(
	SELECT 
		re.retail_event_sid
		, LEAD(re.retail_event_sid) OVER (
					PARTITION BY re.bus_dt, re.cash_register_sid 
					ORDER BY re.cash_register_event_nr	) AS next_retail_event_sid
		, re.cash_register_event_nr
		, re.event_start_tmsp
		, re.bus_dt
		, re.cash_register_sid
		, re.store_sid
		, re.cashier_hash
		, re.txn_net_val
		, re.txn_gross_val
		, re.country_org_cd
		, re.curr_cd
		, re.event_end_tmsp
		, re.turnover_relevant_fg
		, re.retail_event_type_cd
	FROM ${FWRK_WORK_DB}.vt1 
		join core_rel.t_retail_event_1 re_1 
				on re.STORE_SID = vt1.LOC_SID 
				and re.BUS_DT = vt1.DWH_CAL_DT
				and re.COUNTRY_ORG_CD = vt1.COUNTRY_CD
	WHERE 1=1
		--Delta extraction
		and bus_dt BETWEEN $min_dwh_cal_dt AND $max_dwh_cal_dt

		--Standard cash register only
		and (re.CASH_REGISTER_TYPE_CD = 'TIL'
			OR re.CASH_REGISTER_TYPE_CD IS NULL)
)
-- "Tail" in the meaning that these cancellation lines are at the end of receipts
-- after them there are no more regular (product_retail) lines
,tail_position_cancel AS
(
	SELECT
		ene.*
		,cl.retail_event_line_seq	as TAIL_CANCEL_LINE_SEQ 
		,cl.event_tmsp				as TAIL_CANCEL_TMSP
        ,cl.auth_by_hash
	FROM event_and_next_event ene
		join core_rel.t_cancellation_line_1 cl
				on cl.RETAIL_EVENT_SID = ene.RETAIL_EVENT_SID
				and cl.STORE_SID = ene.STORE_SID 
				and cl.BUS_DT = ene.BUS_DT
				and cl.COUNTRY_ORG_CD = ene.COUNTRY_ORG_CD
		left join core_rel.t_product_retail_line_1 prl
				on prl.RETAIL_EVENT_SID = ene.RETAIL_EVENT_SID
				and prl.STORE_SID = ene.STORE_SID 
				and prl.BUS_DT = ene.BUS_DT
				and prl.COUNTRY_ORG_CD = ene.COUNTRY_ORG_CD
				and (
                        prl.EVENT_START_TMSP > cl.event_tmsp
						or (prl.EVENT_START_TMSP = cl.EVENT_TMSP and prl.RETAIL_EVENT_LINE_SEQ > cl.RETAIL_EVENT_LINE_SEQ)
                    )
	
	WHERE prl.RETAIL_EVENT_SID is null
	
		--Following two filters moved here from event_and_next_event CTE to not eliminate turnover not relevant and non sales_1 receipts as main receipt's followers - in sync with receipt follower definition from MIS
		-- this eliminates cancelled (aborted) and suspended receipts too
		and ene.TURNOVER_RELEVANT_FG = TRUE
		--Sales_1 receipts only
		and ene.RETAIL_EVENT_TYPE_CD = 'S'
)
, event_with_suspicious_cancel AS
(
	SELECT 
		-- we want only the event, 1 row for every receipt that has suspicous cancellation
		tpc.retail_event_sid
		,tpc.next_retail_event_sid
		,tpc.cash_register_event_nr
		,tpc.event_start_tmsp
		,tpc.bus_dt
		,tpc.cash_register_sid
		,tpc.store_sid
		,tpc.cashier_hash
		,tpc.txn_net_val
		,tpc.txn_gross_val
		,tpc.country_org_cd
		,tpc.curr_cd
		,tpc.event_end_tmsp
		
		,max(tpc.TAIL_CANCEL_TMSP) 					as LAST_CANCEL_TMSP
		-- how many cancellation lines exist after the last retail line (at the "tail" end of the receipt)
		,count(distinct tpc.TAIL_CANCEL_LINE_SEQ) 	as TAIL_CANCEL_LINES_CNT 
		-- how many of the "tail" cancellation lines are approved for the given event
		,count(tpc.AUTH_BY_HASH)					as TAIL_CANCEL_APPROVED_CNT  
		
	FROM tail_position_cancel tpc
		INNER JOIN core_rel.t_product_retail_line_1 prl
				ON prl.RETAIL_EVENT_SID = tpc.RETAIL_EVENT_SID
				and prl.CANCEL_LINE_SEQ = tpc.TAIL_CANCEL_LINE_SEQ
				
				and prl.STORE_SID = tpc.STORE_SID 
				and prl.BUS_DT = tpc.BUS_DT
				and prl.COUNTRY_ORG_CD = tpc.COUNTRY_ORG_CD
				
		INNER JOIN core_dim.t_dim_sales_variant_1 p
			ON prl.prod_variant_sid = p.sales_variant_sid
			AND p.dwh_valid_fg = TRUE
		
	WHERE 1=1
		--Item_1 quantity lower than 50
		AND ZEROIFNULL(prl.prod_variant_cnt) + ZEROIFNULL(prl.prod_variant_qty) < 50
		
		--Item_1 within the item_1 groups in scope
		and p.int_item_grp_nr is not NULL 
        and p.int_item_grp_nr not in ('10', '20') -- exclude Fruit/Vegetables and Flowers 
        
        and p.sub_item_grp_nr is not NULL
		and p.sub_item_grp_nr != '74' -- exclude bakery
		
		-- cancelled product is not on next receipt
		AND NOT EXISTS
			(
				SELECT 1
				FROM core_rel.T_PRODUCT_RETAIL_LINE_1 n_prl
				WHERE 1=1
					and n_prl.RETAIL_EVENT_SID = tpc.NEXT_RETAIL_EVENT_SID
					and n_prl.LOCAL_PROD_NR = prl.LOCAL_PROD_NR
					and n_prl.BUS_DT = tpc.BUS_DT 
					and n_prl.COUNTRY_ORG_CD = tpc.COUNTRY_ORG_CD
			)
			
		--Cash payments only
		AND NOT EXISTS 
			(
				SELECT 1
				FROM core_rel.t_payment_line_1 pl
				WHERE 1=1
					and pl.RETAIL_EVENT_SID = tpc.RETAIL_EVENT_SID
					and pl.PAYM_TYPE_ID <> 11
					and pl.BUS_DT = tpc.BUS_DT
					and pl.COUNTRY_ORG_CD = tpc.COUNTRY_ORG_CD
					and pl.bus_dt BETWEEN $min_dwh_cal_dt AND $max_dwh_cal_dt
			)
			
		-- Filter to exclude cancellations of negative values (for example deposit)
		and prl.RETAIL_LINE_GROSS_VAL > 0
	group by
		tpc.retail_event_sid
		,tpc.next_retail_event_sid
		,tpc.cash_register_event_nr
		,tpc.event_start_tmsp
		,tpc.bus_dt
		,tpc.cash_register_sid
		,tpc.store_sid
		,tpc.cashier_hash
		,tpc.txn_net_val
		,tpc.txn_gross_val
		,tpc.country_org_cd
		,tpc.curr_cd
		,tpc.event_end_tmsp
)
-- lines_of_event_with_suspicious_cancel
SELECT
	ewsc.*
	,tprl.local_prod_nr
	,tprl.retail_line_gross_val
	,tprl.prod_variant_sid
	,tprl.retail_event_line_seq
	,tprl.cancel_line_seq
	,tprl.prod_variant_input_nr
	,tprl.auth_by_hash
	,tprl.prod_entry_method_cd
	,ZEROIFNULL(tprl.prod_variant_cnt) + ZEROIFNULL(tprl.prod_variant_qty) AS prod_variant_qtyx
	
	
	,MAX(tprl.base_gross_val) OVER (PARTITION BY ewsc.retail_event_sid) AS MAX_LINE_AMT_PER_EVENT
	
	-- for flag "CANCEL_LAST_POS_SINGLE_POS_FG" we need to make sure only 1 regular retail line (excl. deposits) is not cancelled.
	,SUM(iff(tprl.CANCEL_LINE_SEQ is null and tprl.PROD_RETAIL_LINE_TYPE_CD = 'S',1,0)) OVER (PARTITION BY ewsc.retail_event_sid) AS EVENT_NON_CANCELLED_RETAIL_LINE_CNT
	,ROW_NUMBER() OVER(PARTITION BY ewsc.retail_event_sid ORDER BY tprl.event_start_tmsp, tprl.retail_event_line_seq) AS line_rn

	--Cancellation at last position
	,CASE
			WHEN tpc.RETAIL_EVENT_SID is not NULL 
				and tprl.RETAIL_LINE_GROSS_VAL > 0 THEN 1
			ELSE 0
		END AS last_pos_cancel_line_fg
	
	--Cancellation at last position after subtotal
	,CASE
			WHEN last_pos_cancel_line_fg = 1 AND tsl.retail_event_sid IS NOT NULL THEN 1
			ELSE 0
		END AS last_pos_after_subtotal_cancel_fg
	
	--Cancellation of alcohol/tobacco at last position
	,CASE
			WHEN last_pos_cancel_line_fg = 1 AND p.sub_item_grp_nr IN ('60', '61', '63', '80') THEN 1
			ELSE 0
		END AS last_pos_alc_tbc_cancel_fg
	
	-- Line with the biggest amount is cancelled by "last cancel"
	,CASE 
			WHEN last_pos_cancel_line_fg = 1 AND tprl.base_gross_val = MAX_LINE_AMT_PER_EVENT THEN 1 
			ELSE  0 
		END AS last_pos_highest_pos_fg
		
	-- Cancellation (Storno) is outside work hours
	,CASE 
			WHEN last_pos_cancel_line_fg = 1 
				AND (to_time(ewsc.EVENT_START_TMSP) < soh.open_tm OR to_time(ewsc.EVENT_END_TMSP) > soh.close_tm) THEN 1
			ELSE 0                                  
		END AS last_pos_outside_opening_hr_fg

	-- Cancellation of multiple lines which are at last(tail) position - meaning not retail lines after them
	,CASE 
			WHEN last_pos_cancel_line_fg = 1 
				AND TAIL_CANCEL_LINES_CNT > 1 THEN 1
			ELSE 0                                  
		END AS last_and_other_pos_fg
		
	-- Cancellations at last position without approval - None of the "tail" cancelation lines is approved (other cancellation lines that are at "regular" position might still be approved, but we do not care for this situation)
	,CASE 
		WHEN last_pos_cancel_line_fg = 1 
			AND TAIL_CANCEL_APPROVED_CNT = 0 THEN 1
		ELSE 0                                  END AS no_approval_cancel_line_fg
			
	/* Storno of the only retail line */
	,CASE
			WHEN last_pos_cancel_line_fg = 1
				AND EVENT_NON_CANCELLED_RETAIL_LINE_CNT = 1
				AND ewsc.TXN_GROSS_VAL <= p_sl.PARAM_VAL_QTY THEN 1
			ELSE 0 END AS CANCEL_SINGLE_POS_LINE_FG

FROM event_with_suspicious_cancel ewsc
	join core_rel.t_product_retail_line_1 tprl
			on tprl.RETAIL_EVENT_SID = ewsc.RETAIL_EVENT_SID
			and tprl.STORE_SID = ewsc.STORE_SID 
			and tprl.BUS_DT = ewsc.BUS_DT
			and tprl.COUNTRY_ORG_CD = ewsc.COUNTRY_ORG_CD
			
	INNER JOIN materialize_param_view p_sl -- parameter "Bonsumme < X LW und nur 1 Artikel_1" 
				ON ewsc.COUNTRY_ORG_CD = p_sl.COUNTRY_ORG_CD
				AND p_sl.PARAM_ID = 56
				-- if scenario is not enabled all receipts from that country_1 will be eliminated in this inner join
				AND p_sl.IS_SCENARIO_ENABLED_IN_COUNTRY_FG = TRUE
			
	LEFT JOIN core_rel.T_CANCELLATION_LINE_1 cl 
				ON cl.RETAIL_EVENT_SID = ewsc.RETAIL_EVENT_SID
				AND cl.RETAIL_EVENT_LINE_SEQ = tprl.CANCEL_LINE_SEQ
				AND cl.bus_dt BETWEEN $min_dwh_cal_dt AND $max_dwh_cal_dt
			
	left join tail_position_cancel tpc
			on tpc.RETAIL_EVENT_SID = ewsc.RETAIL_EVENT_SID
			and tpc.TAIL_CANCEL_LINE_SEQ = tprl.CANCEL_LINE_SEQ
			
	left join core_dim.T_DIM_SALES_VARIANT_1 p
		ON tprl.prod_variant_sid = p.sales_variant_sid
		AND p.dwh_valid_fg = TRUE
		
	left join core_rel.T_STORE_OPENING_HOURS_1 soh
			ON ewsc.STORE_SID = soh.STORE_SID
			AND dayofweek(ewsc.BUS_DT) = soh.DAY_OF_WEEK
			AND soh.dwh_valid_fg = true

	--Joining to t_subtotal_line_1 to find subtotal rows appearing before cancellation
	-- we just need to check if sub-total line exists before the storno (which is in last position in this case), so we take the earliest sub-total line
	LEFT OUTER JOIN
		(
			SELECT
				retail_event_sid
				,min(EVENT_TMSP) FIRST_SUBTOTAL_LINE_TMSP
			FROM ${FWRK_WORK_DB}.vt1
				join core_rel.t_subtotal_line_1 sl
						on sl.STORE_SID = vt1.LOC_SID 
						and sl.BUS_DT = vt1.DWH_CAL_DT
						and sl.COUNTRY_ORG_CD = vt1.COUNTRY_CD
			WHERE bus_dt BETWEEN $min_dwh_cal_dt AND $max_dwh_cal_dt
			GROUP BY retail_event_sid
		) tsl
			ON ewsc.retail_event_sid = tsl.retail_event_sid
			AND ewsc.LAST_CANCEL_TMSP > tsl.FIRST_SUBTOTAL_LINE_TMSP
;







INSERT INTO
	${FWRK_WORK_DB}.t_fact_fraud_detection_by_cash_register_event_final
		(
			cash_register_event_sid
			, cash_register_event_nr
			, event_start_tmsp
			, bus_dt
			, cash_register_sid
			, cash_register_nr
			, store_sid
			, cashier_hash
			, txn_net_val
			, txn_gross_val
			, cancel_last_pos_gross_val
			, curr_cd
			, cancel_last_pos_line_cnt
			, cancel_last_pos_fg
			, cancel_last_pos_after_subtotal_fg
			, cancel_last_pos_exact_paym_fg
			, cancel_last_pos_alcohol_tobacco_fg
			
			, cancel_last_pos_highest_pos_fg
			, cancel_last_pos_outside_opening_hr_fg
			, cancel_last_and_other_pos_fg
			, cancel_last_pos_without_auth_fg
			, cancel_last_pos_single_pos_fg
		)
WITH
materialize_param_view AS
(
	SELECT
		*
	FROM
		core_app_fraud_detection.v_fraud_detection_parameter_current_value_1
	WHERE
		scenario_id = 18
)
,event_lines_change_flag AS
(
	SELECT
		*
		--Doppeltipper: mark row if this and the previous row were scanned
		, CASE
			WHEN EQUAL_NULL(LAG(prod_entry_method_cd) OVER(PARTITION BY retail_event_sid ORDER BY line_rn), prod_entry_method_cd)
				AND prod_entry_method_cd = 'SC'
			THEN 1
			ELSE 0
			END AS curr_and_prev_scanned_fg
		--Doppeltipper: mark row as not changed only when the item_1 and quantity are the same as in a previous row and when this is the consecutive scan
		, CASE 
			WHEN curr_and_prev_scanned_fg = 1
				AND EQUAL_NULL(LAG(local_prod_nr) OVER(PARTITION BY retail_event_sid ORDER BY line_rn), local_prod_nr)
				AND EQUAL_NULL(LAG(prod_variant_qtyx) OVER(PARTITION BY retail_event_sid ORDER BY line_rn), prod_variant_qtyx)
			THEN 0
			ELSE 1
			END AS doppeltipper_change_fg
	
	FROM ${FWRK_WORK_DB}.T_TMP_LINES_OF_EVENT_WITH_SUSPICIOUS_CANCEL
)
, event_lines_groups AS
(
	SELECT 
		*
		, SUM(doppeltipper_change_fg) OVER(
				PARTITION BY retail_event_sid 
				ORDER BY line_rn 
				ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS group_id
	FROM
		event_lines_change_flag
)
,event_group_counts AS
(
	SELECT 
		retail_event_sid
		, group_id
		
		, ANY_VALUE(cash_register_event_nr) AS cash_register_event_nr
		, ANY_VALUE(event_start_tmsp) AS event_start_tmsp
		, ANY_VALUE(bus_dt) AS bus_dt
		, ANY_VALUE(cash_register_sid) AS cash_register_sid
		, ANY_VALUE(store_sid) AS store_sid
		, ANY_VALUE(cashier_hash) AS cashier_hash
		, ANY_VALUE(txn_net_val) AS txn_net_val
		, ANY_VALUE(txn_gross_val) AS txn_gross_val
		, ANY_VALUE(country_org_cd) AS country_org_cd
		, ANY_VALUE(curr_cd) AS curr_cd
		
		,COUNT(*) 									AS lines_per_group
		,SUM(last_pos_cancel_line_fg) 				AS last_pos_cancel_lines_per_group
		
		--Still calculating cancelled gross value per group - this will be compared with "Total value of cancelled items" threshold and should be filtered out by Doppeltipper logic before compared as per requirement
		,SUM(retail_line_gross_val*last_pos_cancel_line_fg) AS cancel_gross_val_per_group
		
		--Calculating final values for cancel_last_pos_line_cnt and cancel_last_pos_gross_val here
		--In MIS the report metrics that use fields corresponding to these two contain aggregated values for all lines being at last positions, regardless they could fall into Doppeltipper exclusion or not
		--So if we have two cancellations in last positions from which one should be excluded by Doppeltipper and another following cancellation that should not be affected by Doppeltipper then the metric for gross value of last position cancellations should aggregate both these lines
		--Then, to avoid affection by Doppeltipper filter in next event_counts CTE, both these fields are calculated here using window functions
        ,SUM(last_pos_cancel_lines_per_group) OVER(PARTITION BY retail_event_sid) AS last_pos_cancel_lines_per_event
		,SUM(cancel_gross_val_per_group) OVER(PARTITION BY retail_event_sid) AS cancel_gross_val_per_event
		

		
		-- sub-scenario flags
		-- if at least one line in the group has this flag, then the group has the flag 
		-- and later if the group is not eliminated as doppletipper, the event will get the flag.
		,(SUM(last_pos_after_subtotal_cancel_fg) > 0)::NUMBER	 	as group_last_pos_after_subtotal_cancel_fg
		,(SUM(last_pos_alc_tbc_cancel_fg) > 0)::NUMBER				as group_last_pos_alc_tbc_cancel_fg
		,(SUM(last_pos_highest_pos_fg) > 0)::NUMBER 				as group_last_pos_highest_pos_cancel_fg
			
		,(SUM(last_pos_outside_opening_hr_fg) > 0)::NUMBER			as group_last_pos_outside_opening_hr_cancel_fg
		,(SUM(last_and_other_pos_fg) > 0)::NUMBER					as group_last_and_other_pos_cancel_fg
		,(SUM(no_approval_cancel_line_fg) > 0)::NUMBER				as group_no_approval_cancel_fg
		,(SUM(cancel_single_pos_line_fg) > 0)::NUMBER				as group_cancel_single_pos_line_fg
	FROM
		event_lines_groups
	GROUP BY
		retail_event_sid
		,group_id
)
,event_counts as 
(
	SELECT 
		egc.retail_event_sid
		
		, ANY_VALUE(egc.cash_register_event_nr) AS cash_register_event_nr
		, ANY_VALUE(egc.event_start_tmsp) AS event_start_tmsp
		, ANY_VALUE(egc.bus_dt) AS bus_dt
		, ANY_VALUE(egc.cash_register_sid) AS cash_register_sid
		, ANY_VALUE(egc.store_sid) AS store_sid
		, ANY_VALUE(egc.cashier_hash) AS cashier_hash
		, ANY_VALUE(egc.txn_net_val) AS txn_net_val
		, ANY_VALUE(egc.txn_gross_val) AS txn_gross_val
		, ANY_VALUE(egc.country_org_cd) AS country_org_cd
		, ANY_VALUE(egc.curr_cd) AS curr_cd
		
		--Passing any value from groups CTE as these two fields were already calculated on receipt level
		, ANY_VALUE(egc.cancel_gross_val_per_event) AS cancel_gross_val_per_event
		, ANY_VALUE(egc.last_pos_cancel_lines_per_event) AS last_position_cancel_lines_per_event
		
		, 1 AS cancel_last_pos_fg
		, DECODE(SUM(egc.group_last_pos_after_subtotal_cancel_fg), 0, 0, 1) 		AS cancel_last_pos_after_subtotal_fg
		, DECODE(SUM(egc.group_last_pos_alc_tbc_cancel_fg), 0, 0, 1) 				AS cancel_last_pos_alcohol_tobacco_fg
		
		, DECODE(SUM(egc.group_last_pos_highest_pos_cancel_fg), 0, 0, 1) 			AS cancel_last_pos_highest_pos_fg
		, DECODE(SUM(egc.group_last_pos_outside_opening_hr_cancel_fg), 0, 0, 1) 	AS cancel_last_pos_outside_opening_hr_fg
		, DECODE(SUM(egc.group_last_and_other_pos_cancel_fg), 0, 0, 1) 				AS cancel_last_and_other_pos_fg
		, DECODE(SUM(egc.group_no_approval_cancel_fg), 0, 0, 1) 					AS cancel_last_pos_without_auth_fg
		, DECODE(SUM(egc.group_cancel_single_pos_line_fg), 0, 0, 1) 				AS cancel_last_pos_single_pos_fg
	FROM
		event_group_counts egc
	
		--Parameter "Total value of cancelled items"
		INNER JOIN materialize_param_view p_tcl
			ON egc.country_org_cd = p_tcl.country_org_cd
			AND p_tcl.param_id = 55
	WHERE 1=1
		-- take only groups for which we have cancellation by the last position
		and egc.last_pos_cancel_lines_per_group > 0 
		--Doppeltipper: filter out groups where there are two or more consecutively scanned items with only one corresponding line cancel
		AND NOT (egc.lines_per_group > 1 AND egc.last_pos_cancel_lines_per_group = 1)
	GROUP BY
		egc.retail_event_sid
	HAVING
		SUM(egc.cancel_gross_val_per_group) > ANY_VALUE(p_tcl.param_val_qty)
)
SELECT 
    ec.retail_event_sid AS cash_register_event_sid
    , ec.cash_register_event_nr
    , ec.event_start_tmsp
    , ec.bus_dt
    , ec.cash_register_sid
    , cr.cash_register_nr
    , ec.store_sid
    , ec.cashier_hash
    , ec.txn_net_val
    , ec.txn_gross_val
    , ec.cancel_gross_val_per_event AS cancel_last_pos_gross_val
    , ec.curr_cd
    , ec.last_position_cancel_lines_per_event AS cancel_last_pos_line_cnt
    , ec.cancel_last_pos_fg
	, ec.cancel_last_pos_after_subtotal_fg
    , CASE
            WHEN (ec.txn_gross_val > 0 AND tpl.chg_aft_pay < 0) OR (ec.txn_gross_val < 0 AND tpl.chg_aft_pay > 0)
            THEN 1
            ELSE 0
            END AS cancel_last_pos_exact_paym_fg
    , ec.cancel_last_pos_alcohol_tobacco_fg
	
	, cancel_last_pos_highest_pos_fg
	, cancel_last_pos_outside_opening_hr_fg
	, cancel_last_and_other_pos_fg
	, cancel_last_pos_without_auth_fg
	, cancel_last_pos_single_pos_fg

FROM event_counts ec
	INNER JOIN core_rel.t_cash_register_1 cr
			ON cr.cash_register_sid = ec.cash_register_sid
			AND cr.dwh_valid_fg = TRUE
	
	LEFT OUTER JOIN
		(
			SELECT
				retail_event_sid
				, COALESCE(MAX(CASE WHEN paym_line_type_cd = 'R' THEN retail_event_line_seq ELSE 0 END), 0) - COALESCE(MAX(CASE WHEN paym_line_type_cd = 'P' THEN retail_event_line_seq ELSE 0 END), 0) AS chg_aft_pay
			FROM
				core_rel.t_payment_line_1
			WHERE
				bus_dt BETWEEN $min_dwh_cal_dt AND $max_dwh_cal_dt
				AND (country_org_cd, bus_dt, store_sid) IN
					(
						SELECT
							country_cd, dwh_cal_dt, loc_sid
						FROM
							${FWRK_WORK_DB}.vt1
					)
			GROUP BY
				retail_event_sid
		) tpl
		ON ec.retail_event_sid = tpl.retail_event_sid

WHERE 1=1
	--Doppeltipper: filter out receipts with no more last position cancellations after Doppeltipper groups being removed in a previous subquery
	-- NOT NEEDED - only 1 group can have items cancelled by "last cancel" and this is the group we take in the previous sub-query
	--ec.last_position_cancel_lines_per_event > 0
;
