CREATE TABLE IF NOT EXISTS kfl_production_dbp_process.art_loesch_id_2 (
kl_art_id BIGNUMERIC(38,0) NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
loesch_id STRING(2) COLLATE 'und:ci' NOT NULL,
loesch_dat DATE NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);