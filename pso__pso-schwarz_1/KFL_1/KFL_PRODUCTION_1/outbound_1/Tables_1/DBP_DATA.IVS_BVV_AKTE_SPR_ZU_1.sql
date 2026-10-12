CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.ivs_bvv_akte_spr_zu_1 (
bvv_akte_id STRING(32) COLLATE 'und:ci' NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
bvv_akte_bez STRING(255) COLLATE 'und:ci',
td_update TIMESTAMP,
td_insert TIMESTAMP
);