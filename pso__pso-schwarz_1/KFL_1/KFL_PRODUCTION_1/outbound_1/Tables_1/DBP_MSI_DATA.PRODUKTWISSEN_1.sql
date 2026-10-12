CREATE TABLE IF NOT EXISTS kfl_production_dbp_msi_data.produktwissen_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
matching_id BIGNUMERIC(38,0) NOT NULL,
dat_zeit_pflege DATETIME DEFAULT CAST('1900-01-01 00:00:00.000000' AS DATETIME) NOT NULL,
dat_pflege DATE,
f49_produktwissen STRING(1000) COLLATE 'und:ci' DEFAULT '-1' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);