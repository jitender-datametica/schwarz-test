/*
===================================================================================================================================
Division		|	Lidl
Solution		|	Enterprise Logistics
DB schema		|	p_lew_mart_lead
DB view			|	v_edi_desadv_cum_wk_2
Description		|	View with calculated KPIs - MIS Lead / 02 Prozesse / 021103 Ware umschlagen / EDI/DESADV Kennzahlen
===================================================================================================================================
*/

-- The aggregation level for all data is client_id, aspect_id (warehouse type), wh_id, sup_sid, business year and calendar_2 week. 
CREATE OR REPLACE VIEW p_lew_mart_lead.v_edi_desadv_cum_wk_2 (
	CLIENT_ID COMMENT 'Client ID',
	CTRY_GRP_ID COMMENT 'Country_2 group ID',
	ASPECT_ID COMMENT 'Aspect ID (1=Betriebsgesellschaft, 2=Vertriebsgesellschaft)',
	WH_ID COMMENT 'Warehouse ID',
	WH_LOC_SID COMMENT 'Location_2 surrogate ID',
	SUP_SID COMMENT 'Supplier_2 surrogate ID',
	GL_LOC_NR COMMENT 'Supplier_2 global location_2 number',
	SUP_NAME COMMENT 'Supplier_2 name',
	BYR COMMENT 'Current business year of the record',
	CY_WEEK COMMENT 'Current calendar_2 week of the record',
	BYR_PY COMMENT 'Business year in previous calendar_2 year',
	CY_WEEK_PY COMMENT 'Calendar_2 week in previous calendar_2 year',
	BYR_SEQ COMMENT 'Sequence for business year',
	CY_WEEK_SEQ COMMENT 'Sequence for calendar_2 week',
	BASE_DESP_ADV_CNT_WK_SUM COMMENT 'Total number of despatch advices per calendar_2 week',
	BASE_DESP_ADV_CNT_WK_CUM COMMENT 'Running total number of despatch advices within a business year cumulated after every calendar_2 week',
	BASE_DESP_ADV_CNT_WK_SUM_PY COMMENT 'Total number of despatch advices of the calendar_2 week of the previous business year (mapped to the current week)',
	BASE_DESP_ADV_CNT_WK_CUM_PY COMMENT 'Total number of despatch advices cumulated after every calendar_2 week within the previous business year (mapped to the current week)',
	USABLE_DESP_ADV_CNT_WK_SUM COMMENT 'Total number of usable despatch adviecs per calendar_2 week',
	USABLE_DESP_ADV_CNT_WK_CUM COMMENT 'Running total number of usable despatch advices within a business year cumulated after every calendar_2 week',
	USABLE_DESP_ADV_CNT_WK_SUM_PY COMMENT 'Total number of usable despatch advices of the calendar_2 week of the previous business year (mapped to th ecurrent week)',
	USABLE_DESP_ADV_CNT_WK_CUM_PY COMMENT 'Total number of usable despatch advices cumulated after every calendar_2 week within the previous business year (mapped to the current week)',
	BASE_WH_RCVG_ALL_CNT_WK_SUM COMMENT 'Total number of item_2 receipts (All) per calendar_2 week',
	BASE_WH_RCVG_ALL_CNT_WK_CUM COMMENT 'Running total number of item_2 receipts (All) within a business year cumulated after every calendar_2 week',
	BASE_WH_RCVG_ALL_CNT_WK_SUM_PY COMMENT 'Total number of item_2 receipts (All) of the calendar_2 week of the previous business year (mapped to the current week)',
	BASE_WH_RCVG_ALL_CNT_WK_CUM_PY COMMENT 'Total number of item_2 receipts (All) cumulated after every calendar_2 week within the previous business year (mapped to the current week)',
	BASE_WH_RCVG_EDI_CNT_WK_SUM COMMENT 'Total number of item_2 receipts (EDI) per calendar_2 week',
	BASE_WH_RCVG_EDI_CNT_WK_CUM COMMENT 'Running total number of item_2 receipts (EDI) within a business year cumulated after every calendar_2 week',
	BASE_WH_RCVG_EDI_CNT_WK_SUM_PY COMMENT 'Total number of item_2 receipts (EDI) of the calendar_2 week of the previous business year (mapped to the current week)',
	BASE_WH_RCVG_EDI_CNT_WK_CUM_PY COMMENT 'Total number of item_2 receipts (EDI) cumulated after every calendar_2 week within the previous business year (mapped to the current week)',
	BASE_ITEM_RCVG_CNT_WK_SUM COMMENT 'Total number of item_2 receiving countings per calendar_2 week',
	BASE_ITEM_RCVG_CNT_WK_CUM COMMENT 'Running total number of item_2 receiving countings within a business year cumulated after every calendar_2 week',
	BASE_ITEM_RCVG_CNT_WK_SUM_PY COMMENT 'Total number of item_2 receiving countings of the calendar_2 week of the previous business year (mapped to the current week)',
	BASE_ITEM_RCVG_CNT_WK_CUM_PY COMMENT 'Total number of item_2 receiving countings cumulated after every calendar_2 week within the previous business year (mapped to the current week)',
	TGT_RATE_ADV_OVERALL_ALL COMMENT 'DESADV overall target rate for All per country_2 and business year',
	TGT_RATE_ADV_OVERALL_EDI COMMENT 'DESADV overall target rate for EDI per country_2 and business year',
	TGT_RATE_ADV_AVAIL_ALL COMMENT 'DESADV availability target rate for All per country_2 and business year',
	TGT_RATE_ADV_AVAIL_EDI COMMENT 'DESADV availability target rate for EDI per country_2 and business year',
	TGT_RATE_ADV_USAGE COMMENT 'DESADV usage target rate per country_2 and business year'
	)
COMMENT = 'View with cumulated facts - MIS Lead / 02 Prozesse / 021103 Ware umschlagen / EDI/DESADV Kennzahlen'
AS
WITH 
/* 
Identification of relevant countries, warehouses and suppliers which is the first part of the fact index (client_id, aspect_id, wh_id, sup_sid, byr, cy_week)
*/
listing_suppliers AS (
	SELECT DISTINCT client_id -- Attribute filter in dossier
		, ctry_grp_id -- Uniquely clear for each client_id
		, aspect_id -- This is necessary for the index because this attribute is also used in the report data though there is no specific attribute filter to use.  
		, wh_id -- Attribute filter in dossier
		, wh_loc_sid -- Uniquely clear for each wh_id 
		, sup_sid -- Attribute filter in dossier
	FROM p_lew_mart_lead.v_edi_desadv_agg_2
	),
/* 
Identification of relevant calendar_2 weeks and corresponding weeks of previous year which is the second part of the fact index (client_id, aspect_id, wh_id, sup_sid, byr, cy_week)
*/
listing_weeks AS (
	SELECT DISTINCT c.busyear
		, c.cy_week 
		, c.busyear - 1 AS busyear_prev_1y -- previous business year 
		, w.cy_week_prev_1y -- corresponding calendar_2 week in previous calendar_2 year. cy_week to cy_week_prev_1y is 1:1 relation 
		, c.busyear_seq -- sequence for current business year 
		, c.cy_week_seq -- sequence for current week
	FROM p_lew_core_ac.v_cal_calendarday_2 c
		LEFT OUTER JOIN p_lew_core_ac.v_cal_week_2 w
			ON c.cy_week = w.cy_week
	WHERE c.busyear_seq BETWEEN -2 AND 0 -- last two and current business year but the oldest year will be filtered out later because of empty previous year values
		AND c.cy_week_seq <= 0 -- including whole current week that might include despatch advices with upcoming deliveries
	),
/* 
Creation of distinct index (client_id, aspect_id, wh_id, sup_sid, byr, cy_week) combining the supplier_2 and time dimensions 
The index is needed to artificially fill up the fact data for a continuous set of calendar_2 weeks per supplier_2 because there are also weeks where a supplier_2 has no recorded data.
Thereby it is possible to match the week of previous year entirely and determine the cumulated KPI values of previous year thoroughly.
*/
listing_index AS (
	SELECT s.client_id -- mandatory index field
		, s.ctry_grp_id -- not mandatory because unique per client
		, s.aspect_id -- mandatory index field
		, s.wh_id -- mandatory index field
		, s.wh_loc_sid -- not mandatory because unique per wh_id  
		, s.sup_sid -- mandatory index field
		, w.busyear -- mandatory index field
		, w.cy_week -- mandatory index field
		, w.busyear_prev_1y -- not mandatory and only to calculate values of previous year
		, w.cy_week_prev_1y -- not mandatory and only to calculate values of previous year
		, w.busyear_seq -- not mandatory and only to filter on current time periods in FE eventually
		, w.cy_week_seq -- not mandatory and only to filter on current time periods in FE eventually
	FROM listing_suppliers s
		CROSS JOIN listing_weeks w
	),
/*
Preselection of relevant plan data with target rates for early limitation 
*/
limitation_target_rates AS 
	(SELECT client_id -- International = client_id 7 
		, bus_year
		, advice_target_rate 			AS tgt_rate_adv_overall_all -- 'Target rate of despatch advices which have been used in the receivings process among all receivings (all suppliers)' 
		, advice_edi_target_rate 		AS tgt_rate_adv_overall_edi -- 'Target rate of despatch advices which have been used in the receivings process among all receivings (EDI suppliers only)' 
		, advice_avail_target_rate 		AS tgt_rate_adv_avail_all 	-- 'Target rate of sent despatch advices among all receivings (all suppliers)' 
		, advice_avail_edi_target_rate 	AS tgt_rate_adv_avail_edi 	-- 'Target rate of sent despatch advices among all receivings (EDI suppliers only)' 
		, advice_usage_target_rate 		AS tgt_rate_adv_usage 		-- 'Target rate of despatch advices which have been used in the receivings process among all sent despatch advices from EDI suppliers only' 
		, dwh_valid_from
		, dwh_valid_to
		--, dwh_created
		--, dwh_updated
	FROM p_lew_core_ac.v_despatch_advice_usage_plan_hist_2
	WHERE CURRENT_DATE BETWEEN dwh_valid_from AND dwh_valid_to 
	),
/*
Adding further supplier_2 information for easier search and analysis of the data. 
This data is not mandatory for the report but serves as support for quicker data analysis later. 
*/
listing_supplier_information AS
	(SELECT client_id
		, supplier_id -- PK
		, global_location_nr 
		, supplier_name 
		, orig_supplier_nr 
		, supplier_id_int
	FROM p_lew_mart_msi_ac.v_sup_supplier_2
	WHERE supplier_id >= 0 -- excluding country_2 entries
	),
/*
Totals of facts per calendar_2 week. All cumulations of KPIs are per index group (client_id, aspect_id, wh_id, sup_sid, busyear, cy_week). 
*/
fact_aggregation_week AS (
	SELECT client_id
		, aspect_id
		, wh_id
		, sup_sid
		, byr
		, cy_week
		-- 1. Weekly totals and running totals of despatch advices (Angekommene Lieferavise)
		, SUM(desp_adv_cnt) AS desp_adv_cnt_wk_sum -- week total (Angekommene Lieferavise - Ist) 
		, SUM(desp_adv_cnt_wk_sum) OVER (PARTITION BY client_id, wh_id, sup_sid, byr ORDER BY cy_week ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS desp_adv_cnt_wk_cum -- running totals cumulated after every week (Angekommene Lieferavise - Ist aufgel.) 
		-- Weekly totals and running totals of usable despatch advices (Verwendbare Lieferavise)
		,SUM(usable_desp_adv_cnt) AS usable_desp_adv_cnt_wk_sum -- week total (Verwendbare Lieferavise - Ist)
		,SUM(usable_desp_adv_cnt_wk_sum) OVER (PARTITION BY client_id, wh_id, sup_sid, byr ORDER BY cy_week ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS usable_desp_adv_cnt_wk_cum 
		-- 2. Weekly totals and running totals of booked item_2 receipts at a warehouse (Gebuchte Wareneingaenge Gesamt)  
		, SUM(wh_rcvg_all_cnt) AS wh_rcvg_all_cnt_wk_sum -- week total (Gebuchte Wareneingaenge Gesamt - Ist) 
		, SUM(wh_rcvg_all_cnt_wk_sum) OVER (PARTITION BY client_id, wh_id, sup_sid, byr ORDER BY cy_week ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS wh_rcvg_all_cnt_wk_cum -- running totals cumulated after every week (Gebuchte Wareneingaenge Gesamt - Ist aufgel.) 
		-- 3. Weekly totals and running totals of booked item_2 receipts at a warehouse limited to EDI (Gebuchte Wareneingaenge EDI Lieferanten) 
		, SUM(wh_rcvg_edi_cnt) AS wh_rcvg_edi_cnt_wk_sum -- week total (Gebuchte Wareneingaenge EDI Lieferanten - Ist) 
		, SUM(wh_rcvg_edi_cnt_wk_sum) OVER (PARTITION BY client_id, wh_id, sup_sid, byr ORDER BY cy_week ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS wh_rcvg_edi_cnt_wk_cum -- running totals cumulated after every week (Gebuchte Wareneingaenge EDI Lieferanten - Ist aufgel.) 
		-- 4. Weekly totals and running totals of item_2 receiving countings with a referenced used despatch advice (Verwendete Lieferavise) 
		, SUM(item_rcvg_cnt) AS item_rcvg_cnt_wk_sum -- week total (Verwendete Lieferavise - Ist)
		, SUM(item_rcvg_cnt_wk_sum) OVER (PARTITION BY client_id, wh_id, sup_sid, byr ORDER BY cy_week ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS item_rcvg_cnt_wk_cum -- running totals cumulated after every week (Verwendete Lieferavise - Ist aufgel.) 
	FROM p_lew_mart_lead.v_edi_desadv_agg_2 a
	GROUP BY client_id
		, aspect_id
		, wh_id
		, sup_sid
		, byr
		, cy_week
	),
/* 
Mapping of facts to index list and also facts from previous year for each calendar_2 week with yearly cumulation (cum) 
*/
mapping_index_fact_previousyear AS ( 
	SELECT i.client_id 
		, i.ctry_grp_id
		, i.aspect_id
		, i.wh_id 
		, i.wh_loc_sid
		, i.sup_sid
		, i.busyear
		, i.cy_week
		, i.busyear_prev_1y
		, i.cy_week_prev_1y
		, i.busyear_seq
		, i.cy_week_seq
		-- 1. Mapping fact of previous year for despatch advices (Angekommene Lieferavise)
		, f.desp_adv_cnt_wk_sum
		, COALESCE(f.desp_adv_cnt_wk_cum
			, LAG(f.desp_adv_cnt_wk_cum) IGNORE NULLS OVER (PARTITION BY i.client_id, i.wh_id, i.sup_sid, i.busyear ORDER BY i.cy_week)
			) AS desp_adv_cnt_wk_cum
		, fp.desp_adv_cnt_wk_sum AS desp_adv_cnt_wk_sum_py -- Angekommene Lieferavise - VJ 
		, COALESCE(fp.desp_adv_cnt_wk_cum
			, LAG(fp.desp_adv_cnt_wk_cum) IGNORE NULLS OVER (PARTITION BY i.client_id, i.wh_id, i.sup_sid, i.busyear ORDER BY i.cy_week)
			) AS desp_adv_cnt_wk_cum_py -- Angekommene Lieferavise - VJ aufgel. 
		, f.usable_desp_adv_cnt_wk_sum
		, COALESCE(f.usable_desp_adv_cnt_wk_cum
			, LAG(f.usable_desp_adv_cnt_wk_cum) IGNORE NULLS OVER (PARTITION BY i.client_id, i.wh_id, i.sup_sid, i.busyear ORDER BY i.cy_week)
			) AS usable_desp_adv_cnt_wk_cum
		, fp.usable_desp_adv_cnt_wk_sum AS usable_desp_adv_cnt_wk_sum_py -- Verwendbare Lieferavise - VJ
		, COALESCE(fp.usable_desp_adv_cnt_wk_cum
			, LAG(fp.usable_desp_adv_cnt_wk_cum) IGNORE NULLS OVER (PARTITION BY i.client_id, i.wh_id, i.sup_sid, i.busyear ORDER BY i.cy_week)
			) AS usable_desp_adv_cnt_wk_cum_py -- Verwendbare Lieferavise - VJ aufgel.
		-- 2. Mapping fact of previous year for booked item_2 receipts at a warehouse (Gebuchte Wareneingaenge Gesamt)  
		, f.wh_rcvg_all_cnt_wk_sum
		, COALESCE(f.wh_rcvg_all_cnt_wk_cum
			, LAG(f.wh_rcvg_all_cnt_wk_cum) IGNORE NULLS OVER (PARTITION BY i.client_id, i.wh_id, i.sup_sid, i.busyear ORDER BY i.cy_week)
			) AS wh_rcvg_all_cnt_wk_cum
		, fp.wh_rcvg_all_cnt_wk_sum AS wh_rcvg_all_cnt_wk_sum_py -- Gebuchte Wareneingaenge Gesamt - VJ 
		, COALESCE(fp.wh_rcvg_all_cnt_wk_cum
			, LAG(fp.wh_rcvg_all_cnt_wk_cum) IGNORE NULLS OVER (PARTITION BY i.client_id, i.wh_id, i.sup_sid, i.busyear ORDER BY i.cy_week)
			) AS wh_rcvg_all_cnt_wk_cum_py -- Gebuchte Wareneingaenge Gesamt - VJ aufgel. 
		-- 3. Mapping fact of previous year for booked item_2 receipts at a warehouse limited to EDI (Gebuchte Wareneingaenge EDI Lieferanten) 
		, f.wh_rcvg_edi_cnt_wk_sum
		, COALESCE(f.wh_rcvg_edi_cnt_wk_cum
			, LAG(f.wh_rcvg_edi_cnt_wk_cum) IGNORE NULLS OVER (PARTITION BY i.client_id, i.wh_id, i.sup_sid, i.busyear ORDER BY i.cy_week)
			) AS wh_rcvg_edi_cnt_wk_cum
		, fp.wh_rcvg_edi_cnt_wk_sum AS wh_rcvg_edi_cnt_wk_sum_py -- Gebuchte Wareneingaenge EDI Lieferanten - VJ 
		, COALESCE(fp.wh_rcvg_edi_cnt_wk_cum
			, LAG(fp.wh_rcvg_edi_cnt_wk_cum) IGNORE NULLS OVER (PARTITION BY i.client_id, i.wh_id, i.sup_sid, i.busyear ORDER BY i.cy_week)
			) AS wh_rcvg_edi_cnt_wk_cum_py -- Gebuchte Wareneingaenge EDI Lieferanten - VJ aufgel. 
		-- 4. Mapping fact of previous year for item_2 receiving countings with a referenced used despatch advice (Verwendete Lieferavise) 
		, f.item_rcvg_cnt_wk_sum
		, COALESCE(f.item_rcvg_cnt_wk_cum
			, LAG(f.item_rcvg_cnt_wk_cum) IGNORE NULLS OVER (PARTITION BY i.client_id, i.wh_id, i.sup_sid, i.busyear ORDER BY i.cy_week)
			) AS item_rcvg_cnt_wk_cum
		, fp.item_rcvg_cnt_wk_sum AS item_rcvg_cnt_wk_sum_py -- Verwendete Lieferavise - VJ 
		, COALESCE(fp.item_rcvg_cnt_wk_cum
			, LAG(fp.item_rcvg_cnt_wk_cum) IGNORE NULLS OVER (PARTITION BY i.client_id, i.wh_id, i.sup_sid, i.busyear ORDER BY i.cy_week)
			) AS item_rcvg_cnt_wk_cum_py -- Verwendete Lieferavise - VJ aufgel. 
	FROM listing_index i
		LEFT OUTER JOIN fact_aggregation_week f
			ON i.client_id = f.client_id 
				AND i.aspect_id = f.aspect_id 
				AND i.wh_id = f.wh_id 
				AND i.sup_sid = f.sup_sid
				AND i.busyear = f.byr 
				AND i.cy_week = f.cy_week
		LEFT OUTER JOIN fact_aggregation_week fp
			ON i.client_id = fp.client_id 
				AND i.aspect_id = fp.aspect_id 
				AND i.wh_id = fp.wh_id
				AND i.sup_sid = fp.sup_sid
				AND i.busyear_prev_1y = fp.byr -- To avoid doubled matches because of week 9 as first week of a business year (partial week in Feb and partial week in Mar separately) 
				AND i.cy_week_prev_1y = fp.cy_week
	QUALIFY i.busyear > MIN(i.busyear) OVER (PARTITION BY 1) -- filter out the data of that oldest year where values for previous year are empty
	),
/* 
Comparison of facts between current year and previous year for absolute und relative differences. 
However, these KPI differences are not needed for the report.
*/
/*
kpi_differences AS (
	SELECT 
		client_id
		, wh_id
		, sup_sid
		, busyear
		, cy_week
		, busyear_prev_1y
		, cy_week_prev_1y
		, ctry_grp_id
		, aspect_id
		, wh_loc_sid
		, byr_seq
		, cy_week_seq
		-- 1. Differences for despatch advices (Angekommene Lieferavise)
		, desp_adv_cnt_wk_sum
		, desp_adv_cnt_wk_cum
		, desp_adv_cnt_wk_sum_py 
		, desp_adv_cnt_wk_cum_py 
		, ZEROIFNULL(desp_adv_cnt_wk_sum) - ZEROIFNULL(desp_adv_cnt_wk_sum_py) 	AS desp_adv_cnt_wk_sum_diff_abs -- Delta VJ absolut 
		, DIV0NULL(desp_adv_cnt_wk_sum_diff_abs, desp_adv_cnt_wk_sum_py) 		AS desp_adv_cnt_wk_sum_diff_rel -- Delta VJ relativ 
		, ZEROIFNULL(desp_adv_cnt_wk_cum) - ZEROIFNULL(desp_adv_cnt_wk_cum_py)	AS desp_adv_cnt_wk_cum_diff_abs -- Delta VJ aufgelaufen absolut
		, DIV0NULL(desp_adv_cnt_wk_cum_diff_abs, desp_adv_cnt_wk_cum_py)		AS desp_adv_cnt_wk_cum_diff_rel -- Delta VJ aufgelaufen relativ  
		-- 2. Differences for booked item_2 receipts at a warehouse (Gebuchte Wareneingaenge Gesamt)  
		, wh_rcvg_all_cnt_wk_sum
		, wh_rcvg_all_cnt_wk_cum
		, wh_rcvg_all_cnt_wk_sum_py 
		, wh_rcvg_all_cnt_wk_cum_py 
		, ZEROIFNULL(wh_rcvg_all_cnt_wk_sum) - ZEROIFNULL(wh_rcvg_all_cnt_wk_sum_py)	AS wh_rcvg_all_cnt_wk_sum_diff_abs -- Delta VJ absolut 
		, DIV0NULL(wh_rcvg_all_cnt_wk_sum_diff_abs, wh_rcvg_all_cnt_wk_sum_py)			AS wh_rcvg_all_cnt_wk_sum_diff_rel -- Delta VJ relativ 
		, ZEROIFNULL(wh_rcvg_all_cnt_wk_cum) - ZEROIFNULL(wh_rcvg_all_cnt_wk_cum_py)	AS wh_rcvg_all_cnt_wk_cum_diff_abs -- Delta VJ aufgelaufen absolut
		, DIV0NULL(wh_rcvg_all_cnt_wk_cum_diff_abs, wh_rcvg_all_cnt_wk_cum_py)			AS wh_rcvg_all_cnt_wk_cum_diff_rel -- Delta VJ aufgelaufen relativ  
		-- 3. Differences for booked item_2 receipts at a warehouse limited to EDI (Gebuchte Wareneingaenge EDI Lieferanten) 
		, wh_rcvg_edi_cnt_wk_sum
		, wh_rcvg_edi_cnt_wk_cum
		, wh_rcvg_edi_cnt_wk_sum_py 
		, wh_rcvg_edi_cnt_wk_cum_py 
		, ZEROIFNULL(wh_rcvg_edi_cnt_wk_sum) - ZEROIFNULL(wh_rcvg_edi_cnt_wk_sum_py)	AS wh_rcvg_edi_cnt_wk_sum_diff_abs -- Delta VJ absolut 
		, DIV0NULL(wh_rcvg_edi_cnt_wk_sum_diff_abs, wh_rcvg_edi_cnt_wk_sum_py)			AS wh_rcvg_edi_cnt_wk_sum_diff_rel -- Delta VJ relativ 
		, ZEROIFNULL(wh_rcvg_edi_cnt_wk_cum) - ZEROIFNULL(wh_rcvg_edi_cnt_wk_cum_py)	AS wh_rcvg_edi_cnt_wk_cum_diff_abs -- Delta VJ aufgelaufen absolut
		, DIV0NULL(wh_rcvg_edi_cnt_wk_cum_diff_abs, wh_rcvg_edi_cnt_wk_cum_py)			AS wh_rcvg_edi_cnt_wk_cum_diff_rel -- Delta VJ aufgelaufen relativ  
		-- 4. Differences for item_2 receiving countings with a referenced used despatch advice (Verwendete Lieferavise) 
		, item_rcvg_cnt_wk_sum
		, item_rcvg_cnt_wk_cum
		, item_rcvg_cnt_wk_sum_py 
		, item_rcvg_cnt_wk_cum_py 
		, ZEROIFNULL(item_rcvg_cnt_wk_sum) - ZEROIFNULL(item_rcvg_cnt_wk_sum_py) 	AS item_rcvg_cnt_wk_sum_diff_abs -- Delta VJ absolut 
		, DIV0NULL(item_rcvg_cnt_wk_sum_diff_abs, item_rcvg_cnt_wk_sum_py)			AS item_rcvg_cnt_wk_sum_diff_rel -- Delta VJ relativ 
		, ZEROIFNULL(item_rcvg_cnt_wk_cum) - ZEROIFNULL(item_rcvg_cnt_wk_cum_py)	AS item_rcvg_cnt_wk_cum_diff_abs -- Delta VJ aufgelaufen absolut
		, DIV0NULL(item_rcvg_cnt_wk_cum_diff_abs, item_rcvg_cnt_wk_cum_py)			AS item_rcvg_cnt_wk_cum_diff_rel -- Delta VJ aufgelaufen relativ  
	FROM mapping_index_fact_previousyear 
	),
*/
/* 
Addition of target rates and further supplier_2 information to the KPIs 
*/
kpi_targets AS (
	SELECT 
		f.client_id  
		, f.ctry_grp_id
		, f.aspect_id
		, f.wh_id 
		, f.wh_loc_sid
		, f.sup_sid
		, s.global_location_nr
		, s.supplier_name 
		, f.busyear
		, f.cy_week
		, f.busyear_prev_1y
		, f.cy_week_prev_1y
		, f.busyear_seq
		, f.cy_week_seq
		-- 1. despatch advices (Angekommene Lieferavise)
		, f.desp_adv_cnt_wk_sum 			-- Angekommene Lieferavise - Ist 
		, f.desp_adv_cnt_wk_cum 			-- Angekommene Lieferavise - Ist aufgel. 
		, f.desp_adv_cnt_wk_sum_py 			-- Angekommene Lieferavise - VJ
		, f.desp_adv_cnt_wk_cum_py 			-- Angekommene Lieferavise - VJ aufgel.
		/*, desp_adv_cnt_wk_sum_diff_abs 	-- Angekommene Lieferavise - Delta VJ
		, desp_adv_cnt_wk_sum_diff_rel 		-- Angekommene Lieferavise - Delta VJ %
		, desp_adv_cnt_wk_cum_diff_abs 		-- Angekommene Lieferavise - Delta VJ aufgel.
		, desp_adv_cnt_wk_cum_diff_rel		-- Angekommene Lieferavise - Delta VJ % aufgel. */
		-- usable despatch advices (Verwendbare Lieferavise)
		, f.usable_desp_adv_cnt_wk_sum      -- Verwendbare Lieferavise -- Ist
		, f.usable_desp_adv_cnt_wk_cum      -- Verwendbare Lieferavise -- Ist aufgel.
		, f.usable_desp_adv_cnt_wk_sum_py   -- Verwendbare Lieferavise -- VJ
		, f.usable_desp_adv_cnt_wk_cum_py   -- Verwendbare Lieferavise -- VJ aufgel.
		-- 2. booked item_2 receipts at a warehouse (Gebuchte Wareneingaenge Gesamt)  
		, f.wh_rcvg_all_cnt_wk_sum 			-- Gebuchte Wareneingaenge Gesamt - Ist
		, f.wh_rcvg_all_cnt_wk_cum 			-- Gebuchte Wareneingaenge Gesamt - Ist aufgel.
		, f.wh_rcvg_all_cnt_wk_sum_py 		-- Gebuchte Wareneingaenge Gesamt - VJ
		, f.wh_rcvg_all_cnt_wk_cum_py		-- Gebuchte Wareneingaenge Gesamt - VJ aufgel.
		/*, wh_rcvg_all_cnt_wk_sum_diff_abs	-- Gebuchte Wareneingaenge Gesamt - Delta VJ
		, wh_rcvg_all_cnt_wk_sum_diff_rel 	-- Gebuchte Wareneingaenge Gesamt - Delta VJ %
		, wh_rcvg_all_cnt_wk_cum_diff_abs 	-- Gebuchte Wareneingaenge Gesamt - Delta VJ aufgel.
		, wh_rcvg_all_cnt_wk_cum_diff_rel 	-- Gebuchte Wareneingaenge Gesamt - Delta VJ % aufgel. */
		-- 3. booked item_2 receipts at a warehouse limited to EDI (Gebuchte Wareneingaenge EDI Lieferanten) 
		, f.wh_rcvg_edi_cnt_wk_sum 			-- Gebuchte Wareneingaenge EDI Lieferanten - Ist
		, f.wh_rcvg_edi_cnt_wk_cum 			-- Gebuchte Wareneingaenge EDI Lieferanten - Ist aufgel.
		, f.wh_rcvg_edi_cnt_wk_sum_py 		-- Gebuchte Wareneingaenge EDI Lieferanten - VJ
		, f.wh_rcvg_edi_cnt_wk_cum_py 		-- Gebuchte Wareneingaenge EDI Lieferanten - VJ aufgel.
		/*, wh_rcvg_edi_cnt_wk_sum_diff_abs -- Gebuchte Wareneingaenge EDI Lieferanten - Delta VJ
		, wh_rcvg_edi_cnt_wk_sum_diff_rel 	-- Gebuchte Wareneingaenge EDI Lieferanten - Delta VJ %
		, wh_rcvg_edi_cnt_wk_cum_diff_abs 	-- Gebuchte Wareneingaenge EDI Lieferanten - Delta VJ aufgel.
		, wh_rcvg_edi_cnt_wk_cum_diff_rel 	-- Gebuchte Wareneingaenge EDI Lieferanten - Delta VJ % aufgel. */
		-- 4. item_2 receiving countings with a referenced used despatch advice (Verwendete Lieferavise) 
		, f.item_rcvg_cnt_wk_sum 			-- Verwendete Lieferavise - Ist
		, f.item_rcvg_cnt_wk_cum 			-- Verwendete Lieferavise - Ist aufgel.
		, f.item_rcvg_cnt_wk_sum_py 		-- Verwendete Lieferavise - VJ
		, f.item_rcvg_cnt_wk_cum_py 		-- Verwendete Lieferavise - VJ aufgel.
		/*, item_rcvg_cnt_wk_sum_diff_abs 	-- Verwendete Lieferavise - Delta VJ
		, item_rcvg_cnt_wk_sum_diff_rel 	-- Verwendete Lieferavise - Delta VJ %
		, item_rcvg_cnt_wk_cum_diff_abs 	-- Verwendete Lieferavise - Delta VJ aufgel.
		, item_rcvg_cnt_wk_cum_diff_rel 	-- Verwendete Lieferavise - Delta VJ % aufgel.*/
		-- Target rates for each country_2 
		, t.tgt_rate_adv_overall_all 	-- DESADV target rate for All per country_2 and business year 
		, t.tgt_rate_adv_overall_edi 	-- DESADV target rate for EDI per country_2 and business year  
		, t.tgt_rate_adv_avail_all 		-- Availability target rate for All per country_2 and business year  
		, t.tgt_rate_adv_avail_edi 		-- Availability target rate for EDI per country_2 and business year   
		, t.tgt_rate_adv_usage 			-- Usage target rate per country_2 and business year
		/*
		-- A. Rates for DESADV All / DESADV Quote Gesamt based on base kpis from 4. and 2. 
		, DIV0NULL(item_rcvg_cnt_wk_sum, wh_rcvg_all_cnt_wk_sum)			AS rate_desadv_overall_all_act 			-- DESADV Quote Gesamt Ist = Verwendete Lieferavise Ist / Gebuchte Wareneingaenge Gesamt Ist
		, DIV0NULL(item_rcvg_cnt_wk_cum, wh_rcvg_all_cnt_wk_cum)			AS rate_desadv_overall_all_act_cum 		-- DESADV Quote Gesamt Ist aufgel. = Verwendete Lieferavise Ist aufgel. / Gebuchte Wareneingaenge Gesamt Ist aufgel.
		, DIV0NULL(item_rcvg_cnt_wk_sum_py, wh_rcvg_all_cnt_wk_sum_py)		AS rate_desadv_overall_all_py			-- DESADV Quote Gesamt VJ = Verwendete Lieferavise VJ / Gebuchte Wareneingaenge Gesamt VJ 
		, DIV0NULL(item_rcvg_cnt_wk_cum_py, wh_rcvg_all_cnt_wk_cum_py)		AS rate_desadv_overall_all_py_cum		-- DESADV Quote Gesamt VJ aufgel. = Verwendete Lieferavise VJ aufgel. / Gebuchte Wareneingaenge Gesamt VJ aufgel. 
		, rate_desadv_overall_all_act - rate_desadv_overall_all_py	 		AS rate_desadv_overall_all_diff_py 		-- DESADV Quote Gesamt Delta VJ = DESADV Quote Gesamt Ist - DESADV Quote Gesamt VJ 
		, rate_desadv_overall_all_act_cum - rate_desadv_overall_all_py_cum	AS rate_desadv_overall_all_diff_py_cum	-- DESADV Quote Gesamt Delta VJ aufgel. = DESADV Quote Gesamt Ist aufgel. - DESADV Quote Gesamt VJ aufgel.  
		, rate_desadv_overall_all_act - tgt_rate_adv_overall_all 			AS rate_desadv_overall_all_diff_tgt 	-- DESADV Quote Gesamt Delta Ziel = DESADV Quote Gesamt Ist - DESADV Quote Gesamt Ziel 
		, rate_desadv_overall_all_act_cum - tgt_rate_adv_overall_all 		AS rate_desadv_overall_all_diff_tgt_cum -- DESADV Quote Gesamt Delta Ziel aufgel. = DESADV Quote Gesamt Ist aufgel. - DESADV Quote Gesamt Ziel 
		-- B. Rates for DESADV EDI suppliers / DESADV Quote EDI Lieferanten based on base kpis from 4. and 3. 
		, DIV0NULL(item_rcvg_cnt_wk_sum, wh_rcvg_edi_cnt_wk_sum)			AS rate_desadv_overall_edi_act 			-- DESADV Quote EDI Lieferanten Ist = Verwendete Lieferavise Ist / Gebuchte Wareneingaenge EDI Lieferanten Ist
		, DIV0NULL(item_rcvg_cnt_wk_cum, wh_rcvg_edi_cnt_wk_cum)			AS rate_desadv_overall_edi_act_cum 		-- DESADV Quote EDI Lieferanten Ist aufgel. = Verwendete Lieferavise Ist aufgel. / Gebuchte Wareneingaenge EDI Lieferanten Ist aufgel.
		, DIV0NULL(item_rcvg_cnt_wk_sum_py, wh_rcvg_edi_cnt_wk_sum_py)		AS rate_desadv_overall_edi_py			-- DESADV Quote EDI Lieferanten VJ = Verwendete Lieferavise VJ / Gebuchte Wareneingaenge EDI Lieferanten VJ 
		, DIV0NULL(item_rcvg_cnt_wk_cum_py, wh_rcvg_edi_cnt_wk_cum_py)		AS rate_desadv_overall_edi_py_cum		-- DESADV Quote EDI Lieferanten VJ aufgel. = Verwendete Lieferavise VJ aufgel. / Gebuchte Wareneingaenge EDI Lieferanten VJ aufgel. 
		, rate_desadv_overall_edi_act - rate_desadv_overall_edi_py	 		AS rate_desadv_overall_edi_diff_py 		-- DESADV Quote EDI Lieferanten Delta VJ = DESADV Quote EDI Lieferanten Ist - DESADV Quote EDI Lieferanten VJ 
		, rate_desadv_overall_edi_act_cum - rate_desadv_overall_edi_py_cum	AS rate_desadv_overall_edi_diff_py_cum	-- DESADV Quote EDI Lieferanten Delta VJ aufgel. = DESADV Quote EDI Lieferanten Ist aufgel. - DESADV Quote EDI Lieferanten VJ aufgel.  
		, rate_desadv_overall_edi_act - tgt_rate_adv_overall_edi 			AS rate_desadv_overall_edi_diff_tgt 	-- DESADV Quote EDI Lieferanten Delta Ziel = DESADV Quote EDI Lieferanten Ist - DESADV Quote EDI Lieferanten Ziel 
		, rate_desadv_overall_edi_act_cum - tgt_rate_adv_overall_edi 		AS rate_desadv_overall_edi_diff_tgt_cum -- DESADV Quote EDI Lieferanten Delta Ziel aufgel. = DESADV Quote EDI Lieferanten Ist aufgel. - DESADV Quote EDI Lieferanten Ziel 
		-- C. Rates for DESADV availability All / DESADV Verfuegbarkeit Gesamt based on base kpis from 1. and 2.
		, DIV0NULL(desp_adv_cnt_wk_sum, wh_rcvg_all_cnt_wk_sum)			AS rate_desadv_avail_all_act 			-- DESADV Verfuegbarkeit Gesamt Ist = Angekommene Lieferavise Ist / Gebuchte Wareneingaenge Gesamt Ist
		, DIV0NULL(desp_adv_cnt_wk_cum, wh_rcvg_all_cnt_wk_cum)			AS rate_desadv_avail_all_act_cum 		-- DESADV Verfuegbarkeit Gesamt Ist aufgel. = Angekommene Lieferavise Ist aufgel. / Gebuchte Wareneingaenge Gesamt Ist aufgel.
		, DIV0NULL(desp_adv_cnt_wk_sum_py, wh_rcvg_all_cnt_wk_sum_py)	AS rate_desadv_avail_all_py				-- DESADV Verfuegbarkeit Gesamt VJ = Angekommene Lieferavise VJ / Gebuchte Wareneingaenge Gesamt VJ 
		, DIV0NULL(desp_adv_cnt_wk_cum_py, wh_rcvg_all_cnt_wk_cum_py)	AS rate_desadv_avail_all_py_cum			-- DESADV Verfuegbarkeit Gesamt VJ aufgel. = Angekommene Lieferavise VJ aufgel. / Gebuchte Wareneingaenge Gesamt VJ aufgel. 
		, rate_desadv_avail_all_act - rate_desadv_avail_all_py	 		AS rate_desadv_avail_all_diff_py 		-- DESADV Verfuegbarkeit Gesamt Delta VJ = DESADV Verfuegbarkeit Gesamt Ist - DESADV Verfuegbarkeit Gesamt VJ 
		, rate_desadv_avail_all_act_cum - rate_desadv_avail_all_py_cum	AS rate_desadv_avail_all_diff_py_cum	-- DESADV Verfuegbarkeit Gesamt Delta VJ aufgel. = DESADV Verfuegbarkeit Gesamt Ist aufgel. - DESADV Verfuegbarkeit Gesamt VJ aufgel.  
		, rate_desadv_avail_all_act - tgt_rate_adv_avail_all			AS rate_desadv_avail_all_diff_tgt 		-- DESADV Verfuegbarkeit Gesamt Delta Ziel = DESADV Verfuegbarkeit Gesamt Ist - DESADV Verfuegbarkeit Gesamt Ziel 
		, rate_desadv_avail_all_act_cum - tgt_rate_adv_avail_all		AS rate_desadv_avail_all_diff_tgt_cum	-- DESADV Verfuegbarkeit Gesamt Delta Ziel aufgel. = DESADV Verfuegbarkeit Gesamt Ist aufgel. - DESADV Verfuegbarkeit Gesamt Ziel 
		-- D. Rates for DESADV availability EDI suppliers / DESADV Verfuegbarkeit EDI Lieferanten based on base kpis from 1. and 3.
		, DIV0NULL(desp_adv_cnt_wk_sum, wh_rcvg_edi_cnt_wk_sum)			AS rate_desadv_avail_edi_act 			-- DESADV Verfuegbarkeit EDI Lieferanten Ist = Angekommene Lieferavise Ist / Gebuchte Wareneingaenge EDI Lieferanten Ist
		, DIV0NULL(desp_adv_cnt_wk_cum, wh_rcvg_edi_cnt_wk_cum)			AS rate_desadv_avail_edi_act_cum 		-- DESADV Verfuegbarkeit EDI Lieferanten Ist aufgel. = Angekommene Lieferavise Ist aufgel. / Gebuchte Wareneingaenge EDI Lieferanten Ist aufgel.
		, DIV0NULL(desp_adv_cnt_wk_sum_py, wh_rcvg_edi_cnt_wk_sum_py)	AS rate_desadv_avail_edi_py				-- DESADV Verfuegbarkeit EDI Lieferanten VJ = Angekommene Lieferavise VJ / Gebuchte Wareneingaenge EDI Lieferanten VJ 
		, DIV0NULL(desp_adv_cnt_wk_cum_py, wh_rcvg_edi_cnt_wk_cum_py)	AS rate_desadv_avail_edi_py_cum			-- DESADV Verfuegbarkeit EDI Lieferanten VJ aufgel. = Angekommene Lieferavise VJ aufgel. / Gebuchte Wareneingaenge EDI Lieferanten VJ aufgel. 
		, rate_desadv_avail_edi_act - rate_desadv_avail_edi_py	 		AS rate_desadv_avail_edi_diff_py 		-- DESADV Verfuegbarkeit EDI Lieferanten Delta VJ = DESADV Verfuegbarkeit EDI Lieferanten Ist - DESADV Verfuegbarkeit EDI Lieferanten VJ 
		, rate_desadv_avail_edi_act_cum - rate_desadv_avail_edi_py_cum	AS rate_desadv_avail_edi_diff_py_cum	-- DESADV Verfuegbarkeit EDI Lieferanten Delta VJ aufgel. = DESADV Verfuegbarkeit EDI Lieferanten Ist aufgel. - DESADV Verfuegbarkeit EDI Lieferanten VJ aufgel.  
		, rate_desadv_avail_edi_act - tgt_rate_adv_avail_edi			AS rate_desadv_avail_edi_diff_tgt 		-- DESADV Verfuegbarkeit EDI Lieferanten Delta Ziel = DESADV Verfuegbarkeit EDI Lieferanten Ist - DESADV Verfuegbarkeit EDI Lieferanten Ziel 
		, rate_desadv_avail_edi_act_cum - tgt_rate_adv_avail_edi		AS rate_desadv_avail_edi_diff_tgt_cum	-- DESADV Verfuegbarkeit EDI Lieferanten Delta Ziel aufgel. = DESADV Verfuegbarkeit EDI Lieferanten Ist aufgel. - DESADV Verfuegbarkeit EDI Lieferanten Ziel 
		-- E. Rates for DESADV usage / DESADV Nutzung based on base kpis from 4. and 1.
		, DIV0NULL(item_rcvg_cnt_wk_sum, desp_adv_cnt_wk_sum)			AS rate_desadv_usage_act 			-- DESADV Nutzung Ist = Verwendete Lieferavise Ist / Angekommene Lieferavise Ist
		, DIV0NULL(item_rcvg_cnt_wk_cum, desp_adv_cnt_wk_cum)			AS rate_desadv_usage_act_cum 		-- DESADV Nutzung Ist aufgel. = Verwendete Lieferavise Ist aufgel. / Angekommene Lieferavise Ist aufgel.
		, DIV0NULL(item_rcvg_cnt_wk_sum_py, desp_adv_cnt_wk_sum_py)		AS rate_desadv_usage_py				-- DESADV Nutzung VJ = Verwendete Lieferavise VJ / Angekommene Lieferavise VJ 
		, DIV0NULL(item_rcvg_cnt_wk_cum_py, desp_adv_cnt_wk_cum_py)		AS rate_desadv_usage_py_cum			-- DESADV Nutzung VJ aufgel. = Verwendete Lieferavise VJ aufgel. / Angekommene Lieferavise VJ aufgel. 
		, rate_desadv_usage_act - rate_desadv_usage_py			 		AS rate_desadv_usage_diff_py 		-- DESADV Nutzung Delta VJ = DESADV Nutzung Ist - DESADV Nutzung VJ 
		, rate_desadv_usage_act_cum - rate_desadv_usage_py_cum			AS rate_desadv_usage_diff_py_cum	-- DESADV Nutzung Delta VJ aufgel. = DESADV Nutzung Ist aufgel. - DESADV Nutzung VJ aufgel. 
		, rate_desadv_usage_act - tgt_rate_adv_usage					AS rate_desadv_usage_diff_tgt 		-- DESADV Nutzung Delta Ziel = DESADV Nutzung Ist - DESADV Nutzung Ziel 
		, rate_desadv_usage_act_cum - tgt_rate_adv_usage				AS rate_desadv_usage_diff_tgt_cum	-- DESADV Nutzung Delta Ziel aufgel. = DESADV Nutzung Ist aufgel. - DESADV Nutzung Ziel 
		-- F. Rates for DESADV capability All / DESADV Potenzial Gesamt based on base kpis from 2. and 1.
		, wh_rcvg_all_cnt_wk_sum - desp_adv_cnt_wk_sum					AS rate_desadv_cap_all_act 			-- DESADV Potenzial Gesamt Ist = Gebuchte Wareneingaenge Gesamt Ist - Angekommene Lieferavise Ist
		, wh_rcvg_all_cnt_wk_cum - desp_adv_cnt_wk_cum					AS rate_desadv_cap_all_act_cum 		-- DESADV Potenzial Gesamt Ist aufgel. = Gebuchte Wareneingaenge Gesamt Ist aufgel. - Angekommene Lieferavise Ist aufgel.
		, wh_rcvg_all_cnt_wk_sum_py - desp_adv_cnt_wk_sum_py			AS rate_desadv_cap_all_py			-- DESADV Potenzial Gesamt VJ = Gebuchte Wareneingaenge Gesamt VJ - Angekommene Lieferavise VJ 
		, wh_rcvg_all_cnt_wk_cum_py - desp_adv_cnt_wk_cum_py			AS rate_desadv_cap_all_py_cum		-- DESADV Potenzial Gesamt VJ aufgel. = Gebuchte Wareneingaenge Gesamt VJ aufgel. - Angekommene Lieferavise VJ aufgel. 
		, rate_desadv_cap_all_act - rate_desadv_cap_all_py		 		AS rate_desadv_cap_all_diff_py 		-- DESADV Potenzial Gesamt Delta VJ = DESADV Potenzial Gesamt Ist - DESADV Potenzial Gesamt VJ 
		, rate_desadv_cap_all_act_cum - rate_desadv_cap_all_py_cum		AS rate_desadv_cap_all_diff_py_cum	-- DESADV Potenzial Gesamt Delta VJ aufgel. = DESADV Potenzial Gesamt Ist aufgel. - DESADV Potenzial Gesamt VJ aufgel. 
		-- G. Rates for DESADV capability EDI suppliers / DESADV Potenzial EDI Lieferanten based on base kpis from 3. and 1.
		, wh_rcvg_edi_cnt_wk_sum - desp_adv_cnt_wk_sum					AS rate_desadv_cap_edi_act 			-- DESADV Potenzial EDI Lieferanten Ist = Gebuchte Wareneingaenge EDI Lieferanten Ist - Angekommene Lieferavise Ist
		, wh_rcvg_edi_cnt_wk_cum - desp_adv_cnt_wk_cum					AS rate_desadv_cap_edi_act_cum 		-- DESADV Potenzial EDI Lieferanten Ist aufgel. = Gebuchte Wareneingaenge EDI Lieferanten Ist aufgel. - Angekommene Lieferavise Ist aufgel.
		, wh_rcvg_edi_cnt_wk_sum_py - desp_adv_cnt_wk_sum_py			AS rate_desadv_cap_edi_py			-- DESADV Potenzial EDI Lieferanten VJ = Gebuchte Wareneingaenge EDI Lieferanten VJ - Angekommene Lieferavise VJ 
		, wh_rcvg_edi_cnt_wk_cum_py - desp_adv_cnt_wk_cum_py			AS rate_desadv_cap_edi_py_cum		-- DESADV Potenzial EDI Lieferanten VJ aufgel. = Gebuchte Wareneingaenge EDI Lieferanten VJ aufgel. - Angekommene Lieferavise VJ aufgel. 
		, rate_desadv_cap_edi_act - rate_desadv_cap_edi_py		 		AS rate_desadv_cap_edi_diff_py 		-- DESADV Potenzial EDI Lieferanten Delta VJ = DESADV Potenzial EDI Lieferanten Ist - DESADV Potenzial EDI Lieferanten VJ 
		, rate_desadv_cap_edi_act_cum - rate_desadv_cap_edi_py_cum		AS rate_desadv_cap_edi_diff_py_cum	-- DESADV Potenzial EDI Lieferanten Delta VJ aufgel. = DESADV Potenzial EDI Lieferanten Ist aufgel. - DESADV Potenzial EDI Lieferanten VJ aufgel. 
		*/
	FROM mapping_index_fact_previousyear f
		LEFT OUTER JOIN limitation_target_rates t 
			ON f.client_id = t.client_id
				AND f.busyear = t.bus_year
		LEFT OUTER JOIN listing_supplier_information s
			ON f.client_id = s.client_id
				AND f.sup_sid = s.supplier_id
	)
SELECT 
	client_id 
	, ctry_grp_id
	, aspect_id
	, wh_id 
	, wh_loc_sid
	, sup_sid
	, global_location_nr AS gl_loc_nr
	, supplier_name AS sup_name
	, busyear AS byr
	, cy_week
	, busyear_prev_1y AS byr_py
	, cy_week_prev_1y AS cy_week_py
	, busyear_seq AS byr_seq
	, cy_week_seq
	, desp_adv_cnt_wk_sum AS base_desp_adv_cnt_wk_sum 
	, desp_adv_cnt_wk_cum AS base_desp_adv_cnt_wk_cum
	, desp_adv_cnt_wk_sum_py AS base_desp_adv_cnt_wk_sum_py
	, desp_adv_cnt_wk_cum_py AS base_desp_adv_cnt_wk_cum_py
	, usable_desp_adv_cnt_wk_sum
	, usable_desp_adv_cnt_wk_cum
	, usable_desp_adv_cnt_wk_sum_py
	, usable_desp_adv_cnt_wk_cum_py
	/*, desp_adv_cnt_wk_sum_diff_abs AS base_desp_adv_cnt_wk_sum_diff_abs
	, desp_adv_cnt_wk_sum_diff_rel AS base_desp_adv_cnt_wk_sum_diff_rel
	, desp_adv_cnt_wk_cum_diff_abs AS base_desp_adv_cnt_wk_cum_diff_abs
	, desp_adv_cnt_wk_cum_diff_rel AS base_desp_adv_cnt_wk_cum_diff_rel */
	, wh_rcvg_all_cnt_wk_sum AS base_wh_rcvg_all_cnt_wk_sum
	, wh_rcvg_all_cnt_wk_cum AS base_wh_rcvg_all_cnt_wk_cum
	, wh_rcvg_all_cnt_wk_sum_py AS base_wh_rcvg_all_cnt_wk_sum_py
	, wh_rcvg_all_cnt_wk_cum_py AS base_wh_rcvg_all_cnt_wk_cum_py
	/*, wh_rcvg_all_cnt_wk_sum_diff_abs AS base_wh_rcvg_all_cnt_wk_sum_diff_abs
	, wh_rcvg_all_cnt_wk_sum_diff_rel AS base_wh_rcvg_all_cnt_wk_sum_diff_rel
	, wh_rcvg_all_cnt_wk_cum_diff_abs AS base_wh_rcvg_all_cnt_wk_cum_diff_abs
	, wh_rcvg_all_cnt_wk_cum_diff_rel AS base_wh_rcvg_all_cnt_wk_cum_diff_rel */
	, wh_rcvg_edi_cnt_wk_sum AS base_wh_rcvg_edi_cnt_wk_sum
	, wh_rcvg_edi_cnt_wk_cum AS base_wh_rcvg_edi_cnt_wk_cum
	, wh_rcvg_edi_cnt_wk_sum_py AS base_wh_rcvg_edi_cnt_wk_sum_py
	, wh_rcvg_edi_cnt_wk_cum_py AS base_wh_rcvg_edi_cnt_wk_cum_py
	/*, wh_rcvg_edi_cnt_wk_sum_diff_abs AS base_wh_rcvg_edi_cnt_wk_sum_diff_abs
	, wh_rcvg_edi_cnt_wk_sum_diff_rel AS base_wh_rcvg_edi_cnt_wk_sum_diff_rel
	, wh_rcvg_edi_cnt_wk_cum_diff_abs AS base_wh_rcvg_edi_cnt_wk_cum_diff_abs
	, wh_rcvg_edi_cnt_wk_cum_diff_rel AS base_wh_rcvg_edi_cnt_wk_cum_diff_rel */
	, item_rcvg_cnt_wk_sum AS base_item_rcvg_cnt_wk_sum
	, item_rcvg_cnt_wk_cum AS base_item_rcvg_cnt_wk_cum
	, item_rcvg_cnt_wk_sum_py AS base_item_rcvg_cnt_wk_sum_py
	, item_rcvg_cnt_wk_cum_py AS base_item_rcvg_cnt_wk_cum_py
	/*, item_rcvg_cnt_wk_sum_diff_abs AS base_item_rcvg_cnt_wk_sum_diff_abs
	, item_rcvg_cnt_wk_sum_diff_rel AS base_item_rcvg_cnt_wk_sum_diff_rel
	, item_rcvg_cnt_wk_cum_diff_abs AS base_item_rcvg_cnt_wk_cum_diff_abs
	, item_rcvg_cnt_wk_cum_diff_rel AS base_item_rcvg_cnt_wk_cum_diff_rel */
	, tgt_rate_adv_overall_all
	, tgt_rate_adv_overall_edi
	, tgt_rate_adv_avail_all
	, tgt_rate_adv_avail_edi
	, tgt_rate_adv_usage
	/*
	, rate_desadv_overall_all_act
	, rate_desadv_overall_all_act_cum
	, rate_desadv_overall_all_py
	, rate_desadv_overall_all_py_cum
	, rate_desadv_overall_all_diff_py
	, rate_desadv_overall_all_diff_py_cum
	, rate_desadv_overall_all_diff_tgt
	, rate_desadv_overall_all_diff_tgt_cum
	, rate_desadv_overall_edi_act
	, rate_desadv_overall_edi_act_cum
	, rate_desadv_overall_edi_py
	, rate_desadv_overall_edi_py_cum
	, rate_desadv_overall_edi_diff_py
	, rate_desadv_overall_edi_diff_py_cum
	, rate_desadv_overall_edi_diff_tgt
	, rate_desadv_overall_edi_diff_tgt_cum
	, rate_desadv_avail_all_act
	, rate_desadv_avail_all_act_cum
	, rate_desadv_avail_all_py
	, rate_desadv_avail_all_py_cum
	, rate_desadv_avail_all_diff_py
	, rate_desadv_avail_all_diff_py_cum
	, rate_desadv_avail_all_diff_tgt
	, rate_desadv_avail_all_diff_tgt_cum
	, rate_desadv_avail_edi_act
	, rate_desadv_avail_edi_act_cum
	, rate_desadv_avail_edi_py
	, rate_desadv_avail_edi_py_cum
	, rate_desadv_avail_edi_diff_py
	, rate_desadv_avail_edi_diff_py_cum
	, rate_desadv_avail_edi_diff_tgt
	, rate_desadv_avail_edi_diff_tgt_cum
	, rate_desadv_usage_act
	, rate_desadv_usage_act_cum
	, rate_desadv_usage_py
	, rate_desadv_usage_py_cum
	, rate_desadv_usage_diff_py
	, rate_desadv_usage_diff_py_cum
	, rate_desadv_usage_diff_tgt
	, rate_desadv_usage_diff_tgt_cum
	, rate_desadv_cap_all_act
	, rate_desadv_cap_all_act_cum
	, rate_desadv_cap_all_py
	, rate_desadv_cap_all_py_cum
	, rate_desadv_cap_all_diff_py
	, rate_desadv_cap_all_diff_py_cum
	, rate_desadv_cap_edi_act
	, rate_desadv_cap_edi_act_cum
	, rate_desadv_cap_edi_py
	, rate_desadv_cap_edi_py_cum
	, rate_desadv_cap_edi_diff_py
	, rate_desadv_cap_edi_diff_py_cum
	*/
FROM kpi_targets;
