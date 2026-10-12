create or replace TABLE LDL_DATA_PRODUCTION.META.T_FACT_DATA_QUALITY_MEASURE (
	DQ_RULE_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for a data quality rule.',
	CAL_DT DATE NOT NULL COMMENT 'The day represented as a calendar date of the form YYYY-MM-DD. YYYY is the calendar year, MM (between 1 and 12) the calendar month and DD the day of the calendar month (between 1 and 31). ',
	TOTAL_REC_CNT NUMBER(38,0) NOT NULL COMMENT 'The total number of records which were the input for this data quality check.',
	SKIPPED_REC_CNT NUMBER(38,0) NOT NULL COMMENT 'The number of records for which the data quality check was not executed.',
	PASSED_REC_CNT NUMBER(38,0) NOT NULL COMMENT 'The number of records which passed the data quality check.',
	FAILED_REC_CNT NUMBER(38,0) NOT NULL COMMENT 'The number of records which failed the data quality check.',
	TEST_EXEC_STATUS_CD VARCHAR(20) NOT NULL COMMENT 'A code identifying the overall result of a test, e.g. success or failed.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_FACT_DATA_QUALITY_MEASURE primary key (DQ_RULE_SID, CAL_DT)
)COMMENT='The execution of a data quality check leads to a result. There is one record for each check and day. If the check has not been executed on a given day, the last available result is taken.'
;