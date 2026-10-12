CREATE TABLE IF NOT EXISTS ldl_p_lew_process.t_wawi_sys_load_1 (
jobname STRING(80) COLLATE 'und:ci' NOT NULL,
instance_id DATETIME NOT NULL,
ab_run_id INTEGER,
load_id INTEGER NOT NULL
);