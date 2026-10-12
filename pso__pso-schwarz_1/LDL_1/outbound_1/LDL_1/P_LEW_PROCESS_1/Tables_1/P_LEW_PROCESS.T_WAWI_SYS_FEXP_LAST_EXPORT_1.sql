CREATE TABLE IF NOT EXISTS ldl_p_lew_process.t_wawi_sys_fexp_last_export_1 (
jobname STRING(80) COLLATE 'und:ci' NOT NULL,
instance_id STRING(19) COLLATE 'und:ci' NOT NULL,
ab_run_id BIGNUMERIC(38,0),
load_id BIGNUMERIC(38,0) NOT NULL,
max_load_id BIGNUMERIC(38,0),
table_name STRING(30) COLLATE 'und:ci' NOT NULL,
export_name STRING(30) COLLATE 'und:ci' NOT NULL
);