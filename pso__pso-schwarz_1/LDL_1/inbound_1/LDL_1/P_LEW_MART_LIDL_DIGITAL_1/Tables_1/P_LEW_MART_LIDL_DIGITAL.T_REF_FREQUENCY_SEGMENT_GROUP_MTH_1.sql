create or replace TABLE LDL_PRODUCTION_CLONE_GOOGLE_20260608_1030.P_LEW_MART_LIDL_DIGITAL.T_REF_FREQUENCY_SEGMENT_GROUP_MTH_1 (
	MTH_FR_SEGMENT_GROUP_SID NUMBER(38,0) NOT NULL COMMENT 'ids of frequency segments group',
	MTH_FR_SEGMENT_GROUP_NAME VARCHAR(100) NOT NULL COMMENT 'frequency segments group',
	MTH_FR_SEGMENT_GROUP_ACTIVE_FG NUMBER(38,0) NOT NULL COMMENT 'Description for segment activation, 0 - inactive, 1 - active',
	MTH_FR_SEGMENT_GROUP_ACTIVE_FG_NAME VARCHAR(20) NOT NULL COMMENT 'Description for Segment Activation',
	MTH_FR_SEGMENT_SID NUMBER(38,0) NOT NULL COMMENT 'ids of frequency segments from rfm model',
	LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'Load identifier',
	DWH_CREATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Row create time',
	DWH_UPDATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Row update time',
	constraint PK_REF_FR_SEGMENT_MTH primary key (MTH_FR_SEGMENT_SID)
)COMMENT='Lidlplus : frequency segments group - reference'
;
