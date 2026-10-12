CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_rpm_feld_1 (
rpm_feld_id BIGNUMERIC(38,0) NOT NULL,
rpm_feld_bez STRING(50) COLLATE 'und:ci' NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);