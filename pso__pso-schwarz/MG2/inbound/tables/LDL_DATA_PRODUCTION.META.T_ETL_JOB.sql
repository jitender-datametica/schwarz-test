create or replace TABLE LDL_DATA_PRODUCTION.META.T_ETL_JOB (
	ETL_JOB_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the ETL job',
	DWH_VALID_FROM_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
	DWH_VALID_TO_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
	DWH_VALID_FG BOOLEAN NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
	ETL_JOB_NAME VARCHAR(100) NOT NULL COMMENT 'The name under which the ETL job is stored (not including the path name).',
	ETL_JOB_VERSION_NR VARCHAR(20) COMMENT 'In case the ETL job gets modified later on, this number can be used to distinguish the various versions.',
	PATH_NAME VARCHAR(100) COMMENT 'The full path to the ETL job.',
	ETL_JOB_DESCR VARCHAR(250) COMMENT 'A free text detailing the purpose and structure of the ETL job.',
	ETL_JOB_TYPE_CD VARCHAR(20) NOT NULL COMMENT 'The code identifying the type of ETL job, e.g. SQL script or Ab Initio graph.',
	ETL_APPL_SID NUMBER(38,0) COMMENT 'The unique identifier (surrogate key) for the group of ETL jobs that form an application.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_ETL_JOB primary key (ETL_JOB_SID, DWH_VALID_FROM_TMSP)
)COMMENT='An ETL job is a piece of software that is used to extract data from a source system, transform it or to load it into the data warehouse. ETL jobs may use any technology, such as SQL or Ab Initio graphs. A job may consist of several steps.'
;