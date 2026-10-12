CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.wbnk_gruppe_zu (
system_id BIGNUMERIC(38,0) NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
wbnk_id STRING(4) COLLATE 'und:ci' NOT NULL,
wbnk_gruppe_id BIGNUMERIC(38,0) NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);