create or replace view LDL_DATA_PRODUCTION.META.V_SCHEMA_1(
	SYS_NAME COMMENT 'The name of the IT system.',
	DB_NAME COMMENT 'The name by which the database is identified on the system.',
	SCHEMA_NAME COMMENT 'The name of the schema, as it is defined in the database management system.',
	DWH_VALID_FROM_TMSP COMMENT 'The point in time when this record became valid.',
	DWH_VALID_TO_TMSP COMMENT 'The point in time when this record was no longer valid.',
	DWH_VALID_FG COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
	ENV_CD COMMENT 'The code which identifies the (development / test_1 / production / ...) environment for which the schema is used.',
	SCHEMA_DESCR COMMENT 'A textual description of the database schema, explaining its purpose.',
	DWH_CREATED_TMSP COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.'
) COMMENT='A schema defines a name space in a database management system. Other objects, such as tables and views, are created in a schema.'
 as SELECT
   sys_name
  ,db_name
  ,schema_name
  ,dwh_valid_from_tmsp
  ,dwh_valid_to_tmsp
  ,dwh_valid_fg
  ,env_cd
  ,schema_descr
  ,dwh_created_tmsp
  ,dwh_updated_tmsp
  ,dwh_load_id
  ,dwh_node_cd
FROM META.T_SCHEMA_1
UNION
SELECT '@', '@', '@', '1900-01-01 00:00:00.000 +0100', '9999-12-31 23:59:00.000 +0100', true, '@', 'Unknown schema', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, -1, 'MANUAL'
;