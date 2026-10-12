CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.rpm_hierarchie_zu_per_1 (
rpm_hierarchie_id STRING(32) COLLATE 'und:ci' NOT NULL,
dat_von DATE NOT NULL,
dat_bis DATE NOT NULL,
rpm_bereich_id STRING(20) COLLATE 'und:ci' NOT NULL,
rpm_ebene_id BIGNUMERIC(38,0) NOT NULL,
rpm_hierarchie_mutter_id STRING(32) COLLATE 'und:ci' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);