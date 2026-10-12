CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.rpm_element_spr_zu_2 (
rpm_element_id STRING(32) COLLATE 'und:ci' NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
dat_von DATE,
rpm_element_bez STRING(40) COLLATE 'und:ci' NOT NULL,
rpm_element_langtext STRING(320) COLLATE 'und:ci',
td_update TIMESTAMP,
td_insert TIMESTAMP
);