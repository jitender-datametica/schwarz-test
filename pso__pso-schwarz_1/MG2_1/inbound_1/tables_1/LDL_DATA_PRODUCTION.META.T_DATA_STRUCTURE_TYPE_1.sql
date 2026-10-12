create or replace TABLE LDL_DATA_PRODUCTION.META.T_DATA_STRUCTURE_TYPE_1 (
	DATA_STRUCT_TYPE_CD VARCHAR(50) NOT NULL COMMENT 'The code which identifies the subtype discriminator for data structures. It distinguishes between entities, tables, views, files and streams.',
	DATA_STRUCT_TYPE_DESCR VARCHAR(250) NOT NULL COMMENT 'A textual description for the subtype discriminator for data structures.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_DATA_STRUCTURE_TYPE primary key (DATA_STRUCT_TYPE_CD)
)COMMENT='This minor entity defines the subtype discriminators for data structures.'
;