CREATE OR REPLACE TABLE ldl_p_lew_mart_lidl_digital.t_agg_cust_reg_opt_in_ldpl_wk (
client_id INTEGER NOT NULL OPTIONS(description='Client Identifier'),
cy_week INTEGER NOT NULL OPTIONS(description='Week identifier'),
harmo_cal_week_no INTEGER NOT NULL OPTIONS(description='Harmonized week no per country - week since rollout'),
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
cw_reg_cnt INTEGER OPTIONS(description='Number of registrations for given week'),
pw_reg_cnt INTEGER OPTIONS(description='Number of registrations for previous week'),
pyw_reg_cnt INTEGER OPTIONS(description='Number of registrations for previous year week'),
load_id INTEGER NOT NULL OPTIONS(description='Load identifier'),
dwh_created DATETIME NOT NULL OPTIONS(description='Row created time'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Row update time'),
PRIMARY KEY (client_id, gender_cd, age_range_cd, distinct_reg_user_fg, cy_week) NOT ENFORCED
) OPTIONS(description=' Lidlplus: Table to provide registration and opt_in of customers count at week level');