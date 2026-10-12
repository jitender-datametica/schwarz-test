create or replace TABLE LDL_DATA_PRODUCTION.META.T_DATA_CLEANSING_LOG (
	LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the execution of an ETL job.',
	DATA_ELEM_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) of the data element, to which the data cleansing rule has been applied.',
	DATA_CLEANSING_RULE_NAME VARCHAR(100) NOT NULL COMMENT 'The unique identifier (surrogate key) for the data cleansing rule.',
	REC_CNT NUMBER(38,0) NOT NULL COMMENT 'The number of records which have been corrected by this data cleansing rule.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_DATA_CLEANSING_LOG primary key (DATA_CLEANSING_RULE_NAME, DATA_ELEM_SID, LOAD_ID)
)COMMENT='ETL jobs need to cater for less than optimal quality in the source data. Depending on the mapping specification certain error scenarios might automatically get corrected. E.g. missing columns in the source record might be filled with default values. This log table tracks, how often a data cleansing rule has been applied.'
;