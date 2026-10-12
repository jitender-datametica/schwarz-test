CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_brand_abschnitt (
mandant_id BIGNUMERIC(38,0) NOT NULL,
brand_abschnitt_id STRING(2) COLLATE 'und:ci' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);