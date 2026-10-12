create or replace TABLE LDL_PRODUCTION_CLONE_GOOGLE_20260608_1030.P_LEW_MART_LIDL_DIGITAL.T_CUST_RFM_SEGMENT_WK_2 (
	GEO_AREA_SID NUMBER(38,0) NOT NULL COMMENT 'Identifier for a client',
	CY_WEEK NUMBER(38,0) NOT NULL COMMENT 'Week identifier',
	MODEL_SID NUMBER(38,0) NOT NULL COMMENT 'ID of a rfm model',
	WK_M_SEGMENT_SID NUMBER(38,0) NOT NULL DEFAULT 0 COMMENT 'ids of monetary segments from rfm model',
	WK_RF_SEGMENT_SID NUMBER(38,0) NOT NULL DEFAULT 0 COMMENT 'ids of recency-frequency segments from rfm model',
	WK_ST_SEGMENT_SID NUMBER(38,0) NOT NULL DEFAULT 0 COMMENT 'ids of strategic segments from rfm model',
	WK_FR_SEGMENT_SID NUMBER(38,0) NOT NULL DEFAULT 0 COMMENT 'ids of frequency segments from rfm model',
	WK_MO_SEGMENT_SID NUMBER(38,0) NOT NULL DEFAULT 0 COMMENT 'ids of new monetary segments from rfm model',
	WK_RE_SEGMENT_SID NUMBER(38,0) NOT NULL DEFAULT 0 COMMENT 'ids of recency segments from rfm model',
	CUSTOMER_SID NUMBER(38,0) NOT NULL COMMENT 'Surrogate Key CUSTOMER',
	LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'Load identifier',
	DWH_CREATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Row create time',
	DWH_UPDATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Row update time',
	constraint PK_CUST_RFM_SEGMENT_WK primary key (MODEL_SID, CY_WEEK, GEO_AREA_SID, CUSTOMER_SID)
)COMMENT='Lidlplus : week level of recency-frequency and monetary segments per customer'
;