CREATE TABLE IF NOT EXISTS ldl_p_lew_process.t_lookup_instr_1 (
lila STRING(20) COLLATE 'und:ci' NOT NULL,
target_table STRING(100) COLLATE 'und:ci' NOT NULL,
source_system STRING(20) COLLATE 'und:ci' NOT NULL,
source_unique_name STRING(100) COLLATE 'und:ci' NOT NULL,
target_column STRING(100) COLLATE 'und:ci' NOT NULL,
lkp_column STRING(100) COLLATE 'und:ci' NOT NULL,
lkp_table STRING(100) COLLATE 'und:ci' NOT NULL,
lkp_table_lkp_keys STRING(300) COLLATE 'und:ci' NOT NULL,
source_lkp_keys STRING(300) COLLATE 'und:ci' NOT NULL,
add_temporal_join STRING(3) COLLATE 'und:ci' NOT NULL,
lkp_table_area STRING(20) COLLATE 'und:ci' NOT NULL
);