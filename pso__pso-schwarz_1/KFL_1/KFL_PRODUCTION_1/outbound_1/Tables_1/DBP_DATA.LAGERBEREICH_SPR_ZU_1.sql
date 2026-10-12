CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.lagerbereich_spr_zu_1 (
spr_id BIGNUMERIC(38,0) NOT NULL,
lagerbereich_id STRING(4) COLLATE 'und:ci' NOT NULL,
lagernummer_id STRING(4) COLLATE 'und:ci' NOT NULL,
wup_id BIGNUMERIC(38,0) NOT NULL,
nb_id BIGNUMERIC(38,0) NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
lagertyp_id STRING(4) COLLATE 'und:ci' NOT NULL,
lagerbereich_bez STRING(30) COLLATE 'und:ci' NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP,
lagersortiment_id STRING(1) COLLATE 'und:ci' DEFAULT '-' NOT NULL
);