create or replace TABLE LDL_DATA_PRODUCTION.META.T_DIM_TABLE_2 (
	TABLE_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) of the table.',
	DWH_VALID_FROM_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
	DWH_VALID_TO_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
	DWH_VALID_FG BOOLEAN NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
	SYS_NAME VARCHAR(100) NOT NULL COMMENT 'The name of the IT system.',
	DB_NAME VARCHAR(100) NOT NULL COMMENT 'The name by which the database is identified on the system.',
	SCHEMA_NAME VARCHAR(100) NOT NULL COMMENT 'The name of the schema, as it is defined in the database management system.',
	TABLE_NAME VARCHAR(250) NOT NULL COMMENT 'The physical table name.',
	TABLE_COMMENT_TXT VARCHAR(1000) COMMENT 'The comment text for the table.',
	TENANT_CD VARCHAR(20) NOT NULL COMMENT 'The code identifying the tenant, i.e. the organizational unit_2 within the Schwarz Group which operates its own data warehouse. I.e. Lidl, Kaufland, Lidl Digital, etc.',
	TENANT_NAME VARCHAR(100) NOT NULL COMMENT 'The name of the tenant, i.e. the organizational unit_2 within the Schwarz Group which operates its own data warehouse. I.e. Lidl, Kaufland, Lidl Digital, etc.',
	TECHNOLOGY_NAME VARCHAR(100) COMMENT 'The name by which the technology is known, e.g. Teradata, AVRO, etc.',
	ENV_CD VARCHAR(20) NOT NULL COMMENT 'The code which identifies the (development / test_2 / production / ...) environment.',
	ENV_NAME VARCHAR(100) NOT NULL COMMENT 'The name of the i(development / test_2 / production / ...) environment.',
	TABLE_STATUS_CD VARCHAR(20) NOT NULL COMMENT 'The code identifying the lifecycle status_2 of a table, i.e. deployed or dropped.',
	TABLE_STATUS_DESCR VARCHAR(250) NOT NULL COMMENT 'A textual description for the lifecycle status_2 of a table.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_DIM_TABLE primary key (TABLE_SID, DWH_VALID_FROM_TMSP)
)COMMENT='The table dimension contains all tables which are subject to a data quality check. (If a check accesses a view, it is linked to the underlying table.)'
;