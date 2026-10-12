CREATE OR REPLACE TABLE ldl_p_lew_mart_lidl_digital.t_agg_cust_reg_dereg_ldpl_day_1 (
client_id INTEGER NOT NULL OPTIONS(description='Client identifier'),
dwh_cal_dt DATE NOT NULL OPTIONS(description='Data date'),
gender_cd STRING(5) NOT NULL OPTIONS(description='The code for the gender'),
age_range_cd STRING(10) NOT NULL OPTIONS(description='The code for the age range.'),
household_type_id INTEGER NOT NULL OPTIONS(description='ID of the household type in which the customer lives.'),
child_age_range_group_id INTEGER NOT NULL
OPTIONS(description='Group of one or more age ranges in which the child is categorized depending on the age.'),
distinct_reg_user_fg STRING(1) NOT NULL
OPTIONS(description='Distinct registered user flag. Y - registered users for INTEGER '),
reg_interface_id INTEGER NOT NULL
OPTIONS(description='Id of the registration interface through which the user registered or reregistered for the geographical area in the loyalty program by accepting the legal terms the first time.'),
reg_cnt INTEGER OPTIONS(description='Number of registrations for given day'),
total_reg_cnt INTEGER OPTIONS(description='Number of total registrations since reporting_start_dt to given day'),
dereg_cnt INTEGER OPTIONS(description='Number of deregistrations for given day'),
total_dereg_cnt INTEGER OPTIONS(description='Number of total deregistrations since reporting_start_dt to given day'),
new_reg_cnt INTEGER OPTIONS(description='Number of new registrations for given day'),
total_new_reg_cnt INTEGER OPTIONS(description='Number of total new registrations since reporting_start_dt to given day'),
load_id INTEGER NOT NULL OPTIONS(description='Load identifier'),
dwh_created DATETIME NOT NULL OPTIONS(description='Row created time'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Row update time'),
PRIMARY KEY (client_id, dwh_cal_dt, gender_cd, age_range_cd, distinct_reg_user_fg) NOT ENFORCED
) OPTIONS(description=' Lidlplus: Table to provide registration and deregistration of customers count at day level');