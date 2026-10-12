CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.profit_center_1 (
pc_id STRING(10) COLLATE 'und:ci' NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
krk_id STRING(4) COLLATE 'und:ci' NOT NULL,
system_id BIGNUMERIC(38,0) NOT NULL,
wup_id BIGNUMERIC(38,0),
nb_id BIGNUMERIC(38,0),
werk_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);