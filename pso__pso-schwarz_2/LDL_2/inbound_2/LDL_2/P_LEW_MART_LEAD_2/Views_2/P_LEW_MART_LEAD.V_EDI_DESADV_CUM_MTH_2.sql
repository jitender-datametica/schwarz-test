CREATE OR REPLACE VIEW P_LEW_MART_LEAD.V_EDI_DESADV_CUM_MTH_2(
	CLIENT_ID COMMENT 'Client ID',
	CTRY_GRP_ID COMMENT 'Country_2 group ID',
	ASPECT_ID COMMENT 'Aspect ID (1=Betriebsgesellschaft, 2=Vertriebsgesellschaft)',
	WH_ID COMMENT 'Warehouse ID',
	WH_LOC_SID COMMENT 'Location_2 surrogate ID',
	SUP_SID COMMENT 'Supplier_2 surrogate ID',
	GL_LOC_NR COMMENT 'Supplier_2 global location_2 number',
	SUP_NAME COMMENT 'Supplier_2 name',
	BYR COMMENT 'Current business year of the record',
	CY_MONTH COMMENT 'Current calendar_2 week of the record',
	BYR_PY COMMENT 'Business year in previous calendar_2 year',
	CY_MONTH_PY COMMENT 'Calendar_2 week in previous calendar_2 year',
	BYR_SEQ COMMENT 'Sequence for business year',
	CY_MONTH_SEQ COMMENT 'Sequence for calendar_2 week',
	BASE_DESP_ADV_CNT_MTH_SUM COMMENT 'Total number of despatch advices per calendar_2 month',
	BASE_DESP_ADV_CNT_MTH_CUM COMMENT 'Running total number of despatch advices within a business year cumulated after every calendar_2 month',
	BASE_DESP_ADV_CNT_MTH_SUM_PY COMMENT 'Total number of despatch advices of the calendar_2 month of the previous business year (mapped to the current month)',
	BASE_DESP_ADV_CNT_MTH_CUM_PY COMMENT 'Total number of despatch advices cumulated after every calendar_2 month within the previous business year (mapped to the current month)',
	USABLE_DESP_ADV_CNT_MTH_SUM COMMENT 'Total number of usable despatch advices per calendar_2 month',
	USABLE_DESP_ADV_CNT_MTH_CUM COMMENT 'Running total number of usable despatch advices within a business year cumulated after every calendar_2 month',
	USABLE_DESP_ADV_CNT_MTH_SUM_PY COMMENT 'Total number of usable despatch advices of the calendar_2 month of the previuos business year (mapped to the current month)',
	USABLE_DESP_ADV_CNT_MTH_CUM_PY COMMENT 'Running total number of usable despatch advices cumulated after every calendar_2 month whint the previous business year (mapped to the current month)',
	BASE_WH_RCVG_ALL_CNT_MTH_SUM COMMENT 'Total number of item_2 receipts (All) per calendar_2 month',
	BASE_WH_RCVG_ALL_CNT_MTH_CUM COMMENT 'Running total number of item_2 receipts (All) within a business year cumulated after every calendar_2 month',
	BASE_WH_RCVG_ALL_CNT_MTH_SUM_PY COMMENT 'Total number of item_2 receipts (All) of the calendar_2 month of the previous business year (mapped to the current month)',
	BASE_WH_RCVG_ALL_CNT_MTH_CUM_PY COMMENT 'Total number of item_2 receipts (All) cumulated after every calendar_2 month within the previous business year (mapped to the current month)',
	BASE_WH_RCVG_EDI_CNT_MTH_SUM COMMENT 'Total number of item_2 receipts (EDI) per calendar_2 month',
	BASE_WH_RCVG_EDI_CNT_MTH_CUM COMMENT 'Running total number of item_2 receipts (EDI) within a business year cumulated after every calendar_2 month',
	BASE_WH_RCVG_EDI_CNT_MTH_SUM_PY COMMENT 'Total number of item_2 receipts (EDI) of the calendar_2 week of the previous business year (mapped to the current month)',
	BASE_WH_RCVG_EDI_CNT_MTH_CUM_PY COMMENT 'Total number of item_2 receipts (EDI) cumulated after every calendar_2 month within the previous business year (mapped to the current month)',
	BASE_ITEM_RCVG_CNT_MTH_SUM COMMENT 'Total number of item_2 receiving countings per calendar_2 month',
	BASE_ITEM_RCVG_CNT_MTH_CUM COMMENT 'Running total number of item_2 receiving countings within a business year cumulated after every calendar_2 month',
	BASE_ITEM_RCVG_CNT_MTH_SUM_PY COMMENT 'Total number of item_2 receiving countings of the calendar_2 month of the previous business year (mapped to the current month)',
	BASE_ITEM_RCVG_CNT_MTH_CUM_PY COMMENT 'Total number of item_2 receiving countings cumulated after every calendar_2 month within the previous business year (mapped to the current month)',
	TGT_RATE_ADV_OVERALL_ALL COMMENT 'DESADV overall target rate for All per country_2 and business year',
	TGT_RATE_ADV_OVERALL_EDI COMMENT 'DESADV overall target rate for EDI per country_2 and business year',
	TGT_RATE_ADV_AVAIL_ALL COMMENT 'DESADV availability target rate for All per country_2 and business year',
	TGT_RATE_ADV_AVAIL_EDI COMMENT 'DESADV availability target rate for EDI per country_2 and business year',
	TGT_RATE_ADV_USAGE COMMENT 'DESADV usage target rate per country_2 and business year'
) COMMENT='View with cumulated facts for Month - MIS Lead / 02 Prozesse / 021103 Ware umschlagen / EDI/ DESADV Kennzahlen'
AS
WITH listing_suppliers AS (
SELECT DISTINCT 
     client_id 
	,ctry_grp_id 
	,aspect_id   
	,wh_id 
	,wh_loc_sid  
	,sup_sid 
	FROM p_lew_mart_lead.v_edi_desadv_agg_2
),
listing_months AS (
    SELECT
        c.busyear
       ,c.cy_month
       ,c.busyear-1 AS busyear_prev_1y
       ,m.cy_month_prev_1y 
       ,c.busyear_seq
       ,c.cy_month_seq
FROM p_lew_core_ac.v_cal_calendarday_2 c
INNER JOIN p_lew_core_ac.v_cal_month_2 m
ON c.cy_month = m.cy_month
WHERE c.busyear_seq BETWEEN -2 AND 0
AND c.cy_month_seq <=0
GROUP BY 1,2,3,4,5,6
),
listing_index AS (
    SELECT s.client_id 
		, s.ctry_grp_id 
		, s.aspect_id 
		, s.wh_id 
		, s.wh_loc_sid  
		, s.sup_sid 
		, m.busyear 
		, m.cy_month 
		, m.busyear_prev_1y 
		, m.cy_month_prev_1y 
        , m.busyear_seq 
        , m.cy_month_seq 
	FROM listing_suppliers s
		CROSS JOIN listing_months m
),
limitation_target_rates AS (
    SELECT 
        client_id 
	   ,bus_year
	   ,advice_target_rate AS tgt_rate_adv_overall_all -- 'Target rate of despatch advices which have been used in the receivings process among all receivings (all suppliers)' 
	   ,advice_edi_target_rate AS tgt_rate_adv_overall_edi -- 'Target rate of despatch advices which have been used in the receivings process among all receivings (EDI suppliers only)' 
	   ,advice_avail_target_rate AS tgt_rate_adv_avail_all 	-- 'Target rate of sent despatch advices among all receivings (all suppliers)' 
	   ,advice_avail_edi_target_rate AS tgt_rate_adv_avail_edi 	-- 'Target rate of sent despatch advices among all receivings (EDI suppliers only)' 
	   ,advice_usage_target_rate AS tgt_rate_adv_usage 		-- 'Target rate of despatch advices which have been used in the receivings process among all sent despatch advices from EDI suppliers only' 
	   ,dwh_valid_from
	   ,dwh_valid_to
		--, dwh_created
		--, dwh_updated
	FROM p_lew_core_ac.v_despatch_advice_usage_plan_hist_2
	WHERE CURRENT_DATE BETWEEN dwh_valid_from AND dwh_valid_to 
),
listing_supplier_information AS (
    SELECT 
        client_id
	   ,supplier_id 
	   ,global_location_nr 
	   ,supplier_name 
	   ,orig_supplier_nr 
	   ,supplier_id_int
	FROM p_lew_mart_msi_ac.v_sup_supplier_2
	WHERE supplier_id >= 0 -- excluding country_2 entries
),
fact_aggregation_month AS (
    SELECT 
        client_id
	   ,aspect_id
	   ,wh_id
	   ,sup_sid
	   ,byr 
	   ,cy_month
	   ,SUM(desp_adv_cnt) AS desp_adv_cnt_mth_sum -- month total (Angekommene Lieferavise - Ist) 
       ,SUM(desp_adv_cnt_mth_sum) OVER (PARTITION BY client_id, wh_id, sup_sid, byr ORDER BY cy_month ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS desp_adv_cnt_mth_cum
       ,SUM(usable_desp_adv_cnt) AS usable_desp_adv_cnt_mth_sum -- Month total (verwendbare Lieferavise - Ist)
       ,SUM(usable_desp_adv_cnt_mth_sum) OVER (PARTITION BY client_id, wh_id, sup_sid, byr ORDER BY cy_month ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS usable_desp_adv_cnt_mth_cum  
       ,SUM(wh_rcvg_all_cnt) AS wh_rcvg_all_cnt_mth_sum -- month total (Gebuchte Wareneingaenge Gesamt - Ist)
       ,SUM(wh_rcvg_all_cnt_mth_sum) OVER (PARTITION BY client_id, wh_id, sup_sid, byr ORDER BY cy_month ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS wh_rcvg_all_cnt_mth_cum
       ,SUM(wh_rcvg_edi_cnt) AS wh_rcvg_edi_cnt_mth_sum -- month total (Gebuchte Wareneingaege EDI Lieferanten - Ist)
       ,SUM(wh_rcvg_edi_cnt_mth_sum) OVER (PARTITION BY client_id, wh_id, sup_sid, byr ORDER BY cy_month ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS wh_rcvg_edi_cnt_mth_cum
       ,SUM(item_rcvg_cnt) AS item_rcvg_cnt_mth_sum
       ,SUM(item_rcvg_cnt_mth_sum) OVER (PARTITION BY client_id, wh_id,sup_sid,byr ORDER BY cy_month ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS item_rcvg_cnt_mth_cum
	FROM p_lew_mart_lead.v_edi_desadv_agg_2 
	GROUP BY client_id
		    ,aspect_id
		    ,wh_id
		    ,sup_sid
		    ,byr
		    ,cy_month
),
mapping_index_fact_previousyear AS ( 
	SELECT 
        i.client_id 
	   ,i.ctry_grp_id
	   ,i.aspect_id
	   ,i.wh_id 
	   ,i.wh_loc_sid
	   ,i.sup_sid
	   ,i.busyear
	   ,i.cy_month
	   ,i.busyear_prev_1y
	   ,i.cy_month_prev_1y
	   ,i.busyear_seq
	   ,i.cy_month_seq
		-- 1. Mapping fact of previous year for despatch advices (Angekommene Lieferavise)
	   ,f.desp_adv_cnt_mth_sum
	   ,COALESCE(f.desp_adv_cnt_mth_cum
			, LAG(f.desp_adv_cnt_mth_cum) IGNORE NULLS OVER (PARTITION BY i.client_id, i.wh_id, i.sup_sid, i.busyear ORDER BY i.cy_month)
			) AS desp_adv_cnt_mth_cum
	   ,fp.desp_adv_cnt_mth_sum AS desp_adv_cnt_mth_sum_py -- Angekommene Lieferavise - VJ 
	   ,COALESCE(fp.desp_adv_cnt_mth_cum
		,LAG(fp.desp_adv_cnt_mth_cum) IGNORE NULLS OVER (PARTITION BY i.client_id, i.wh_id, i.sup_sid, i.busyear ORDER BY i.cy_month)
			) AS desp_adv_cnt_mth_cum_py -- Angekommene Lieferavise - VJ aufgel.
		-- Mapping fact of previous year for usable despatch advices (Verwendbare Lieferavise)
		,f.usable_desp_adv_cnt_mth_sum
		,COALESCE(f.usable_desp_adv_cnt_mth_cum
			, LAG(f.usable_desp_adv_cnt_mth_cum) IGNORE NULLS OVER (PARTITION BY i.client_id, i.wh_id, i.sup_sid, i.busyear ORDER BY i.cy_month)
			) AS usable_desp_adv_cnt_mth_cum
		,fp.usable_desp_adv_cnt_mth_sum AS usable_desp_adv_cnt_mth_sum_py -- Verwendbare Lieferavise - VJ
		,COALESCE(fp.usable_desp_adv_cnt_mth_cum
			,LAG(fp.usable_desp_adv_cnt_mth_cum) IGNORE NULLS OVER (PARTITION BY i.client_id, i.wh_id, i.sup_sid, i.busyear ORDER BY i.cy_month)
			) AS usable_desp_adv_cnt_mth_cum_py
		-- 2. Mapping fact of previous year for booked item_2 receipts at a warehouse (Gebuchte Wareneingaenge Gesamt)  
		,f.wh_rcvg_all_cnt_mth_sum
		,COALESCE(f.wh_rcvg_all_cnt_mth_cum
		,LAG(f.wh_rcvg_all_cnt_mth_cum) IGNORE NULLS OVER (PARTITION BY i.client_id, i.wh_id, i.sup_sid, i.busyear ORDER BY i.cy_month)
			) AS wh_rcvg_all_cnt_mth_cum
		,fp.wh_rcvg_all_cnt_mth_sum AS wh_rcvg_all_cnt_mth_sum_py -- Gebuchte Wareneingaenge Gesamt - VJ 
		,COALESCE(fp.wh_rcvg_all_cnt_mth_cum
		,LAG(fp.wh_rcvg_all_cnt_mth_cum) IGNORE NULLS OVER (PARTITION BY i.client_id, i.wh_id, i.sup_sid, i.busyear ORDER BY i.cy_month)
		) AS wh_rcvg_all_cnt_mth_cum_py -- Gebuchte Wareneingaenge Gesamt - VJ aufgel. 
		-- 3. Mapping fact of previous year for booked item_2 receipts at a warehouse limited to EDI (Gebuchte Wareneingaenge EDI Lieferanten) 
		,f.wh_rcvg_edi_cnt_mth_sum
		,COALESCE(f.wh_rcvg_edi_cnt_mth_cum
		,LAG(f.wh_rcvg_edi_cnt_mth_cum) IGNORE NULLS OVER (PARTITION BY i.client_id, i.wh_id, i.sup_sid, i.busyear ORDER BY i.cy_month)
		) AS wh_rcvg_edi_cnt_mth_cum
		,fp.wh_rcvg_edi_cnt_mth_sum AS wh_rcvg_edi_cnt_mth_sum_py -- Gebuchte Wareneingaenge EDI Lieferanten - VJ 
		,COALESCE(fp.wh_rcvg_edi_cnt_mth_cum
		,LAG(fp.wh_rcvg_edi_cnt_mth_cum) IGNORE NULLS OVER (PARTITION BY i.client_id, i.wh_id, i.sup_sid, i.busyear ORDER BY i.cy_month)
			) AS wh_rcvg_edi_cnt_mth_cum_py -- Gebuchte Wareneingaenge EDI Lieferanten - VJ aufgel. 
		-- 4. Mapping fact of previous year for item_2 receiving countings with a referenced used despatch advice (Verwendete Lieferavise) 
		,f.item_rcvg_cnt_mth_sum
		,COALESCE(f.item_rcvg_cnt_mth_cum
		,LAG(f.item_rcvg_cnt_mth_cum) IGNORE NULLS OVER (PARTITION BY i.client_id, i.wh_id, i.sup_sid, i.busyear ORDER BY i.cy_month)
			) AS item_rcvg_cnt_mth_cum
		,fp.item_rcvg_cnt_mth_sum AS item_rcvg_cnt_mth_sum_py -- Verwendete Lieferavise - VJ 
		,COALESCE(fp.item_rcvg_cnt_mth_cum
		,LAG(fp.item_rcvg_cnt_mth_cum) IGNORE NULLS OVER (PARTITION BY i.client_id, i.wh_id, i.sup_sid, i.busyear ORDER BY i.cy_month)
			) AS item_rcvg_cnt_mth_cum_py -- Verwendete Lieferavise - VJ aufgel. */
	FROM listing_index i
    LEFT OUTER JOIN fact_aggregation_month f
			ON i.client_id = f.client_id 
				AND i.aspect_id = f.aspect_id 
				AND i.wh_id = f.wh_id 
				AND i.sup_sid = f.sup_sid
				AND i.busyear = f.byr 
				AND i.cy_month = f.cy_month
		LEFT OUTER JOIN fact_aggregation_month fp
			ON i.client_id = fp.client_id 
				AND i.aspect_id = fp.aspect_id 
				AND i.wh_id = fp.wh_id
				AND i.sup_sid = fp.sup_sid
				AND i.busyear_prev_1y = fp.byr -- To avoid doubled matches because of week 9 as first week of a business year (partial week in Feb and partial week in Mar separately) 
				AND i.cy_month_prev_1y = fp.cy_month
	QUALIFY i.busyear > MIN(i.busyear) OVER (PARTITION BY 1) -- filter out the data of that oldest year where values for previous year are empty
	),
kpi_targets AS (
	SELECT 
		f.client_id  
	   ,f.ctry_grp_id
	   ,f.aspect_id
	   ,f.wh_id 
	   ,f.wh_loc_sid
	   ,f.sup_sid
	   ,s.global_location_nr
	   ,s.supplier_name 
	   ,f.busyear
	   ,f.cy_month
	   ,f.busyear_prev_1y
	   ,f.cy_month_prev_1y
	   ,f.busyear_seq
	   ,f.cy_month_seq
		-- 1. despatch advices (Angekommene Lieferavise)
	   ,f.desp_adv_cnt_mth_sum 			-- Angekommene Lieferavise - Ist 
	   ,f.desp_adv_cnt_mth_cum 			-- Angekommene Lieferavise - Ist aufgel. 
	   ,f.desp_adv_cnt_mth_sum_py 			-- Angekommene Lieferavise - VJ
	   ,f.desp_adv_cnt_mth_cum_py 			-- Angekommene Lieferavise - VJ aufgel.
	   -- usable despatch advices (Verwendbare Lieferavise)
	   ,f.usable_desp_adv_cnt_mth_sum    -- Verwendbare Lieferavise - Ist
	   ,f.usable_desp_adv_cnt_mth_cum    -- Verwendbare Lieferavise -- Ist augel.
	   ,f.usable_desp_adv_cnt_mth_sum_py  -- Verwendbare Lieferavise - VJ
	   ,f.usable_desp_adv_cnt_mth_cum_py  -- Verwendbare Lieferavise - VJ augfel.
		-- 2. booked item_2 receipts at a warehouse (Gebuchte Wareneingaenge Gesamt)  
	   ,f.wh_rcvg_all_cnt_mth_sum 			-- Gebuchte Wareneingaenge Gesamt - Ist
	   ,f.wh_rcvg_all_cnt_mth_cum 			-- Gebuchte Wareneingaenge Gesamt - Ist aufgel.
	   ,f.wh_rcvg_all_cnt_mth_sum_py 		-- Gebuchte Wareneingaenge Gesamt - VJ
	   ,f.wh_rcvg_all_cnt_mth_cum_py		-- Gebuchte Wareneingaenge Gesamt - VJ aufgel.
		-- 3. booked item_2 receipts at a warehouse limited to EDI (Gebuchte Wareneingaenge EDI Lieferanten) 
	   ,f.wh_rcvg_edi_cnt_mth_sum 			-- Gebuchte Wareneingaenge EDI Lieferanten - Ist
	   ,f.wh_rcvg_edi_cnt_mth_cum 			-- Gebuchte Wareneingaenge EDI Lieferanten - Ist aufgel.
	   ,f.wh_rcvg_edi_cnt_mth_sum_py 		-- Gebuchte Wareneingaenge EDI Lieferanten - VJ
	   ,f.wh_rcvg_edi_cnt_mth_cum_py 		-- Gebuchte Wareneingaenge EDI Lieferanten - VJ aufgel.
		-- 4. item_2 receiving countings with a referenced used despatch advice (Verwendete Lieferavise) 
       ,f.item_rcvg_cnt_mth_sum 			-- Verwendete Lieferavise - Ist
	   ,f.item_rcvg_cnt_mth_cum 			-- Verwendete Lieferavise - Ist aufgel.
	   ,f.item_rcvg_cnt_mth_sum_py 		-- Verwendete Lieferavise - VJ
	   ,f.item_rcvg_cnt_mth_cum_py 		-- Verwendete Lieferavise - VJ aufgel.
		-- Target rates for each country_2 
		,t.tgt_rate_adv_overall_all 	-- DESADV target rate for All per country_2 and business year 
		,t.tgt_rate_adv_overall_edi 	-- DESADV target rate for EDI per country_2 and business year  
		,t.tgt_rate_adv_avail_all 		-- Availability target rate for All per country_2 and business year  
		,t.tgt_rate_adv_avail_edi 		-- Availability target rate for EDI per country_2 and business year   
		,t.tgt_rate_adv_usage 			-- Usage target rate per country_2 and business year
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
	, cy_month
	, busyear_prev_1y AS byr_py
	, cy_month_prev_1y AS cy_month_py
	, busyear_seq AS byr_seq
	, cy_month_seq
	, desp_adv_cnt_mth_sum AS base_desp_adv_cnt_mth_sum 
	, desp_adv_cnt_mth_cum AS base_desp_adv_cnt_mth_cum
	, desp_adv_cnt_mth_sum_py AS base_desp_adv_cnt_mth_sum_py
	, desp_adv_cnt_mth_cum_py AS base_desp_adv_cnt_mth_cum_py
	, usable_desp_adv_cnt_mth_sum
	, usable_desp_adv_cnt_mth_cum
	, usable_desp_adv_cnt_mth_sum_py
	, usable_desp_adv_cnt_mth_cum_py
	, wh_rcvg_all_cnt_mth_sum AS base_wh_rcvg_all_cnt_mth_sum
	, wh_rcvg_all_cnt_mth_cum AS base_wh_rcvg_all_cnt_mth_cum
	, wh_rcvg_all_cnt_mth_sum_py AS base_wh_rcvg_all_cnt_mth_sum_py
	, wh_rcvg_all_cnt_mth_cum_py AS base_wh_rcvg_all_cnt_mth_cum_py
	, wh_rcvg_edi_cnt_mth_sum AS base_wh_rcvg_edi_cnt_mth_sum
	, wh_rcvg_edi_cnt_mth_cum AS base_wh_rcvg_edi_cnt_mth_cum
	, wh_rcvg_edi_cnt_mth_sum_py AS base_wh_rcvg_edi_cnt_mth_sum_py
	, wh_rcvg_edi_cnt_mth_cum_py AS base_wh_rcvg_edi_cnt_mth_cum_py
	, item_rcvg_cnt_mth_sum AS base_item_rcvg_cnt_mth_sum
	, item_rcvg_cnt_mth_cum AS base_item_rcvg_cnt_mth_cum
	, item_rcvg_cnt_mth_sum_py AS base_item_rcvg_cnt_mth_sum_py
	, item_rcvg_cnt_mth_cum_py AS base_item_rcvg_cnt_mth_cum_py
	, tgt_rate_adv_overall_all
	, tgt_rate_adv_overall_edi
	, tgt_rate_adv_avail_all
	, tgt_rate_adv_avail_edi
	, tgt_rate_adv_usage
FROM kpi_targets;
