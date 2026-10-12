CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.rpm_hier_bed_konzept_zu_per_2 (
bedienkonzept_id BIGNUMERIC(38,0) NOT NULL,
rpm_hierarchie_id STRING(32) COLLATE 'und:ci' NOT NULL,
dat_von DATE NOT NULL,
rpm_tab_id BIGNUMERIC(38,0) NOT NULL,
dat_bis DATE NOT NULL,
dat_bedienkonzept DATE NOT NULL,
bedienkonzept_auspr_id BIGNUMERIC(38,0),
td_update TIMESTAMP,
td_insert TIMESTAMP
);