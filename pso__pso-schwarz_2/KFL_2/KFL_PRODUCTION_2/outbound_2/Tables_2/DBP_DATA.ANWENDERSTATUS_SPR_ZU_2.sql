CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.anwenderstatus_spr_zu_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
anwenderstatus_id STRING(5) COLLATE 'und:ci' NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
system_id BIGNUMERIC(38,0) NOT NULL,
anwenderstatus_bez_kurz STRING(4) COLLATE 'und:ci',
anwenderstatus_bez STRING(30) COLLATE 'und:ci',
td_insert TIMESTAMP,
td_update TIMESTAMP
);