CREATE TABLE IF NOT EXISTS kfl_production_dbp_security.gf_code_1 (
gf_id BIGNUMERIC(38,0) NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
gf_code_1 STRING(10) COLLATE 'und:ci' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);