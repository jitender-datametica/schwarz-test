create or replace view LDL_PRODUCTION_CLONE_GOOGLE_20260608_1030.P_LEW_MART_LIDL_DIGITAL_AC.V_CUST_RFM_SEGMENT_WK(
	GEO_AREA_SID COMMENT 'Identifier for a client',
	CY_WEEK COMMENT 'Week identifier',
	MODEL_SID COMMENT 'ID of a rfm model',
	WK_M_SEGMENT_SID COMMENT 'ids of monetary segments from rfm model',
	WK_RF_SEGMENT_SID COMMENT 'ids of recency-frequency segments from rfm model',
	WK_ST_SEGMENT_SID COMMENT 'ids of new strategic segments from rfm model',
	WK_FR_SEGMENT_SID COMMENT 'ids of new frequency segments from rfm model',
	WK_RE_SEGMENT_SID COMMENT 'ids of new recency segments from rfm model',
	WK_MO_SEGMENT_SID COMMENT 'ids of new monetary segments from rfm model',
	CUSTOMER_SID COMMENT 'Surrogate Key CUSTOMER',
	LOAD_ID COMMENT 'Load identifier',
	DWH_CREATED COMMENT 'Row create time',
	DWH_UPDATED COMMENT 'Row update time'
) as
SELECT
 GEO_AREA_SID
,CY_WEEK
,MODEL_SID
,WK_M_SEGMENT_SID
,WK_RF_SEGMENT_SID
,WK_ST_SEGMENT_SID
,WK_FR_SEGMENT_SID
,WK_RE_SEGMENT_SID
,WK_MO_SEGMENT_SID
,CUSTOMER_SID
,LOAD_ID
,DWH_CREATED
,DWH_UPDATED
FROM P_LEW_MART_LIDL_DIGITAL.V_CUST_RFM_SEGMENT_WK 
;
