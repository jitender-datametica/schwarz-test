create or replace view LDL_DATA_PRODUCTION.FE_MSTR_GF_LEAD.V_DIM_OWNERSHIP_TYPE(
	OWNERSHIP_TYPE_CD COMMENT 'The code identifying the ownership type of a real estate object, i.e. if it has been bought or if it is rented.',
	OWNERSHIP_TYPE_DESCR COMMENT 'A textual description for the ownership type of a real estate object, (Description in group language, i.e. in German)',
	OWNERSHIP_TYPE_DESCR_DE COMMENT 'A textual description for the ownership type of a real estate object, (Description in German)',
	OWNERSHIP_TYPE_DESCR_EN COMMENT 'A textual description for the ownership type of a real estate object, (Description in English)',
	DWH_CREATED_TMSP COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP COMMENT 'The point in time when this record was last updated.',
	DWH_LOAD_ID COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.'
) COMMENT='This minor dimension defines the ownership type of a real estate object, i.e. if it has been bought or if it is rented.'
 as SELECT
main.ownership_type_cd AS ownership_type_cd
,main.ownership_type_descr AS ownership_type_descr
,main.ownership_type_descr_de AS ownership_type_descr_de
,main.ownership_type_descr_en AS ownership_type_descr_en
,main.dwh_created_tmsp AS dwh_created_tmsp
,main.dwh_updated_tmsp AS dwh_updated_tmsp
,main.dwh_load_id AS dwh_load_id
,main.dwh_node_cd AS dwh_node_cd 
FROM CORE_DIM.T_DIM_OWNERSHIP_TYPE main;