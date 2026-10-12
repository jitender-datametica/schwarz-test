create or replace TABLE LDL_PRODUCTION_CLONE_GOOGLE_20260608_1030.P_LEW_MART_LIDL_DIGITAL.T_REF_MONETARY_SEGMENT_WK_2 (
	WK_MO_SEGMENT_SID NUMBER(38,0) NOT NULL COMMENT 'ids of NEW monetary segments from rfm model',
	WK_MO_SEGMENT_NAME VARCHAR(100) NOT NULL COMMENT 'NEW monetary segments, m_segment: high, medium, low',
	WK_MO_SEGMENT_DESCR VARCHAR(250) COMMENT 'exact description of NEW monetary segments from rfm model',
	LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'Load identifier',
	DWH_CREATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Row create time',
	DWH_UPDATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Row update time',
	constraint PK_MONETARY_WK primary key (WK_MO_SEGMENT_SID)
)COMMENT='Lidlplus : NEW monetary segments - referenece table'
;
