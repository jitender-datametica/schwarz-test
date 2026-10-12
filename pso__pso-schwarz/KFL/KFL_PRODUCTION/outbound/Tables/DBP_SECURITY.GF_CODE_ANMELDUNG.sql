CREATE TABLE IF NOT EXISTS kfl_production_dbp_security.gf_code_anmeldung (
user_id STRING(30) COLLATE 'und:ci' NOT NULL,
gf_code STRING(10) COLLATE 'und:ci' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);