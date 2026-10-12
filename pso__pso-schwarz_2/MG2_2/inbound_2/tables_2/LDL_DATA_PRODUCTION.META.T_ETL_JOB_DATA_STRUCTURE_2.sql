create or replace TABLE LDL_DATA_PRODUCTION.META.T_ETL_JOB_DATA_STRUCTURE_2 (
	ETL_JOB_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the ETL job',
	DATA_STRUCT_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) of the data structure.',
	DATA_OBJ_ACCESS_TYPE_CD VARCHAR(20) NOT NULL COMMENT 'The code identifying the way how a data object is used by an ETL job.',
	DWH_VALID_FROM_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
	DWH_VALID_TO_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
	DWH_VALID_FG BOOLEAN NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_ETL_JOB_DATA_STRUCTURE primary key (ETL_JOB_SID, DATA_OBJ_ACCESS_TYPE_CD, DATA_STRUCT_SID, DWH_VALID_FROM_TMSP)
)COMMENT='An ETL job may use a data object in various different ways. It may read from the object, it may write it, it may reference it as a lookup or use it as an intermediate storage. This entity links an ETL job to all its referenced data objects. The way how the data object is used, is defined by the usage type.'
;