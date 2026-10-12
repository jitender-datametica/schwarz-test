create or replace view LDL_DATA_PRODUCTION.META.V_DATABASE(
	SYS_NAME COMMENT 'The name of the IT system.',
	DB_NAME COMMENT 'The name by which the database is identified on the system.',
	DWH_VALID_FROM_TMSP COMMENT 'The point in time when this record became valid.',
	DWH_VALID_TO_TMSP COMMENT 'The point in time when this record was no longer valid.',
	DWH_VALID_FG COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
	TENANT_CD COMMENT 'The code identifying the tenant, i.e. the organizational unit within the Schwarz Group which operates its own data warehouse. I.e. Lidl, Kaufland, Lidl Digital, etc.',
	ENV_CD COMMENT 'The code for the environment, in case the entire database is dedicated to one environment.',
	DB_DESCR COMMENT 'A textual description of the database, explaining its purpose.',
	DWH_CREATED_TMSP COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.'
) COMMENT='A database is a container in a DBMS for other objects.'
 as SELECT
   sys_name
  ,db_name
  ,dwh_valid_from_tmsp
  ,dwh_valid_to_tmsp
  ,dwh_valid_fg
  ,tenant_cd
  ,env_cd
  ,db_descr
  ,dwh_created_tmsp
  ,dwh_updated_tmsp
  ,dwh_load_id
  ,dwh_node_cd
FROM META.T_DATABASE
UNION
SELECT '@', '@', '1900-01-01 00:00:00.000 +0100', '9999-12-31 23:59:00.000 +0100', true, '@', '@', 'Unknown database', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, -1, 'MANUAL'
;