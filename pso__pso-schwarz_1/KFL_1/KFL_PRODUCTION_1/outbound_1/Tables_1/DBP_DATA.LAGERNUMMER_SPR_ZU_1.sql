CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.lagernummer_spr_zu_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
lagernummer_id STRING(4) COLLATE 'und:ci' NOT NULL,
wup_id BIGNUMERIC(38,0) NOT NULL,
nb_id BIGNUMERIC(38,0) NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
lagernummer_bez STRING(30) COLLATE 'und:ci' DEFAULT ' ' NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);