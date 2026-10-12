CREATE TABLE IF NOT EXISTS kfl_production_dbp_process.ivs_flaeche_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
flaeche_bez STRING(50) COLLATE 'und:ci' NOT NULL,
dat DATE NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);