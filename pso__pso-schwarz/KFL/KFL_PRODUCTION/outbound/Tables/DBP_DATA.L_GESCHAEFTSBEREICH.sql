CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_geschaeftsbereich (
mandant_id BIGNUMERIC(38,0) NOT NULL,
geschaeftsbereich_id STRING(4) COLLATE 'und:ci' NOT NULL,
system_id BIGNUMERIC(38,0) NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);