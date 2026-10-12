create or replace TABLE LDL_PRODUCTION_CLONE_GOOGLE_20260608_1030.P_LEW_MART_LIDL_DIGITAL.T_REF_FREQUENCY_SEGMENT_MTH_2 (
	MTH_FR_SEGMENT_SID NUMBER(38,0) NOT NULL COMMENT 'Ids of frequency segments from rfm model - used (MTH_RF_SEGMENT_SID) to select p_lew_core.t_ref_segment.segment_sid',
	MTH_FR_SEGMENT_NAME VARCHAR(100) NOT NULL COMMENT 'frequency segments',
	MTH_FR_SEGMENT_DESCR VARCHAR(250) COMMENT 'Exact description of frequency from rfm model',
	LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'Load identifier',
	DWH_CREATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Row create time',
	DWH_UPDATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Row update time',
	constraint PK_REF_FR_SEGMENT_MTH primary key (MTH_FR_SEGMENT_SID)
)COMMENT='Lidlplus : frequency segments - referenece'
;
