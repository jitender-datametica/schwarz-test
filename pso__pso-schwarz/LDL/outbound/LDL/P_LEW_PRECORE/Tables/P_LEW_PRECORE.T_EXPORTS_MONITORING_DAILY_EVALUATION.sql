CREATE TABLE IF NOT EXISTS ldl_p_lew_precore.t_exports_monitoring_daily_evaluation (
app_name STRING(128),
parent_jobdef STRING(128),
child_job STRING(256),
starttime_cet DATETIME,
endtime_cet DATETIME,
metric STRING(128),
is_value FLOAT64 NOT NULL,
status STRING(128)
);