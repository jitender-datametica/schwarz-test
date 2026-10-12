CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tf_lp_custmap_content_2_ref_ident_type_2 (
context_name STRING(100) COLLATE 'und:ci' NOT NULL,
ident_type_cd STRING(20) COLLATE 'und:ci' NOT NULL,
ident_type_descr STRING(100) COLLATE 'und:ci',
extraction_dt DATE,
dwh_mapping_dt DATE,
tf_error_fg INTEGER,
record_id INTEGER,
filename STRING(1000)
);