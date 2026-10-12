/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for v_agg_new_reg_ldpl_day
#----------------------------------------------------------------------------

#----------------------------------------------------------------------------





#----------------------------------------------------------------------------

#----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer               Task
#  --- ---------- ----------------------- --------------------------------
#  1.0 2022-08-12 Marcin Kikola           Initial version
#                                         Removal of unnecesary columns, 
#                                         adding comments and renaming of dwh_inserted column 
#  1.1 2023-12-18 Pawel Wieczorek         AP0069622 Added columns gender_cd, age_range_cd
#  1.2 2024-02-14 Pawel Wieczorek         AP0197960 Added column distinct_reg_user_fg
#  1.3 2024-02-15 Pawel Wieczorek         AP0197960 Keep PK the same as on prod, because of error: Required column alter is not supported for column GENDER_CD
#  1.4 2024-02-15 Pawel Wieczorek         AP0197960 Added not null to gender_cd, age_range_cd, the same as the real stucture
#  1.5 2024-02-15 Pawel Wieczorek         AP0197960 Recreated DDL with predeployment script because of alter error
#  1.6 2024-02-16 Pawel Wieczorek         AP0197960 Fixed comment typos
#                                         
#
#----------------------------------------------------------------------------
*/



/* ==============================================================================
   VIEW DDL
   ============================================================================== */


CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_lidl_digital.t_agg_cust_reg_dereg_ldpl_day (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Client identifier'),
dwh_cal_dt DATE NOT NULL OPTIONS(description='Data date'),
gender_cd STRING(5) NOT NULL OPTIONS(description='The code for the gender'),
age_range_cd STRING(10) NOT NULL OPTIONS(description='The code for the age range.'),
distinct_reg_user_fg STRING NOT NULL
OPTIONS(description='Distinct registered user flag. Y - registered users for INTEGER '),
reg_cnt BIGNUMERIC(38,0) OPTIONS(description='Number of registrations for given day'),
total_reg_cnt BIGNUMERIC(38,0)
OPTIONS(description='Number of total registrations since reporting_start_dt to given day'),
dereg_cnt BIGNUMERIC(38,0) OPTIONS(description='Number of deregistrations for given day'),
total_dereg_cnt BIGNUMERIC(38,0)
OPTIONS(description='Number of total deregistrations since reporting_start_dt to given day'),
new_reg_cnt BIGNUMERIC(38,0) OPTIONS(description='Number of new registrations for given day'),
total_new_reg_cnt BIGNUMERIC(38,0)
OPTIONS(description='Number of total new registrations since reporting_start_dt to given day'),
load_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Load identifier'),
dwh_created DATETIME NOT NULL OPTIONS(description='Row created time'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Row update time'),
PRIMARY KEY (client_id, dwh_cal_dt, gender_cd, age_range_cd, distinct_reg_user_fg) NOT ENFORCED
) OPTIONS(description=' Lidlplus: Table to provide registration and deregistration of customers count at day level');