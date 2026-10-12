CREATE TABLE IF NOT EXISTS ldl_score_etl_process.t_etl_rel_dim_table_dependency_2 (
target_db STRING(15) COLLATE 'und:ci' NOT NULL,
target_table STRING(100) COLLATE 'und:ci' NOT NULL,
target_join_key STRING(100) COLLATE 'und:ci' NOT NULL,
target_fields STRING(500) COLLATE 'und:ci' NOT NULL,
source_db STRING(20) COLLATE 'und:ci' NOT NULL,
source_table STRING(100) COLLATE 'und:ci' NOT NULL,
source_join_key STRING(100) COLLATE 'und:ci' NOT NULL,
source_fields STRING(500) COLLATE 'und:ci' NOT NULL,
last_read_tmsp DATETIME NOT NULL,
is_active BOOL NOT NULL,
dwh_created_tmsp TIMESTAMP NOT NULL,
dwh_updated_tmsp TIMESTAMP NOT NULL
);