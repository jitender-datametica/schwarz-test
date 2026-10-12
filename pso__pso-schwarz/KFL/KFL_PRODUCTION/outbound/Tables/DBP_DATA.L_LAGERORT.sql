CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_lagerort (
mandant_id BIGNUMERIC(38,0) NOT NULL,
lagerort_id STRING(4) COLLATE 'und:ci' NOT NULL,
wup_id BIGNUMERIC(38,0) NOT NULL,
nb_id BIGNUMERIC(38,0) NOT NULL,
lagernummer_id STRING(3) COLLATE 'und:ci',
td_insert TIMESTAMP,
td_update TIMESTAMP
);