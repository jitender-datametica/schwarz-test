CREATE TABLE IF NOT EXISTS kfl_production_dbp_msi_data.ios_datenfreigabe_ime_2 (
user_id STRING(30) COLLATE 'und:ci' NOT NULL,
ime_fg BIGNUMERIC(38,0) NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);