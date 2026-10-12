CREATE TABLE p_lew_process.t_wawi_sys_load (
jobname VARCHAR(80) COLLATE 'en-ci' NOT NULL,
instance_id TIMESTAMP(0) NOT NULL,
ab_run_id INTEGER,
load_id INTEGER NOT NULL,
UNIQUE ( load_id)
);