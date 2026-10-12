CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_EDI_DESADV_CUM_MTH(
	CLIENT_ID COMMENT 'Client ID',
	CTRY_GRP_ID COMMENT 'Country group ID',
	ASPECT_ID COMMENT 'Aspect ID (1=Betriebsgesellschaft, 2=Vertriebsgesellschaft)',
	WH_ID COMMENT 'Warehouse ID',
	WH_LOC_SID COMMENT 'Location surrogate ID',
	SUP_SID COMMENT 'Supplier surrogate ID',
	GL_LOC_NR COMMENT 'Supplier global location number',
	SUP_NAME COMMENT 'Supplier name',
	BYR COMMENT 'Current business year of the record',
	CY_MONTH COMMENT 'Current calendar week of the record',
	BYR_PY COMMENT 'Business year in previous calendar year',
	CY_MONTH_PY COMMENT 'Calendar week in previous calendar year',
	BYR_SEQ COMMENT 'Sequence for business year',
	CY_MONTH_SEQ COMMENT 'Sequence for calendar week',
	BASE_DESP_ADV_CNT_MTH_SUM COMMENT 'Total number of despatch advices per calendar month',
	BASE_DESP_ADV_CNT_MTH_CUM COMMENT 'Running total number of despatch advices within a business year cumulated after every calendar month',
	BASE_DESP_ADV_CNT_MTH_SUM_PY COMMENT 'Total number of despatch advices of the calendar month of the previous business year (mapped to the current month)',
	BASE_DESP_ADV_CNT_MTH_CUM_PY COMMENT 'Total number of despatch advices cumulated after every calendar month within the previous business year (mapped to the current month)',
	USABLE_DESP_ADV_CNT_MTH_SUM COMMENT 'Total number of usable despatch advices per calendar month',
	USABLE_DESP_ADV_CNT_MTH_CUM COMMENT 'Running total number of usable despatch advices within a business year cumulated after every calendar month',
	USABLE_DESP_ADV_CNT_MTH_SUM_PY COMMENT 'Total number of usable despatch advices of the calendar month of the previuos business year (mapped to the current month)',
	USABLE_DESP_ADV_CNT_MTH_CUM_PY COMMENT 'Running total number of usable despatch advices cumulated after every calendar month whint the previous business year (mapped to the current month)',
	BASE_WH_RCVG_ALL_CNT_MTH_SUM COMMENT 'Total number of item receipts (All) per calendar month',
	BASE_WH_RCVG_ALL_CNT_MTH_CUM COMMENT 'Running total number of item receipts (All) within a business year cumulated after every calendar month',
	BASE_WH_RCVG_ALL_CNT_MTH_SUM_PY COMMENT 'Total number of item receipts (All) of the calendar month of the previous business year (mapped to the current month)',
	BASE_WH_RCVG_ALL_CNT_MTH_CUM_PY COMMENT 'Total number of item receipts (All) cumulated after every calendar month within the previous business year (mapped to the current month)',
	BASE_WH_RCVG_EDI_CNT_MTH_SUM COMMENT 'Total number of item receipts (EDI) per calendar month',
	BASE_WH_RCVG_EDI_CNT_MTH_CUM COMMENT 'Running total number of item receipts (EDI) within a business year cumulated after every calendar month',
	BASE_WH_RCVG_EDI_CNT_MTH_SUM_PY COMMENT 'Total number of item receipts (EDI) of the calendar week of the previous business year (mapped to the current month)',
	BASE_WH_RCVG_EDI_CNT_MTH_CUM_PY COMMENT 'Total number of item receipts (EDI) cumulated after every calendar month within the previous business year (mapped to the current month)',
	BASE_ITEM_RCVG_CNT_MTH_SUM COMMENT 'Total number of item receiving countings per calendar month',
	BASE_ITEM_RCVG_CNT_MTH_CUM COMMENT 'Running total number of item receiving countings within a business year cumulated after every calendar month',
	BASE_ITEM_RCVG_CNT_MTH_SUM_PY COMMENT 'Total number of item receiving countings of the calendar month of the previous business year (mapped to the current month)',
	BASE_ITEM_RCVG_CNT_MTH_CUM_PY COMMENT 'Total number of item receiving countings cumulated after every calendar month within the previous business year (mapped to the current month)',
	TGT_RATE_ADV_OVERALL_ALL COMMENT 'DESADV overall target rate for All per country and business year',
	TGT_RATE_ADV_OVERALL_EDI COMMENT 'DESADV overall target rate for EDI per country and business year',
	TGT_RATE_ADV_AVAIL_ALL COMMENT 'DESADV availability target rate for All per country and business year',
	TGT_RATE_ADV_AVAIL_EDI COMMENT 'DESADV availability target rate for EDI per country and business year',
	TGT_RATE_ADV_USAGE COMMENT 'DESADV usage target rate per country and business year'
) COMMENT='View with cumulated facts for Month - MIS Lead / 02 Prozesse / 021103 Ware umschlagen / EDI/ DESADV Kennzahlen'
AS
SELECT 
	client_id
	,ctry_grp_id
	,aspect_id
	,wh_id
	,wh_loc_sid
	,sup_sid
	,gl_loc_nr
	,sup_name
	,byr
	,cy_month
	,byr_py
	,cy_month_py
	,byr_seq
	,cy_month_seq
	,base_desp_adv_cnt_mth_sum
	,base_desp_adv_cnt_mth_cum
	,base_desp_adv_cnt_mth_sum_py
	,base_desp_adv_cnt_mth_cum_py
	,usable_desp_adv_cnt_mth_sum
	,usable_desp_adv_cnt_mth_cum
	,usable_desp_adv_cnt_mth_sum_py
	,usable_desp_adv_cnt_mth_cum_py
	,base_wh_rcvg_all_cnt_mth_sum
	,base_wh_rcvg_all_cnt_mth_cum
	,base_wh_rcvg_all_cnt_mth_sum_py
	,base_wh_rcvg_all_cnt_mth_cum_py
	,base_wh_rcvg_edi_cnt_mth_sum
	,base_wh_rcvg_edi_cnt_mth_cum
	,base_wh_rcvg_edi_cnt_mth_sum_py
	,base_wh_rcvg_edi_cnt_mth_cum_py
	,base_item_rcvg_cnt_mth_sum
	,base_item_rcvg_cnt_mth_cum
	,base_item_rcvg_cnt_mth_sum_py
	,base_item_rcvg_cnt_mth_cum_py
	,tgt_rate_adv_overall_all
	,tgt_rate_adv_overall_edi
	,tgt_rate_adv_avail_all
	,tgt_rate_adv_avail_edi
	,tgt_rate_adv_usage
FROM p_lew_mart_lead.v_edi_desadv_cum_mth
;
