CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_sonderabwicklung_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
sonderabwicklung_id STRING(20) COLLATE 'und:ci' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);