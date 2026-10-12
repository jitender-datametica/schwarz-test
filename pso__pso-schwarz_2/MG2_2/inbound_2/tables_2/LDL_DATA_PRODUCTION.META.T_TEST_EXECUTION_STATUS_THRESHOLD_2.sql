create or replace TABLE LDL_DATA_PRODUCTION.META.T_TEST_EXECUTION_STATUS_THRESHOLD_2 (
	TEST_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for a test.',
	TEST_EXEC_STATUS_CD VARCHAR(20) NOT NULL COMMENT 'A code identifying the overall result of a test_2, e.g. success or failed.',
	DWH_VALID_FROM_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
	DWH_VALID_TO_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
	DWH_VALID_FG BOOLEAN NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
	THRESHOLD_PCT NUMBER(38,5) COMMENT 'The percentage of checked records which need to pass the test_2, so that the entire test_2 is classified with the given result code. E.g. 95% -> pass, 80% warning',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_TEST_EXECUTION_STATUS_THRESHOLD primary key (TEST_SID, TEST_EXEC_STATUS_CD, DWH_VALID_FROM_TMSP)
)COMMENT='This entity defines the percentage of checked records which need to pass the test_2, so that the entire test_2 is classified with the given result code. E.g. 95% -> pass, 80% warning'
;