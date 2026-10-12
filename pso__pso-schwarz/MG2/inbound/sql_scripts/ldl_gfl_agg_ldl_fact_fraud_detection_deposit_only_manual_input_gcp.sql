-- Converted to BigQuery SQL using Python script

/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung - DWH / MIS
#----------------------------------------------------------------------------
# Script: ldl_fact_fraud_detection_deposit_only_manual_input.sql
#----------------------------------------------------------------------------
# History:
#  1.0  20.08.2024  Osman Yilmaz  - ZKP GF Story 33404 ZKP: deposit receipt payout / Pfandbon manuell + rein
#  1.1  22.08.2024  Osman Yilmaz  - ZKP GF Story 33402 ZKP: deposit receipt with one sales item / Pfandbon + 1 Artikel
#  1.2  26.08.2024  Osman Yilmaz  - ZKP GF Story 46545 ZKP: Bonsumme<X LW + 1 Artikel: Total receipt amount less than X and the receipt contains only one article
#  1.3  04.12.2024  Kamil Roszczyk - ZKP GF - bugfixing: https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/58124
#									Change log:
#										- adjusted the threshold comparison for deposit_only_manual_input_fg - changed from 'txn_gross_val < threshold' to 'ABS(txn_gross_val) > threshold' just as it was in old ZKP
#										- rebuilding the query, performance optimization
#										- adjusting the receipt filters to the ones used commonly in GF
#  1.4  20.12.2024  Kamil Roszczyk - ZKP GF - performance optimization, query rebuilding
#  1.5	08.01.2025  Kamil Roszczyk - ZKP GF - bugfixing: https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/62169
#									Change log:
#										- removed txn_gross_val<->man_deposit_val comparison from deposit_only_manual_input_fg flag logic - replaced with checking if there is no sales and deposit sales lines in receipt
#  1.6	18.02.2025  Andrzej Wandtke - ZKP GF - Remove scenario 25 (small_sale_fg) - not used in core_dim but calculated as a manual KPI in a separate script
                                               Remove scenario 1 (deposit_and_one_prod_fg) - https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/64819
#  1.7  26.03.2025  Mihail Ivanov  - Changes:
						- added logic to set the flag only in scenario is enabled in a country (and remove the flag if scenario is disabled)
							https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/63803
						- removed columns that were only relevant for "storno" scenarios
#  1.8  03.04.2025  Mihail Ivanov  - Changes:
						Removing flag if scenario is disabled is moved out of this script to the main script
#  1.9	06.05.2025  Andrzej Wandtke - ZKP GF - 69532 - Remove filter on cancel_rows_cnt in order to mark the receipts with Storno transactions as well
*/
INSERT INTO `${BQ_PROJECT_ID}.${FWRK_WORK_DB}.T_FACT_FRAUD_DETECTION_BY_CASH_REGISTER_EVENT_FINAL`
-- INSERT INTO	`data-at-schwarz.ETL.T_FACT_FRAUD_DETECTION_BY_CASH_REGISTER_EVENT_FINAL_copy`
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
			, curr_cd
			, deposit_only_manual_input_fg
		)
WITH
	mat_params AS
		(
			SELECT
				*
			FROM
				`${BQ_PROJECT_ID}.CORE_APP_FRAUD_DETECTION.V_FRAUD_DETECTION_PARAMETER_CURRENT_VALUE`
			WHERE
				scenario_id IN (4)	--Pfandbon + rein
                -- WHERE SCENARIO_ID = 2 
		)
	, prequal_headers AS
		(
			SELECT
				head.retail_event_sid AS cash_register_event_sid
				, head.cash_register_event_nr
				, head.event_start_tmsp
				, head.bus_dt
				, head.cash_register_sid
				, cr.cash_register_nr
				, head.store_sid
				, head.cashier_hash
				, head.txn_net_val
				, head.txn_gross_val
				, head.curr_cd
			FROM
				VT1 VT1
			INNER JOIN
				`${BQ_PROJECT_ID}.CORE_REL.T_RETAIL_EVENT` head
					ON VT1.dwh_cal_dt = head.bus_dt
					AND VT1.country_cd = head.country_org_cd
					AND VT1.loc_sid = head.store_sid
			INNER JOIN
				`${BQ_PROJECT_ID}.CORE_REL.T_CASH_REGISTER` cr
					ON head.cash_register_sid = cr.cash_register_sid
					AND cr.dwh_valid_fg = True
			WHERE
				head.retail_event_type_cd = 'S'
				AND head.cancel_fg = False
				AND head.suspend_fg = False
		)
	, prequal_lines AS
		(
			SELECT
				line.retail_event_sid AS cash_register_event_sid
				, ANY_VALUE(line.bus_dt) AS bus_dt
				, ANY_VALUE(line.country_org_cd) AS country_org_cd
				, ANY_VALUE(line.store_sid) AS store_sid
				, SUM(CASE WHEN line.retail_event_line_scenario_id IN (120, 122) AND line.prod_entry_method_cd IN ('DV', 'KE') THEN 1 ELSE 0 END) AS man_deposit_return_cnt
				, SUM(CASE WHEN line.retail_event_line_scenario_id IN (101, 102) THEN 1 ELSE 0 END) AS sale_rows_cnt
				, SUM(CASE WHEN line.retail_event_line_scenario_id IN (101, 102) THEN line.retail_line_gross_val ELSE 0 END) AS sale_rows_val
				, SUM(CASE WHEN line.retail_event_line_scenario_id IN (121, 123) THEN 1 ELSE 0 END) AS deposit_sale_rows_cnt
				, SUM(CASE WHEN line.retail_event_line_scenario_id IN (120, 122) THEN 1 ELSE 0 END) AS deposit_return_rows_cnt
				, SUM(CASE WHEN line.retail_event_line_scenario_id IN (141, 142) THEN 1 ELSE 0 END) AS return_rows_cnt
				, SUM(CASE WHEN line.retail_event_line_scenario_id IN (180, 182) THEN 1 ELSE 0 END) AS cancel_wo_code_rows_cnt
			FROM
				VT1 VT1
			INNER JOIN
				`${BQ_PROJECT_ID}.CORE_REL.T_PRODUCT_RETAIL_LINE` line
					ON VT1.dwh_cal_dt = line.bus_dt
					AND VT1.country_cd = line.country_org_cd
					AND VT1.loc_sid = line.store_sid
			GROUP BY
				line.retail_event_sid
			HAVING
				return_rows_cnt + cancel_wo_code_rows_cnt = 0
		)
	, deposit_scenarios AS
		(
			SELECT
				ph.cash_register_event_sid
				, ph.cash_register_event_nr
				, ph.event_start_tmsp
				, ph.bus_dt
				, ph.cash_register_sid
				, ph.cash_register_nr
				, ph.store_sid
				, ph.cashier_hash
				, ph.txn_net_val
				, ph.txn_gross_val
				, ph.curr_cd
				, CASE
						WHEN pl.sale_rows_cnt + pl.deposit_sale_rows_cnt = 0
							AND pl.deposit_return_rows_cnt = pl.man_deposit_return_cnt
							AND ABS(ph.txn_gross_val) > s4_dg.param_val_qty THEN 1
						ELSE 0
					END AS deposit_only_manual_input_fg
			FROM
				prequal_headers ph
			INNER JOIN
				prequal_lines pl
					ON ph.cash_register_event_sid = pl.cash_register_event_sid
			INNER JOIN
				mat_params s4_dg		--Scenario 4, parameter "total returned deposit value greater than X LW"
					ON s4_dg.country_org_cd = pl.country_org_cd
					AND s4_dg.scenario_id = 4
					AND s4_dg.param_id = 11
					-- if scenario is not enabled all receipts from that country will be eliminated in the inner join
					and s4_dg.IS_SCENARIO_ENABLED_IN_COUNTRY_FG = TRUE 
		)
SELECT
	cash_register_event_sid  
	, CAST(cash_register_event_nr AS STRING) AS cash_register_event_nr
  
	, event_start_tmsp
	, bus_dt
	, cash_register_sid
	, CAST(cash_register_nr AS STRING) AS cash_register_nr
	, store_sid
	, cashier_hash
	, txn_net_val
	, txn_gross_val
	, curr_cd
	, CAST(deposit_only_manual_input_fg AS BOOL) AS deposit_only_manual_input_fg
FROM	deposit_scenarios
WHERE   deposit_only_manual_input_fg = 1
;

