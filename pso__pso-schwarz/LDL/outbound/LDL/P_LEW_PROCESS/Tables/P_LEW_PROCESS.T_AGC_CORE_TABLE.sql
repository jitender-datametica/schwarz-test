CREATE TABLE IF NOT EXISTS ldl_p_lew_process.t_agc_core_table (
core_table_sid BIGNUMERIC(38,0) NOT NULL,
core_table_name STRING(100) COLLATE 'und:ci',
update_trigger_mode STRING(100) COLLATE 'und:ci',
interval_start_field STRING(100) COLLATE 'und:ci',
interval_end_field STRING(100) COLLATE 'und:ci',
last_updated DATETIME,
last_load_id BIGNUMERIC(38,0)
);