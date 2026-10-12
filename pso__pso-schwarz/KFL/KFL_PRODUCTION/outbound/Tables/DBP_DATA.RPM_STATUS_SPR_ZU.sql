CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.rpm_status_spr_zu (
rpm_status_id BIGNUMERIC(38,0) NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
rpm_status_bez STRING(60) COLLATE 'und:ci',
td_update TIMESTAMP,
td_insert TIMESTAMP
);