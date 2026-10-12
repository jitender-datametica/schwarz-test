create or replace TABLE LDL_PRODUCTION_CLONE_GOOGLE_20260608_1030.P_LEW_CORE.T_STORAGE_TEST_PARAMETER_1 (
	STORAGE_TEST_EXEC_SID NUMBER(38,0) NOT NULL COMMENT 'Surrogate Key for individual test_1 executions.',
	STORAGE_TEST_RESULT_GRP_SID NUMBER(38,0) NOT NULL COMMENT 'Surrogate key for result grouping.',
	STORAGE_TEST_PARAM_TYPE_CD VARCHAR(100) NOT NULL COMMENT 'Type of the parameter for a storage test.',
	PARAM_TXT VARCHAR(1000) COMMENT 'Text value of parameter.',
	PARAM_PCT NUMBER(38,5) COMMENT 'Percent value of parameter.',
	PARAM_MEAS NUMBER(38,5) COMMENT 'Numeric value of a parameter.',
	PARAM_FG NUMBER(38,0) COMMENT 'Flag value of a parameter.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The identifier of the last load run which inserted or updated this row.',
	DWH_CREATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'The timestamp when the row was inserted.',
	DWH_UPDATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'The timestamp when the row was updated the last time.',
	constraint PK_T_STORAGE_TEST_PARAMETER primary key (STORAGE_TEST_EXEC_SID, STORAGE_TEST_RESULT_GRP_SID, STORAGE_TEST_PARAM_TYPE_CD)
)COMMENT='A table that stores values of parameters used in the storage test_1 run.\n             Source: FTM'
;
