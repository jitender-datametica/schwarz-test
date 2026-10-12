create or replace view LDL_DATA_PRODUCTION.FE_MSTR_GF_LEAD.V_DIM_OWNERSHIP_RATIO_TYPE(
	OWNERSHIP_RATIO_TYPE_CD COMMENT 'The code identifying the ownership ratio of a real estate object, i.e. if it is fully owned or partly owned.',
	OWNERSHIP_RATIO_TYPE_DESCR COMMENT 'A textual description for the ownership ratio of a real estate object, (Description in group language, i.e. in German)',
	OWNERSHIP_RATIO_TYPE_DESCR_DE COMMENT 'A textual description for the ownership ratio of a real estate object, (Description in German)',
	OWNERSHIP_RATIO_TYPE_DESCR_EN COMMENT 'A textual description for the ownership ratio of a real estate object, (Description in English)',
	DWH_CREATED_TMSP COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP COMMENT 'The point in time when this record was last updated.',
	DWH_LOAD_ID COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.'
) COMMENT='This minor dimension defines the ownership ratio of a real estate object, i.e. if it is fully owned or partly owned.'
 as SELECT
main.ownership_ratio_type_cd AS ownership_ratio_type_cd
,main.ownership_ratio_type_descr AS ownership_ratio_type_descr
,main.ownership_ratio_type_descr_de AS ownership_ratio_type_descr_de
,main.ownership_ratio_type_descr_en AS ownership_ratio_type_descr_en
,main.dwh_created_tmsp AS dwh_created_tmsp
,main.dwh_updated_tmsp AS dwh_updated_tmsp
,main.dwh_load_id AS dwh_load_id
,main.dwh_node_cd AS dwh_node_cd 
FROM CORE_DIM.T_DIM_OWNERSHIP_RATIO_TYPE main;