CREATE TABLE IF NOT EXISTS kfl_production_dbp_msi_data.user_wup_zu_1 (
user_id STRING(30) COLLATE 'und:ci' NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
wup_id BIGNUMERIC(38,0) NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);