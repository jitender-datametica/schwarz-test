CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.vorgangsklasse_spr_zu_1 (
system_id BIGNUMERIC(38,0) NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
vorgangsklasse_id STRING(5) COLLATE 'und:ci' NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
vorgangsklasse_bez STRING(40) COLLATE 'und:ci',
vorgangsklasse_bez_kurz STRING(20) COLLATE 'und:ci',
vorgangsklasse_bez_lang STRING(100) COLLATE 'und:ci',
td_insert TIMESTAMP,
td_update TIMESTAMP
);