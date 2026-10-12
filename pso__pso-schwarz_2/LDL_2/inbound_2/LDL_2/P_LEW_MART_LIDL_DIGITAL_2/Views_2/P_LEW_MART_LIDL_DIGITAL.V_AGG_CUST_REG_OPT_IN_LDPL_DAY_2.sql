create or replace view LDL_PRODUCTION_CLONE_GOOGLE_20260608_1030.P_LEW_MART_LIDL_DIGITAL.V_AGG_CUST_REG_OPT_IN_LDPL_DAY_2(
	CLIENT_ID COMMENT 'Client identifier',
	DWH_CAL_DT COMMENT 'Data date',
	GENDER_CD COMMENT 'The code for the gender',
	AGE_RANGE_CD COMMENT 'The code for the age range.',
	DISTINCT_REG_USER_FG COMMENT 'Distinct registered user flag. Y - registered users for INT',
	REG_INTERFACE_ID COMMENT 'Id of the registration interface through which the user registered or reregistered for the geographical area in the loyalty program by accepting the legal terms the first time.',
	PUSH_CONTACT_CONSENT_FG COMMENT 'flag for push optIn type',
	EMAIL_CONTACT_CONSENT_FG COMMENT 'flag for email optIn type',
	SMS_CONTACT_CONSENT_FG COMMENT 'flag for sms optIn type',
	POSTAL_CONTACT_CONSENT_FG COMMENT 'flag for postal optIn type',
	WHATSAPP_CONTACT_CONSENT_FG COMMENT 'flag for pwhatsapp optIn type',
	REG_CNT COMMENT 'Number of registrations for given day',
	LOAD_ID COMMENT 'Load identifier',
	DWH_CREATED COMMENT 'Row created time',
	DWH_UPDATED COMMENT 'Row update time'
) COMMENT=' Lidlplus view : Table to provide registration OPT_IN of customers count at day level'
 as
SELECT 
 CLIENT_ID
,DWH_CAL_DT
,GENDER_CD 
,AGE_RANGE_CD 
,DISTINCT_REG_USER_FG
,REG_INTERFACE_ID
,PUSH_CONTACT_CONSENT_FG
,EMAIL_CONTACT_CONSENT_FG
,SMS_CONTACT_CONSENT_FG
,POSTAL_CONTACT_CONSENT_FG
,WHATSAPP_CONTACT_CONSENT_FG
,REG_CNT
,LOAD_ID
,DWH_CREATED
,DWH_UPDATED
FROM P_LEW_MART_LIDL_DIGITAL.T_AGG_CUST_REG_OPT_IN_LDPL_DAY_2;
