CREATE OR REPLACE VIEW ldl_p_lew_mart_lidl_digital.v_agg_cust_reg_opt_in_ldpl_wk_2 (client_id
OPTIONS(description='Client Identifier'), cy_week OPTIONS(description='Week identifier'), harmo_cal_week_no
OPTIONS(description='Harmonized week no per country_2 - week since rollout'), gender_cd
OPTIONS(description='The code for the gender'), age_range_cd OPTIONS(description='The code for the age range.'),
distinct_reg_user_fg OPTIONS(description='Distinct registered user flag. Y - registered users for INTEGER '),
reg_interface_id
OPTIONS(description='ID of the registration interface through which the user registered or reregistered for the geographical area in the loyalty program by accepting the legal terms the first time.'),
push_contact_consent_fg OPTIONS(description='flag for push optIn type'), email_contact_consent_fg
OPTIONS(description='flag for email optIn type'), sms_contact_consent_fg OPTIONS(description='flag for sms optIn type'),
postal_contact_consent_fg OPTIONS(description='flag for postal optIn type'), whatsapp_contact_consent_fg
OPTIONS(description='flag for pwhatsapp optIn type'), cw_reg_cnt
OPTIONS(description='Number of registrations for given week'), pw_reg_cnt
OPTIONS(description='Number of registrations for previous week'), pyw_reg_cnt
OPTIONS(description='Number of registrations for previous year week'), load_id OPTIONS(description='Load identifier'),
dwh_created OPTIONS(description='Row created time'), dwh_updated OPTIONS(description='Row update time'))
OPTIONS(DESCRIPTION = ` Lidlplus view : Table to provide registration Opt-in of customers count at week level`) AS
SELECT client_id,
 cy_week,
 harmo_cal_week_no,
 gender_cd,
 age_range_cd,
 distinct_reg_user_fg,
 reg_interface_id,
 push_contact_consent_fg,
 email_contact_consent_fg,
 sms_contact_consent_fg,
 postal_contact_consent_fg,
 whatsapp_contact_consent_fg,
 cw_reg_cnt,
 pw_reg_cnt,
 pyw_reg_cnt,
 load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_mart_lidl_digital.t_agg_cust_reg_opt_in_ldpl_wk_2;