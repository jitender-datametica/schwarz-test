CREATE OR REPLACE VIEW ldl_p_lew_mart_lidl_digital_ac.v_agg_cust_reg_dereg_ldpl_mth_2 (client_id
OPTIONS(description='Client Identifier'), cy_month OPTIONS(description='Month identifier'), harmo_cal_month_no
OPTIONS(description='Harmonized month no  per country_2 - month since rollout'), gender_cd
OPTIONS(description='The code for the gender'), age_range_cd OPTIONS(description='The code for the age range.'),
household_type_id OPTIONS(description='ID of the household type in which the customer lives.'), child_age_range_group_id
OPTIONS(description='Group of one or more age ranges in which the child is categorized depending on the age.'),
distinct_reg_user_fg OPTIONS(description='Distinct registered user flag. Y - registered users for INTEGER '),
reg_interface_id
OPTIONS(description='ID of the registration interface through which the user registered or reregistered for the geographical area in the loyalty program by accepting the legal terms the first time.'),
mth_m_segment_sid OPTIONS(description='ids of monetary segments from rfm model'), mth_rf_segment_sid
OPTIONS(description='ids of recency-frequency segments from rfm model'), mth_st_segment_sid
OPTIONS(description='ids of new STRATEGIC segments from rfm model'), mth_fr_segment_sid
OPTIONS(description='ids of new FREQUENCY segments from rfm model'), mth_re_segment_sid
OPTIONS(description='ids of new RECENCY segments from rfm model'), mth_mo_segment_sid
OPTIONS(description='ids of new monetary segments from rfm model'), cm_reg_cnt
OPTIONS(description='Number of registrations for given month'), pm_reg_cnt
OPTIONS(description='Number of registrations for previous month'), pym_reg_cnt
OPTIONS(description='Number of registrations for previous year month'), cm_total_reg_cnt
OPTIONS(description='Number of total registrations since reporting_start_dt to given month'), pm_total_reg_cnt
OPTIONS(description='Number of total registrations since reporting_start_dt to previous month'), pym_total_reg_cnt
OPTIONS(description='Number of total registrations since reporting_start_dt to previous year month'), cm_dereg_cnt
OPTIONS(description='Number of deregistrations for given month'), pm_dereg_cnt
OPTIONS(description='Number of deregistrations for previous month'), pym_dereg_cnt
OPTIONS(description='Number of deregistrations for previous year month'), cm_total_dereg_cnt
OPTIONS(description='Number of total deregistrations since reporting_start_dt to given month'), pm_total_dereg_cnt
OPTIONS(description='Number of total deregistrations since reporting_start_dt to previous month'), pym_total_dereg_cnt
OPTIONS(description='Number of total deregistrations since reporting_start_dt to previous year month'), cm_new_reg_cnt
OPTIONS(description='Number of new registrations for given month'), pm_new_reg_cnt
OPTIONS(description='Number of new registrations for previous month'), pym_new_reg_cnt
OPTIONS(description='Number of new registrations for previous year month'), cm_total_new_reg_cnt
OPTIONS(description='Number of total new registrations since reporting_start_dt to given month'), pm_total_new_reg_cnt
OPTIONS(description='Number of total new registrations since reporting_start_dt to previous month'),
pym_total_new_reg_cnt
OPTIONS(description='Number of total new registrations since reporting_start_dt to previous year month'), load_id
OPTIONS(description='Load identifier'), dwh_created OPTIONS(description='Row created time'), dwh_updated
OPTIONS(description='Row update time')) AS SELECT client_id,
 cy_month,
 harmo_cal_month_no,
 gender_cd,
 age_range_cd,
 household_type_id,
 child_age_range_group_id,
 distinct_reg_user_fg,
 reg_interface_id,
 mth_m_segment_sid,
 mth_rf_segment_sid,
 mth_st_segment_sid,
 mth_fr_segment_sid,
 mth_re_segment_sid,
 mth_mo_segment_sid,
 cm_reg_cnt,
 pm_reg_cnt,
 pym_reg_cnt,
 cm_total_reg_cnt,
 pm_total_reg_cnt,
 pym_total_reg_cnt,
 cm_dereg_cnt,
 pm_dereg_cnt,
 pym_dereg_cnt,
 cm_total_dereg_cnt,
 pm_total_dereg_cnt,
 pym_total_dereg_cnt,
 cm_new_reg_cnt,
 pm_new_reg_cnt,
 pym_new_reg_cnt,
 cm_total_new_reg_cnt,
 pm_total_new_reg_cnt,
 pym_total_new_reg_cnt,
 load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_mart_lidl_digital.v_agg_cust_reg_dereg_ldpl_mth_2;