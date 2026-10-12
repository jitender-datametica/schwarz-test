CREATE TABLE IF NOT EXISTS szd_etl_process.t_etl_rel_dim_table_dependency_2 (
target_db STRING(20),
target_table STRING(100),
target_join_key STRING(16777216),
target_fields STRING(16777216),
source_db STRING(20),
source_table STRING(100),
source_join_key STRING(16777216),
source_fields STRING(16777216),
last_read_tmsp DATETIME,
is_active BOOL,
dwh_created_tmsp DATETIME,
dwh_updated_tmsp DATETIME
);