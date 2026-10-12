create or replace view LDL_DATA_PRODUCTION.FE_MSTR_GF_LEAD.V_DIM_WAREHOUSE_PURPOSE(
	WH_PURPOSE_CD COMMENT 'The code identifying the purpose of a warehouse.',
	WH_PURPOSE_DESCR COMMENT 'A textual description for the purpose of a warehouse. (Description in group language, i.e. in German)',
	WH_PURPOSE_DESCR_DE COMMENT 'A textual description for the purpose of a warehouse. (Description in German)',
	WH_PURPOSE_DESCR_EN COMMENT 'A textual description for the purpose of a warehouse. (Description in English)',
	DWH_CREATED_TMSP COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP COMMENT 'The point in time when this record was last updated.',
	DWH_LOAD_ID COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.'
) COMMENT='This minor dimension defines the main purposes which a warehouse may serve. E.g. crossdock, import warehouse, etc.'
 as SELECT
main.wh_purpose_cd AS wh_purpose_cd
,main.wh_purpose_descr AS wh_purpose_descr
,main.wh_purpose_descr_de AS wh_purpose_descr_de
,main.wh_purpose_descr_en AS wh_purpose_descr_en
,main.dwh_created_tmsp AS dwh_created_tmsp
,main.dwh_updated_tmsp AS dwh_updated_tmsp
,main.dwh_load_id AS dwh_load_id
,main.dwh_node_cd AS dwh_node_cd 
FROM CORE_DIM.T_DIM_WAREHOUSE_PURPOSE main;