create or replace view LDL_DATA_PRODUCTION.META.V_SYSTEM_1(
	SYS_NAME COMMENT 'The name of the IT system.',
	DWH_VALID_FROM_TMSP COMMENT 'The point in time when this record became valid.',
	DWH_VALID_TO_TMSP COMMENT 'The point in time when this record was no longer valid.',
	DWH_VALID_FG COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
	SYS_DESCR COMMENT 'A textual description of the database, explaining its purpose.',
	SYS_TYPE_CD COMMENT 'The code identifying the type of system, e.g. the Cloud Data Warehouse, the data store, operational systems, the ETL tool, ...',
	ENV_CD COMMENT 'The code for the environment, in case the entire system is dedicated to one environment.',
	TECHNOLOGY_NAME COMMENT 'The name of the technology on which the system operates, e.g. Teradata, Snowflake, Microstrategy, ...',
	DWH_CREATED_TMSP COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.'
) COMMENT='An IT system, either on premise or in the cloud. This includes source systems, downstream systems and of course also the data warehouse and the data store.'
 as SELECT
   sys_name
  ,dwh_valid_from_tmsp
  ,dwh_valid_to_tmsp
  ,dwh_valid_fg
  ,sys_descr
  ,sys_type_cd
  ,env_cd
  ,technology_name
  ,dwh_created_tmsp
  ,dwh_updated_tmsp
  ,dwh_load_id
  ,dwh_node_cd
FROM META.T_SYSTEM_1
UNION
SELECT '@', '1900-01-01 00:00:00.000 +0100', '9999-12-31 23:59:00.000 +0100', true, 'Unknown system', '@', '@', 'Unknown technology', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, -1, 'MANUAL'
;