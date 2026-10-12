create or replace view LDL_DATA_PRODUCTION.FE_MSTR_APP_FRAUD_DETECTION.V_FRAUD_DETECTION_SCENARIO_GROUP_2(
	SCENARIO_GRP_ID COMMENT 'The unique identifier of fraud detection scenario group.',
	SCENARIO_GRP_NAME COMMENT 'The name of the identified scenario use case.',
	DWH_CREATED_TMSP COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.'
) COMMENT='Holds the scenario groups (for example cancel, returns..)'
 as  SELECT 
main.scenario_grp_id
,main.scenario_grp_name
,main.dwh_created_tmsp
,main.dwh_updated_tmsp
,main.dwh_load_id
,main.dwh_node_cd
FROM CORE_APP_FRAUD_DETECTION.T_FRAUD_DETECTION_SCENARIO_GROUP_2 main;