CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.ivs_immo_obj_miet_region_zu_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
immo_objekt_id STRING(20) COLLATE 'und:ci' NOT NULL,
miet_region_id BIGNUMERIC(38,0) NOT NULL,
bl_id STRING(3) COLLATE 'und:ci' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);