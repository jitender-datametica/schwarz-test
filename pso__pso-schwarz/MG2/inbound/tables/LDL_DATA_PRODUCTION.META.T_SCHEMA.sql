create or replace TABLE LDL_DATA_PRODUCTION.META.T_SCHEMA (
	SYS_NAME VARCHAR(100) NOT NULL COMMENT 'The name of the IT system.',
	DB_NAME VARCHAR(100) NOT NULL COMMENT 'The name by which the database is identified on the system.',
	SCHEMA_NAME VARCHAR(100) NOT NULL COMMENT 'The name of the schema, as it is defined in the database management system.',
	DWH_VALID_FROM_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
	DWH_VALID_TO_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
	DWH_VALID_FG BOOLEAN NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
	ENV_CD VARCHAR(20) NOT NULL COMMENT 'The code which identifies the (development / test / production / ...) environment for which the schema is used.',
	SCHEMA_DESCR VARCHAR(250) NOT NULL COMMENT 'A textual description of the database schema, explaining its purpose.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_SCHEMA primary key (SCHEMA_NAME, DB_NAME, SYS_NAME, DWH_VALID_FROM_TMSP)
)COMMENT='A schema defines a name space in a database management system. Other objects, such as tables and views, are created in a schema.'
;