CREATE OR REPLACE TABLE ldl_p_lew_mart_lidl_digital.t_agg_cust_reg_opt_in_ldpl_day_1 (
client_id INTEGER NOT NULL OPTIONS(description='Client identifier'),
dwh_cal_dt DATE NOT NULL OPTIONS(description='Data date'),
gender_cd STRING(5) NOT NULL OPTIONS(description='The code for the gender'),
age_range_cd STRING(10) NOT NULL OPTIONS(description='The code for the age range.'),
distinct_reg_user_fg STRING(1) NOT NULL
OPTIONS(description='Distinct registered user flag. Y - registered users for INTEGER '),
reg_interface_id INTEGER NOT NULL
OPTIONS(description='Id of the registration interface through which the user registered or reregistered for the geographical area in the loyalty program by accepting the legal terms the first time.'),
push_contact_consent_fg INTEGER OPTIONS(description='flag for push optIn type'),
email_contact_consent_fg INTEGER OPTIONS(description='flag for email optIn type'),
sms_contact_consent_fg INTEGER OPTIONS(description='flag for sms optIn type'),
postal_contact_consent_fg INTEGER OPTIONS(description='flag for postal optIn type'),
whatsapp_contact_consent_fg INTEGER OPTIONS(description='flag for pwhatsapp optIn type'),
reg_cnt INTEGER OPTIONS(description='Number of registrations for given day'),
load_id INTEGER NOT NULL OPTIONS(description='Load identifier'),
dwh_created DATETIME NOT NULL OPTIONS(description='Row created time'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Row update time'),
PRIMARY KEY (client_id, dwh_cal_dt, gender_cd, age_range_cd, distinct_reg_user_fg) NOT ENFORCED
) OPTIONS(description=' Lidlplus: Table to provide registration opr_in flags of customers count at day level');