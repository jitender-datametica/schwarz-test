create or replace TABLE LDL_DATA_PRODUCTION.META.T_DATA_STRUCTURE_SIZE_TYPE_1 (
	DATA_STRUCT_SIZE_TYPE_CD VARCHAR(20) NOT NULL COMMENT 'The code identifying how the storage space for a data object is measured. E.g. compressed vs. uncompressed size',
	DATA_STRUCT_SIZE_TYPE_DESCR VARCHAR(250) NOT NULL COMMENT 'A textual description for the way how the storage space for a data object is measured. E.g. compressed vs. uncompressed size',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_DATA_STRUCTURE_SIZE_TYPE primary key (DATA_STRUCT_SIZE_TYPE_CD)
)COMMENT='The required storage space for a data structure can be measured in several ways, e.g. compressed vs. uncompressed size. Snowflake allocates space for the net data volume, for time travel and for fail safe storage. This minor entity defines the type of storage space.'
;