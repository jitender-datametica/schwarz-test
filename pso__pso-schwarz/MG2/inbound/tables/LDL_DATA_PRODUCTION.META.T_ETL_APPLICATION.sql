create or replace TABLE LDL_DATA_PRODUCTION.META.T_ETL_APPLICATION (
	ETL_APPL_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the group of ETL jobs that form an application.',
	ETL_APPL_NAME VARCHAR(100) NOT NULL COMMENT 'The name for the group of ETL jobs that form an application.',
	ETL_APPL_DESCR VARCHAR(250) COMMENT 'A textual description of the ETL application, detailing the purpose and structure of the application.',
	SYS_NAME VARCHAR(100) NOT NULL COMMENT 'The name of the system on which the application runs.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_ETL_APPLICATION primary key (ETL_APPL_SID)
)COMMENT='ETL jobs which serve the same purpose, e.g. which load the same set of target tables, form an application'
;