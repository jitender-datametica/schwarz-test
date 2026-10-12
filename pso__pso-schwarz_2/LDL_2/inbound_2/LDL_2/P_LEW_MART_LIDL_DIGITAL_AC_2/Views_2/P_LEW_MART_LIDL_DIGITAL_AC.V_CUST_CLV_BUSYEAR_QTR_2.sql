create or replace view LDL_PRODUCTION_CLONE_GOOGLE_20260608_1030.P_LEW_MART_LIDL_DIGITAL_AC.V_CUST_CLV_BUSYEAR_QTR_2(
	CLIENT_ID COMMENT 'Identifier for client',
	GEO_AREA_SID COMMENT 'Ceographical identifier for client',
	CURRENCY_ISO_CD COMMENT 'ISO code for the currency of the client.',
	CURR_TOT_ID COMMENT 'Fixe Werte fuer EUR=0, GBP=40 sonst Client_Id',
	BUSYEAR_QTR COMMENT 'Business year quarter identifier',
	BUSYEAR_QTR_PREV_1Q COMMENT 'Quarter of the business one quarter ago',
	BUSYEAR_QTR_PREV_1Y COMMENT 'Business year quarter identifier 1 year ago',
	BUSYEAR_QTR_M_SEGMENT_SID COMMENT 'ids of monetary segments from rfm model',
	BUSYEAR_QTR_RF_SEGMENT_SID COMMENT 'ids of recency-frequency segments from rfm model',
	GENDER_CD COMMENT 'The code for the gender',
	AGE_RANGE_CD COMMENT 'The code for the age range.',
	HOUSEHOLD_TYPE_ID COMMENT 'ID of the household type in which the customer lives.',
	CHILD_AGE_RANGE_GROUP_ID COMMENT 'Group of one or more age ranges in which the child is categorized depending on the age.',
	CUSTOMER_SID COMMENT 'Customer identifier',
	CLV_365_DAYS COMMENT 'result of the calculation of a score type for an individual customer in a certain model run.',
	LOAD_ID COMMENT 'Load identifier',
	DWH_CREATED COMMENT 'Row create time',
	DWH_UPDATED COMMENT 'Row update time'
) COMMENT='Lidlplus table :  KPIs show the Lidl Plus clv 365 per business year quarter'
 as
SELECT
 t.client_id
,t.geo_area_sid
,t.currency_iso_cd            
,t.curr_tot_id                
,t.busyear_qtr
,t.busyear_qtr_prev_1q
,t.busyear_qtr_prev_1y
,t.busyear_qtr_m_segment_sid
,t.busyear_qtr_rf_segment_sid
,t.gender_cd
,t.age_range_cd
,t.household_type_id
,t.child_age_range_group_id
,t.customer_sid
,t.clv_365_days
,t.load_id
,t.dwh_created
,t.dwh_updated
FROM p_lew_mart_lidl_digital.v_cust_clv_busyear_qtr_2 AS t
;
