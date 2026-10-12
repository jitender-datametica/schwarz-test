create or replace view LDL_DATA_PRODUCTION.FE_MSTR_APP_FRAUD_DETECTION.V_FRAUD_DETECTION_PARAMETER_1(
	SCENARIO_ID COMMENT 'The unique identifier of fraud detection scenario.',
	PARAM_ID COMMENT 'The unique identifier of parameter (thereshold) of a scenario',
	PARAM_NAME COMMENT 'The name of a scenario parameter',
	PARAM_DESCR COMMENT 'The description of scenario paramter.',
	PARAM_DEFAULT_VAL_QTY COMMENT 'The default value of a scenario parameter.',
	DWH_CREATED_TMSP COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.'
) COMMENT='One scenario defines one or several parameters.Several scenarios can use parameters with the same name.'
 as SELECT 
main.scenario_id
,main.param_id
,main.param_name
,main.param_descr
,main.param_default_val_qty
,main.dwh_created_tmsp
,main.dwh_updated_tmsp
,main.dwh_load_id
,main.dwh_node_cd
FROM CORE_APP_FRAUD_DETECTION.T_FRAUD_DETECTION_PARAMETER_1 main;