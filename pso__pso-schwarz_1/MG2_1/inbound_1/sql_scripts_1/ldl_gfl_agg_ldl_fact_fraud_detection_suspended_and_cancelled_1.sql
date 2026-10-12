/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung - DWH / MIS
#----------------------------------------------------------------------------
# Script: ldl_fact_fraud_detection_suspended_and_cancelled.sql
#----------------------------------------------------------------------------
# History:
#  1.0  16.09.2024  Andrzej Wandtke   - ZKP GF_1 - development by Olexander Bezpalko
#				        Script - Scenario Suspended Receipts - Bonrückstellung mit Bonabbruch/Storno/neuer Kunde
#  1.1  02.12.2024  Kamil Roszczyk    - ZKP GF_1 - bugfixing: https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/59465
									  Change log:
										- added small sale filter to the query as per old ZKP
										- added thresholds to the logic
										- rebuilding the whole query, performance optimization
#  1.2  09.12.2024  Osman Yilmaz    - ZKP GF_1 - bugfixing: https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/59465
										Change log:
										- Threshold is added for the some cancelation total value
										- The error has fixed for new sales_1 line determination
										- Threshold for small sale is applied already in the CTE instead of mail
#  1.3  12.12.2024  Osman Yilmaz    - ZKP GF_1 - bugfixing: https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/59465
										Change log:
										- Logic change in small sale determination
#  1.4	18.03.2025  Andrzej Wandtke   - ZKP GF_1 changes - task 66853 - filter on standard cash registers : POS type TIL

#  1.5  26.03.2025  Mihail Ivanov  - Changes:
						- added logic to set the flag only in scenario is enabled in a country_1 (and remove the flag if scenario is disabled)
							https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/63803
						- removed columns that were only relevant for "storno" scenarios
						- Using CASHIER_NR to determine next receipt by same employee. This is necessary because sometimes we get two hashes for same Store+Day+CashierNR

#  1.6  03.04.2025  Mihail Ivanov  - Changes:
						Removing flag if scenario is disabled is moved out of this script to the main script

#  1.7  29.04.2025  Kamil Roszczyk	- changes: changed 'TIL' filter for non selfcheckout cash registers
										- filter: "cash_register_type_cd = 'TIL'"; replaced with: "cash_register_type_cd = 'TIL' OR cash_register_type_cd IS NULL"
											https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/69257
*/

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
			, txn_gross_val
			, txn_net_val
			, curr_cd
			, suspend_and_abort_fg          --Suspended and subsequently cancelled
			, suspend_and_line_cancel_fg    --Suspended and subsequently resumed with a cancellation line
			, suspend_and_extend_fg         --Suspended and Entry of new articles with subsequent receipt closing
		)
WITH
mat_params AS
		(
			SELECT
				*
			FROM
				core_app_fraud_detection.v_fraud_detection_parameter_current_value_1
			WHERE
				scenario_id = 15 --  Bonrückstellung mit Bonabbruch
		)
	, all_cash_reg_events AS
		(
			SELECT
				tcre.tech_cash_register_event_sid AS cash_register_event_sid
				, tcre.cash_register_event_nr
				, tcre.event_tmsp
				, tcre.bus_dt
				, tcre.country_org_cd
				, tcre.cash_register_sid
				, tcre.cashier_hash
				, 'TECH_EVENT' AS event_category
				, tcre.tech_cash_register_event_type_cd AS event_subcategory
				, tcre.cancel_fg
				, tcre.suspend_fg
				, 0 AS txn_gross_val
				, ce.cashier_nr
			FROM core_rel.t_technical_cash_register_event_1 tcre
					join core_app_fraud_detection.T_CASHIER_ENCRYPTION_1 ce
						on ce.CASHIER_HASH = tcre.CASHIER_HASH
			WHERE
				tech_cash_register_event_type_cd NOT IN (400, 405, 420, 425, 430)
				AND tcre.bus_dt BETWEEN $MIN_DWH_CAL_DT AND $MAX_DWH_CAL_DT
				AND (tcre.country_org_cd, tcre.bus_dt, tcre.store_sid) IN
					(
						SELECT
							country_cd
							, dwh_cal_dt
							, loc_sid
						FROM
							${FWRK_WORK_DB}.vt1
					)
			UNION ALL
			SELECT
				re.retail_event_sid AS cash_register_event_sid
				, re.cash_register_event_nr
				, re.event_start_tmsp
				, re.bus_dt
				, re.country_org_cd
				, re.cash_register_sid
				, re.cashier_hash
				, 'RETAIL_EVENT' AS event_category
				, re.retail_event_type_cd AS event_subcategory
				, re.cancel_fg
				, re.suspend_fg
				, re.txn_gross_val
				, ce.cashier_nr
			FROM core_rel.t_retail_event_1 re_1
				join core_app_fraud_detection.T_CASHIER_ENCRYPTION_1 ce
						on ce.CASHIER_HASH = re.CASHIER_HASH
			WHERE
				re.bus_dt BETWEEN $MIN_DWH_CAL_DT AND $MAX_DWH_CAL_DT
				AND (re.country_org_cd, re.bus_dt, re.store_sid) IN
					(
						SELECT
							country_cd
							, dwh_cal_dt
							, loc_sid
						FROM
							${FWRK_WORK_DB}.vt1
					)
				AND (re.CASH_REGISTER_TYPE_CD = 'TIL'
					OR re.CASH_REGISTER_TYPE_CD IS NULL)
		)
	, small_sales_receipt_lines AS
		(
			SELECT 
				tprl.retail_event_sid
			FROM
				${FWRK_WORK_DB}.vt1
			INNER JOIN
				core_rel.t_product_retail_line_1 tprl
					ON vt1.country_cd = tprl.country_org_cd
					AND vt1.dwh_cal_dt = tprl.bus_dt
					AND vt1.loc_sid = tprl.store_sid
			INNER JOIN mat_params s15_kb -- Scenario 15, parameter "Small sale lesser than X LW"
					ON s15_kb.country_org_cd = vt1.country_cd
					AND s15_kb.param_id = 45  
					and s15_kb.IS_SCENARIO_ENABLED_IN_COUNTRY_FG = TRUE 				 
			WHERE	tprl.turnover_relevant_fg = True
			AND     (tprl.CASH_REGISTER_TYPE_CD = 'TIL'
					OR tprl.CASH_REGISTER_TYPE_CD IS NULL)
			AND     tprl.bus_dt BETWEEN $MIN_DWH_CAL_DT AND $MAX_DWH_CAL_DT
			GROUP BY
				tprl.retail_event_sid
			HAVING
				--take only these receipts with only one sale or deposit return line
				SUM(CASE WHEN tprl.retail_event_line_scenario_id IN (101, 102, 120, 122, 201, 202, 220, 222) THEN 1 ELSE 0 END) = 1
				--take only these receipts where there is no cancellation line with relevant value
				AND SUM(CASE WHEN tprl.cancel_line_seq IS NULL AND tprl.retail_line_gross_val < s15_kb.param_val_qty AND tprl.RETAIL_EVENT_LINE_SCENARIO_ID IN (101, 102, 120, 122, 201, 202, 220, 222) THEN 1 ELSE 0 END) = 1
		)
	, retail_events_suspended as
		(
			SELECT
				tre.retail_event_sid		--grouping on retail_event_sid without any calculation at this level - a trick to generate an optimal execution plan for the next CTE: retail_and_cancel_lines. Without this grouping Snowflake scans big tables first in next CTE
				, ANY_VALUE(tre.bus_dt) AS bus_dt
				, ANY_VALUE(tre.event_start_tmsp) AS event_start_tmsp
				, ANY_VALUE(tre.cash_register_sid) AS cash_register_sid
				, ANY_VALUE(tcr.cash_register_nr) AS cash_register_nr
				, ANY_VALUE(tre.cash_register_event_nr) AS cash_register_event_nr
				, ANY_VALUE(tre.store_sid) AS store_sid
				, ANY_VALUE(tre.country_org_cd) AS country_org_cd
				, ANY_VALUE(tre.cashier_hash) AS cashier_hash
				, ANY_VALUE(tre.txn_net_val) AS txn_net_val
				, ANY_VALUE(tre.txn_gross_val) AS txn_gross_val
				, ANY_VALUE(tre.curr_cd) AS curr_cd
				, ANY_VALUE(tre_cont.retail_event_sid) AS cont_retail_event_sid
				, ANY_VALUE(tre_cont.cancel_fg) AS cont_cancel_fg
				, ANY_VALUE(ce.CASHIER_NR) AS CASHIER_NR
			FROM
				${FWRK_WORK_DB}.vt1
			INNER JOIN
				core_rel.t_retail_event_1 tre
					ON vt1.dwh_cal_dt = tre.bus_dt
					AND vt1.country_cd = tre.country_org_cd
					AND vt1.loc_sid = tre.store_sid
			INNER JOIN
				core_rel.t_cash_register_1 tcr
					ON tre.cash_register_sid = tcr.cash_register_sid
					AND tcr.dwh_valid_fg = True
			INNER JOIN					--joining the receipt being a continuation of a suspended receipt
				core_rel.t_retail_event_1 tre_cont
					ON vt1.dwh_cal_dt = tre_cont.bus_dt
					AND tre.retail_event_sid = tre_cont.susp_retail_event_sid
			INNER JOIN
				mat_params s15_rgt    -- Scenario 15, parameter "Suspended receipt total value greater than X LW"
					ON s15_rgt.country_org_cd = tre.country_org_cd
					AND s15_rgt.scenario_id = 15
					AND s15_rgt.param_id = 46
					and s15_rgt.IS_SCENARIO_ENABLED_IN_COUNTRY_FG = TRUE 
			INNER JOIN
				core_app_fraud_detection.T_CASHIER_ENCRYPTION_1 ce
						on ce.CASHIER_HASH = tre.CASHIER_HASH
			WHERE
				tre.bus_dt BETWEEN $MIN_DWH_CAL_DT AND $MAX_DWH_CAL_DT
				AND tre.retail_event_type_cd = 'S'				--sales_1 transaction
				AND tre.suspend_fg = TRUE 						--suspended
				AND tre.cancel_fg = FALSE						--not cancelled
				AND tre.txn_gross_val > s15_rgt.param_val_qty	--total gross value of suspended receipt greater than the threshold value
				AND (tre.CASH_REGISTER_TYPE_CD = 'TIL'
					OR tre.CASH_REGISTER_TYPE_CD IS NULL)
			GROUP BY
				tre.retail_event_sid
		)
	, susp_retail_and_cancel_lines AS
		(
			SELECT
				res.retail_event_sid
				, ANY_VALUE(res.bus_dt) AS bus_dt
				, ANY_VALUE(res.event_start_tmsp) AS event_start_tmsp
				, ANY_VALUE(res.cash_register_sid) AS cash_register_sid
				, ANY_VALUE(res.cash_register_nr) AS cash_register_nr
				, ANY_VALUE(res.cash_register_event_nr) AS cash_register_event_nr
				, ANY_VALUE(res.store_sid) AS store_sid
				, ANY_VALUE(res.country_org_cd) AS country_org_cd
				, ANY_VALUE(res.cashier_hash) AS cashier_hash
				, ANY_VALUE(res.txn_net_val) AS txn_net_val
				, ANY_VALUE(res.txn_gross_val) AS txn_gross_val
				, ANY_VALUE(res.curr_cd) AS curr_cd
				, ANY_VALUE(res.cont_retail_event_sid) AS cont_retail_event_sid
				, ANY_VALUE(res.cont_cancel_fg) AS cont_cancel_fg
				, ANY_VALUE(res.cashier_nr) AS cashier_nr
				
				, MAX(COALESCE(tcl.retail_event_line_seq, 0)) AS max_cancellation_line
				, MAX(COALESCE(tprl.retail_event_line_seq, 0)) AS max_retail_line
				, SUM(CASE WHEN tprl.retail_event_line_scenario_id in (270, 201) THEN 1 ELSE 0 END) AS cnt_retail_line
  			    , MAX(COALESCE(decode(tprl.retail_event_line_scenario_id,201,tprl.retail_event_line_seq, 0),0)) AS last_sale_retail_line
			FROM
				retail_events_suspended res
			INNER JOIN					--joining the retail lines of a suspended receipt
				core_rel.t_product_retail_line_1 tprl
					ON res.bus_dt = tprl.bus_dt
					AND res.country_org_cd = tprl.country_org_cd
					AND res.store_sid = tprl.store_sid
					AND res.retail_event_sid = tprl.retail_event_sid
			LEFT OUTER JOIN				--joining the cancellation lines of a suspended receipt
				core_rel.t_cancellation_line_1 tcl
					ON res.bus_dt = tcl.bus_dt
					AND res.country_org_cd = tcl.country_org_cd
					AND res.store_sid = tcl.store_sid
					AND res.retail_event_sid = tcl.retail_event_sid
			GROUP BY
				res.retail_event_sid
		)
	, cont_retail_and_cancel_lines AS
		(
			SELECT
				sracl.retail_event_sid
				, ANY_VALUE(sracl.bus_dt) AS bus_dt
				, ANY_VALUE(sracl.event_start_tmsp) AS event_start_tmsp
				, ANY_VALUE(sracl.cash_register_sid) AS cash_register_sid
				, ANY_VALUE(sracl.cash_register_nr) AS cash_register_nr
				, ANY_VALUE(sracl.cash_register_event_nr) AS cash_register_event_nr
				, ANY_VALUE(sracl.store_sid) AS store_sid
				, ANY_VALUE(sracl.country_org_cd) AS country_org_cd
				, ANY_VALUE(sracl.cashier_hash) AS cashier_hash
				, ANY_VALUE(sracl.txn_net_val) AS txn_net_val
				, ANY_VALUE(sracl.txn_gross_val) AS txn_gross_val
				, ANY_VALUE(sracl.curr_cd) AS curr_cd
				, ANY_VALUE(sracl.cont_retail_event_sid) AS cont_retail_event_sid
				, ANY_VALUE(sracl.cont_cancel_fg) AS cont_cancel_fg
				, ANY_VALUE(sracl.cashier_nr) AS cashier_nr
				, ANY_VALUE(sracl.max_cancellation_line) AS max_cancellation_line
				, ANY_VALUE(sracl.max_retail_line) AS max_retail_line
				, ANY_VALUE(sracl.cnt_retail_line) AS cnt_retail_line
                , ANY_VALUE(sracl.last_sale_retail_line) AS last_sale_retail_line
				, MAX(COALESCE(tcl_cont.retail_event_line_seq, 0)) AS max_cont_cancellation_line
				, MAX(COALESCE(tprl_cont.retail_event_line_seq, 0)) AS max_cont_retail_line
                , SUM(CASE WHEN COALESCE(tprl_cont.cancel_line_seq,-1) > sracl.max_cancellation_line THEN tprl_cont.retail_line_gross_val ELSE 0 END) AS sum_cont_cancel_line_val	
				, SUM(CASE WHEN tprl_cont.retail_event_line_scenario_id in (170, 101) THEN 1 ELSE 0 END) AS cnt_cont_retail_line
                , MAX(COALESCE(decode(tprl_cont.retail_event_line_scenario_id,101,tprl_cont.retail_event_line_seq, 0),0)) AS last_cont_sale_retail_line				
			FROM
				susp_retail_and_cancel_lines sracl
			INNER JOIN					--joining the retail lines of a continuation receipt
				core_rel.t_product_retail_line_1 tprl_cont
					ON sracl.bus_dt = tprl_cont.bus_dt
					AND sracl.country_org_cd = tprl_cont.country_org_cd
					AND sracl.store_sid = tprl_cont.store_sid
					AND sracl.cont_retail_event_sid = tprl_cont.retail_event_sid
			LEFT OUTER JOIN				--joining the cancellation lines of a continuation receipt
				core_rel.t_cancellation_line_1 tcl_cont
					ON sracl.bus_dt = tcl_cont.bus_dt
					AND sracl.country_org_cd = tcl_cont.country_org_cd
					AND sracl.store_sid = tcl_cont.store_sid
					AND sracl.cont_retail_event_sid = tcl_cont.retail_event_sid
			GROUP BY
				sracl.retail_event_sid
		)
	, event_and_next_event as
		(
			SELECT
				cracl.retail_event_sid
				, cracl.bus_dt
				, cracl.event_start_tmsp
				, cracl.cash_register_sid
				, cracl.cash_register_nr
				, cracl.cash_register_event_nr
				, cracl.store_sid 
				, cracl.cashier_hash
				, cracl.txn_net_val
				, cracl.txn_gross_val
				, cracl.curr_cd
				, cracl.cont_retail_event_sid
				, cracl.cont_cancel_fg
				, cracl.max_cancellation_line
				, cracl.max_retail_line
				, cracl.max_cont_cancellation_line
				, cracl.max_cont_retail_line
				, cracl.sum_cont_cancel_line_val	
				, cracl.cnt_retail_line
                , cracl.cnt_cont_retail_line
                , cracl.last_sale_retail_line
                , cracl.last_cont_sale_retail_line
				, acre.cash_register_event_sid AS next_cash_register_event_sid
				, acre.event_category AS next_event_category
				, acre.event_subcategory AS next_event_subcategory
				, acre.country_org_cd AS next_country_org_cd
				, acre.suspend_fg AS next_suspend_fg
				, acre.cancel_fg AS next_cancel_fg
				, acre.txn_gross_val AS next_txn_gross_val
			FROM
				cont_retail_and_cancel_lines cracl
			INNER JOIN
				all_cash_reg_events acre
					ON cracl.cash_register_sid = acre.cash_register_sid
					AND cracl.bus_dt = acre.bus_dt
					AND cracl.cashier_nr = acre.cashier_nr -- no need to add condition for store, we already have same cash_register_sid
					AND cracl.cash_register_event_nr < acre.cash_register_event_nr
			QUALIFY
				-- we take the next event at the same Cash Register (that happened after the suspended receipt)
				ROW_NUMBER() OVER(PARTITION BY cracl.retail_event_sid ORDER BY acre.cash_register_event_nr) = 1
		)
	, calc_flags AS 
		(
			SELECT 
				eane.retail_event_sid AS cash_register_event_sid
				, eane.cash_register_event_nr
				, eane.event_start_tmsp
				, eane.bus_dt
				, eane.cash_register_sid
				, eane.cash_register_nr
				, eane.store_sid
				, eane.cashier_hash
				, eane.txn_gross_val
				, eane.txn_net_val
				, eane.curr_cd
				, DECODE(eane.cont_cancel_fg, True, 1, 0) AS suspend_and_abort_fg		--Suspended and subsequently aborted
				, CASE
						WHEN eane.cont_cancel_fg = False
							AND eane.max_cont_cancellation_line > eane.max_cancellation_line 
                            AND eane.sum_cont_cancel_line_val  > s15_kb.param_val_qty THEN 1
						ELSE 0
					END AS suspend_and_line_cancel_fg    								--Suspended and subsequently resumed with a storno line
				, CASE
						WHEN eane.cont_cancel_fg = False
                          AND eane.cnt_cont_retail_line > eane.cnt_retail_line
                          AND eane.last_cont_sale_retail_line > eane.last_sale_retail_line
						  AND eane.max_cont_retail_line > eane.max_retail_line THEN 1
						ELSE 0
					END AS suspend_and_extend_fg         								--Suspended and entry of new articles

			FROM
				event_and_next_event eane
			INNER JOIN
				mat_params s15_kb    -- Scenario 15, Storno von Artikeln bis max. letzter Artikel_1 und Stornosumme > X LW
					ON s15_kb.country_org_cd = eane.next_country_org_cd
					AND s15_kb.scenario_id = 15
					AND s15_kb.param_id = 47
					and s15_kb.IS_SCENARIO_ENABLED_IN_COUNTRY_FG = TRUE 
			LEFT OUTER JOIN
				small_sales_receipt_lines ssrl
					ON eane.next_cash_register_event_sid = ssrl.retail_event_sid
			WHERE
				-- we check if this next event is a sale or a logoff event
				-- "sign off" cash register event
				(eane.next_event_category = 'TECH_EVENT'
					AND eane.next_event_subcategory = '410')
				-- "small sale" retail event
				OR (eane.next_event_category = 'RETAIL_EVENT'
					AND eane.next_event_subcategory = 'S'
					AND ssrl.retail_event_sid IS NOT NULL
				   )
		)
SELECT
    cash_register_event_sid
	, cash_register_event_nr
	, event_start_tmsp
	, bus_dt
	, cash_register_sid
	, cash_register_nr
	, store_sid
	, cashier_hash
	, txn_gross_val
	, txn_net_val
	, curr_cd
	
	, suspend_and_abort_fg
	, suspend_and_line_cancel_fg
	, suspend_and_extend_fg
FROM
    calc_flags
WHERE
    suspend_and_abort_fg > 0
	OR suspend_and_line_cancel_fg > 0
	OR suspend_and_extend_fg > 0
;
