CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_planungsart (
mandant_id BIGNUMERIC(38,0) NOT NULL,
planungsart_id STRING(1) COLLATE 'und:ci' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);