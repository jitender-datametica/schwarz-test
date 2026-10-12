create or replace view LDL_PRODUCTION_CLONE_GOOGLE_20260608_1030.P_LEW_MART_LIDL_DIGITAL.V_CUST_CLV_MTH_1(
	CLIENT_ID COMMENT 'Identifier for client',
	GEO_AREA_SID COMMENT 'Ceographical identifier for client',
	CURRENCY_ISO_CD COMMENT 'ISO code for the currency of the client.',
	CURR_TOT_ID COMMENT 'Fixe Werte fuer EUR=0, GBP=40 sonst Client_Id',
	CY_MONTH COMMENT 'Calendar_1 Year+Month in form YYYYMM',
	CY_MONTH_PREV_1M COMMENT 'The calendar_1 month 1 month ago as a number in the form YYYYMM. Eg. 201901. [Month Identifier]',
	CY_MONTH_PREV_1Y COMMENT 'The calendar_1 month 1 year ago as a number in the form YYYYMM. Eg. 201802. [Month Identifier]',
	MTH_RF_SEGMENT_SID COMMENT 'ids of recency-frequency segments from rfm model',
	MTH_M_SEGMENT_SID COMMENT 'ids of monetary segments from rfm model',
	GENDER_CD COMMENT 'The code for the gender',
	AGE_RANGE_CD COMMENT 'The code for the age range.',
	HOUSEHOLD_TYPE_ID COMMENT 'ID of the household type in which the customer lives.',
	CHILD_AGE_RANGE_GROUP_ID COMMENT 'Group of one or more age ranges in which the child is categorized depending on the age.',
	CUSTOMER_SID COMMENT 'Customer identifier',
	CLV_365_DAYS COMMENT 'result of the calculation of a score type for an individual customer in a certain model run.',
	LOAD_ID COMMENT 'Load identifier',
	DWH_CREATED COMMENT 'Row create time',
	DWH_UPDATED COMMENT 'Row update time'
) COMMENT='Lidlplus table :  KPIs show the Lidl Plus clv 365 per month'
 as
SELECT
 t.client_id
,t.geo_area_sid
,t.currency_iso_cd
,t.curr_tot_id
,t.cy_month
,t.cy_month_prev_1m
,t.cy_month_prev_1y
,t.mth_rf_segment_sid
,t.mth_m_segment_sid
,t.gender_cd
,t.age_range_cd
,t.household_type_id
,t.child_age_range_group_id
,t.customer_sid
,t.clv_365_days
,t.load_id
,t.dwh_created
,t.dwh_updated
FROM p_lew_mart_lidl_digital.t_cust_clv_mth_1 AS t
;
