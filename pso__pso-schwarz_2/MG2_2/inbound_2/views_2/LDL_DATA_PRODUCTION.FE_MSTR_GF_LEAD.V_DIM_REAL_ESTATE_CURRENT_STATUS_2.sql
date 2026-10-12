create or replace view LDL_DATA_PRODUCTION.FE_MSTR_GF_LEAD.V_DIM_REAL_ESTATE_CURRENT_STATUS_2(
	REAL_ESTATE_STATUS_CD COMMENT 'The code identifying the lifecycle status_2 for real estate objects. (This is the business lifecycle, so it might differ from the status_2 code shown in the source system.)',
	REAL_ESTATE_STATUS_DESCR COMMENT 'A textual description for the lifecycle status_2 for real estate objects. (Description in group language, i.e. in German)',
	REAL_ESTATE_STATUS_DESCR_DE COMMENT 'A textual description for the lifecycle status_2 for real estate objects. (Description in German)',
	REAL_ESTATE_STATUS_DESCR_EN COMMENT 'A textual description for the lifecycle status_2 for real estate objects. (Description in English)',
	DWH_CREATED_TMSP COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP COMMENT 'The point in time when this record was last updated.',
	DWH_LOAD_ID COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.'
) COMMENT='This minor dimension defines the lifecycle status_2 for real estate objects.. E.g. an object may be under contract, open, closed or terminated. (This is the business lifecycle, so it might differ from the status_2 code shown in the source system.), Lookup View for the attribute Real Estate Current Status_2'
 as SELECT
main.real_estate_status_cd AS real_estate_status_cd
,main.real_estate_status_descr AS real_estate_status_descr
,main.real_estate_status_descr_de AS real_estate_status_descr_de
,main.real_estate_status_descr_en AS real_estate_status_descr_en
,main.dwh_created_tmsp AS dwh_created_tmsp
,main.dwh_updated_tmsp AS dwh_updated_tmsp
,main.dwh_load_id AS dwh_load_id
,main.dwh_node_cd AS dwh_node_cd 
FROM CORE_DIM.T_DIM_REAL_ESTATE_STATUS_2 main;