/*
===================================================================================================================================
Division		|	Lidl
Solution		|	Enterprise Logistics
DB schema		|	p_lew_mart_lead_ac
DB view			|	v_edi_desadv_cum_wk
Description		|	Access view with aggregated facts - MIS Lead / 02 Prozesse / 021103 Ware umschlagen / EDI/DESADV Kennzahlen
===================================================================================================================================
*/

-- The aggregation level for all data is client_id, aspect_id (warehouse type), wh_id, sup_sid, business year and calendar week.
CREATE OR REPLACE VIEW p_lew_mart_lead_ac.v_edi_desadv_cum_wk (
	CLIENT_ID COMMENT 'Client ID',
	CTRY_GRP_ID COMMENT 'Country group ID',
	ASPECT_ID COMMENT 'Aspect ID (1=Betriebsgesellschaft, 2=Vertriebsgesellschaft)',
	WH_ID COMMENT 'Warehouse ID',
	WH_LOC_SID COMMENT 'Location surrogate ID',
	SUP_SID COMMENT 'Supplier surrogate ID',
	GL_LOC_NR COMMENT 'Supplier global location number',
	SUP_NAME COMMENT 'Supplier name',
	BYR COMMENT 'Current business year of the record',
	CY_WEEK COMMENT 'Current calendar week of the record',
	BYR_PY COMMENT 'Business year in previous calendar year',
	CY_WEEK_PY COMMENT 'Calendar week in previous calendar year',
	BYR_SEQ COMMENT 'Sequence for business year',
	CY_WEEK_SEQ COMMENT 'Sequence for calendar week',
	BASE_DESP_ADV_CNT_WK_SUM COMMENT 'Total number of despatch advices per calendar week',
	BASE_DESP_ADV_CNT_WK_CUM COMMENT 'Running total number of despatch advices within a business year cumulated after every calendar week',
	BASE_DESP_ADV_CNT_WK_SUM_PY COMMENT 'Total number of despatch advices of the calendar week of the previous business year (mapped to the current week)',
	BASE_DESP_ADV_CNT_WK_CUM_PY COMMENT 'Total number of despatch advices cumulated after every calendar week within the previous business year (mapped to the current week)',
	USABLE_DESP_ADV_CNT_WK_SUM COMMENT 'Total number of usable despatch adviecs per calendar week',
	USABLE_DESP_ADV_CNT_WK_CUM COMMENT 'Running total number of usable despatch advices within a business year cumulated after every calendar week',
	USABLE_DESP_ADV_CNT_WK_SUM_PY COMMENT 'Total number of usable despatch advices of the calendar week of the previous business year (mapped to th ecurrent week)',
	USABLE_DESP_ADV_CNT_WK_CUM_PY COMMENT 'Total number of usable despatch advices cumulated after every calendar week within the previous business year (mapped to the current week)',
	BASE_WH_RCVG_ALL_CNT_WK_SUM COMMENT 'Total number of item receipts (All) per calendar week',
	BASE_WH_RCVG_ALL_CNT_WK_CUM COMMENT 'Running total number of item receipts (All) within a business year cumulated after every calendar week',
	BASE_WH_RCVG_ALL_CNT_WK_SUM_PY COMMENT 'Total number of item receipts (All) of the calendar week of the previous business year (mapped to the current week)',
	BASE_WH_RCVG_ALL_CNT_WK_CUM_PY COMMENT 'Total number of item receipts (All) cumulated after every calendar week within the previous business year (mapped to the current week)',
	BASE_WH_RCVG_EDI_CNT_WK_SUM COMMENT 'Total number of item receipts (EDI) per calendar week',
	BASE_WH_RCVG_EDI_CNT_WK_CUM COMMENT 'Running total number of item receipts (EDI) within a business year cumulated after every calendar week',
	BASE_WH_RCVG_EDI_CNT_WK_SUM_PY COMMENT 'Total number of item receipts (EDI) of the calendar week of the previous business year (mapped to the current week)',
	BASE_WH_RCVG_EDI_CNT_WK_CUM_PY COMMENT 'Total number of item receipts (EDI) cumulated after every calendar week within the previous business year (mapped to the current week)',
	BASE_ITEM_RCVG_CNT_WK_SUM COMMENT 'Total number of item receiving countings per calendar week',
	BASE_ITEM_RCVG_CNT_WK_CUM COMMENT 'Running total number of item receiving countings within a business year cumulated after every calendar week',
	BASE_ITEM_RCVG_CNT_WK_SUM_PY COMMENT 'Total number of item receiving countings of the calendar week of the previous business year (mapped to the current week)',
	BASE_ITEM_RCVG_CNT_WK_CUM_PY COMMENT 'Total number of item receiving countings cumulated after every calendar week within the previous business year (mapped to the current week)',
	TGT_RATE_ADV_OVERALL_ALL COMMENT 'DESADV overall target rate for All per country and business year',
	TGT_RATE_ADV_OVERALL_EDI COMMENT 'DESADV overall target rate for EDI per country and business year',
	TGT_RATE_ADV_AVAIL_ALL COMMENT 'DESADV availability target rate for All per country and business year',
	TGT_RATE_ADV_AVAIL_EDI COMMENT 'DESADV availability target rate for EDI per country and business year',
	TGT_RATE_ADV_USAGE COMMENT 'DESADV usage target rate per country and business year'
	)
COMMENT = 'Access view with aggregated facts - MIS Lead / 02 Prozesse / 021103 Ware umschlagen / EDI/DESADV Kennzahlen'
AS
SELECT 
	client_id 
	, ctry_grp_id
	, aspect_id
	, wh_id 
	, wh_loc_sid
	, sup_sid
	, gl_loc_nr	
	, sup_name
	, byr
	, cy_week
	, byr_py
	, cy_week_py
	, byr_seq
	, cy_week_seq
	, base_desp_adv_cnt_wk_sum
	, base_desp_adv_cnt_wk_cum
	, base_desp_adv_cnt_wk_sum_py
	, base_desp_adv_cnt_wk_cum_py
	, usable_desp_adv_cnt_wk_sum
	, usable_desp_adv_cnt_wk_cum
	, usable_desp_adv_cnt_wk_sum_py
	, usable_desp_adv_cnt_wk_cum_py
	/*, base_desp_adv_cnt_wk_sum_diff_abs
	, base_desp_adv_cnt_wk_sum_diff_rel
	, base_desp_adv_cnt_wk_cum_diff_abs
	, base_desp_adv_cnt_wk_cum_diff_rel */
	, base_wh_rcvg_all_cnt_wk_sum
	, base_wh_rcvg_all_cnt_wk_cum
	, base_wh_rcvg_all_cnt_wk_sum_py
	, base_wh_rcvg_all_cnt_wk_cum_py
	/*, base_wh_rcvg_all_cnt_wk_sum_diff_abs
	, base_wh_rcvg_all_cnt_wk_sum_diff_rel
	, base_wh_rcvg_all_cnt_wk_cum_diff_abs
	, base_wh_rcvg_all_cnt_wk_cum_diff_rel */
	, base_wh_rcvg_edi_cnt_wk_sum
	, base_wh_rcvg_edi_cnt_wk_cum
	, base_wh_rcvg_edi_cnt_wk_sum_py
	, base_wh_rcvg_edi_cnt_wk_cum_py
	/*, base_wh_rcvg_edi_cnt_wk_sum_diff_abs
	, base_wh_rcvg_edi_cnt_wk_sum_diff_rel
	, base_wh_rcvg_edi_cnt_wk_cum_diff_abs
	, base_wh_rcvg_edi_cnt_wk_cum_diff_rel */
	, base_item_rcvg_cnt_wk_sum
	, base_item_rcvg_cnt_wk_cum
	, base_item_rcvg_cnt_wk_sum_py
	, base_item_rcvg_cnt_wk_cum_py
	/*, base_item_rcvg_cnt_wk_sum_diff_abs
	, base_item_rcvg_cnt_wk_sum_diff_rel
	, base_item_rcvg_cnt_wk_cum_diff_abs
	, base_item_rcvg_cnt_wk_cum_diff_rel */
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
FROM p_lew_mart_lead.v_edi_desadv_cum_wk
;