create or replace TABLE LDL_DATA_PRODUCTION.META.T_LOAD_PROTOCOL_2 (
	LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the execution of an ETL job.',
	ETL_JOB_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the ETL job',
	START_TMSP TIMESTAMP_TZ(9) NOT NULL COMMENT 'The point in time when the ETL job was started.',
	END_TMSP TIMESTAMP_TZ(9) COMMENT 'The point in time when the ETL job terminated (either successfully or with an error).',
	RERUN_FG BOOLEAN NOT NULL COMMENT 'An indicator showing, if the ETL job was run again after a failure.',
	RESTART_FG BOOLEAN NOT NULL COMMENT 'An indicator showing, if the job was restarted.',
	JOB_EXEC_STATUS_CD VARCHAR(20) NOT NULL COMMENT 'The return code of the ETL job.',
	READ_REC_CNT NUMBER(38,0) COMMENT 'The number of records which have been read by the ETL job.',
	WRITTEN_REC_CNT NUMBER(38,0) COMMENT 'The number of records which have been written to the target data structure by the ETL job.',
	REJECTED_REC_CNT NUMBER(38,0) COMMENT 'The number of records which have been rejected by the ETL job.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_LOAD_PROTOCOL primary key (LOAD_ID)
)COMMENT='The load protocol tracks the execution of ETL jobs. Whenever a job is run, it is logged in this entity. '
;