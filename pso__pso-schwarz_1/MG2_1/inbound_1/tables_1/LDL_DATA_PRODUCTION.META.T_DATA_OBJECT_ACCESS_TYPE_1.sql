create or replace TABLE LDL_DATA_PRODUCTION.META.T_DATA_OBJECT_ACCESS_TYPE_1 (
	DATA_OBJ_ACCESS_TYPE_CD VARCHAR(20) NOT NULL COMMENT 'The code identifying the way how a data object is used by an ETL job.',
	DATA_OBJ_ACCESS_TYPE_DESCR VARCHAR(250) NOT NULL COMMENT 'A textual description for the way how a data object is used by an ETL job.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_DATA_OBJECT_ACCESS_TYPE primary key (DATA_OBJ_ACCESS_TYPE_CD)
)COMMENT='An ETL job may use a data object in various different ways. It may read from the object, it may write it, it may reference it as a lookup or use it as an intermediate storage. This minor entity defines the way, how the data object is used by an ETL job,'
;