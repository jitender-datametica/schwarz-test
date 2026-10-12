CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_einh_1 (
einh_id STRING(3) COLLATE 'und:ci' NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);