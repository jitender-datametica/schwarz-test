CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_ewm_exception_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
lagernummer_id STRING(4) COLLATE 'und:ci' NOT NULL,
ewm_exception_id STRING(4) COLLATE 'und:ci' NOT NULL,
wup_id BIGNUMERIC(38,0),
nb_id BIGNUMERIC(38,0),
ewm_exc_kategorie_id STRING(1) COLLATE 'und:ci',
td_update TIMESTAMP,
td_insert TIMESTAMP
);