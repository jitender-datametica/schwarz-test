CREATE OR REPLACE VIEW ldl_p_lew_mart_lidl_digital_ac.v_agg_cust_reg_opt_in_ldpl_mth (client_id
OPTIONS(description='Client Identifier'), cy_month OPTIONS(description='Month identifier'), harmo_cal_month_no
OPTIONS(description='Harmonized month no  per country - month since rollout'), gender_cd
OPTIONS(description='The code for the gender'), age_range_cd OPTIONS(description='The code for the age range.'),
distinct_reg_user_fg OPTIONS(description='Distinct registered user flag. Y - registered users for INTEGER '),
reg_interface_id
OPTIONS(description='ID of the registration interface through which the user registered or reregistered for the geographical area in the loyalty program by accepting the legal terms the first time.'),
push_contact_consent_fg OPTIONS(description='flag for push optIn type'), email_contact_consent_fg
OPTIONS(description='flag for email optIn type'), sms_contact_consent_fg OPTIONS(description='flag for sms optIn type'),
postal_contact_consent_fg OPTIONS(description='flag for postal optIn type'), whatsapp_contact_consent_fg
OPTIONS(description='flag for pwhatsapp optIn type'), cm_reg_cnt
OPTIONS(description='Number of registrations for given month'), pm_reg_cnt
OPTIONS(description='Number of registrations for previous month'), pym_reg_cnt
OPTIONS(description='Number of registrations for previous year month'), load_id OPTIONS(description='Load identifier'),
dwh_created OPTIONS(description='Row created time'), dwh_updated OPTIONS(description='Row update time'))
OPTIONS(DESCRIPTION = ` Lidlplus view : Table to provide registration opt-in of customers count at month level`) AS
SELECT client_id,
 cy_month,
 harmo_cal_month_no,
 gender_cd,
 age_range_cd,
 distinct_reg_user_fg,
 reg_interface_id,
 push_contact_consent_fg,
 email_contact_consent_fg,
 sms_contact_consent_fg,
 postal_contact_consent_fg,
 whatsapp_contact_consent_fg,
 cm_reg_cnt,
 pm_reg_cnt,
 pym_reg_cnt,
 load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_mart_lidl_digital.v_agg_cust_reg_opt_in_ldpl_mth;