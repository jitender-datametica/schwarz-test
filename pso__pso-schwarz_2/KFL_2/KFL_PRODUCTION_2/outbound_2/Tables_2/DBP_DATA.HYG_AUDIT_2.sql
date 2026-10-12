CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.hyg_audit_2 (
hyg_audit_id STRING(36) COLLATE 'und:ci' NOT NULL,
audit_instance_id STRING(36) COLLATE 'und:ci' NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
wup_id BIGNUMERIC(38,0) NOT NULL,
dat_start DATETIME,
dat_ende DATETIME,
audit_instance_bez STRING(60) COLLATE 'und:ci',
status_string STRING(255) COLLATE 'und:ci',
notes STRING(255) COLLATE 'und:ci',
gj BIGNUMERIC(38,0),
dat_real DATE,
td_insert TIMESTAMP,
td_update TIMESTAMP
);