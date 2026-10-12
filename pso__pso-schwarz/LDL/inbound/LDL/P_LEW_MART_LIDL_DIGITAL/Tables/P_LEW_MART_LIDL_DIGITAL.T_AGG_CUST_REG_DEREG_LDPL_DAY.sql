create or replace TABLE LDL_PRODUCTION_CLONE_GOOGLE_20260608_1030.P_LEW_MART_LIDL_DIGITAL.T_AGG_CUST_REG_DEREG_LDPL_DAY (
	CLIENT_ID NUMBER(38,0) NOT NULL COMMENT 'Client identifier',
	DWH_CAL_DT DATE NOT NULL COMMENT 'Data date',
	GENDER_CD VARCHAR(5) NOT NULL COMMENT 'The code for the gender',
	AGE_RANGE_CD VARCHAR(10) NOT NULL COMMENT 'The code for the age range.',
	HOUSEHOLD_TYPE_ID NUMBER(38,0) NOT NULL COMMENT 'ID of the household type in which the customer lives.',
	CHILD_AGE_RANGE_GROUP_ID NUMBER(38,0) NOT NULL COMMENT 'Group of one or more age ranges in which the child is categorized depending on the age.',
	DISTINCT_REG_USER_FG VARCHAR(1) NOT NULL COMMENT 'Distinct registered user flag. Y - registered users for INT',
	REG_INTERFACE_ID NUMBER(38,0) NOT NULL COMMENT 'Id of the registration interface through which the user registered or reregistered for the geographical area in the loyalty program by accepting the legal terms the first time.',
	REG_CNT NUMBER(38,0) COMMENT 'Number of registrations for given day',
	TOTAL_REG_CNT NUMBER(38,0) COMMENT 'Number of total registrations since reporting_start_dt to given day',
	DEREG_CNT NUMBER(38,0) COMMENT 'Number of deregistrations for given day',
	TOTAL_DEREG_CNT NUMBER(38,0) COMMENT 'Number of total deregistrations since reporting_start_dt to given day',
	NEW_REG_CNT NUMBER(38,0) COMMENT 'Number of new registrations for given day',
	TOTAL_NEW_REG_CNT NUMBER(38,0) COMMENT 'Number of total new registrations since reporting_start_dt to given day',
	LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'Load identifier',
	DWH_CREATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Row created time',
	DWH_UPDATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Row update time',
	constraint PK_CUST_REG_DEREG_LDPL_DAY primary key (CLIENT_ID, DWH_CAL_DT, GENDER_CD, AGE_RANGE_CD, DISTINCT_REG_USER_FG)
)COMMENT=' Lidlplus: Table to provide registration and deregistration of customers count at day level'
;