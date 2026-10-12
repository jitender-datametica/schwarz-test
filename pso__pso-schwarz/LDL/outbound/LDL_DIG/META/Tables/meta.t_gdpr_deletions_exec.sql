CREATE TABLE IF NOT EXISTS ldl_dig_meta.t_gdpr_deletions_exec (
deletions_exec_id INTEGER NOT NULL,
type_cd STRING(250),
num_gdpr_recs INTEGER NOT NULL,
num_customers INTEGER NOT NULL,
status_id INTEGER NOT NULL,
run_start DATETIME,
run_end DATETIME
);