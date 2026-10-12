create or replace TABLE LDL_PRODUCTION_CLONE_GOOGLE_20260608_1030.P_LEW_MART_LIDL_DIGITAL.T_REF_STRATEGIC_SEGMENT_GROUP_MTH_2 (
	MTH_ST_SEGMENT_GROUP_SID NUMBER(38,0) NOT NULL COMMENT 'ids of strategic segments group',
	MTH_ST_SEGMENT_GROUP_NAME VARCHAR(100) NOT NULL COMMENT 'strategic segments group',
	MTH_ST_SEGMENT_GROUP_ACTIVE_FG NUMBER(38,0) NOT NULL COMMENT 'Description for segment activation, 0 - inactive, 1 - active',
	MTH_ST_SEGMENT_GROUP_ACTIVE_FG_NAME VARCHAR(20) NOT NULL COMMENT 'Description for Segment Activation',
	MTH_ST_SEGMENT_SID NUMBER(38,0) NOT NULL COMMENT 'ids of strategic segments from rfm model',
	LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'Load identifier',
	DWH_CREATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Row create time',
	DWH_UPDATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Row update time',
	constraint PK_REF_ST_SEGMENT_MTH primary key (MTH_ST_SEGMENT_SID)
)COMMENT='Lidlplus : strategic segments group - reference'
;
