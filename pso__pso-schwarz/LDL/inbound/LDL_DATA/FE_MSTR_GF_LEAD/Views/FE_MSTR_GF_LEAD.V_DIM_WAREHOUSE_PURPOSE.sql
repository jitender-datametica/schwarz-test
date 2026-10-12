CREATE OR REPLACE VIEW FE_MSTR_GF_LEAD.V_DIM_WAREHOUSE_PURPOSE (
wh_purpose_cd COMMENT 'The code identifying the purpose of a warehouse.'
,wh_purpose_descr COMMENT 'A textual description for the purpose of a warehouse. (Description in group language, i.e. in German)'
,wh_purpose_descr_de COMMENT 'A textual description for the purpose of a warehouse. (Description in German)'
,wh_purpose_descr_en COMMENT 'A textual description for the purpose of a warehouse. (Description in English)'
,dwh_created_tmsp COMMENT 'The point in time when this record was created in the data warehouse.'
,dwh_updated_tmsp COMMENT 'The point in time when this record was last updated.'
,dwh_load_id COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'
,dwh_node_cd COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.'
) COMMENT = 'This minor dimension defines the main purposes which a warehouse may serve. E.g. crossdock, import warehouse, etc.' AS SELECT
main.wh_purpose_cd AS wh_purpose_cd
,main.wh_purpose_descr AS wh_purpose_descr
,main.wh_purpose_descr_de AS wh_purpose_descr_de
,main.wh_purpose_descr_en AS wh_purpose_descr_en
,main.dwh_created_tmsp AS dwh_created_tmsp
,main.dwh_updated_tmsp AS dwh_updated_tmsp
,main.dwh_load_id AS dwh_load_id
,main.dwh_node_cd AS dwh_node_cd 
FROM CORE_DIM.T_DIM_WAREHOUSE_PURPOSE main;