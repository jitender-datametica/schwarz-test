INSERT INTO
	`${BQ_PROJECT_ID}.${FWRK_WORK_DB}.T_FACT_FRAUD_DETECTION_BY_CASH_REGISTER_EVENT_FINAL` 
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
				`${BQ_PROJECT_ID}.CORE_APP_FRAUD_DETECTION.V_FRAUD_DETECTION_PARAMETER_CURRENT_VALUE`
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
			FROM `${BQ_PROJECT_ID}.CORE_REL.T_TECHNICAL_CASH_REGISTER_EVENT` tcre
			JOIN `${BQ_PROJECT_ID}.CORE_APP_FRAUD_DETECTION.T_CASHIER_ENCRYPTION` ce
				ON ce.CASHIER_HASH = tcre.CASHIER_HASH
			JOIN VT1 vt1  
			-- ${FWRK_WORK_DB}
				ON vt1.country_cd = tcre.country_org_cd
				AND vt1.dwh_cal_dt = tcre.bus_dt
				AND vt1.loc_sid = tcre.store_sid
			WHERE
				tcre.tech_cash_register_event_type_cd NOT IN ('400', '405', '420', '425', '430')
				AND tcre.bus_dt BETWEEN MIN_DWH_CAL_DT AND MAX_DWH_CAL_DT
			UNION ALL
			SELECT
				re.retail_event_sid AS cash_register_event_sid
				, re.cash_register_event_nr
				, re.event_start_tmsp AS event_tmsp
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
			FROM `${BQ_PROJECT_ID}.CORE_REL.T_RETAIL_EVENT` re
			JOIN `${BQ_PROJECT_ID}.CORE_APP_FRAUD_DETECTION.T_CASHIER_ENCRYPTION` ce
				ON ce.CASHIER_HASH = re.CASHIER_HASH
			JOIN VT1 vt1
			-- ${FWRK_WORK_DB}
				ON vt1.country_cd = re.country_org_cd
				AND vt1.dwh_cal_dt = re.bus_dt
				AND vt1.loc_sid = re.store_sid
			WHERE
				re.bus_dt BETWEEN MIN_DWH_CAL_DT AND MAX_DWH_CAL_DT
				AND (re.CASH_REGISTER_TYPE_CD = 'TIL' OR re.CASH_REGISTER_TYPE_CD IS NULL)
		)
	, small_sales_receipt_lines AS
		(
			SELECT
				tprl.retail_event_sid
			FROM
				VT1 
				-- ${FWRK_WORK_DB}
			INNER JOIN
				`${BQ_PROJECT_ID}.CORE_REL.T_PRODUCT_RETAIL_LINE` tprl
					ON VT1.country_cd = tprl.country_org_cd
					AND VT1.dwh_cal_dt = tprl.bus_dt
					AND VT1.loc_sid = tprl.store_sid
			INNER JOIN mat_params s15_kb -- Scenario 15, parameter "Small sale lesser than X LW"
				ON s15_kb.country_org_cd = VT1.country_cd
				AND s15_kb.param_id = 45
				AND s15_kb.IS_SCENARIO_ENABLED_IN_COUNTRY_FG = TRUE
			WHERE
				tprl.turnover_relevant_fg = TRUE
				AND (tprl.CASH_REGISTER_TYPE_CD = 'TIL' OR tprl.CASH_REGISTER_TYPE_CD IS NULL)
				AND tprl.bus_dt BETWEEN MIN_DWH_CAL_DT AND MAX_DWH_CAL_DT
			GROUP BY
				tprl.retail_event_sid
			HAVING
				SUM(CASE WHEN tprl.retail_event_line_scenario_id IN (101, 102, 120, 122, 201, 202, 220, 222) THEN 1 ELSE 0 END) = 1
				AND SUM(CASE WHEN tprl.cancel_line_seq IS NULL AND tprl.retail_line_gross_val < s15_kb.param_val_qty AND tprl.RETAIL_EVENT_LINE_SCENARIO_ID IN (101, 102, 120, 122, 201, 202, 220, 222) THEN 1 ELSE 0 END) = 1
		)
	, retail_events_suspended AS
		(
			SELECT
				tre.retail_event_sid
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
				VT1 
				-- ${FWRK_WORK_DB}
			INNER JOIN `${BQ_PROJECT_ID}.CORE_REL.T_RETAIL_EVENT` tre
				ON VT1.dwh_cal_dt = tre.bus_dt
				AND VT1.country_cd = tre.country_org_cd
				AND VT1.loc_sid = tre.store_sid
			INNER JOIN `${BQ_PROJECT_ID}.CORE_REL.T_CASH_REGISTER` tcr
				ON tre.cash_register_sid = tcr.cash_register_sid
				AND tcr.dwh_valid_fg = TRUE
			INNER JOIN `${BQ_PROJECT_ID}.CORE_REL.T_RETAIL_EVENT` tre_cont
				ON VT1.dwh_cal_dt = tre_cont.bus_dt
				AND tre.retail_event_sid = tre_cont.susp_retail_event_sid
			INNER JOIN mat_params s15_rgt
				ON s15_rgt.country_org_cd = tre.country_org_cd
				AND s15_rgt.scenario_id = 15
				AND s15_rgt.param_id = 46
				AND s15_rgt.IS_SCENARIO_ENABLED_IN_COUNTRY_FG = TRUE
			INNER JOIN `${BQ_PROJECT_ID}.CORE_APP_FRAUD_DETECTION.T_CASHIER_ENCRYPTION` ce
				ON ce.CASHIER_HASH = tre.CASHIER_HASH
			WHERE
				tre.bus_dt BETWEEN MIN_DWH_CAL_DT AND MAX_DWH_CAL_DT
				AND tre.retail_event_type_cd = 'S'
				AND tre.suspend_fg = TRUE
				AND tre.cancel_fg = FALSE
				AND tre.txn_gross_val > s15_rgt.param_val_qty
				AND (tre.CASH_REGISTER_TYPE_CD = 'TIL' OR tre.CASH_REGISTER_TYPE_CD IS NULL)
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
				, MAX(COALESCE(IF(tprl.retail_event_line_scenario_id = 201, tprl.retail_event_line_seq, 0), 0)) AS last_sale_retail_line
			FROM
				retail_events_suspended res
			INNER JOIN `${BQ_PROJECT_ID}.CORE_REL.T_PRODUCT_RETAIL_LINE` tprl
				ON res.bus_dt = tprl.bus_dt
				AND res.country_org_cd = tprl.country_org_cd
				AND res.store_sid = tprl.store_sid
				AND res.retail_event_sid = tprl.retail_event_sid
			LEFT OUTER JOIN `${BQ_PROJECT_ID}.CORE_REL.T_CANCELLATION_LINE` tcl
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
				, MAX(COALESCE(tcl_cont.retail_event_line_seq, 0)) AS max_conT_CANCELLATION_LINE
				, MAX(COALESCE(tprl_cont.retail_event_line_seq, 0)) AS max_cont_retail_line
				, SUM(CASE WHEN COALESCE(tprl_cont.cancel_line_seq, -1) > sracl.max_cancellation_line THEN tprl_cont.retail_line_gross_val ELSE 0 END) AS sum_cont_cancel_line_val
				, SUM(CASE WHEN tprl_cont.retail_event_line_scenario_id in (170, 101) THEN 1 ELSE 0 END) AS cnt_cont_retail_line
				, MAX(COALESCE(IF(tprl_cont.retail_event_line_scenario_id = 101, tprl_cont.retail_event_line_seq, 0), 0)) AS last_cont_sale_retail_line
			FROM
				susp_retail_and_cancel_lines sracl
			INNER JOIN `${BQ_PROJECT_ID}.CORE_REL.T_PRODUCT_RETAIL_LINE` tprl_cont
				ON sracl.bus_dt = tprl_cont.bus_dt
				AND sracl.country_org_cd = tprl_cont.country_org_cd
				AND sracl.store_sid = tprl_cont.store_sid
				AND sracl.cont_retail_event_sid = tprl_cont.retail_event_sid
			LEFT OUTER JOIN `${BQ_PROJECT_ID}.CORE_REL.T_CANCELLATION_LINE` tcl_cont
				ON sracl.bus_dt = tcl_cont.bus_dt
				AND sracl.country_org_cd = tcl_cont.country_org_cd
				AND sracl.store_sid = tcl_cont.store_sid
				AND sracl.cont_retail_event_sid = tcl_cont.retail_event_sid
			GROUP BY
				sracl.retail_event_sid
		)
	, event_and_next_event AS
		(
			SELECT * FROM (
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
					, cracl.max_conT_CANCELLATION_LINE
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
					, ROW_NUMBER() OVER(PARTITION BY cracl.retail_event_sid ORDER BY acre.cash_register_event_nr) as rn
				FROM
					cont_retail_and_cancel_lines cracl
				INNER JOIN all_cash_reg_events acre
					ON cracl.cash_register_sid = acre.cash_register_sid
					AND cracl.bus_dt = acre.bus_dt
					AND cracl.cashier_nr = acre.cashier_nr
					AND cracl.cash_register_event_nr < acre.cash_register_event_nr
			)
			WHERE rn = 1
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
				, IF(eane.cont_cancel_fg, 1, 0) AS suspend_and_abort_fg
				, CASE
						WHEN eane.cont_cancel_fg = FALSE
							AND eane.max_conT_CANCELLATION_LINE > eane.max_cancellation_line
                            AND eane.sum_cont_cancel_line_val > s15_kb.param_val_qty THEN 1
						ELSE 0
					END AS suspend_and_line_cancel_fg
				, CASE
						WHEN eane.cont_cancel_fg = FALSE
						  AND eane.cnt_cont_retail_line > eane.cnt_retail_line
						  AND eane.last_cont_sale_retail_line > eane.last_sale_retail_line
						  AND eane.max_cont_retail_line > eane.max_retail_line THEN 1
						ELSE 0
					END AS suspend_and_extend_fg
			FROM
				event_and_next_event eane
			INNER JOIN mat_params s15_kb
				ON s15_kb.country_org_cd = eane.next_country_org_cd
				AND s15_kb.scenario_id = 15
				AND s15_kb.param_id = 47
				AND s15_kb.IS_SCENARIO_ENABLED_IN_COUNTRY_FG = TRUE
			LEFT OUTER JOIN small_sales_receipt_lines ssrl
				ON eane.next_cash_register_event_sid = ssrl.retail_event_sid
			WHERE
				(eane.next_event_category = 'TECH_EVENT' AND eane.next_event_subcategory = '410')
				OR (eane.next_event_category = 'RETAIL_EVENT' AND eane.next_event_subcategory = 'S' AND ssrl.retail_event_sid IS NOT NULL)
		)
SELECT
    cash_register_event_sid
	, CAST(cash_register_event_nr as STRING) AS cash_register_event_nr
	, event_start_tmsp
	, bus_dt
	, cash_register_sid
	, CAST(cash_register_nr as STRING) AS cash_register_nr
	, store_sid
	, cashier_hash
	, txn_gross_val
	, txn_net_val
	, curr_cd
	, CAST(suspend_and_abort_fg AS BOOL) AS suspend_and_abort_fg
	, CAST(suspend_and_line_cancel_fg AS BOOL) AS suspend_and_line_cancel_fg
	, CAST(suspend_and_extend_fg AS BOOL) AS suspend_and_extend_fg
   FROM  calc_flags
WHERE
    suspend_and_abort_fg > 0
	OR suspend_and_line_cancel_fg > 0
	OR suspend_and_extend_fg > 0
;
