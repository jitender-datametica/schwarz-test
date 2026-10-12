CREATE OR REPLACE VIEW ldl_p_lew_mart_lidl_digital_ac.v_agg_cust_reg_dereg_ldpl_day (client_id
OPTIONS(description='Client identifier'), dwh_cal_dt OPTIONS(description='Data date'), gender_cd
OPTIONS(description='The code for the gender'), age_range_cd OPTIONS(description='The code for the age range.'),
household_type_id OPTIONS(description='ID of the household type in which the customer lives.'), child_age_range_group_id
OPTIONS(description='Group of one or more age ranges in which the child is categorized depending on the age.'),
distinct_reg_user_fg OPTIONS(description='Distinct registered user flag. Y - registered users for INTEGER '),
reg_interface_id
OPTIONS(description='ID of the registration interface through which the user registered or reregistered for the geographical area in the loyalty program by accepting the legal terms the first time.'),
reg_cnt OPTIONS(description='Number of registrations for given day'), total_reg_cnt
OPTIONS(description='Number of total registrations since reporting_start_dt to given day'), dereg_cnt
OPTIONS(description='Number of deregistrations for given day'), total_dereg_cnt
OPTIONS(description='Number of total deregistrations since reporting_start_dt to given day'), new_reg_cnt
OPTIONS(description='Number of new registrations for given day'), total_new_reg_cnt
OPTIONS(description='Number of total new registrations since reporting_start_dt to given day'), load_id
OPTIONS(description='Load identifier'), dwh_created OPTIONS(description='Row created time'), dwh_updated
OPTIONS(description='Row update time')) AS SELECT client_id,
 dwh_cal_dt,
 gender_cd,
 age_range_cd,
 household_type_id,
 child_age_range_group_id,
 distinct_reg_user_fg,
 reg_interface_id,
 reg_cnt,
 total_reg_cnt,
 dereg_cnt,
 total_dereg_cnt,
 new_reg_cnt,
 total_new_reg_cnt,
 load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_mart_lidl_digital.v_agg_cust_reg_dereg_ldpl_day;