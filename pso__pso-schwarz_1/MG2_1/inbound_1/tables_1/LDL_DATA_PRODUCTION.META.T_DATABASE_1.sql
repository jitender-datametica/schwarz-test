create or replace TABLE LDL_DATA_PRODUCTION.META.T_DATABASE_1 (
	SYS_NAME VARCHAR(100) NOT NULL COMMENT 'The name of the IT system.',
	DB_NAME VARCHAR(100) NOT NULL COMMENT 'The name by which the database is identified on the system.',
	DWH_VALID_FROM_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
	DWH_VALID_TO_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
	DWH_VALID_FG BOOLEAN NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
	TENANT_CD VARCHAR(20) COMMENT 'The code identifying the tenant, i.e. the organizational unit_1 within the Schwarz Group which operates its own data warehouse. I.e. Lidl, Kaufland, Lidl Digital, etc.',
	ENV_CD VARCHAR(20) COMMENT 'The code for the environment, in case the entire database is dedicated to one environment.',
	DB_DESCR VARCHAR(250) COMMENT 'A textual description of the database, explaining its purpose.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_DATABASE primary key (DB_NAME, SYS_NAME, DWH_VALID_FROM_TMSP)
)COMMENT='A database is a container in a DBMS for other objects.'
;