CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.rpm_feld_zu_per (
rpm_hierarchie_id STRING(32) COLLATE 'und:ci' NOT NULL,
rpm_feld_id BIGNUMERIC(38,0) NOT NULL,
rpm_tab_id BIGNUMERIC(38,0) NOT NULL,
dat_von DATE NOT NULL,
dat_bis DATE NOT NULL,
rpm_gewichtung BIGNUMERIC(38,0),
rpm_feld_auspr_id BIGNUMERIC(38,0),
td_update TIMESTAMP,
td_insert TIMESTAMP
);