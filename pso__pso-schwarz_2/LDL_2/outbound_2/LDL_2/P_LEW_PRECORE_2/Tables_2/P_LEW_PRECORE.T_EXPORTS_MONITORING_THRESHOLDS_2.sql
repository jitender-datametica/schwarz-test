CREATE TABLE IF NOT EXISTS ldl_p_lew_precore.t_exports_monitoring_thresholds_2 (
app_name STRING(128),
parent_jobdef STRING(128),
child_job STRING(256),
sample_size BIGNUMERIC(38,0),
metric STRING(128),
min_val FLOAT64,
lowest_pct_val FLOAT64,
low_pct_val FLOAT64,
median_val FLOAT64,
upper_pct_val FLOAT64,
highest_pct_val FLOAT64,
max_val FLOAT64,
manual_fg BIGNUMERIC(38,0) DEFAULT 0
);