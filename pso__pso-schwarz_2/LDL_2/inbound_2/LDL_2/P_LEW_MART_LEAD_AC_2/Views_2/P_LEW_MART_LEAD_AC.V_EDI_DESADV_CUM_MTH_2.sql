CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_EDI_DESADV_CUM_MTH_2(
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
FROM p_lew_mart_lead.v_edi_desadv_cum_mth_2
;
