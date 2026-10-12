CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_edi_desadv_cum_mth (client_id OPTIONS(description='Client ID'),
ctry_grp_id OPTIONS(description='Country group ID'), aspect_id
OPTIONS(description='Aspect ID (1=Betriebsgesellschaft, 2=Vertriebsgesellschaft)'), wh_id
OPTIONS(description='Warehouse ID'), wh_loc_sid OPTIONS(description='Location surrogate ID'), sup_sid
OPTIONS(description='Supplier surrogate ID'), gl_loc_nr OPTIONS(description='Supplier global location number'), sup_name
OPTIONS(description='Supplier name'), byr OPTIONS(description='Current business year of the record'), cy_month
OPTIONS(description='Current calendar week of the record'), byr_py
OPTIONS(description='Business year in previous calendar year'), cy_month_py
OPTIONS(description='Calendar week in previous calendar year'), byr_seq
OPTIONS(description='Sequence for business year'), cy_month_seq OPTIONS(description='Sequence for calendar week'),
base_desp_adv_cnt_mth_sum OPTIONS(description='Total number of despatch advices per calendar month'),
base_desp_adv_cnt_mth_cum
OPTIONS(description='Running total number of despatch advices within a business year cumulated after every calendar month'),
base_desp_adv_cnt_mth_sum_py
OPTIONS(description='Total number of despatch advices of the calendar month of the previous business year (mapped to the current month)'),
base_desp_adv_cnt_mth_cum_py
OPTIONS(description='Total number of despatch advices cumulated after every calendar month within the previous business year (mapped to the current month)'),
usable_desp_adv_cnt_mth_sum OPTIONS(description='Total number of usable despatch advices per calendar month'),
usable_desp_adv_cnt_mth_cum
OPTIONS(description='Running total number of usable despatch advices within a business year cumulated after every calendar month'),
usable_desp_adv_cnt_mth_sum_py
OPTIONS(description='Total number of usable despatch advices of the calendar month of the previuos business year (mapped to the current month)'),
usable_desp_adv_cnt_mth_cum_py
OPTIONS(description='Running total number of usable despatch advices cumulated after every calendar month whint the previous business year (mapped to the current month)'),
base_wh_rcvg_all_cnt_mth_sum OPTIONS(description='Total number of item receipts (All) per calendar month'),
base_wh_rcvg_all_cnt_mth_cum
OPTIONS(description='Running total number of item receipts (All) within a business year cumulated after every calendar month'),
base_wh_rcvg_all_cnt_mth_sum_py
OPTIONS(description='Total number of item receipts (All) of the calendar month of the previous business year (mapped to the current month)'),
base_wh_rcvg_all_cnt_mth_cum_py
OPTIONS(description='Total number of item receipts (All) cumulated after every calendar month within the previous business year (mapped to the current month)'),
base_wh_rcvg_edi_cnt_mth_sum OPTIONS(description='Total number of item receipts (EDI) per calendar month'),
base_wh_rcvg_edi_cnt_mth_cum
OPTIONS(description='Running total number of item receipts (EDI) within a business year cumulated after every calendar month'),
base_wh_rcvg_edi_cnt_mth_sum_py
OPTIONS(description='Total number of item receipts (EDI) of the calendar week of the previous business year (mapped to the current month)'),
base_wh_rcvg_edi_cnt_mth_cum_py
OPTIONS(description='Total number of item receipts (EDI) cumulated after every calendar month within the previous business year (mapped to the current month)'),
base_item_rcvg_cnt_mth_sum OPTIONS(description='Total number of item receiving countings per calendar month'),
base_item_rcvg_cnt_mth_cum
OPTIONS(description='Running total number of item receiving countings within a business year cumulated after every calendar month'),
base_item_rcvg_cnt_mth_sum_py
OPTIONS(description='Total number of item receiving countings of the calendar month of the previous business year (mapped to the current month)'),
base_item_rcvg_cnt_mth_cum_py
OPTIONS(description='Total number of item receiving countings cumulated after every calendar month within the previous business year (mapped to the current month)'),
tgt_rate_adv_overall_all OPTIONS(description='DESADV overall target rate for All per country and business year'),
tgt_rate_adv_overall_edi OPTIONS(description='DESADV overall target rate for EDI per country and business year'),
tgt_rate_adv_avail_all OPTIONS(description='DESADV availability target rate for All per country and business year'),
tgt_rate_adv_avail_edi OPTIONS(description='DESADV availability target rate for EDI per country and business year'),
tgt_rate_adv_usage OPTIONS(description='DESADV usage target rate per country and business year'))
OPTIONS(DESCRIPTION = `VIEW WITH CUMULATED FACTS FOR MONTH - MIS LEAD / 02 PROZESSE / 021103 WARE UMSCHLAGEN / EDI/ DESADV KENNZAHLEN`)
AS SELECT *
FROM ldl_p_lew_mart_lead.v_edi_desadv_cum_mth;