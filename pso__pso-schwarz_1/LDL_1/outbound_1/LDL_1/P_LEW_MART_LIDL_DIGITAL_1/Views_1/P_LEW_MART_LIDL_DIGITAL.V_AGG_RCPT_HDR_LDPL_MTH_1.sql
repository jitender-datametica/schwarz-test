CREATE OR REPLACE VIEW ldl_p_lew_mart_lidl_digital.v_agg_rcpt_hdr_ldpl_mth_1 (aspect_id
OPTIONS(description='Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'), client_id
OPTIONS(description='Identifier for client'), move_to_store_id OPTIONS(description='Store ID'), wh_id
OPTIONS(description='Warehouse ID'), lidlplus_cust_fg OPTIONS(description='Lidplus customer flag'), adjust_growth_fg
OPTIONS(description='Adjust growth flag - berenigte steigerung'), mth_rf_segment_sid
OPTIONS(description='Recency-frequency segments id - used (client_id + loc_sid(LU), customer_sid, cy_month) to select t_cust_rfm_segment_mth.mth_rf_segment_sid'),
mth_m_segment_sid
OPTIONS(description='Monetary Segment Id - used (client_id + loc_sid(LU), customer_sid, cy_month) to select t_cust_m_segment_mth.mth_m_segment_sid'),
mth_st_segment_sid
OPTIONS(description='STRATEGIC Segment Id - used (client_id + loc_sid(LU), customer_sid, cy_month) to select t_cust_m_segment_mth.mth_m_segment_sid'),
mth_fr_segment_sid
OPTIONS(description='FREQUENCY Segment Id - used (client_id + loc_sid(LU), customer_sid, cy_month) to select t_cust_m_segment_mth.mth_m_segment_sid'),
mth_re_segment_sid
OPTIONS(description='RECENCY Segment Id - used (client_id + loc_sid(LU), customer_sid, cy_month) to select t_cust_m_segment_mth.mth_m_segment_sid'),
mth_mo_segment_sid
OPTIONS(description='new Monetary Segment Id - used (client_id + loc_sid(LU), customer_sid, cy_month) to select t_cust_m_segment_mth.mth_m_segment_sid'),
busyear_qtr_rf_segment_sid
OPTIONS(description='Recency-frequency segments id - used (client_id + loc_sid(LU), customer_sid, cy_month) to select t_cust_rfm_segment_busyear_qtr.busyear_qtr_rf_segment_sid'),
busyear_qtr_m_segment_sid
OPTIONS(description='Monetary Segment Id - used (client_id + loc_sid(LU), customer_sid, cy_month) to select t_cust_m_segment_busyear_qtr.busyear_m_segment_sid'),
cy_month OPTIONS(description='Month number'), harmo_cal_month_no
OPTIONS(description='Harmonized month no  per country_1 - month since rollout'), currency_iso_cd
OPTIONS(description='ISO code for the currency of the client.'), curr_tot_id
OPTIONS(description='Fixe Werte fuer EUR=0, GBP=40 sonst Client_Id'), pcwo_reason_id
OPTIONS(description='Unique ID of the write-off or Price change reason. Country_1-specific write-off reasons have ID>100.'),
coupon_reason_nr OPTIONS(description='Identifier of the booking reason in SCRM'), gender_cd
OPTIONS(description='The code for the geder'), age_range_cd OPTIONS(description='The code for the age range.'),
household_type_id OPTIONS(description='ID of the household type in which the customer lives.'), child_age_range_group_id
OPTIONS(description='Group of one or more age ranges in which the child is categorized depending on the age.'),
cm_mth_str_open_fg OPTIONS(description='Store open flag : Current month'), cm_tot_gros_val
OPTIONS(description='Total gross value : Current month'), cm_tot_net_val
OPTIONS(description='Total net value : Current month'), cm_rcpts_cnt
OPTIONS(description='Receipts count : Current month'), cm_tot_rcpt_cnt_mth OPTIONS(description='Receipts count'),
cm_trans_time_in_mins OPTIONS(description='Transaction time measured in minutes : Current month'), cm_items_scanned_cnt
OPTIONS(description='Number of items scanned : Current month'), cm_new_reg_cnt
OPTIONS(description='Number of new registrations for given month'), cm_dereg_cnt
OPTIONS(description='Number of deregistrations for given month'), cm_tot_reg_cnt
OPTIONS(description='Number of total new registrations since reporting_start_dt to given month'), cm_discount_val
OPTIONS(description='Discount value : Current month'), cm_writeoff_val
OPTIONS(description='Writeoff net value: Current month'), pm_mth_str_open_fg
OPTIONS(description='Store open flag : Previous month'), pm_tot_gros_val
OPTIONS(description='Total gross value : Previous month'), pm_tot_net_val
OPTIONS(description='Total net value : Previous month'), pm_rcpts_cnt
OPTIONS(description='Receipts count : Previous month'), pm_tot_rcpt_cnt_mth OPTIONS(description='Receipts count'),
pm_trans_time_in_mins OPTIONS(description='Transaction time measured in minutes : Previous month'), pm_items_scanned_cnt
OPTIONS(description='Number of items scanned : Previous month'), pm_new_reg_cnt
OPTIONS(description='Number of new registrations for previous month'), pm_dereg_cnt
OPTIONS(description='Number of deregistrations for previous month'), pm_tot_reg_cnt
OPTIONS(description='Number of total new registrations since reporting_start_dt to previous month'), pm_discount_val
OPTIONS(description='Discount value : Previous month'), pm_writeoff_val
OPTIONS(description='Writeoff net value: Previous month'), pym_mth_str_open_fg
OPTIONS(description='Store open flag : Previous year month'), pym_tot_gros_val
OPTIONS(description='Total gross value : Previous year month'), pym_tot_net_val
OPTIONS(description='Total net value : Previous year month'), pym_rcpts_cnt
OPTIONS(description='Receipts count : Previous year month'), pym_tot_rcpt_cnt_mth OPTIONS(description='Receipts count'),
pym_trans_time_in_mins OPTIONS(description='Transaction time measured in minutes : Previous year month'),
pym_items_scanned_cnt OPTIONS(description='Number of items scanned : Previous year month'), pym_new_reg_cnt
OPTIONS(description='Number of new registrations for previous year month'), pym_dereg_cnt
OPTIONS(description='Number of deregistrations for previous year month'), pym_tot_reg_cnt
OPTIONS(description='Number of total new registrations since reporting_start_dt to previous year month'),
pym_discount_val OPTIONS(description='Discount value : Previous year month'), pym_writeoff_val
OPTIONS(description='Writeoff net value: Previous year month'), load_id OPTIONS(description='Load identifier'),
dwh_created OPTIONS(description='Row create time'), dwh_updated OPTIONS(description='Row update time')) AS SELECT CASE
  WHEN move_to_store_id = 0
  THEN 0
  ELSE aspect_id
  END AS aspect_id,
 client_id,
 move_to_store_id,
 wh_id,
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
 cy_month,
 harmo_cal_month_no,
 currency_iso_cd,
 curr_tot_id,
 pcwo_reason_id,
 coupon_reason_nr,
 gender_cd,
 age_range_cd,
 household_type_id,
 child_age_range_group_id,
 cm_mth_str_open_fg,
 cm_tot_gros_val,
 cm_tot_net_val,
 cm_rcpts_cnt,
 cm_tot_rcpt_cnt_mth,
 cm_trans_time_in_mins,
 cm_items_scanned_cnt,
 CAST(NULL AS INTEGER) AS cm_new_reg_cnt,
 CAST(NULL AS INTEGER) AS cm_dereg_cnt,
 CAST(NULL AS INTEGER) AS cm_tot_reg_cnt,
 cm_discount_val,
 cm_writeoff_val,
 pm_mth_str_open_fg,
 pm_tot_gros_val,
 pm_tot_net_val,
 pm_rcpts_cnt,
 pm_tot_rcpt_cnt_mth,
 pm_trans_time_in_mins,
 pm_items_scanned_cnt,
 CAST(NULL AS INTEGER) AS pm_new_reg_cnt,
 CAST(NULL AS INTEGER) AS pm_dereg_cnt,
 CAST(NULL AS INTEGER) AS pm_tot_reg_cnt,
 pm_discount_val,
 pm_writeoff_val,
 pym_mth_str_open_fg,
 pym_tot_gros_val,
 pym_tot_net_val,
 pym_rcpts_cnt,
 pym_tot_rcpt_cnt_mth,
 pym_trans_time_in_mins,
 pym_items_scanned_cnt,
 CAST(NULL AS INTEGER) AS pym_new_reg_cnt,
 CAST(NULL AS INTEGER) AS pym_dereg_cnt,
 CAST(NULL AS INTEGER) AS pym_tot_reg_cnt,
 pym_discount_val,
 pym_writeoff_val,
 load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_mart_lidl_digital.t_agg_rcpt_hdr_ldpl_mth_1 AS T;