create or replace view LDL_PRODUCTION_CLONE_GOOGLE_20260608_1030.P_LEW_MART_LIDL_DIGITAL_AC.V_CUST_RFM_SEGMENT_MTH_1(
	GEO_AREA_SID COMMENT 'Identifier for a client',
	CY_MONTH COMMENT 'Month identifier',
	MODEL_SID COMMENT 'ID of a rfm model',
	MTH_M_SEGMENT_SID COMMENT 'ids of monetary segments from rfm model',
	MTH_RF_SEGMENT_SID COMMENT 'ids of recency-frequency segments from rfm model',
	MTH_ST_SEGMENT_SID COMMENT 'ids of new strategic segments from rfm model',
	MTH_FR_SEGMENT_SID COMMENT 'ids of new frequency segments from rfm model',
	MTH_RE_SEGMENT_SID COMMENT 'ids of new recency segments from rfm model',
	MTH_MO_SEGMENT_SID COMMENT 'ids of new monetary segments from rfm model',
	CUSTOMER_SID COMMENT 'Surrogate Key CUSTOMER',
	LOAD_ID COMMENT 'Load identifier',
	DWH_CREATED COMMENT 'Row create time',
	DWH_UPDATED COMMENT 'Row update time'
) as
SELECT
 GEO_AREA_SID
,CY_MONTH
,MODEL_SID
,MTH_M_SEGMENT_SID
,MTH_RF_SEGMENT_SID
,MTH_ST_SEGMENT_SID
,MTH_FR_SEGMENT_SID
,MTH_RE_SEGMENT_SID
,MTH_MO_SEGMENT_SID
,CUSTOMER_SID
,LOAD_ID
,DWH_CREATED
,DWH_UPDATED
FROM P_LEW_MART_LIDL_DIGITAL.V_CUST_RFM_SEGMENT_MTH_1 
;
