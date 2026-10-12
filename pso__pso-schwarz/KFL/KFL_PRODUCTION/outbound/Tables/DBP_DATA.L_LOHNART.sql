CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_lohnart (
mandant_id BIGNUMERIC(38,0) NOT NULL,
lohnart_id STRING(5) COLLATE 'und:ci' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);