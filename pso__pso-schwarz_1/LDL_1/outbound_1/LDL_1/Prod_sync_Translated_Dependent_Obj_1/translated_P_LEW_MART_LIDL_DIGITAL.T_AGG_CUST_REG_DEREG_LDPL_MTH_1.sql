CREATE OR REPLACE TABLE ldl_p_lew_mart_lidl_digital.t_agg_cust_reg_dereg_ldpl_mth_1 (
client_id INTEGER NOT NULL OPTIONS(description='Client Identifier'),
cy_month INTEGER NOT NULL OPTIONS(description='Month identifier'),
harmo_cal_month_no INTEGER NOT NULL OPTIONS(description='Harmonized month no  per country_1 - month since rollout'),
gender_cd STRING(5) NOT NULL OPTIONS(description='The code for the gender'),
age_range_cd STRING(10) NOT NULL OPTIONS(description='The code for the age range.'),
household_type_id INTEGER NOT NULL OPTIONS(description='ID of the household type in which the customer lives.'),
child_age_range_group_id INTEGER NOT NULL
OPTIONS(description='Group of one or more age ranges in which the child is categorized depending on the age.'),
distinct_reg_user_fg STRING(1) NOT NULL
OPTIONS(description='Distinct registered user flag. Y - registered users for INTEGER '),
reg_interface_id INTEGER NOT NULL OPTIONS(description='ids of REG_INTERFACE_ID'),
mth_m_segment_sid INTEGER DEFAULT 0 OPTIONS(description='ids of monetary segments from rfm model'),
mth_rf_segment_sid INTEGER DEFAULT 0 OPTIONS(description='ids of recency-frequency segments from rfm model'),
mth_st_segment_sid INTEGER DEFAULT 0 OPTIONS(description='ids of strategic segments from rfm model'),
mth_fr_segment_sid INTEGER DEFAULT 0 OPTIONS(description='ids of frequency segments from rfm model'),
mth_mo_segment_sid INTEGER DEFAULT 0 OPTIONS(description='ids of new monetary segments from rfm model'),
mth_re_segment_sid INTEGER DEFAULT 0 OPTIONS(description='ids of recency segments from rfm model'),
cm_reg_cnt INTEGER OPTIONS(description='Number of registrations for given month'),
pm_reg_cnt INTEGER OPTIONS(description='Number of registrations for previous month'),
pym_reg_cnt INTEGER OPTIONS(description='Number of registrations for previous year month'),
cm_total_reg_cnt INTEGER OPTIONS(description='Number of total registrations since reporting_start_dt to given month'),
pm_total_reg_cnt INTEGER OPTIONS(description='Number of total registrations since reporting_start_dt to previous month'),
pym_total_reg_cnt INTEGER
OPTIONS(description='Number of total registrations since reporting_start_dt to previous year month'),
cm_dereg_cnt INTEGER OPTIONS(description='Number of deregistrations for given month'),
pm_dereg_cnt INTEGER OPTIONS(description='Number of deregistrations for previous month'),
pym_dereg_cnt INTEGER OPTIONS(description='Number of deregistrations for previous year month'),
cm_total_dereg_cnt INTEGER
OPTIONS(description='Number of total deregistrations since reporting_start_dt to given month'),
pm_total_dereg_cnt INTEGER
OPTIONS(description='Number of total deregistrations since reporting_start_dt to previous month'),
pym_total_dereg_cnt INTEGER
OPTIONS(description='Number of total deregistrations since reporting_start_dt to previous year month'),
cm_new_reg_cnt INTEGER OPTIONS(description='Number of new registrations for given month'),
pm_new_reg_cnt INTEGER OPTIONS(description='Number of new registrations for previous month'),
pym_new_reg_cnt INTEGER OPTIONS(description='Number of new registrations for previous year month'),
cm_total_new_reg_cnt INTEGER
OPTIONS(description='Number of total new registrations since reporting_start_dt to given month'),
pm_total_new_reg_cnt INTEGER
OPTIONS(description='Number of total new registrations since reporting_start_dt to previous month'),
pym_total_new_reg_cnt INTEGER
OPTIONS(description='Number of total new registrations since reporting_start_dt to previous year month'),
load_id INTEGER NOT NULL OPTIONS(description='Load identifier'),
dwh_created DATETIME NOT NULL OPTIONS(description='Row created time'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Row update time'),
PRIMARY KEY (client_id, gender_cd, age_range_cd, distinct_reg_user_fg, cy_month) NOT ENFORCED
) OPTIONS(description=' Lidlplus: Table to provide registration and deregistration of customers count at month level');