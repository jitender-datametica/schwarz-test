CREATE OR REPLACE VIEW FE_MSTR_MASTER.V_DIM_WAREHOUSE_BUILDING_TYPE (
wh_building_type_cd COMMENT 'The code for the subtype discriminator for warehouse building.'
,wh_building_type_descr COMMENT 'A textual description for the subtype discriminator for warehouse buildings. (Description in group language, i.e. in German)'
,wh_building_type_descr_de COMMENT 'A textual description for the subtype discriminator for warehouse buildings. (Description in German)'
,wh_building_type_descr_en COMMENT 'A textual description for the subtype discriminator for warehouse buildings. (Description in English)'
,dwh_created_tmsp COMMENT 'The point in time when this record was created in the data warehouse.'
,dwh_updated_tmsp COMMENT 'The point in time when this record was last updated.'
,dwh_load_id COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'
,dwh_node_cd COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.'
) COMMENT = 'This minor dimension defines the subtype discriminator for warehouse building. It distinguishes between main warehouses and external warehouses.' AS SELECT
main.wh_building_type_cd AS wh_building_type_cd
,main.wh_building_type_descr AS wh_building_type_descr
,main.wh_building_type_descr_de AS wh_building_type_descr_de
,main.wh_building_type_descr_en AS wh_building_type_descr_en
,main.dwh_created_tmsp AS dwh_created_tmsp
,main.dwh_updated_tmsp AS dwh_updated_tmsp
,main.dwh_load_id AS dwh_load_id
,main.dwh_node_cd AS dwh_node_cd 
FROM CORE_DIM.T_DIM_WAREHOUSE_BUILDING_TYPE main;