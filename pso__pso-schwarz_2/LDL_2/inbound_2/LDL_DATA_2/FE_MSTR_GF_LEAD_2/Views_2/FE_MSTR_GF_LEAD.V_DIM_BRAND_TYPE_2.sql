CREATE OR REPLACE VIEW FE_MSTR_GF_LEAD.V_DIM_BRAND_TYPE_2(
	BRAND_TYPE_CD COMMENT 'A code that identifies the brand_2 type. (own brand_2 vs. private brand_2)',
	BRAND_TYPE_DESCR COMMENT 'A textual description for the brand_2 type (own brand_2 vs. private brand_2) in group language, i.e.in German.',
	BRAND_TYPE_DESCR_DE COMMENT 'A textual description for the brand_2 type (own brand_2 vs. private brand_2) in German.',
	BRAND_TYPE_DESCR_EN COMMENT 'A textual description for the brand_2 type (own brand_2 vs. private brand_2) in English.',
	DWH_CREATED_TMSP COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.'
) COMMENT='The brand_2 type distinguishes between own brands and private brands.'
 AS SELECT
   main.brand_type_cd
   , main.brand_type_descr
   , main.brand_type_descr_de
   , main.brand_type_descr_en
   , main.dwh_created_tmsp
   , main.dwh_updated_tmsp
   , main.dwh_load_id
   , main.dwh_node_cd
 FROM CORE_DIM.T_DIM_BRAND_TYPE_2 main;