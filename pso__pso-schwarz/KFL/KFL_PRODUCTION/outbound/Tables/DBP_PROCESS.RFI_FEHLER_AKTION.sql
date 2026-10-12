CREATE TABLE IF NOT EXISTS kfl_production_dbp_process.rfi_fehler_aktion (
mandant_id BIGNUMERIC(38,0) NOT NULL,
rfi_id BIGNUMERIC(38,0) NOT NULL,
tabelle STRING(30) COLLATE 'und:ci' NOT NULL,
rfi_feld STRING(200) COLLATE 'und:ci' NOT NULL,
rfi_fachbereich_id STRING(100) COLLATE 'und:ci',
td_update TIMESTAMP,
td_insert TIMESTAMP
);