/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: Registration and deregistration of customers
#----------------------------------------------------------------------------

#----------------------------------------------------------------------------





#----------------------------------------------------------------------------

#----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer               Task
#  --- ---------- ----------------------- --------------------------------
#
#  1.0 2020-06-01 Pawel Wieczorek         Initial version SD-639
#                                         20200603_2491_lidlplus_reg_dereg
#  1.1 2020-11-25 Pawel Wieczork          20201117_2664_harmo_cal SD-1544
#                                         Add column
#                                                   harmo_cal_week_no
#                                                   adjust_growth_fg
#                                         adding comments and renaming of dwh_inserted column 
#  1.6 2023-10-30 Pawel Wieczorek         AP0069622 Added columns gender_cd, age_range_cd
#  1.7 2024-02-13 Pawel Wieczorek         AP0197960 Added column distinct_reg_user_fg
#  1.8 2024-02-15 Pawel Wieczorek         AP0197960 Keep PK the same as on prod, because of error: Required column alter is not supported for column GENDER_CD
#  1.9 2024-02-15 Pawel Wieczorek         AP0197960 Added not null to gender_cd, age_range_cd, the same as the real stucture
#  2.0 2024-02-15 Pawel Wieczorek         AP0197960 Recreated DDL with predeployment script because of alter error
#  2.1 2024-02-16 Pawel Wieczorek         AP0197960 Fixed comment typos
#----------------------------------------------------------------------------
*/



/* ==============================================================================
   VIEW DDL
   ============================================================================== */


CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_lidl_digital.t_agg_cust_reg_dereg_ldpl_wk_1 (
client_id INTEGER NOT NULL OPTIONS(description='Client Identifier'),
cy_week INTEGER NOT NULL OPTIONS(description='Week identifier'),
harmo_cal_week_no INTEGER NOT NULL OPTIONS(description='Harmonized week no per country_1 - week since rollout'),
adjust_growth_fg INTEGER NOT NULL
OPTIONS(description='Flag used to differentiate between bereinigte and unbereinigte values for metrics'),
gender_cd STRING(5) NOT NULL OPTIONS(description='The code for the gender'),
age_range_cd STRING(10) NOT NULL OPTIONS(description='The code for the age range.'),
distinct_reg_user_fg STRING(1) NOT NULL
OPTIONS(description='Distinct registered user flag. Y - registered users for INTEGER '),
cw_reg_cnt INTEGER OPTIONS(description='Number of registrations for given week'),
pw_reg_cnt INTEGER OPTIONS(description='Number of registrations for previous week'),
pyw_reg_cnt INTEGER OPTIONS(description='Number of registrations for previous year week'),
cw_total_reg_cnt INTEGER OPTIONS(description='Number of total registrations since reporting_start_dt to given week'),
pw_total_reg_cnt INTEGER OPTIONS(description='Number of total registrations since reporting_start_dt to previous week'),
pyw_total_reg_cnt INTEGER
OPTIONS(description='Number of total registrations since reporting_start_dt to previous year week'),
cw_dereg_cnt INTEGER OPTIONS(description='Number of deregistrations for given week'),
pw_dereg_cnt INTEGER OPTIONS(description='Number of deregistrations for previous week'),
pyw_dereg_cnt INTEGER OPTIONS(description='Number of deregistrations for previous year week'),
cw_total_dereg_cnt INTEGER OPTIONS(description='Number of total deregistrations since reporting_start_dt to given week'),
pw_total_dereg_cnt INTEGER
OPTIONS(description='Number of total deregistrations since reporting_start_dt to previous week'),
pyw_total_dereg_cnt INTEGER
OPTIONS(description='Number of total deregistrations since reporting_start_dt to previous year week'),
cw_new_reg_cnt INTEGER OPTIONS(description='Number of new registrations for given week'),
pw_new_reg_cnt INTEGER OPTIONS(description='Number of new registrations for previous week'),
pyw_new_reg_cnt INTEGER OPTIONS(description='Number of new registrations for previous year week'),
cw_total_new_reg_cnt INTEGER
OPTIONS(description='Number of total new registrations since reporting_start_dt to given week'),
pw_total_new_reg_cnt INTEGER
OPTIONS(description='Number of total new registrations since reporting_start_dt to previous week'),
pyw_total_new_reg_cnt INTEGER
OPTIONS(description='Number of total new registrations since reporting_start_dt to previous year week'),
load_id INTEGER NOT NULL OPTIONS(description='Load identifier'),
dwh_created DATETIME NOT NULL OPTIONS(description='Row created time'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Row update time'),
PRIMARY KEY (client_id, adjust_growth_fg, gender_cd, age_range_cd, distinct_reg_user_fg, cy_week) NOT ENFORCED
) OPTIONS(description=' Lidlplus: Table to provide registration and deregistration of customers count at week level');