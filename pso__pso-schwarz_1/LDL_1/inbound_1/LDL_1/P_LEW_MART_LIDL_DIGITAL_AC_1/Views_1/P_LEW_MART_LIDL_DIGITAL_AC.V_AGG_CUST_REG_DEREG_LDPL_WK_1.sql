create or replace view LDL_PRODUCTION_CLONE_GOOGLE_20260608_1030.P_LEW_MART_LIDL_DIGITAL_AC.V_AGG_CUST_REG_DEREG_LDPL_WK_1(
	CLIENT_ID COMMENT 'Client Identifier',
	CY_WEEK COMMENT 'Week identifier',
	HARMO_CAL_WEEK_NO COMMENT 'Harmonized week no per country_1 - week since rollout',
	GENDER_CD COMMENT 'The code for the gender',
	AGE_RANGE_CD COMMENT 'The code for the age range.',
	HOUSEHOLD_TYPE_ID COMMENT 'ID of the household type in which the customer lives.',
	CHILD_AGE_RANGE_GROUP_ID COMMENT 'Group of one or more age ranges in which the child is categorized depending on the age.',
	DISTINCT_REG_USER_FG COMMENT 'Distinct registered user flag. Y - registered users for INT',
	REG_INTERFACE_ID COMMENT 'ID of the registration interface through which the user registered or reregistered for the geographical area in the loyalty program by accepting the legal terms the first time.',
	WK_M_SEGMENT_SID COMMENT 'ids of monetary segments from rfm model',
	WK_RF_SEGMENT_SID COMMENT 'ids of recency-frequency segments from rfm model',
	WK_ST_SEGMENT_SID COMMENT 'ids of strategic segments from rfm model',
	WK_FR_SEGMENT_SID COMMENT 'ids of frequency segments from rfm model',
	WK_MO_SEGMENT_SID COMMENT 'ids of new monetary segments from rfm model',
	WK_RE_SEGMENT_SID COMMENT 'ids of recency segments from rfm model',
	CW_REG_CNT COMMENT 'Number of registrations for given week',
	PW_REG_CNT COMMENT 'Number of registrations for previous week',
	PYW_REG_CNT COMMENT 'Number of registrations for previous year week',
	CW_TOTAL_REG_CNT COMMENT 'Number of total registrations since reporting_start_dt to given week',
	PW_TOTAL_REG_CNT COMMENT 'Number of total registrations since reporting_start_dt to previous week',
	PYW_TOTAL_REG_CNT COMMENT 'Number of total registrations since reporting_start_dt to previous year week',
	CW_DEREG_CNT COMMENT 'Number of deregistrations for given week',
	PW_DEREG_CNT COMMENT 'Number of deregistrations for previous week',
	PYW_DEREG_CNT COMMENT 'Number of deregistrations for previous year week',
	CW_TOTAL_DEREG_CNT COMMENT 'Number of total deregistrations since reporting_start_dt to given week',
	PW_TOTAL_DEREG_CNT COMMENT 'Number of total deregistrations since reporting_start_dt to previous week',
	PYW_TOTAL_DEREG_CNT COMMENT 'Number of total deregistrations since reporting_start_dt to previous year week',
	CW_NEW_REG_CNT COMMENT 'Number of new registrations for given week',
	PW_NEW_REG_CNT COMMENT 'Number of new registrations for previous week',
	PYW_NEW_REG_CNT COMMENT 'Number of new registrations for previous year week',
	CW_TOTAL_NEW_REG_CNT COMMENT 'Number of total new registrations since reporting_start_dt to given week',
	PW_TOTAL_NEW_REG_CNT COMMENT 'Number of total new registrations since reporting_start_dt to previous week',
	PYW_TOTAL_NEW_REG_CNT COMMENT 'Number of total new registrations since reporting_start_dt to previous year week',
	LOAD_ID COMMENT 'Load identifier',
	DWH_CREATED COMMENT 'Row created time',
	DWH_UPDATED COMMENT 'Row update time'
) as 
SELECT
 CLIENT_ID
,CY_WEEK
,HARMO_CAL_WEEK_NO
,GENDER_CD 
,AGE_RANGE_CD 
,HOUSEHOLD_TYPE_ID 
,CHILD_AGE_RANGE_GROUP_ID 
,DISTINCT_REG_USER_FG
,REG_INTERFACE_ID
,WK_M_SEGMENT_SID
,WK_RF_SEGMENT_SID
,WK_ST_SEGMENT_SID
,WK_FR_SEGMENT_SID
,WK_MO_SEGMENT_SID
,WK_RE_SEGMENT_SID
,CW_REG_CNT
,PW_REG_CNT
,PYW_REG_CNT
,CW_TOTAL_REG_CNT
,PW_TOTAL_REG_CNT
,PYW_TOTAL_REG_CNT
,CW_DEREG_CNT
,PW_DEREG_CNT
,PYW_DEREG_CNT
,CW_TOTAL_DEREG_CNT
,PW_TOTAL_DEREG_CNT
,PYW_TOTAL_DEREG_CNT
,CW_NEW_REG_CNT
,PW_NEW_REG_CNT
,PYW_NEW_REG_CNT
,CW_TOTAL_NEW_REG_CNT
,PW_TOTAL_NEW_REG_CNT
,PYW_TOTAL_NEW_REG_CNT
,LOAD_ID
,DWH_CREATED
,DWH_UPDATED
FROM P_LEW_MART_LIDL_DIGITAL.V_AGG_CUST_REG_DEREG_LDPL_WK_1
;
