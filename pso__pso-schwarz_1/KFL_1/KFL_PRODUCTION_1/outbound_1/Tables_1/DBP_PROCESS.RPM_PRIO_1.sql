CREATE TABLE IF NOT EXISTS kfl_production_dbp_process.rpm_prio_1 (
rpm_feld_bez STRING(50) COLLATE 'und:ci' NOT NULL,
rpm_gewichtung BIGNUMERIC(38,0),
td_update TIMESTAMP,
td_insert TIMESTAMP
);