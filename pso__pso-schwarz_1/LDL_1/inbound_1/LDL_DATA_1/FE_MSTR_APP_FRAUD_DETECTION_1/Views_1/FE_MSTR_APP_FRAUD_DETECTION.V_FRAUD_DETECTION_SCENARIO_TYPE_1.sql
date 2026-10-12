CREATE OR REPLACE VIEW FE_MSTR_APP_FRAUD_DETECTION.V_FRAUD_DETECTION_SCENARIO_TYPE_1(
	SCENARIO_TYPE_CD COMMENT 'The code of the scenario',
	SCENARIO_TYPE_DESCR COMMENT 'Describes a type of scenario Automaticly or manuall',
	DWH_CREATED_TMSP COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.'
) COMMENT='Describes a type of scenario. Automaticly or manuall'
 AS  SELECT 
main.scenario_type_cd
,main.scenario_type_descr
,main.dwh_created_tmsp
,main.dwh_updated_tmsp
,main.dwh_load_id
,main.dwh_node_cd
FROM CORE_APP_FRAUD_DETECTION.T_FRAUD_DETECTION_SCENARIO_TYPE_1 main;