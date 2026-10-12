create or replace view LDL_PRODUCTION_CLONE_GOOGLE_20260608_1030.P_LEW_MART_LIDL_DIGITAL_AC.V_AGG_CUST_REG_DEREG_LDPL_MTH_1(
	CLIENT_ID COMMENT 'Client Identifier',
	CY_MONTH COMMENT 'Month identifier',
	HARMO_CAL_MONTH_NO COMMENT 'Harmonized month no  per country_1 - month since rollout',
	GENDER_CD COMMENT 'The code for the gender',
	AGE_RANGE_CD COMMENT 'The code for the age range.',
	HOUSEHOLD_TYPE_ID COMMENT 'ID of the household type in which the customer lives.',
	CHILD_AGE_RANGE_GROUP_ID COMMENT 'Group of one or more age ranges in which the child is categorized depending on the age.',
	DISTINCT_REG_USER_FG COMMENT 'Distinct registered user flag. Y - registered users for INT',
	REG_INTERFACE_ID COMMENT 'ID of the registration interface through which the user registered or reregistered for the geographical area in the loyalty program by accepting the legal terms the first time.',
	MTH_M_SEGMENT_SID COMMENT 'ids of monetary segments from rfm model',
	MTH_RF_SEGMENT_SID COMMENT 'ids of recency-frequency segments from rfm model',
	MTH_ST_SEGMENT_SID COMMENT 'ids of new STRATEGIC segments from rfm model',
	MTH_FR_SEGMENT_SID COMMENT 'ids of new FREQUENCY segments from rfm model',
	MTH_RE_SEGMENT_SID COMMENT 'ids of new RECENCY segments from rfm model',
	MTH_MO_SEGMENT_SID COMMENT 'ids of new monetary segments from rfm model',
	CM_REG_CNT COMMENT 'Number of registrations for given month',
	PM_REG_CNT COMMENT 'Number of registrations for previous month',
	PYM_REG_CNT COMMENT 'Number of registrations for previous year month',
	CM_TOTAL_REG_CNT COMMENT 'Number of total registrations since reporting_start_dt to given month',
	PM_TOTAL_REG_CNT COMMENT 'Number of total registrations since reporting_start_dt to previous month',
	PYM_TOTAL_REG_CNT COMMENT 'Number of total registrations since reporting_start_dt to previous year month',
	CM_DEREG_CNT COMMENT 'Number of deregistrations for given month',
	PM_DEREG_CNT COMMENT 'Number of deregistrations for previous month',
	PYM_DEREG_CNT COMMENT 'Number of deregistrations for previous year month',
	CM_TOTAL_DEREG_CNT COMMENT 'Number of total deregistrations since reporting_start_dt to given month',
	PM_TOTAL_DEREG_CNT COMMENT 'Number of total deregistrations since reporting_start_dt to previous month',
	PYM_TOTAL_DEREG_CNT COMMENT 'Number of total deregistrations since reporting_start_dt to previous year month',
	CM_NEW_REG_CNT COMMENT 'Number of new registrations for given month',
	PM_NEW_REG_CNT COMMENT 'Number of new registrations for previous month',
	PYM_NEW_REG_CNT COMMENT 'Number of new registrations for previous year month',
	CM_TOTAL_NEW_REG_CNT COMMENT 'Number of total new registrations since reporting_start_dt to given month',
	PM_TOTAL_NEW_REG_CNT COMMENT 'Number of total new registrations since reporting_start_dt to previous month',
	PYM_TOTAL_NEW_REG_CNT COMMENT 'Number of total new registrations since reporting_start_dt to previous year month',
	LOAD_ID COMMENT 'Load identifier',
	DWH_CREATED COMMENT 'Row created time',
	DWH_UPDATED COMMENT 'Row update time'
) as 
SELECT
 CLIENT_ID
,CY_MONTH
,HARMO_CAL_MONTH_NO
,GENDER_CD 
,AGE_RANGE_CD 
,HOUSEHOLD_TYPE_ID 
,CHILD_AGE_RANGE_GROUP_ID 
,DISTINCT_REG_USER_FG

,REG_INTERFACE_ID 
,MTH_M_SEGMENT_SID
,MTH_RF_SEGMENT_SID 
,MTH_ST_SEGMENT_SID
,MTH_FR_SEGMENT_SID
,MTH_RE_SEGMENT_SID
,MTH_MO_SEGMENT_SID
,CM_REG_CNT
,PM_REG_CNT
,PYM_REG_CNT
,CM_TOTAL_REG_CNT
,PM_TOTAL_REG_CNT
,PYM_TOTAL_REG_CNT
,CM_DEREG_CNT
,PM_DEREG_CNT
,PYM_DEREG_CNT
,CM_TOTAL_DEREG_CNT
,PM_TOTAL_DEREG_CNT
,PYM_TOTAL_DEREG_CNT
,CM_NEW_REG_CNT
,PM_NEW_REG_CNT
,PYM_NEW_REG_CNT
,CM_TOTAL_NEW_REG_CNT
,PM_TOTAL_NEW_REG_CNT
,PYM_TOTAL_NEW_REG_CNT
,LOAD_ID
,DWH_CREATED
,DWH_UPDATED
FROM P_LEW_MART_LIDL_DIGITAL.V_AGG_CUST_REG_DEREG_LDPL_MTH_1
;
