create or replace view LDL_PRODUCTION_CLONE_GOOGLE_20260608_1030.P_LEW_MART_LIDL_DIGITAL_AC.V_AGG_CUST_REG_DEREG_LDPL_DAY_2(
	CLIENT_ID COMMENT 'Client identifier',
	DWH_CAL_DT COMMENT 'Data date',
	GENDER_CD COMMENT 'The code for the gender',
	AGE_RANGE_CD COMMENT 'The code for the age range.',
	HOUSEHOLD_TYPE_ID COMMENT 'ID of the household type in which the customer lives.',
	CHILD_AGE_RANGE_GROUP_ID COMMENT 'Group of one or more age ranges in which the child is categorized depending on the age.',
	DISTINCT_REG_USER_FG COMMENT 'Distinct registered user flag. Y - registered users for INT',
	REG_INTERFACE_ID COMMENT 'ID of the registration interface through which the user registered or reregistered for the geographical area in the loyalty program by accepting the legal terms the first time.',
	REG_CNT COMMENT 'Number of registrations for given day',
	TOTAL_REG_CNT COMMENT 'Number of total registrations since reporting_start_dt to given day',
	DEREG_CNT COMMENT 'Number of deregistrations for given day',
	TOTAL_DEREG_CNT COMMENT 'Number of total deregistrations since reporting_start_dt to given day',
	NEW_REG_CNT COMMENT 'Number of new registrations for given day',
	TOTAL_NEW_REG_CNT COMMENT 'Number of total new registrations since reporting_start_dt to given day',
	LOAD_ID COMMENT 'Load identifier',
	DWH_CREATED COMMENT 'Row created time',
	DWH_UPDATED COMMENT 'Row update time'
) as
SELECT 
 CLIENT_ID
,DWH_CAL_DT
,GENDER_CD 
,AGE_RANGE_CD 
,HOUSEHOLD_TYPE_ID
,CHILD_AGE_RANGE_GROUP_ID
,DISTINCT_REG_USER_FG
,REG_INTERFACE_ID 
,REG_CNT
,TOTAL_REG_CNT
,DEREG_CNT
,TOTAL_DEREG_CNT
,NEW_REG_CNT
,TOTAL_NEW_REG_CNT
,LOAD_ID
,DWH_CREATED
,DWH_UPDATED
FROM P_LEW_MART_LIDL_DIGITAL.V_AGG_CUST_REG_DEREG_LDPL_DAY_2;
