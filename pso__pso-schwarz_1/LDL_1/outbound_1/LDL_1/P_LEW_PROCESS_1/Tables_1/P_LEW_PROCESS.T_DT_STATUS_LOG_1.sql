CREATE TABLE IF NOT EXISTS ldl_p_lew_process.t_dt_status_log_1 (
target_database STRING(255),
warehouse_name STRING(255),
origin_table_schema STRING(255),
table_name STRING(255),
is_refreshed BIGNUMERIC(38,0),
prio_fg BIGNUMERIC(38,0),
created DATETIME,
last_refreshed DATETIME
);