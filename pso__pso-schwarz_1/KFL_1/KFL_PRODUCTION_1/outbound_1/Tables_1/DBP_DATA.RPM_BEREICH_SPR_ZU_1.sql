CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.rpm_bereich_spr_zu_1 (
rpm_bereich_id STRING(20) COLLATE 'und:ci' NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
rpm_bereich_bez STRING(40) COLLATE 'und:ci',
td_insert TIMESTAMP,
td_update TIMESTAMP
);