CREATE TABLE IF NOT EXISTS kfl_production_dbp_process.l_gp_art_frischeinventur (
mandant_id BIGNUMERIC(38,0) NOT NULL,
gp_id BIGNUMERIC(38,0) NOT NULL,
art_id BIGNUMERIC(38,0) NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);