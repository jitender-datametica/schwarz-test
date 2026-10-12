CREATE TABLE IF NOT EXISTS kfl_production_dbp_process.l_rfi_verantwortung_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
rfi_verantwortung_id STRING(20) COLLATE 'und:ci' NOT NULL,
rfi_fachbereich_id STRING(100) COLLATE 'und:ci' NOT NULL,
nachname STRING(40) COLLATE 'und:ci',
vorname STRING(40) COLLATE 'und:ci',
email STRING(40) COLLATE 'und:ci' NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);