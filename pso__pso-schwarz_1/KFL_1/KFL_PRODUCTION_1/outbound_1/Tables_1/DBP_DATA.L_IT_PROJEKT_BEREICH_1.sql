CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_it_projekt_bereich_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
it_projekt_bereich_id STRING(10) COLLATE 'und:ci' NOT NULL,
it_projekt_bereich_bez STRING(30) COLLATE 'und:ci' NOT NULL,
sparte_id BIGNUMERIC(38,0),
td_insert TIMESTAMP,
td_update TIMESTAMP
);