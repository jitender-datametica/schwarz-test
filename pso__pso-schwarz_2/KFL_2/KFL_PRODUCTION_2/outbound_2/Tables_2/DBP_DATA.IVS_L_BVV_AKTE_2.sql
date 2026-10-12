CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.ivs_l_bvv_akte_2 (
bvv_akte_id STRING(32) COLLATE 'und:ci' NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
bvv_vertrag_nr STRING(80) COLLATE 'und:ci' NOT NULL,
dat_vertrag_beginn DATE,
td_update TIMESTAMP,
td_insert TIMESTAMP
);