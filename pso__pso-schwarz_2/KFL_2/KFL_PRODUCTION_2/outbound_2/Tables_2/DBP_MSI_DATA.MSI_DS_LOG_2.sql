CREATE TABLE IF NOT EXISTS kfl_production_dbp_msi_data.msi_ds_log_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
msi_report_id STRING(32) COLLATE 'und:ci' NOT NULL,
ds_report_start DATETIME NOT NULL,
msi_projekt_name STRING(255) COLLATE 'und:ci' NOT NULL,
msi_report_name STRING(255) COLLATE 'und:ci' NOT NULL,
msi_user_id STRING(255) COLLATE 'und:ci' NOT NULL,
ds_report_ende DATETIME,
ds_status_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL,
ds_info STRING(255) COLLATE 'und:ci',
td_insert TIMESTAMP,
td_update TIMESTAMP
);