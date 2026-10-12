create or replace view LDL_DATA_PRODUCTION.FE_MSTR_APP_FRAUD_DETECTION.V_FRAUD_DETECTION_SCENARIO_2(
	SCENARIO_ID COMMENT 'The unique identifier of fraud detection scenario',
	SCENARIO_TYPE_CD COMMENT 'Type of scenario, code which defines automatic and manuall type of scenario',
	SCENARIO_NAME COMMENT 'The name of the identified scenario use case.',
	SCENARIO_DESCR COMMENT 'Describes the scenario.',
	SCENARIO_GRP_ID COMMENT 'The unique identifier of fraud detection scenario group.',
	DWH_CREATED_TMSP COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.'
) COMMENT='Keeps the fraud detection scenario and their relationship to groups.'
 as
SELECT 
main.SCENARIO_ID AS SCENARIO_ID,
main.SCENARIO_TYPE_CD AS SCENARIO_TYPE_CD,
main.SCENARIO_NAME AS SCENARIO_NAME,
main.SCENARIO_DESCR AS SCENARIO_DESCR,
main.SCENARIO_GRP_ID AS SCENARIO_GRP_ID,
main.DWH_CREATED_TMSP AS DWH_CREATED_TMSP,
main.DWH_UPDATED_TMSP AS DWH_UPDATED_TMSP,
main.DWH_LOAD_ID AS DWH_LOAD_ID,
main.DWH_NODE_CD AS DWH_NODE_CD
FROM CORE_APP_FRAUD_DETECTION.T_FRAUD_DETECTION_SCENARIO_2 main;