CREATE TABLE IF NOT EXISTS kfl_production_dbp_process.art_char_map_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
kl_art_id BIGNUMERIC(38,0) NOT NULL,
matnr_char STRING(20) COLLATE 'und:ci' NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);