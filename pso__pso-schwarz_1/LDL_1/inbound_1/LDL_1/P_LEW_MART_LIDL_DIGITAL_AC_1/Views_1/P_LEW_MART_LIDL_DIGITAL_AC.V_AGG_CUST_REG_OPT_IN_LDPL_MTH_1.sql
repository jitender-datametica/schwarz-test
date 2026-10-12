create or replace view LDL_PRODUCTION_CLONE_GOOGLE_20260608_1030.P_LEW_MART_LIDL_DIGITAL_AC.V_AGG_CUST_REG_OPT_IN_LDPL_MTH_1(
	CLIENT_ID COMMENT 'Client Identifier',
	CY_MONTH COMMENT 'Month identifier',
	HARMO_CAL_MONTH_NO COMMENT 'Harmonized month no  per country_1 - month since rollout',
	GENDER_CD COMMENT 'The code for the gender',
	AGE_RANGE_CD COMMENT 'The code for the age range.',
	DISTINCT_REG_USER_FG COMMENT 'Distinct registered user flag. Y - registered users for INT',
	REG_INTERFACE_ID COMMENT 'ID of the registration interface through which the user registered or reregistered for the geographical area in the loyalty program by accepting the legal terms the first time.',
	PUSH_CONTACT_CONSENT_FG COMMENT 'flag for push optIn type',
	EMAIL_CONTACT_CONSENT_FG COMMENT 'flag for email optIn type',
	SMS_CONTACT_CONSENT_FG COMMENT 'flag for sms optIn type',
	POSTAL_CONTACT_CONSENT_FG COMMENT 'flag for postal optIn type',
	WHATSAPP_CONTACT_CONSENT_FG COMMENT 'flag for pwhatsapp optIn type',
	CM_REG_CNT COMMENT 'Number of registrations for given month',
	PM_REG_CNT COMMENT 'Number of registrations for previous month',
	PYM_REG_CNT COMMENT 'Number of registrations for previous year month',
	LOAD_ID COMMENT 'Load identifier',
	DWH_CREATED COMMENT 'Row created time',
	DWH_UPDATED COMMENT 'Row update time'
) COMMENT=' Lidlplus view : Table to provide registration opt-in of customers count at month level'
 as 
SELECT
 CLIENT_ID
,CY_MONTH
,HARMO_CAL_MONTH_NO
,GENDER_CD 
,AGE_RANGE_CD 
,DISTINCT_REG_USER_FG
,REG_INTERFACE_ID 
,PUSH_CONTACT_CONSENT_FG
,EMAIL_CONTACT_CONSENT_FG
,SMS_CONTACT_CONSENT_FG
,POSTAL_CONTACT_CONSENT_FG
,WHATSAPP_CONTACT_CONSENT_FG
,CM_REG_CNT
,PM_REG_CNT
,PYM_REG_CNT
,LOAD_ID
,DWH_CREATED
,DWH_UPDATED
FROM P_LEW_MART_LIDL_DIGITAL.V_AGG_CUST_REG_OPT_IN_LDPL_MTH_1
;
