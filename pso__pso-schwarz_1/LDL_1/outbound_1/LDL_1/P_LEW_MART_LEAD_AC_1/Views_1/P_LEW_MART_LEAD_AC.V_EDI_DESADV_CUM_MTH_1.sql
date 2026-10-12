CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_edi_desadv_cum_mth_1 (client_id OPTIONS(description='Client ID'),
ctry_grp_id OPTIONS(description='Country_1 group ID'), aspect_id
OPTIONS(description='Aspect ID (1=Betriebsgesellschaft, 2=Vertriebsgesellschaft)'), wh_id
OPTIONS(description='Warehouse ID'), wh_loc_sid OPTIONS(description='Location_1 surrogate ID'), sup_sid
OPTIONS(description='Supplier_1 surrogate ID'), gl_loc_nr OPTIONS(description='Supplier_1 global location_1 number'), sup_name
OPTIONS(description='Supplier_1 name'), byr OPTIONS(description='Current business year of the record'), cy_month
OPTIONS(description='Current calendar_1 week of the record'), byr_py
OPTIONS(description='Business year in previous calendar_1 year'), cy_month_py
OPTIONS(description='Calendar_1 week in previous calendar_1 year'), byr_seq
OPTIONS(description='Sequence for business year'), cy_month_seq OPTIONS(description='Sequence for calendar_1 week'),
base_desp_adv_cnt_mth_sum OPTIONS(description='Total number of despatch advices per calendar_1 month'),
base_desp_adv_cnt_mth_cum
OPTIONS(description='Running total number of despatch advices within a business year cumulated after every calendar_1 month'),
base_desp_adv_cnt_mth_sum_py
OPTIONS(description='Total number of despatch advices of the calendar_1 month of the previous business year (mapped to the current month)'),
base_desp_adv_cnt_mth_cum_py
OPTIONS(description='Total number of despatch advices cumulated after every calendar_1 month within the previous business year (mapped to the current month)'),
usable_desp_adv_cnt_mth_sum OPTIONS(description='Total number of usable despatch advices per calendar_1 month'),
usable_desp_adv_cnt_mth_cum
OPTIONS(description='Running total number of usable despatch advices within a business year cumulated after every calendar_1 month'),
usable_desp_adv_cnt_mth_sum_py
OPTIONS(description='Total number of usable despatch advices of the calendar_1 month of the previuos business year (mapped to the current month)'),
usable_desp_adv_cnt_mth_cum_py
OPTIONS(description='Running total number of usable despatch advices cumulated after every calendar_1 month whint the previous business year (mapped to the current month)'),
base_wh_rcvg_all_cnt_mth_sum OPTIONS(description='Total number of item_1 receipts (All) per calendar_1 month'),
base_wh_rcvg_all_cnt_mth_cum
OPTIONS(description='Running total number of item_1 receipts (All) within a business year cumulated after every calendar_1 month'),
base_wh_rcvg_all_cnt_mth_sum_py
OPTIONS(description='Total number of item_1 receipts (All) of the calendar_1 month of the previous business year (mapped to the current month)'),
base_wh_rcvg_all_cnt_mth_cum_py
OPTIONS(description='Total number of item_1 receipts (All) cumulated after every calendar_1 month within the previous business year (mapped to the current month)'),
base_wh_rcvg_edi_cnt_mth_sum OPTIONS(description='Total number of item_1 receipts (EDI) per calendar_1 month'),
base_wh_rcvg_edi_cnt_mth_cum
OPTIONS(description='Running total number of item_1 receipts (EDI) within a business year cumulated after every calendar_1 month'),
base_wh_rcvg_edi_cnt_mth_sum_py
OPTIONS(description='Total number of item_1 receipts (EDI) of the calendar_1 week of the previous business year (mapped to the current month)'),
base_wh_rcvg_edi_cnt_mth_cum_py
OPTIONS(description='Total number of item_1 receipts (EDI) cumulated after every calendar_1 month within the previous business year (mapped to the current month)'),
base_item_rcvg_cnt_mth_sum OPTIONS(description='Total number of item_1 receiving countings per calendar_1 month'),
base_item_rcvg_cnt_mth_cum
OPTIONS(description='Running total number of item_1 receiving countings within a business year cumulated after every calendar_1 month'),
base_item_rcvg_cnt_mth_sum_py
OPTIONS(description='Total number of item_1 receiving countings of the calendar_1 month of the previous business year (mapped to the current month)'),
base_item_rcvg_cnt_mth_cum_py
OPTIONS(description='Total number of item_1 receiving countings cumulated after every calendar_1 month within the previous business year (mapped to the current month)'),
tgt_rate_adv_overall_all OPTIONS(description='DESADV overall target rate for All per country_1 and business year'),
tgt_rate_adv_overall_edi OPTIONS(description='DESADV overall target rate for EDI per country_1 and business year'),
tgt_rate_adv_avail_all OPTIONS(description='DESADV availability target rate for All per country_1 and business year'),
tgt_rate_adv_avail_edi OPTIONS(description='DESADV availability target rate for EDI per country_1 and business year'),
tgt_rate_adv_usage OPTIONS(description='DESADV usage target rate per country_1 and business year'))
OPTIONS(DESCRIPTION = `VIEW WITH CUMULATED FACTS FOR MONTH - MIS LEAD / 02 PROZESSE / 021103 WARE UMSCHLAGEN / EDI/ DESADV KENNZAHLEN`)
AS SELECT *
FROM ldl_p_lew_mart_lead.v_edi_desadv_cum_mth_1;