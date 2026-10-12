CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_verrechfallart_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
verrechfallart_id STRING(20) COLLATE 'und:ci' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);