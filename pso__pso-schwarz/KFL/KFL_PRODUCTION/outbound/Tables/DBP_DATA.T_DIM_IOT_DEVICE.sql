CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.t_dim_iot_device (
device_id STRING(50) COLLATE 'und:ci' NOT NULL,
device_number STRING(20) COLLATE 'und:ci',
device_model STRING(20) COLLATE 'und:ci',
device_location STRING(100) COLLATE 'und:ci',
td_update TIMESTAMP,
td_insert TIMESTAMP
);