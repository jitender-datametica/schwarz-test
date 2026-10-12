CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_pit_onprem.t_pit_etl_logging_2 (
run_id BIGNUMERIC(38,0) NOT NULL,
run_ts DATETIME DEFAULT CAST(CURRENT_TIMESTAMP() AS DATETIME) NOT NULL,
run_dt DATE DEFAULT DATE '1900-01-01',
module_name STRING(16777216) NOT NULL,
component_name STRING(16777216) NOT NULL,
module_query_band STRING(16777216) NOT NULL,
ai_load_id BIGNUMERIC(38,0),
td_user_id STRING(16777216),
ai_cluster_cd STRING(16777216),
start_run_timestamp DATETIME DEFAULT CAST(CURRENT_TIMESTAMP() AS DATETIME),
end_run_timestamp DATETIME,
exec_status_fg BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL,
deleted_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL,
PRIMARY KEY (run_id, module_name, component_name) NOT ENFORCED
);