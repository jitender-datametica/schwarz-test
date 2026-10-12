CREATE TABLE IF NOT EXISTS ldl_p_lew_precore.t_exports_monitoring_stats_hist_1 (
app_name STRING(128),
parent_jobdef STRING(128),
child_job STRING(256),
sample_size BIGNUMERIC(38,0),
metric STRING(128),
min_val FLOAT64,
pct_025_val FLOAT64,
pct_04_val FLOAT64,
median_val FLOAT64,
pct_06_val FLOAT64,
pct_075_val FLOAT64,
max_val FLOAT64,
valid_from DATE,
valid_to DATE
);