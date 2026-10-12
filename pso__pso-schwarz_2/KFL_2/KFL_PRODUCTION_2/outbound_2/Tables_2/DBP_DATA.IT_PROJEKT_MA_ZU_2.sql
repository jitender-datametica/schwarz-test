CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.it_projekt_ma_zu_2 (
it_projekt_id STRING(10) COLLATE 'und:ci' NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
ma_id BIGNUMERIC(38,0) NOT NULL,
ma_funktion_id STRING(10) COLLATE 'und:ci' NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);