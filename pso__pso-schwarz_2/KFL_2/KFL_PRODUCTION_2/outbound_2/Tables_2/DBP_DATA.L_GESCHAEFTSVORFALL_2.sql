CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_geschaeftsvorfall_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
geschaeftsvorfall_id STRING(2) COLLATE 'und:ci' NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);