create or replace view LDL_DATA_PRODUCTION.FE_MSTR_APP_FRAUD_DETECTION.V_RETAIL_EVENT_TYPE_1(
	RETAIL_EVENT_TYPE_CD COMMENT 'The code identifying the subtype discriminator for retail events.',
	LANG_CD COMMENT 'The code identifying the language.',
	RETAIL_EVENT_TYPE_DESCR COMMENT 'A textual description for the subtype discriminator for retail events.',
	DWH_CREATED_TMSP COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.'
) COMMENT='This minor entity defines the subtye discriminators for retail events. It distinguishes between sales_1 events and returns.'
 as SELECT 
main.retail_event_type_cd
,main.lang_cd
,main.retail_event_type_descr
,main.dwh_created_tmsp
,main.dwh_updated_tmsp
,main.dwh_load_id
,main.dwh_node_cd
FROM CORE_REL.T_RETAIL_EVENT_TYPE_1 main
WHERE main.lang_cd = 'DE';