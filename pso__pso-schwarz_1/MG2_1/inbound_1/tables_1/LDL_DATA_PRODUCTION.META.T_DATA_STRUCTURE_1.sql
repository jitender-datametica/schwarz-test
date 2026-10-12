create or replace TABLE LDL_DATA_PRODUCTION.META.T_DATA_STRUCTURE_1 (
	DATA_STRUCT_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) of the data structure.',
	DWH_VALID_FROM_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
	DWH_VALID_TO_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
	DWH_VALID_FG BOOLEAN NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
	SYS_NAME VARCHAR(100) COMMENT 'The name of the IT system.',
	TECHNOLOGY_NAME VARCHAR(100) COMMENT 'The name by which the technology is known, e.g. Teradata, AVRO, etc.',
	DB_NAME VARCHAR(100) COMMENT 'The name by which the database is identified on the system.',
	SCHEMA_NAME VARCHAR(100) COMMENT 'The name of the schema, as it is defined in the database management system.',
	PATH_NAME VARCHAR(100) COMMENT 'The full path to the file.',
	DATA_STRUCT_NAME VARCHAR(250) NOT NULL COMMENT 'The name of the data object, i.e. depending on the type of object, the entity name, attribute name, file name, etc.',
	DATA_STRUCT_DESCR VARCHAR(250) COMMENT 'The comment text for the data structure.',
	DATA_STRUCT_TYPE_CD VARCHAR(50) NOT NULL COMMENT 'The code which identifies the subtype discriminator for data structures. It distinguishes between entities, tables, views, files and streams.',
	FILE_TYPE_CD VARCHAR(20) COMMENT 'The code for the subtype discriminator for files.',
	FRONTEND_OBJ_TYPE_CD VARCHAR(20) COMMENT 'The code identifying the kind of frontend object.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_DATA_STRUCTURE primary key (DATA_STRUCT_SID, DWH_VALID_FROM_TMSP)
)COMMENT='A data structure is a physical data representation that acts as a container holding other data elements, such as an entity or table or a file. It is typically used to store object terms.'
;