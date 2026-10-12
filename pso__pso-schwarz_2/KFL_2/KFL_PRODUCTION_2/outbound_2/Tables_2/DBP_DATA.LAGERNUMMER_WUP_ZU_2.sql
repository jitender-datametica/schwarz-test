CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.lagernummer_wup_zu_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
lagernummer_id STRING(4) COLLATE 'und:ci' NOT NULL,
nb_id BIGNUMERIC(38,0),
wup_id BIGNUMERIC(38,0),
td_update TIMESTAMP,
td_insert TIMESTAMP
);