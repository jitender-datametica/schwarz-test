CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.pers_teilbereich_spr_zu (
mandant_id BIGNUMERIC(38,0) NOT NULL,
pers_teilbereich_id STRING(4) COLLATE 'und:ci' NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
buchungskreis_id BIGNUMERIC(38,0) NOT NULL,
pers_bereich_id STRING(4) COLLATE 'und:ci' NOT NULL,
persteilbereich_bez STRING(20) COLLATE 'und:ci',
td_insert TIMESTAMP,
td_update TIMESTAMP
);