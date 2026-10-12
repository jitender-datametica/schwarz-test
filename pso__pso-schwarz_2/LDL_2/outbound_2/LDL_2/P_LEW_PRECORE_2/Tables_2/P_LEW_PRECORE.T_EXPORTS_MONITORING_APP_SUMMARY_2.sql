CREATE TABLE IF NOT EXISTS ldl_p_lew_precore.t_exports_monitoring_app_summary_2 (
app_name STRING(128) NOT NULL,
type STRING(128),
total_parent BIGNUMERIC(38,0),
total_child BIGNUMERIC(38,0),
failed_parent BIGNUMERIC(38,0),
succeded_parent BIGNUMERIC(38,0),
failed_child BIGNUMERIC(38,0),
succeded_child BIGNUMERIC(38,0),
valid_from DATE,
valid_to DATE,
PRIMARY KEY (app_name) NOT ENFORCED
);