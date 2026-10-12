CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.in_besch_best_akte_zu (
bvv_akte_id STRING(32) COLLATE 'und:ci' NOT NULL,
best_beleg_id INTEGER NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
in_lief_id BIGNUMERIC(38,0),
td_insert TIMESTAMP,
td_update TIMESTAMP
);