CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.belegklasse_gruppe_zu_2 (
system_id BIGNUMERIC(38,0) NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
belegklasse_id STRING(5) COLLATE 'und:ci' NOT NULL,
belegklasse_gruppe_id BIGNUMERIC(38,0) NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);