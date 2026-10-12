create or replace TABLE LDL_PRODUCTION_CLONE_GOOGLE_20260608_1030.P_LEW_MART_LIDL_DIGITAL.T_AGG_CUST_REG_OPT_IN_LDPL_MTH_1 (
	CLIENT_ID NUMBER(38,0) NOT NULL COMMENT 'Client Identifier',
	CY_MONTH NUMBER(38,0) NOT NULL COMMENT 'Month identifier',
	HARMO_CAL_MONTH_NO NUMBER(38,0) NOT NULL COMMENT 'Harmonized month no  per country_1 - month since rollout',
	GENDER_CD VARCHAR(5) NOT NULL COMMENT 'The code for the gender',
	AGE_RANGE_CD VARCHAR(10) NOT NULL COMMENT 'The code for the age range.',
	DISTINCT_REG_USER_FG VARCHAR(1) NOT NULL COMMENT 'Distinct registered user flag. Y - registered users for INT',
	REG_INTERFACE_ID NUMBER(38,0) NOT NULL COMMENT 'Id of the registration interface through which the user registered or reregistered for the geographical area in the loyalty program by accepting the legal terms the first time.',
	PUSH_CONTACT_CONSENT_FG NUMBER(38,0) COMMENT 'flag for push optIn type',
	EMAIL_CONTACT_CONSENT_FG NUMBER(38,0) COMMENT 'flag for email optIn type',
	SMS_CONTACT_CONSENT_FG NUMBER(38,0) COMMENT 'flag for sms optIn type',
	POSTAL_CONTACT_CONSENT_FG NUMBER(38,0) COMMENT 'flag for postal optIn type',
	WHATSAPP_CONTACT_CONSENT_FG NUMBER(38,0) COMMENT 'flag for pwhatsapp optIn type',
	CM_REG_CNT NUMBER(38,0) COMMENT 'Number of new registrations for given month',
	PM_REG_CNT NUMBER(38,0) COMMENT 'Number of new registrations for previous month',
	PYM_REG_CNT NUMBER(38,0) COMMENT 'Number of new registrations for previous year month',
	LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'Load identifier',
	DWH_CREATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Row created time',
	DWH_UPDATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Row update time',
	constraint PK_CUST_REG_DEREG_LDPL_MTH primary key (CLIENT_ID, GENDER_CD, AGE_RANGE_CD, DISTINCT_REG_USER_FG, CY_MONTH)
)COMMENT=' Lidlplus: Table to provide opt_in of new registration at month level'
;
