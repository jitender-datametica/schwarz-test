CREATE TABLE IF NOT EXISTS ldl_p_lew_process.t_agc_target_aggregate_1 (
aggregate_name STRING(100) COLLATE 'und:ci' NOT NULL,
target_database STRING(100) COLLATE 'und:ci',
source_database STRING(100) COLLATE 'und:ci',
source_view STRING(100) COLLATE 'und:ci',
delta_mode STRING(100) COLLATE 'und:ci',
last_updated DATETIME
);