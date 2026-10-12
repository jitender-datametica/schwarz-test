CREATE TABLE IF NOT EXISTS kfl_production_dbp_process.l_rfi_fachbereich_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
rfi_fachbereich_id STRING(100) COLLATE 'und:ci' NOT NULL,
rfi_fachbereich_bez STRING(200) COLLATE 'und:ci',
td_update TIMESTAMP,
td_insert TIMESTAMP
);