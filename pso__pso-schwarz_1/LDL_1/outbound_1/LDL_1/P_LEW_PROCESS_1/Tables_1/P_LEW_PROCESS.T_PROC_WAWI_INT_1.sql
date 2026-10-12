CREATE TABLE IF NOT EXISTS ldl_p_lew_process.t_proc_wawi_int_1 (
src_table STRING(100) COLLATE 'und:ci',
src_database STRING(100) COLLATE 'und:ci',
src_type STRING(100) COLLATE 'und:ci',
tgt_table STRING(100) COLLATE 'und:ci',
tgt_database STRING(100) COLLATE 'und:ci',
tgt_create_fg BIGNUMERIC(38,0) NOT NULL
);