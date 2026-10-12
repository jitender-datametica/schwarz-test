create or replace TABLE LDL_PRODUCTION_CLONE_GOOGLE_20260608_1030.P_LEW_CORE.T_STORAGE_TEST_RESULT (
	STORAGE_TEST_EXEC_SID NUMBER(38,0) NOT NULL COMMENT 'Surrogate Key for individual test execution.',
	STORAGE_TEST_RESULT_GRP_SID NUMBER(38,0) NOT NULL COMMENT 'Surrogate key for result grouping.',
	STORAGE_TEST_METRIC_TYPE_CD VARCHAR(100) NOT NULL COMMENT 'Type of measure in a storage test.',
	CURR_SID NUMBER(38,0) COMMENT 'Surrogate Key CURRENCY.',
	ACTUAL_VAL NUMBER(38,5) COMMENT 'The actual value of the metrics.',
	ANTICIPATED_VAL NUMBER(38,5) COMMENT 'The expected value of the metrics.',
	SPREAD_PCT NUMBER(38,5) COMMENT 'The result spread.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The identifier of the last load run which inserted or updated this row.',
	DWH_CREATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'The timestamp when the row was inserted.',
	DWH_UPDATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'The timestamp when the row was updated the last time.',
	constraint PK_T_STORAGE_TEST_RESULT primary key (STORAGE_TEST_EXEC_SID, STORAGE_TEST_RESULT_GRP_SID, STORAGE_TEST_METRIC_TYPE_CD)
)COMMENT='A table that stores results for a storage test run.\n             Source: FTM '
;
