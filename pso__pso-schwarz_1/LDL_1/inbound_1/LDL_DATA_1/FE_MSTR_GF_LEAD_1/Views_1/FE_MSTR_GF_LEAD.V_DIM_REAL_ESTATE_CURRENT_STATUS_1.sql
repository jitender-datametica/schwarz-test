CREATE OR REPLACE VIEW FE_MSTR_GF_LEAD.V_DIM_REAL_ESTATE_CURRENT_STATUS_1 (
real_estate_status_cd COMMENT 'The code identifying the lifecycle status_1 for real estate objects. (This is the business lifecycle, so it might differ from the status_1 code shown in the source system.)'
,real_estate_status_descr COMMENT 'A textual description for the lifecycle status_1 for real estate objects. (Description in group language, i.e. in German)'
,real_estate_status_descr_de COMMENT 'A textual description for the lifecycle status_1 for real estate objects. (Description in German)'
,real_estate_status_descr_en COMMENT 'A textual description for the lifecycle status_1 for real estate objects. (Description in English)'
,dwh_created_tmsp COMMENT 'The point in time when this record was created in the data warehouse.'
,dwh_updated_tmsp COMMENT 'The point in time when this record was last updated.'
,dwh_load_id COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'
,dwh_node_cd COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.'
) COMMENT = 'This minor dimension defines the lifecycle status_1 for real estate objects.. E.g. an object may be under contract, open, closed or terminated. (This is the business lifecycle, so it might differ from the status_1 code shown in the source system.), Lookup View for the attribute Real Estate Current Status_1' AS SELECT
main.real_estate_status_cd AS real_estate_status_cd
,main.real_estate_status_descr AS real_estate_status_descr
,main.real_estate_status_descr_de AS real_estate_status_descr_de
,main.real_estate_status_descr_en AS real_estate_status_descr_en
,main.dwh_created_tmsp AS dwh_created_tmsp
,main.dwh_updated_tmsp AS dwh_updated_tmsp
,main.dwh_load_id AS dwh_load_id
,main.dwh_node_cd AS dwh_node_cd 
FROM CORE_DIM.T_DIM_REAL_ESTATE_STATUS_1 main;