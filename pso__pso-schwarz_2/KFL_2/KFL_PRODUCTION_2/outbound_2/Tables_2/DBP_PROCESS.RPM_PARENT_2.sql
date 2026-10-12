CREATE TABLE IF NOT EXISTS kfl_production_dbp_process.rpm_parent_2 (
rpm_hierarchie_id STRING(32) COLLATE 'und:ci' NOT NULL,
rpm_parent_id STRING(32) COLLATE 'und:ci' NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);