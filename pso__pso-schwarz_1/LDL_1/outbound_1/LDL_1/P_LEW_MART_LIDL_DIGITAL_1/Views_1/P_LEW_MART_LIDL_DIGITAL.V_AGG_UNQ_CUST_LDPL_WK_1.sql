CREATE OR REPLACE VIEW ldl_p_lew_mart_lidl_digital.v_agg_unq_cust_ldpl_wk_1 (aspect_id
OPTIONS(description='Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'), client_id
OPTIONS(description='DWH-Mandant_1; FK auf CLIENT'), cy_week
OPTIONS(description='Lidl+ : Week value (-1 means data is not at month level)'), harmo_cal_week_no
OPTIONS(description='Harmonized week no per country_1 - week since rollout'), move_to_store_id
OPTIONS(description='Lidl Store Id'), wh_id OPTIONS(description='Warehouse ID'), customer_sid
OPTIONS(description='Surrogate Key CUSTOMER'), lidlplus_cust_fg OPTIONS(description='Lidl Plus Customer Flag'),
adjust_growth_fg OPTIONS(description='Adjust growth flag - berenigte steigerung'), wk_rf_segment_sid
OPTIONS(description='Recency-frequency segments id - used (client_id + loc_sid(LU), customer_sid, cy_month) to select t_cust_rfm_segment_mth.mth_rf_segment_sid'),
wk_m_segment_sid
OPTIONS(description='Monetary segments id - used (client_id + loc_sid(LU), customer_sid, cy_month) to select t_cust_rfm_segment_mth.mth_m_segment_sid'),
wk_st_segment_sid
OPTIONS(description='STRATEGIC segments id - used (client_id + loc_sid(LU), customer_sid, cy_month) to select t_cust_rfm_segment_mth.mth_m_segment_sid'),
wk_fr_segment_sid
OPTIONS(description='FREQUENCY segments id - used (client_id + loc_sid(LU), customer_sid, cy_month) to select t_cust_rfm_segment_mth.mth_m_segment_sid'),
wk_re_segment_sid
OPTIONS(description='RECENCY segments id - used (client_id + loc_sid(LU), customer_sid, cy_month) to select t_cust_rfm_segment_mth.mth_m_segment_sid'),
wk_mo_segment_sid
OPTIONS(description='new Monetary segments id - used (client_id + loc_sid(LU), customer_sid, cy_month) to select t_cust_rfm_segment_mth.mth_m_segment_sid'),
currency_iso_cd OPTIONS(description='iso code for the clients (countrys) currency'), curr_tot_id
OPTIONS(description='Fixe Werte fur EUR=0, GBP=40 sonst Client_Id'), gender_cd
OPTIONS(description='The code for the gender'), age_range_cd OPTIONS(description='The code for the age range.'),
cw_cust_act OPTIONS(description='Current Week Customer Active flag 1 for active 0 for not active'), pw_cust_act
OPTIONS(description='Previous Week Customer Active flag 1 for active 0 for not active'), pyw_cust_act
OPTIONS(description='Previous Year Week Customer Active flag 1 for active 0 for not active'), cw_wk_str_open_fg
OPTIONS(description='Store open flag : Current week'), cw_rcpts_cnt OPTIONS(description='Receipts count : Current week'),
pw_wk_str_open_fg OPTIONS(description='Store open flag : Previous week'), pw_rcpts_cnt
OPTIONS(description='Receipts count : Previous week'), pyw_wk_str_open_fg
OPTIONS(description='Store open flag : Previous year week'), pyw_rcpts_cnt
OPTIONS(description='Receipts count : Previous year week'), load_id OPTIONS(description='Load identifier'), dwh_created
OPTIONS(description='Row create time'), dwh_updated OPTIONS(description='Row update time')) AS SELECT F.aspect_id,
 F.client_id,
 F.cy_week,
 F.harmo_cal_week_no,
 F.move_to_store_id,
 F.wh_id,
 F.customer_sid,
 F.lidlplus_cust_fg,
 F.adjust_growth_fg,
 F.wk_rf_segment_sid,
 F.wk_m_segment_sid,
 F.wk_st_segment_sid,
 F.wk_fr_segment_sid,
 F.wk_re_segment_sid,
 F.wk_mo_segment_sid,
 F.currency_iso_cd,
 F.curr_tot_id,
 COALESCE(D.gender_cd, 'N/A') AS gender_cd,
 COALESCE(D.age_range_cd, 'N/A') AS age_range_cd,
 F.cw_cust_act,
 F.pw_cust_act,
 F.pyw_cust_act,
 F.cw_wk_str_open_fg,
 F.cw_rcpts_cnt,
 F.pw_wk_str_open_fg,
 F.pw_rcpts_cnt,
 F.pyw_wk_str_open_fg,
 F.pyw_rcpts_cnt,
 F.load_id,
 F.dwh_created,
 F.dwh_updated
FROM ldl_p_lew_mart_lidl_digital.t_agg_unq_cust_ldpl_wk_1 AS F
 LEFT JOIN ldl_p_lew_mart_lidl_digital.t_cust_demogr_1 AS D ON F.customer_sid = D.customer_sid AND F.lidlplus_cust_fg =
   'Y';