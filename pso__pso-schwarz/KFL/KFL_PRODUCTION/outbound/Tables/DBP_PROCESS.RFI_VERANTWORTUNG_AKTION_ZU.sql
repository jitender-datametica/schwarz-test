CREATE TABLE IF NOT EXISTS kfl_production_dbp_process.rfi_verantwortung_aktion_zu (
mandant_id BIGNUMERIC(38,0) NOT NULL,
rfi_verantwortung_id STRING(20) COLLATE 'und:ci' NOT NULL,
uhrzeit BIGNUMERIC(38,0) NOT NULL,
tagversatz BIGNUMERIC(38,0) NOT NULL,
rfi_id BIGNUMERIC(38,0) NOT NULL,
tabelle STRING(30) COLLATE 'und:ci' NOT NULL,
rfi_feld STRING(200) COLLATE 'und:ci' NOT NULL,
rfi_fachbereich_id STRING(100) COLLATE 'und:ci' NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);