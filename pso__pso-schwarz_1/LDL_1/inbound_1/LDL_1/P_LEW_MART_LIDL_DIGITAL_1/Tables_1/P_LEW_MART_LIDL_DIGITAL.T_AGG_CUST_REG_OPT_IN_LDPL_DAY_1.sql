create or replace TABLE LDL_PRODUCTION_CLONE_GOOGLE_20260608_1030.P_LEW_MART_LIDL_DIGITAL.T_AGG_CUST_REG_OPT_IN_LDPL_DAY_1 (
	CLIENT_ID NUMBER(38,0) NOT NULL COMMENT 'Client identifier',
	DWH_CAL_DT DATE NOT NULL COMMENT 'Data date',
	GENDER_CD VARCHAR(5) NOT NULL COMMENT 'The code for the gender',
	AGE_RANGE_CD VARCHAR(10) NOT NULL COMMENT 'The code for the age range.',
	DISTINCT_REG_USER_FG VARCHAR(1) NOT NULL COMMENT 'Distinct registered user flag. Y - registered users for INT',
	REG_INTERFACE_ID NUMBER(38,0) NOT NULL COMMENT 'Id of the registration interface through which the user registered or reregistered for the geographical area in the loyalty program by accepting the legal terms the first time.',
	PUSH_CONTACT_CONSENT_FG NUMBER(38,0) COMMENT 'flag for push optIn type',
	EMAIL_CONTACT_CONSENT_FG NUMBER(38,0) COMMENT 'flag for email optIn type',
	SMS_CONTACT_CONSENT_FG NUMBER(38,0) COMMENT 'flag for sms optIn type',
	POSTAL_CONTACT_CONSENT_FG NUMBER(38,0) COMMENT 'flag for postal optIn type',
	WHATSAPP_CONTACT_CONSENT_FG NUMBER(38,0) COMMENT 'flag for pwhatsapp optIn type',
	REG_CNT NUMBER(38,0) COMMENT 'Number of registrations for given day',
	LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'Load identifier',
	DWH_CREATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Row created time',
	DWH_UPDATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Row update time',
	constraint PK_CUST_REG_DEREG_LDPL_DAY primary key (CLIENT_ID, DWH_CAL_DT, GENDER_CD, AGE_RANGE_CD, DISTINCT_REG_USER_FG)
)COMMENT=' Lidlplus: Table to provide registration opr_in flags of customers count at day level'
;
