CREATE TABLE IF NOT EXISTS kfl_production_dbp_msi_data.ncs_log (
date_start DATE NOT NULL,
service_id STRING(300) COLLATE 'und:ci' NOT NULL,
time_start BIGNUMERIC(38,0) NOT NULL,
date_end DATE,
time_end BIGNUMERIC(38,0),
status BIGNUMERIC(38,0) NOT NULL,
service_name STRING(300) COLLATE 'und:ci' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);