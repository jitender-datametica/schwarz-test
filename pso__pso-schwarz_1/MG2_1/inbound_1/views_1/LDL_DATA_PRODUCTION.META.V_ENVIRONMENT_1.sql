create or replace view LDL_DATA_PRODUCTION.META.V_ENVIRONMENT_1(
	ENV_CD COMMENT 'The code which identifies the (development / test_1 / production / ...) environment.',
	ENV_NAME COMMENT 'The name of the i(development / test_1 / production / ...) environment.',
	DWH_CREATED_TMSP COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.'
) COMMENT='Development, Test_1 and Production can be separated by using different environments.'
 as SELECT
   env_cd
  ,env_name
  ,dwh_created_tmsp
  ,dwh_updated_tmsp
  ,dwh_load_id
  ,dwh_node_cd
FROM META.T_ENVIRONMENT_1
UNION
SELECT '@', 'Unknown environment', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, -1, 'MANUAL'
;