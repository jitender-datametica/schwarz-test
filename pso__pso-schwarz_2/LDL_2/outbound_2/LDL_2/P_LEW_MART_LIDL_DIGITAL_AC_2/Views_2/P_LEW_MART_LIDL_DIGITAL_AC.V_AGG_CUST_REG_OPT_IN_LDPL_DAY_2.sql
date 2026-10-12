CREATE OR REPLACE VIEW ldl_p_lew_mart_lidl_digital_ac.v_agg_cust_reg_opt_in_ldpl_day_2 (client_id
OPTIONS(description='Client identifier'), dwh_cal_dt OPTIONS(description='Data date'), gender_cd
OPTIONS(description='The code for the gender'), age_range_cd OPTIONS(description='The code for the age range.'),
distinct_reg_user_fg OPTIONS(description='Distinct registered user flag. Y - registered users for INTEGER '),
reg_interface_id
OPTIONS(description='ID of the registration interface through which the user registered or reregistered for the geographical area in the loyalty program by accepting the legal terms the first time.'),
push_contact_consent_fg OPTIONS(description='flag for push optIn type'), email_contact_consent_fg
OPTIONS(description='flag for email optIn type'), sms_contact_consent_fg OPTIONS(description='flag for sms optIn type'),
postal_contact_consent_fg OPTIONS(description='flag for postal optIn type'), whatsapp_contact_consent_fg
OPTIONS(description='flag for pwhatsapp optIn type'), reg_cnt
OPTIONS(description='Number of registrations for given day'), load_id OPTIONS(description='Load identifier'),
dwh_created OPTIONS(description='Row created time'), dwh_updated OPTIONS(description='Row update time'))
OPTIONS(DESCRIPTION = ` Lidlplus view : Table to provide registration Opt-In of customers count at day level`) AS SELECT
 client_id,
 dwh_cal_dt,
 gender_cd,
 age_range_cd,
 distinct_reg_user_fg,
 reg_interface_id,
 push_contact_consent_fg,
 email_contact_consent_fg,
 sms_contact_consent_fg,
 postal_contact_consent_fg,
 whatsapp_contact_consent_fg,
 reg_cnt,
 load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_mart_lidl_digital.v_agg_cust_reg_opt_in_ldpl_day_2;