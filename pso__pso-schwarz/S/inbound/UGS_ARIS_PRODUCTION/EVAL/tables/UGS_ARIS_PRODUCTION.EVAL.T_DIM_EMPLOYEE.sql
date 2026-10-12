create or replace TABLE UGS_ARIS_PRODUCTION.EVAL.T_DIM_EMPLOYEE (
	EMP_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the employee.',
	DWH_VALID_FROM_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
	DWH_VALID_TO_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
	DWH_VALID_FG BOOLEAN NOT NULL COMMENT 'An indicator showing the current record in history.',
	EMP_NAME VARCHAR(100) NOT NULL COMMENT 'The name (first name and last name) of the employee.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
	DWH_SRC_FILE_NAME VARCHAR(100) COMMENT 'The path and the name of the file(s) from which this record was loaded.',
	SRC_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.'
);