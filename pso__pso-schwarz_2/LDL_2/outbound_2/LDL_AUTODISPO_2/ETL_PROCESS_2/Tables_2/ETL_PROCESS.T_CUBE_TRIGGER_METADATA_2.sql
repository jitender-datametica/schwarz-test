CREATE TABLE IF NOT EXISTS ldl_autodispo_etl_process.t_cube_trigger_metadata_2 (
project_id STRING(16777216),
cube_id STRING(16777216),
table_schema STRING(16777216),
table_name STRING(16777216),
is_active BOOL,
load_number STRING(16777216),
cube_triggered BOOL,
load_day STRING(16777216),
load_window_open TIME,
load_window_close TIME,
last_load_tmsp TIMESTAMP
);