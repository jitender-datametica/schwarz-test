create or replace TABLE LDL_DATA_PRODUCTION.META.T_ETL_JOB_TYPE_2 (
	ETL_JOB_TYPE_CD VARCHAR(20) NOT NULL COMMENT 'The code identifying the type of ETL job, e.g. SQL script or Ab Initio graph.',
	ETL_JOB_TYPE_DESCR VARCHAR(250) NOT NULL COMMENT 'A textual description for the type of ETL job.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_ETL_JOB_TYPE primary key (ETL_JOB_TYPE_CD)
)COMMENT='This minor entity can be used to distinguish between several types of ETL jobs, such as SQL scripts or Ab Initio graphs.'
;