CREATE TABLE IF NOT EXISTS ldl_score_etl_process.t_lookup_instr (
country STRING(20) COLLATE 'und:ci',
target_table STRING(100) COLLATE 'und:ci',
source_system STRING(20) COLLATE 'und:ci',
source_unique_name STRING(100) COLLATE 'und:ci',
sid_alias STRING(100) COLLATE 'und:ci',
sid_name STRING(100) COLLATE 'und:ci',
table_name STRING(100) COLLATE 'und:ci',
natural_keys STRING(300) COLLATE 'und:ci',
temp_alias_keys STRING(300) COLLATE 'und:ci',
add_temporal_join STRING(3) COLLATE 'und:ci',
lkp_table_area STRING(20) COLLATE 'und:ci',
keyspace_schema STRING(20) COLLATE 'und:ci',
keyspace_subject_area STRING(50) COLLATE 'und:ci',
keyspace_key_type_cd STRING(50) COLLATE 'und:ci',
keyspace_natural_key_name STRING(200) COLLATE 'und:ci',
keyspace_sid_key_name STRING(20) COLLATE 'und:ci'
);