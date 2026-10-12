CREATE TABLE IF NOT EXISTS kfl_production_dbp_process.rfi_fehler_aktion_det (
mandant_id BIGNUMERIC(38,0) NOT NULL,
uhrzeit BIGNUMERIC(38,0) NOT NULL,
tagversatz BIGNUMERIC(38,0) NOT NULL,
rfi_id BIGNUMERIC(38,0) NOT NULL,
tabelle STRING(30) COLLATE 'und:ci' NOT NULL,
rfi_feld STRING(200) COLLATE 'und:ci' NOT NULL,
rfi_aktion_bez STRING(200) COLLATE 'und:ci',
betreff STRING(200) COLLATE 'und:ci',
text STRING(2000) COLLATE 'und:ci',
aktiv_fg BIGNUMERIC(38,0) DEFAULT 1 NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);