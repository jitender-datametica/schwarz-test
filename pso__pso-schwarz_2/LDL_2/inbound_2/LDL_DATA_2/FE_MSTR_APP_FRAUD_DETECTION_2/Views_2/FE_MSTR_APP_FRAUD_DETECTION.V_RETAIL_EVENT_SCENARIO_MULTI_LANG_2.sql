CREATE OR REPLACE VIEW FE_MSTR_APP_FRAUD_DETECTION.V_RETAIL_EVENT_SCENARIO_MULTI_LANG_2(
	COUNTRY_ORG_SID COMMENT 'The identifier for the organization country_2',
	RETAIL_EVENT_SCENARIO_ID COMMENT 'The numeric identifier for the scenario which is represented by the retail event.',
	LANG_CD COMMENT 'The code identifying the language.',
	RETAIL_EVENT_SCENARIO_NAME COMMENT 'The name of the business scenario which is represented by the retail event.',
	RETAIL_EVENT_SCENARIO_DESCR COMMENT 'A textual description of the conditions which determine the business scenario.',
	DWH_CREATED_TMSP COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.'
) COMMENT='This minor entity defines the business scenario which the retail event represents, e.g. regular sales_2, cancelled sales_2, deposit return, etc. The scenario is calculated from a number of other attributes, so it is derived information.'
 AS SELECT 
 o.int_org_sid
,main.retail_event_scenario_id
,main.lang_cd
,main.retail_event_scenario_name
,main.retail_event_scenario_descr
,main.dwh_created_tmsp
,main.dwh_updated_tmsp
,main.dwh_load_id
,main.dwh_node_cd
FROM CORE_REL.T_RETAIL_EVENT_SCENARIO_2 main
INNER JOIN CORE_DIM.T_DIM_INTERNAL_ORGANIZATION_2 o
ON main.lang_cd = o.official_lang_cd
WHERE o.is_country_org_fg
AND o.dwh_valid_fg ;
