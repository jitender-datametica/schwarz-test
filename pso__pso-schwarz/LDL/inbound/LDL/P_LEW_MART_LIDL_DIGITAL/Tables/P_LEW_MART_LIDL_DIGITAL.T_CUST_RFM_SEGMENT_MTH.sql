create or replace TABLE LDL_PRODUCTION_CLONE_GOOGLE_20260608_1030.P_LEW_MART_LIDL_DIGITAL.T_CUST_RFM_SEGMENT_MTH (
	GEO_AREA_SID NUMBER(38,0) NOT NULL COMMENT 'Identifier for a client',
	CY_MONTH NUMBER(38,0) NOT NULL COMMENT 'Month identifier',
	MODEL_SID NUMBER(38,0) NOT NULL COMMENT 'ID of a rfm model',
	MTH_M_SEGMENT_SID NUMBER(38,0) NOT NULL DEFAULT 0 COMMENT 'ids of monetary segments from rfm model',
	MTH_RF_SEGMENT_SID NUMBER(38,0) NOT NULL DEFAULT 0 COMMENT 'ids of recency-frequency segments from rfm model',
	MTH_ST_SEGMENT_SID NUMBER(38,0) NOT NULL DEFAULT 0 COMMENT 'ids of strategic segments from rfm model',
	MTH_FR_SEGMENT_SID NUMBER(38,0) NOT NULL DEFAULT 0 COMMENT 'ids of frequency segments from rfm model',
	MTH_MO_SEGMENT_SID NUMBER(38,0) NOT NULL DEFAULT 0 COMMENT 'ids of new monetary segments from rfm model',
	MTH_RE_SEGMENT_SID NUMBER(38,0) NOT NULL DEFAULT 0 COMMENT 'ids of recency segments from rfm model',
	CUSTOMER_SID NUMBER(38,0) NOT NULL COMMENT 'Surrogate Key CUSTOMER',
	LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'Load identifier',
	DWH_CREATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Row create time',
	DWH_UPDATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Row update time',
	constraint PK_CUST_RFM_SEGMENT_MTH primary key (MODEL_SID, CY_MONTH, GEO_AREA_SID, CUSTOMER_SID)
)COMMENT='Lidlplus : month level of recency-frequency and monetary segments per customer'
;