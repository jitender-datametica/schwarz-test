create or replace TABLE LDL_DATA_PRODUCTION.META.T_DATA_PROFILING_RULE_1 (
	TEST_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for a data profiling rule.',
	DWH_VALID_FROM_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
	DWH_VALID_TO_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
	DWH_VALID_FG BOOLEAN NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
	PROFILING_RULE_NAME VARCHAR(250) NOT NULL COMMENT 'The name by which the data profiling rule has been defined.',
	PROFILING_RULE_DESCR VARCHAR(250) COMMENT 'A free text describing the character and purpose of the data profiling rule.',
	TESTED_DATA_OBJ_SID NUMBER(38,0) COMMENT 'The unique identifier (surrogate key) of the data object which is the target of this test.',
	TESTED_DATA_STRUCT_NAME VARCHAR(250) COMMENT 'The name of the data structure, which is the target of this test.',
	TESTED_DATA_ELEM_NAME VARCHAR(250) COMMENT 'The name of the data element, which is the target of this test.',
	TEST_RESULT_TYPE_CD VARCHAR(20) NOT NULL COMMENT 'A code identifying the type of result value that is produced by a data profiling rule.',
	TEST_ORIGIN_CD VARCHAR(20) NOT NULL COMMENT 'The code identifying the operational source which defines the test.',
	TEST_LIFECYCLE_STATUS_CD VARCHAR(20) NOT NULL COMMENT 'The code identifying the lifecycle status_1 of a test. E.g. draft, approved, expired, ...',
	SCHEDULING_FREQ_CD VARCHAR(20) COMMENT 'A code defining, how often the data profiling rule is executed. E.g daily, weekly, ...',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_DATA_PROFILING_RULE primary key (TEST_SID, DWH_VALID_FROM_TMSP)
)COMMENT='Data profiling assesses data demographics, such as minimum and maximum values, the number of distinct values or the number of NULL values. (Note that a data profiling rule only returns only one result value, e.g. the minimum value of a column. For calculating the maximum value, a second rule is required.)'
;