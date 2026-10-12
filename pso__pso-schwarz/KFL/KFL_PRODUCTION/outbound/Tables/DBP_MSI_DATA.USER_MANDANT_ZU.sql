CREATE TABLE IF NOT EXISTS kfl_production_dbp_msi_data.user_mandant_zu (
mandant_id BIGNUMERIC(38,0) NOT NULL,
user_id STRING(30) COLLATE 'und:ci' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);