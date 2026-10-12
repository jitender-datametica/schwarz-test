CREATE TABLE IF NOT EXISTS kfl_production_dbp_process.load_chk_figures_1 (
cycle_id BIGNUMERIC(38,0),
sql_name STRING(50) COLLATE 'und:ci' NOT NULL,
sql_type STRING(10) COLLATE 'und:ci' NOT NULL,
record_count INTEGER,
durationsec BIGNUMERIC(38,0),
err_count BIGNUMERIC(38,0),
job_name STRING(50) COLLATE 'und:ci' NOT NULL,
scr_name STRING(50) COLLATE 'und:ci' NOT NULL,
loop_id BIGNUMERIC(38,0),
proc_type STRING(5) COLLATE 'und:ci',
td_insert TIMESTAMP,
td_update TIMESTAMP
);