/*
===================================================================================================================================
Division		|	Lidl
Solution		|	Enterprise Logistics
DB schema		|	p_lew_mart_lead_ac
DB view			|	v_edi_desadv_cum_wk_1
Description		|	Access view with aggregated facts - MIS Lead / 02 Prozesse / 021103 Ware umschlagen / EDI/DESADV Kennzahlen
===================================================================================================================================
*/

-- The aggregation level for all data is client_id, aspect_id (warehouse type), wh_id, sup_sid, business year and calendar_1 week.


/* , base_item_rcvg_cnt_wk_sum_diff_abs
	, base_item_rcvg_cnt_wk_sum_diff_rel
	, base_item_rcvg_cnt_wk_cum_diff_abs
	, base_item_rcvg_cnt_wk_cum_diff_rel */
/* , base_wh_rcvg_edi_cnt_wk_sum_diff_abs
	, base_wh_rcvg_edi_cnt_wk_sum_diff_rel
	, base_wh_rcvg_edi_cnt_wk_cum_diff_abs
	, base_wh_rcvg_edi_cnt_wk_cum_diff_rel */
/* , base_wh_rcvg_all_cnt_wk_sum_diff_abs
	, base_wh_rcvg_all_cnt_wk_sum_diff_rel
	, base_wh_rcvg_all_cnt_wk_cum_diff_abs
	, base_wh_rcvg_all_cnt_wk_cum_diff_rel */
/* , base_desp_adv_cnt_wk_sum_diff_abs
	, base_desp_adv_cnt_wk_sum_diff_rel
	, base_desp_adv_cnt_wk_cum_diff_abs
	, base_desp_adv_cnt_wk_cum_diff_rel */
/* , rate_desadv_overall_all_act
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
	, rate_desadv_cap_edi_diff_py_cum */
CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_edi_desadv_cum_wk_1 (client_id OPTIONS(description='Client ID'),
ctry_grp_id OPTIONS(description='Country_1 group ID'), aspect_id
OPTIONS(description='Aspect ID (1=Betriebsgesellschaft, 2=Vertriebsgesellschaft)'), wh_id
OPTIONS(description='Warehouse ID'), wh_loc_sid OPTIONS(description='Location_1 surrogate ID'), sup_sid
OPTIONS(description='Supplier_1 surrogate ID'), gl_loc_nr OPTIONS(description='Supplier_1 global location_1 number'), sup_name
OPTIONS(description='Supplier_1 name'), byr OPTIONS(description='Current business year of the record'), cy_week
OPTIONS(description='Current calendar_1 week of the record'), byr_py
OPTIONS(description='Business year in previous calendar_1 year'), cy_week_py
OPTIONS(description='Calendar_1 week in previous calendar_1 year'), byr_seq
OPTIONS(description='Sequence for business year'), cy_week_seq OPTIONS(description='Sequence for calendar_1 week'),
base_desp_adv_cnt_wk_sum OPTIONS(description='Total number of despatch advices per calendar_1 week'),
base_desp_adv_cnt_wk_cum
OPTIONS(description='Running total number of despatch advices within a business year cumulated after every calendar_1 week'),
base_desp_adv_cnt_wk_sum_py
OPTIONS(description='Total number of despatch advices of the calendar_1 week of the previous business year (mapped to the current week)'),
base_desp_adv_cnt_wk_cum_py
OPTIONS(description='Total number of despatch advices cumulated after every calendar_1 week within the previous business year (mapped to the current week)'),
usable_desp_adv_cnt_wk_sum OPTIONS(description='Total number of usable despatch adviecs per calendar_1 week'),
usable_desp_adv_cnt_wk_cum
OPTIONS(description='Running total number of usable despatch advices within a business year cumulated after every calendar_1 week'),
usable_desp_adv_cnt_wk_sum_py
OPTIONS(description='Total number of usable despatch advices of the calendar_1 week of the previous business year (mapped to th ecurrent week)'),
usable_desp_adv_cnt_wk_cum_py
OPTIONS(description='Total number of usable despatch advices cumulated after every calendar_1 week within the previous business year (mapped to the current week)'),
base_wh_rcvg_all_cnt_wk_sum OPTIONS(description='Total number of item_1 receipts (All) per calendar_1 week'),
base_wh_rcvg_all_cnt_wk_cum
OPTIONS(description='Running total number of item_1 receipts (All) within a business year cumulated after every calendar_1 week'),
base_wh_rcvg_all_cnt_wk_sum_py
OPTIONS(description='Total number of item_1 receipts (All) of the calendar_1 week of the previous business year (mapped to the current week)'),
base_wh_rcvg_all_cnt_wk_cum_py
OPTIONS(description='Total number of item_1 receipts (All) cumulated after every calendar_1 week within the previous business year (mapped to the current week)'),
base_wh_rcvg_edi_cnt_wk_sum OPTIONS(description='Total number of item_1 receipts (EDI) per calendar_1 week'),
base_wh_rcvg_edi_cnt_wk_cum
OPTIONS(description='Running total number of item_1 receipts (EDI) within a business year cumulated after every calendar_1 week'),
base_wh_rcvg_edi_cnt_wk_sum_py
OPTIONS(description='Total number of item_1 receipts (EDI) of the calendar_1 week of the previous business year (mapped to the current week)'),
base_wh_rcvg_edi_cnt_wk_cum_py
OPTIONS(description='Total number of item_1 receipts (EDI) cumulated after every calendar_1 week within the previous business year (mapped to the current week)'),
base_item_rcvg_cnt_wk_sum OPTIONS(description='Total number of item_1 receiving countings per calendar_1 week'),
base_item_rcvg_cnt_wk_cum
OPTIONS(description='Running total number of item_1 receiving countings within a business year cumulated after every calendar_1 week'),
base_item_rcvg_cnt_wk_sum_py
OPTIONS(description='Total number of item_1 receiving countings of the calendar_1 week of the previous business year (mapped to the current week)'),
base_item_rcvg_cnt_wk_cum_py
OPTIONS(description='Total number of item_1 receiving countings cumulated after every calendar_1 week within the previous business year (mapped to the current week)'),
tgt_rate_adv_overall_all OPTIONS(description='DESADV overall target rate for All per country_1 and business year'),
tgt_rate_adv_overall_edi OPTIONS(description='DESADV overall target rate for EDI per country_1 and business year'),
tgt_rate_adv_avail_all OPTIONS(description='DESADV availability target rate for All per country_1 and business year'),
tgt_rate_adv_avail_edi OPTIONS(description='DESADV availability target rate for EDI per country_1 and business year'),
tgt_rate_adv_usage OPTIONS(description='DESADV usage target rate per country_1 and business year'))
OPTIONS(DESCRIPTION = `ACCESS VIEW WITH AGGREGATED FACTS - MIS LEAD / 02 PROZESSE / 021103 WARE UMSCHLAGEN / EDI/DESADV KENNZAHLEN`)
AS SELECT *
FROM ldl_p_lew_mart_lead.v_edi_desadv_cum_wk_1;