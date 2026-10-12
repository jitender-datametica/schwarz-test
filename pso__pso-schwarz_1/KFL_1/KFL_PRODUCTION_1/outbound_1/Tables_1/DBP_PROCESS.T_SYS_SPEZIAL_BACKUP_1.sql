CREATE TABLE IF NOT EXISTS kfl_production_dbp_process.t_sys_spezial_backup_1 (
source_db STRING(15),
target_db STRING(15),
tablename STRING(50),
copy_fg STRING(1),
td_insert TIMESTAMP,
td_update TIMESTAMP
);