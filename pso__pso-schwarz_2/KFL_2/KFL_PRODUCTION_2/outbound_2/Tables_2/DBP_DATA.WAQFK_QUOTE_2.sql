CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.waqfk_quote_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
lagernummer_id STRING(3) COLLATE 'und:ci' NOT NULL,
wup_id BIGNUMERIC(38,0) NOT NULL,
nb_id BIGNUMERIC(38,0) NOT NULL,
waqfk_quote_2 NUMERIC(9,2) NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);