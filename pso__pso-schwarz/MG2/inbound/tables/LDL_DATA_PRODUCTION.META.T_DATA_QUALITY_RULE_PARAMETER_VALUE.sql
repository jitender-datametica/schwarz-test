create or replace TABLE LDL_DATA_PRODUCTION.META.T_DATA_QUALITY_RULE_PARAMETER_VALUE (
	TEST_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for a parametrized formal data quality rule.',
	DQ_RULE_PARAM_NAME VARCHAR(100) NOT NULL COMMENT 'The code identifying the parameter which need to be set for parametrized data quality rules.',
	DWH_VALID_FROM_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
	DWH_VALID_TO_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
	DWH_VALID_FG BOOLEAN NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
	DQ_RULE_PARAM_TXT VARCHAR(1000) NOT NULL COMMENT 'The value which is used for the given parameter type.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_DATA_QUALITY_RULE_PARAMETER_VALUE primary key (TEST_SID, DQ_RULE_PARAM_NAME, DWH_VALID_FROM_TMSP)
)COMMENT='This entity tracks the parameter values which have been used to configure a formal data quality rule.'
;