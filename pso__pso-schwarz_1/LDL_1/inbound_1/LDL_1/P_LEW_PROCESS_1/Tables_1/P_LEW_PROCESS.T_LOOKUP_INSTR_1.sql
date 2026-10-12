CREATE TABLE p_lew_process.t_lookup_instr_1 (
lila VARCHAR(20) COLLATE 'en-ci' NOT NULL,
target_table VARCHAR(100) COLLATE 'en-ci' NOT NULL,
source_system VARCHAR(20) COLLATE 'en-ci' NOT NULL,
source_unique_name VARCHAR(100) COLLATE 'en-ci' NOT NULL,
target_column VARCHAR(100) COLLATE 'en-ci' NOT NULL,
lkp_column VARCHAR(100) COLLATE 'en-ci' NOT NULL,
lkp_table VARCHAR(100) COLLATE 'en-ci' NOT NULL,
lkp_table_lkp_keys VARCHAR(300) COLLATE 'en-ci' NOT NULL,
source_lkp_keys VARCHAR(300) COLLATE 'en-ci' NOT NULL,
add_temporal_join VARCHAR(3) COLLATE 'en-ci' NOT NULL,
lkp_table_area VARCHAR(20) COLLATE 'en-ci' NOT NULL,
UNIQUE ( lila ,target_table ,source_system ,source_unique_name ,
target_column)
);

