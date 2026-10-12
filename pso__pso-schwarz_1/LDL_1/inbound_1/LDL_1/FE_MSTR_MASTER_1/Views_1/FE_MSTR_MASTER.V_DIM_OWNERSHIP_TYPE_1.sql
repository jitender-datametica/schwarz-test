CREATE OR REPLACE VIEW FE_MSTR_MASTER.V_DIM_OWNERSHIP_TYPE_1 (
ownership_type_cd COMMENT 'The code identifying the ownership type of a real estate object, i.e. if it has been bought or if it is rented.'
,ownership_type_descr COMMENT 'A textual description for the ownership type of a real estate object, (Description in group language, i.e. in German)'
,ownership_type_descr_de COMMENT 'A textual description for the ownership type of a real estate object, (Description in German)'
,ownership_type_descr_en COMMENT 'A textual description for the ownership type of a real estate object, (Description in English)'
,dwh_created_tmsp COMMENT 'The point in time when this record was created in the data warehouse.'
,dwh_updated_tmsp COMMENT 'The point in time when this record was last updated.'
,dwh_load_id COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'
,dwh_node_cd COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.'
) COMMENT = 'This minor dimension defines the ownership type of a real estate object, i.e. if it has been bought or if it is rented.' AS SELECT
main.ownership_type_cd AS ownership_type_cd
,main.ownership_type_descr AS ownership_type_descr
,main.ownership_type_descr_de AS ownership_type_descr_de
,main.ownership_type_descr_en AS ownership_type_descr_en
,main.dwh_created_tmsp AS dwh_created_tmsp
,main.dwh_updated_tmsp AS dwh_updated_tmsp
,main.dwh_load_id AS dwh_load_id
,main.dwh_node_cd AS dwh_node_cd 
FROM CORE_DIM.T_DIM_OWNERSHIP_TYPE_1 main;