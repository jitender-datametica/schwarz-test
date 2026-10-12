CREATE TABLE IF NOT EXISTS kfl_production_dbp_process.online_archiving_history_2 (
nr_db STRING(40),
sql_stmt STRING(1000),
cr_date DATE,
cr_time BIGNUMERIC(38,0),
td_update TIMESTAMP,
td_insert TIMESTAMP
);