CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_customer_country_member_hist (client_id
OPTIONS(description='Unique identifier of the DWH client / slice.'), customer_sid
OPTIONS(description='Unique identifier of the customer (surrogate key).'), geo_area_sid
OPTIONS(description='Unique identifier of the geographical area (surrogate key).'), geo_area_cd
OPTIONS(description='Code of the geographical area.'), loyalty_prog_cd
OPTIONS(description='Identifier of the loyalty program: LPLUS (LidlPlus).'), reg_tmsp
OPTIONS(description='timestamp_ntz(9) of the initial registration of the customer for the loyalty program within a geographical area (normally country).'),
dereg_tmsp
OPTIONS(description='timestamp_ntz(9) of the deregistration of the customer for the loyalty program within a geographical area (normally country).'),
rereg_tmsp
OPTIONS(description='timestamp_ntz(9) of the last reregistration of the customer for the loyalty program within a geographical area (normally country). If the customer did not deregister after the first registration then the initial registration timestamp_ntz(9) is stored here.'),
reg_interface_name
OPTIONS(description='Name of the interface through which the user registered or reregistered for the geographical area in the loyalty program by accepting the legal terms the first time.\nA registration or reregistration happens if a customer accepts the legal terms for the first time either at all (initial registration) or after a decline which follows a former registration (reregistration).\nThe interface name from the last acceptance event, of the registration or reregistration, is stored here.'),
first_known_retail_purch_dt
OPTIONS(description='Contains the reported data of the first purchase of a customer in a retail store in the geographical area as used in the rfm segmentation algorithm. This is not directly measured in the pos transaction history.'),
push_contact_consent_fg
OPTIONS(description='Indicator whether or not the user has allowed using push communication in preferences for Lidl plus campaigns and benefits.'),
email_contact_consent_fg
OPTIONS(description='Indicator whether or not the user has allowed using mail communication in preferences for Lidl plus campaigns and benefits.'),
sms_contact_consent_fg
OPTIONS(description='Indicator whether or not the user has allowed using sms communication in preferences for Lidl plus campaigns and benefits.'),
postal_contact_consent_fg
OPTIONS(description='Indicator whether or not the user has allowed using postal communication in preferences for Lidl plus campaigns and benefits.'),
whatsapp_contact_consent_fg
OPTIONS(description='Indicator whether or not the user has allowed using whatsapp communication in preferences for Lidl plus campaigns and benefits.'),
deleted_fg
OPTIONS(description='In case of deleted_fg = 1 the data record is assumed to not exist in the source system between dwh_valid_from / dwh_valid_to.'),
dwh_valid_from
OPTIONS(description='Begin of the validity interval of the record, oldest record of the history starts with 1900-01-01 (minus infinity).'),
dwh_valid_to
OPTIONS(description='End of the validity interval of the record, newest record of the history ends with 9999-12-30 (plus infinity).'),
dwh_load_id
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created OPTIONS(description='Creation timestamp_ntz(9) of the record in the DWH.'), dwh_updated
OPTIONS(description='timestamp_ntz(9) of the last update of the record in the DWH.')) AS SELECT client_id,
 customer_sid,
 geo_area_sid,
 geo_area_cd,
 loyalty_prog_cd,
 reg_tmsp,
 dereg_tmsp,
 rereg_tmsp,
 reg_interface_name,
 first_known_retail_purch_dt,
 push_contact_consent_fg,
 email_contact_consent_fg,
 sms_contact_consent_fg,
 postal_contact_consent_fg,
 whatsapp_contact_consent_fg,
 deleted_fg,
 dwh_valid_from,
 dwh_valid_to,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_customer_country_member_hist;