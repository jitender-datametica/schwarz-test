CREATE OR REPLACE VIEW ldl_p_lew_mart_lidl_digital_ac.v_agg_unq_cust_ldpl_mth_2 (aspect_id
OPTIONS(description='Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'), client_id
OPTIONS(description='DWH-Mandant_2; FK auf CLIENT'), cy_month
OPTIONS(description='Lidl+ : Month value (-1 means data is not at month level)'), harmo_cal_month_no
OPTIONS(description='Harmonized month no  per country_2 - month since rollout'), move_to_store_id
OPTIONS(description='Lidl Store Id'), wh_id OPTIONS(description='Warehouse ID'), customer_sid
OPTIONS(description='Surrogate Key CUSTOMER'), lidlplus_cust_fg OPTIONS(description='Lidl Plus Customer Flag'),
adjust_growth_fg OPTIONS(description='Adjust growth flag - berenigte steigerung'), mth_rf_segment_sid
OPTIONS(description='Recency-frequency segments id - used (client_id + loc_sid(LU), customer_sid, cy_month) to select t_cust_rfm_segment_mth.mth_rf_segment_sid'),
mth_m_segment_sid
OPTIONS(description='Monetary Segment Id - used (client_id + loc_sid(LU), customer_sid, cy_month) to select t_cust_m_segment_mth.mth_m_segment_sid'),
mth_st_segment_sid
OPTIONS(description='new strategic Segment Id - used (client_id + loc_sid(LU), customer_sid, cy_month) to select t_cust_m_segment_mth.mth_m_segment_sid'),
mth_fr_segment_sid
OPTIONS(description='new frequency Segment Id - used (client_id + loc_sid(LU), customer_sid, cy_month) to select t_cust_m_segment_mth.mth_m_segment_sid'),
mth_re_segment_sid
OPTIONS(description='new Recency Segment Id - used (client_id + loc_sid(LU), customer_sid, cy_month) to select t_cust_m_segment_mth.mth_m_segment_sid'),
mth_mo_segment_sid
OPTIONS(description='new Monetary Segment Id - used (client_id + loc_sid(LU), customer_sid, cy_month) to select t_cust_m_segment_mth.mth_m_segment_sid'),
busyear_qtr_rf_segment_sid
OPTIONS(description='Recency-frequency segments id - used (client_id + loc_sid(LU), customer_sid, cy_month) to select t_cust_rfm_segment_busyear_qtr.busyear_qtr_rf_segment_sid'),
busyear_qtr_m_segment_sid
OPTIONS(description='Monetary Segment Id - used (client_id + loc_sid(LU), customer_sid, cy_month) to select t_cust_m_segment_busyear_qtr.busyear_m_segment_sid'),
currency_iso_cd OPTIONS(description='iso code for the clients (countrys) currency'), curr_tot_id
OPTIONS(description='Fixe Werte fur EUR=0, GBP=40 sonst Client_Id'), gender_cd
OPTIONS(description='The code for the gender'), age_range_cd OPTIONS(description='The code for the age range.'),
household_type_id OPTIONS(description='ID of the household type in which the customer lives.'), child_age_range_group_id
OPTIONS(description='Group of one or more age ranges in which the child is categorized depending on the age.'),
cm_cust_act OPTIONS(description='Current Month Customer Active flag 1 for active 0 for not active'), pm_cust_act
OPTIONS(description='Previous Month Customer Active flag 1 for active 0 for not active'), pym_cust_act
OPTIONS(description='Previous Year Month Customer Active flag 1 for active 0 for not active'), cm_mth_str_open_fg
OPTIONS(description='Store open flag : Current month'), cm_rcpts_cnt
OPTIONS(description='Receipts count : Current month'), pm_mth_str_open_fg
OPTIONS(description='Store open flag : Previous month'), pm_rcpts_cnt
OPTIONS(description='Receipts count : Previous month'), pym_mth_str_open_fg
OPTIONS(description='Store open flag : Previous year month'), pym_rcpts_cnt
OPTIONS(description='Receipts count : Previous year month'), load_id OPTIONS(description='Load identifier'), dwh_created
OPTIONS(description='Row create time'), dwh_updated OPTIONS(description='Row update time')) AS SELECT CASE
  WHEN move_to_store_id = 0
  THEN 0
  ELSE aspect_id
  END AS aspect_id,
 client_id,
 cy_month,
 harmo_cal_month_no,
 move_to_store_id,
 wh_id,
 customer_sid,
 lidlplus_cust_fg,
 adjust_growth_fg,
 mth_rf_segment_sid,
 mth_m_segment_sid,
 mth_st_segment_sid,
 mth_fr_segment_sid,
 mth_re_segment_sid,
 mth_mo_segment_sid,
 busyear_qtr_rf_segment_sid,
 busyear_qtr_m_segment_sid,
 currency_iso_cd,
 curr_tot_id,
 gender_cd,
 age_range_cd,
 household_type_id,
 child_age_range_group_id,
 cm_cust_act,
 pm_cust_act,
 pym_cust_act,
 cm_mth_str_open_fg,
 cm_rcpts_cnt,
 pm_mth_str_open_fg,
 pm_rcpts_cnt,
 pym_mth_str_open_fg,
 pym_rcpts_cnt,
 load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_mart_lidl_digital.v_agg_unq_cust_ldpl_mth_2 AS F;