CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.rpm_immobilie_spr_zu (
rpm_immobilie_id STRING(32) COLLATE 'und:ci' NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
dat_von DATE,
rpm_immobilie_bez STRING(40) COLLATE 'und:ci' NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);