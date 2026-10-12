CREATE TABLE IF NOT EXISTS kfl_production_dbp_msi_view_ios.ts_projekt_bemerkung_2 (
cpr_ext_id STRING(30) COLLATE 'und:ci' NOT NULL,
user_id STRING(30) COLLATE 'und:ci' DEFAULT ' ' NOT NULL,
dat_aenderung DATE DEFAULT CAST('1900-01-01' AS DATE) NOT NULL,
projekt_bemerkung STRING(255) COLLATE 'und:ci' DEFAULT ' ' NOT NULL
);