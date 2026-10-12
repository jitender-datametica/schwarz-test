CREATE TABLE IF NOT EXISTS ldl_data_etl_process.t_lookup_instr_1 (
country_1 STRING(20) COLLATE 'und:ci' NOT NULL,
target_table STRING(100) COLLATE 'und:ci' NOT NULL,
source_system STRING(20) COLLATE 'und:ci' NOT NULL,
source_unique_name STRING(100) COLLATE 'und:ci' NOT NULL,
sid_alias STRING(100) COLLATE 'und:ci' NOT NULL,
sid_name STRING(100) COLLATE 'und:ci' NOT NULL,
table_name STRING(100) COLLATE 'und:ci' NOT NULL,
natural_keys STRING(300) COLLATE 'und:ci' NOT NULL,
temp_alias_keys STRING(300) COLLATE 'und:ci' NOT NULL,
add_temporal_join STRING(3) COLLATE 'und:ci' NOT NULL,
lkp_table_area STRING(20) COLLATE 'und:ci' NOT NULL,
keyspace_schema STRING(20) COLLATE 'und:ci' NOT NULL,
keyspace_subject_area STRING(50) COLLATE 'und:ci' NOT NULL,
keyspace_key_type_cd STRING(50) COLLATE 'und:ci' NOT NULL,
keyspace_natural_key_name STRING(200) COLLATE 'und:ci' NOT NULL,
keyspace_sid_key_name STRING(50) COLLATE 'und:ci' NOT NULL
);