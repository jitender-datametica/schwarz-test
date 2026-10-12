create or replace TABLE LDL_PRODUCTION_CLONE_GOOGLE_20260608_1030.P_LEW_MART_LIDL_DIGITAL.T_REF_RECENCY_SEGMENT_WK_1 (
	WK_RE_SEGMENT_SID NUMBER(38,0) NOT NULL COMMENT 'Ids of recency segments from rfm model - used (MTH_RE_SEGMENT_SID) to select p_lew_core.t_ref_segment.segment_sid',
	WK_RE_SEGMENT_NAME VARCHAR(100) NOT NULL COMMENT 'Recency segments',
	WK_RE_SEGMENT_DESCR VARCHAR(250) COMMENT 'Exact description of recency from rfm model',
	LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'Load identifier',
	DWH_CREATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Row create time',
	DWH_UPDATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Row update time',
	constraint PK_REF_RE_SEGMENT_WK primary key (WK_RE_SEGMENT_SID)
)COMMENT='Lidlplus : Recency segments - referenece'
;
