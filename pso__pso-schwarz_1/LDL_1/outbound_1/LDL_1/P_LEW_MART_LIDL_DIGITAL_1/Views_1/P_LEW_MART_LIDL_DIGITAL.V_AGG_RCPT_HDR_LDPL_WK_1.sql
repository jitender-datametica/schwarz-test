CREATE OR REPLACE VIEW ldl_p_lew_mart_lidl_digital.v_agg_rcpt_hdr_ldpl_wk_1 (aspect_id
OPTIONS(description='Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'), client_id
OPTIONS(description='Identifier for client'), move_to_store_id OPTIONS(description='Store ID'), wh_id
OPTIONS(description='Warehouse ID'), lidlplus_cust_fg OPTIONS(description='Lidplus customer flag'), adjust_growth_fg
OPTIONS(description='Adjust growth flag - berenigte steigerung'), wk_rf_segment_sid
OPTIONS(description='Recency-frequency segments id - used (client_id + loc_sid(LU), customer_sid, cy_month) to select t_cust_rfm_segment_wk.wk_rf_segment_sid'),
wk_m_segment_sid
OPTIONS(description='Monetary segments id - used (client_id + loc_sid(LU), customer_sid, cy_month) to select t_cust_rfm_segment_wk.wk_m_segment_sid'),
wk_st_segment_sid
OPTIONS(description='STRATEGIC segments id - used (client_id + loc_sid(LU), customer_sid, cy_month) to select t_cust_rfm_segment_wk.wk_m_segment_sid'),
wk_fr_segment_sid
OPTIONS(description='FREQUENCY segments id - used (client_id + loc_sid(LU), customer_sid, cy_month) to select t_cust_rfm_segment_wk.wk_m_segment_sid'),
wk_re_segment_sid
OPTIONS(description='RECENCY segments id - used (client_id + loc_sid(LU), customer_sid, cy_month) to select t_cust_rfm_segment_wk.wk_m_segment_sid'),
wk_mo_segment_sid
OPTIONS(description='new Monetary segments id - used (client_id + loc_sid(LU), customer_sid, cy_month) to select t_cust_rfm_segment_wk.wk_m_segment_sid'),
cy_week OPTIONS(description='Week number'), harmo_cal_week_no
OPTIONS(description='Harmonized week no per country_1 - week since rollout'), currency_iso_cd
OPTIONS(description='ISO code for the currency of the client.'), curr_tot_id
OPTIONS(description='Fixe Werte fur EUR=0 GBP=40 sonst Client_Id'), pcwo_reason_id
OPTIONS(description='Unique ID of the write-off or Price change reason. Country_1-specific write-off reasons have ID>100.'),
coupon_reason_nr OPTIONS(description='Identifier of the booking reason in SCRM'), gender_cd
OPTIONS(description='The code for the geder'), age_range_cd OPTIONS(description='The code for the age range.'),
cw_wk_str_open_fg OPTIONS(description='Store open flag : Current week'), cw_tot_gros_val
OPTIONS(description='Total gross value : Current week'), cw_tot_net_val
OPTIONS(description='Total net value : Current week'), cw_rcpts_cnt OPTIONS(description='Receipts count : Current week'),
cw_tot_rcpt_cnt_wk OPTIONS(description='Total receipts count : Current week'), cw_trans_time_in_mins
OPTIONS(description='Transaction time measured in minutes : Current week'), cw_items_scanned_cnt
OPTIONS(description='Number of items scanned : Current week'), cw_new_reg_cnt OPTIONS(description='Null measure'),
cw_dereg_cnt OPTIONS(description='Null measure'), cw_tot_reg_cnt OPTIONS(description='Null measure'), cw_discount_val
OPTIONS(description='Discount value : Current week'), cw_writeoff_val
OPTIONS(description='Writeoff net value: Current week'), pw_wk_str_open_fg
OPTIONS(description='Store open flag : Previous week'), pw_tot_gros_val
OPTIONS(description='Total gross value : Previous week'), pw_tot_net_val
OPTIONS(description='Total net value : Previous week'), pw_rcpts_cnt
OPTIONS(description='Receipts count : Previous week'), pw_tot_rcpt_cnt_wk
OPTIONS(description='Total eceipts count : Previous week'), pw_trans_time_in_mins
OPTIONS(description='Transaction time measured in minutes : Previous week'), pw_items_scanned_cnt
OPTIONS(description='Number of items scanned : Previous week'), pw_new_reg_cnt OPTIONS(description='Null measure'),
pw_dereg_cnt OPTIONS(description='Null measure'), pw_tot_reg_cnt OPTIONS(description='Null measure'), pw_discount_val
OPTIONS(description='Discount value : Previous week'), pw_writeoff_val
OPTIONS(description='Writeoff net value: Previous week'), pyw_wk_str_open_fg
OPTIONS(description='Store open flag : Previous year week'), pyw_tot_gros_val
OPTIONS(description='Total gross value : Previous year week'), pyw_tot_net_val
OPTIONS(description='Total net value : Previous year week week'), pyw_rcpts_cnt
OPTIONS(description='Receipts count : Previous year week'), pyw_tot_rcpt_cnt_wk
OPTIONS(description='Total receipts count : Previous year week'), pyw_trans_time_in_mins
OPTIONS(description='Transaction time measured in minutes : Previous year week'), pyw_items_scanned_cnt
OPTIONS(description='Number of items scanned : Previous year week'), pyw_new_reg_cnt OPTIONS(description='Null measure'),
pyw_dereg_cnt OPTIONS(description='Null measure'), pyw_tot_reg_cnt OPTIONS(description='Null measure'), pyw_discount_val
OPTIONS(description='Discount value : Previous year week'), pyw_writeoff_val
OPTIONS(description='Writeoff net value: Previous week'), load_id OPTIONS(description='Load identifier'), dwh_created
OPTIONS(description='Row create time'), dwh_updated OPTIONS(description='Row update time')) AS SELECT aspect_id,
 client_id,
 move_to_store_id,
 wh_id,
 lidlplus_cust_fg,
 adjust_growth_fg,
 wk_rf_segment_sid,
 wk_m_segment_sid,
 wk_st_segment_sid,
 wk_fr_segment_sid,
 wk_re_segment_sid,
 wk_mo_segment_sid,
 cy_week,
 harmo_cal_week_no,
 currency_iso_cd,
 curr_tot_id,
 pcwo_reason_id,
 coupon_reason_nr,
 gender_cd,
 age_range_cd,
 cw_wk_str_open_fg,
 cw_tot_gros_val,
 cw_tot_net_val,
 cw_rcpts_cnt,
 cw_tot_rcpt_cnt_wk,
 cw_trans_time_in_mins,
 cw_items_scanned_cnt,
 CAST(NULL AS INTEGER) AS cw_new_reg_cnt,
 CAST(NULL AS INTEGER) AS cw_dereg_cnt,
 CAST(NULL AS INTEGER) AS cw_tot_reg_cnt,
 cw_discount_val,
 cw_writeoff_val,
 pw_wk_str_open_fg,
 pw_tot_gros_val,
 pw_tot_net_val,
 pw_rcpts_cnt,
 pw_tot_rcpt_cnt_wk,
 pw_trans_time_in_mins,
 pw_items_scanned_cnt,
 CAST(NULL AS INTEGER) AS pw_new_reg_cnt,
 CAST(NULL AS INTEGER) AS pw_dereg_cnt,
 CAST(NULL AS INTEGER) AS pw_tot_reg_cnt,
 pw_discount_val,
 pw_writeoff_val,
 pyw_wk_str_open_fg,
 pyw_tot_gros_val,
 pyw_tot_net_val,
 pyw_rcpts_cnt,
 pyw_tot_rcpt_cnt_wk,
 pyw_trans_time_in_mins,
 pyw_items_scanned_cnt,
 CAST(NULL AS INTEGER) AS pyw_new_reg_cnt,
 CAST(NULL AS INTEGER) AS pyw_dereg_cnt,
 CAST(NULL AS INTEGER) AS pyw_tot_reg_cnt,
 pyw_discount_val,
 pyw_writeoff_val,
 load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_mart_lidl_digital.t_agg_rcpt_hdr_ldpl_wk_1 AS RH;