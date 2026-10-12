CREATE OR REPLACE VIEW ldl_p_lew_mart_lidl_digital.v_agg_cust_reg_dereg_ldpl_wk_2 (client_id
OPTIONS(description='Client Identifier'), cy_week OPTIONS(description='Week identifier'), harmo_cal_week_no
OPTIONS(description='Harmonized week no per country_2 - week since rollout'), gender_cd
OPTIONS(description='The code for the gender'), age_range_cd OPTIONS(description='The code for the age range.'),
household_type_id OPTIONS(description='ID of the household type in which the customer lives.'), child_age_range_group_id
OPTIONS(description='Group of one or more age ranges in which the child is categorized depending on the age.'),
distinct_reg_user_fg OPTIONS(description='Distinct registered user flag. Y - registered users for INTEGER '),
reg_interface_id
OPTIONS(description='ID of the registration interface through which the user registered or reregistered for the geographical area in the loyalty program by accepting the legal terms the first time.'),
wk_m_segment_sid OPTIONS(description='ids of monetary segments from rfm model'), wk_rf_segment_sid
OPTIONS(description='ids of recency-frequency segments from rfm model'), wk_st_segment_sid
OPTIONS(description='ids of strategic segments from rfm model'), wk_fr_segment_sid
OPTIONS(description='ids of frequency segments from rfm model'), wk_mo_segment_sid
OPTIONS(description='ids of new monetary segments from rfm model'), wk_re_segment_sid
OPTIONS(description='ids of recency segments from rfm model'), cw_reg_cnt
OPTIONS(description='Number of registrations for given week'), pw_reg_cnt
OPTIONS(description='Number of registrations for previous week'), pyw_reg_cnt
OPTIONS(description='Number of registrations for previous year week'), cw_total_reg_cnt
OPTIONS(description='Number of total registrations since reporting_start_dt to given week'), pw_total_reg_cnt
OPTIONS(description='Number of total registrations since reporting_start_dt to previous week'), pyw_total_reg_cnt
OPTIONS(description='Number of total registrations since reporting_start_dt to previous year week'), cw_dereg_cnt
OPTIONS(description='Number of deregistrations for given week'), pw_dereg_cnt
OPTIONS(description='Number of deregistrations for previous week'), pyw_dereg_cnt
OPTIONS(description='Number of deregistrations for previous year week'), cw_total_dereg_cnt
OPTIONS(description='Number of total deregistrations since reporting_start_dt to given week'), pw_total_dereg_cnt
OPTIONS(description='Number of total deregistrations since reporting_start_dt to previous week'), pyw_total_dereg_cnt
OPTIONS(description='Number of total deregistrations since reporting_start_dt to previous year week'), cw_new_reg_cnt
OPTIONS(description='Number of new registrations for given week'), pw_new_reg_cnt
OPTIONS(description='Number of new registrations for previous week'), pyw_new_reg_cnt
OPTIONS(description='Number of new registrations for previous year week'), cw_total_new_reg_cnt
OPTIONS(description='Number of total new registrations since reporting_start_dt to given week'), pw_total_new_reg_cnt
OPTIONS(description='Number of total new registrations since reporting_start_dt to previous week'),
pyw_total_new_reg_cnt
OPTIONS(description='Number of total new registrations since reporting_start_dt to previous year week'), load_id
OPTIONS(description='Load identifier'), dwh_created OPTIONS(description='Row created time'), dwh_updated
OPTIONS(description='Row update time')) AS SELECT client_id,
 cy_week,
 harmo_cal_week_no,
 gender_cd,
 age_range_cd,
 household_type_id,
 child_age_range_group_id,
 distinct_reg_user_fg,
 reg_interface_id,
 wk_m_segment_sid,
 wk_rf_segment_sid,
 wk_st_segment_sid,
 wk_fr_segment_sid,
 wk_mo_segment_sid,
 wk_re_segment_sid,
 cw_reg_cnt,
 pw_reg_cnt,
 pyw_reg_cnt,
 cw_total_reg_cnt,
 pw_total_reg_cnt,
 pyw_total_reg_cnt,
 cw_dereg_cnt,
 pw_dereg_cnt,
 pyw_dereg_cnt,
 cw_total_dereg_cnt,
 pw_total_dereg_cnt,
 pyw_total_dereg_cnt,
 cw_new_reg_cnt,
 pw_new_reg_cnt,
 pyw_new_reg_cnt,
 cw_total_new_reg_cnt,
 pw_total_new_reg_cnt,
 pyw_total_new_reg_cnt,
 load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_mart_lidl_digital.t_agg_cust_reg_dereg_ldpl_wk_2;