/* --------------------------------------------------------------------------------
   DDL for table: t_customer_country_member_hist_1
   generated from Powerdesigner on Montag, 28. Juli 2025 09:30:37
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_customer_country_member_hist_1 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Unique identifier of the DWH client / slice.'),
customer_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Unique identifier of the customer (surrogate key).'),
geo_area_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Unique identifier of the geographical area (surrogate key).'),
geo_area_cd STRING(5) COLLATE 'und:ci' NOT NULL OPTIONS(description='Code of the geographical area.'),
loyalty_prog_cd STRING(5) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Identifier of the loyalty program: LPLUS (LidlPlus).'),
reg_tmsp DATETIME NOT NULL
OPTIONS(description='Timestamp of the initial registration of the customer for the loyalty program within a geographical area (normally country_1).'),
dereg_tmsp DATETIME NOT NULL
OPTIONS(description='Timestamp of the deregistration of the customer for the loyalty program within a geographical area (normally country_1).'),
rereg_tmsp DATETIME NOT NULL
OPTIONS(description='Timestamp of the last reregistration of the customer for the loyalty program within a geographical area (normally country_1). If the customer did not deregister after the first registration then the initial registration timestamp is stored here.'),
reg_interface_name STRING(100) NOT NULL
OPTIONS(description='Name of the interface through which the user registered or reregistered for the geographical area in the loyalty program by accepting the legal terms the first time.            A registration or reregistration happens if a customer accepts the legal terms for the first time either at all (initial registration) or after a decline which follows a former registration (reregistration).            The interface name from the last acceptance event, of the registration or reregistration, is stored here.'),
push_contact_consent_fg BIGNUMERIC(38,0)
OPTIONS(description='Indicator whether or not the user has allowed using push communication_1 in preferences for Lidl plus campaigns and benefits.'),
email_contact_consent_fg BIGNUMERIC(38,0)
OPTIONS(description='Indicator whether or not the user has allowed using mail communication_1 in preferences for Lidl plus campaigns and benefits.'),
sms_contact_consent_fg BIGNUMERIC(38,0)
OPTIONS(description='Indicator whether or not the user has allowed using sms communication_1 in preferences for Lidl plus campaigns and benefits.'),
postal_contact_consent_fg BIGNUMERIC(38,0)
OPTIONS(description='Indicator whether or not the user has allowed using postal communication_1 in preferences for Lidl plus campaigns and benefits.'),
whatsapp_contact_consent_fg BIGNUMERIC(38,0)
OPTIONS(description='Indicator whether or not the user has allowed using whatsapp communication_1 in preferences for Lidl plus campaigns and benefits.'),
deleted_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='In case of deleted_fg = 1 the data record is assumed to not exist in the source system between dwh_valid_from / dwh_valid_to.'),
dwh_valid_from DATE NOT NULL
OPTIONS(description='Begin of the validity_1 interval of the record, oldest record of the history starts with 1900-01-01 (minus infinity).'),
dwh_valid_to DATE NOT NULL
OPTIONS(description='End of the validity_1 interval of the record, newest record of the history ends with 9999-12-30 (plus infinity).'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (geo_area_sid, customer_sid, dwh_valid_from) NOT ENFORCED
)
OPTIONS(description='Contains information regarding membership of a customer to a loyalty program for a certain geographical area.             Based on the agreement to the terms of usage for a certain geographical area (i.e. agreement and withdrawal of agreement).');