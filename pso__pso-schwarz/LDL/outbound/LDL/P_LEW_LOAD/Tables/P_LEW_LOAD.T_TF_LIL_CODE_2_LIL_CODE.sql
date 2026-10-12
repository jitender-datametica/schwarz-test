CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tf_lil_code_2_lil_code (
main_code STRING(100) COLLATE 'und:ci' NOT NULL,
lil_code_main_code STRING(250) NOT NULL,
lil_code_sub_code STRING(250) NOT NULL,
lil_code_key_field STRING(250) NOT NULL,
sub_code STRING(100) COLLATE 'und:ci' NOT NULL,
key_field STRING(100) COLLATE 'und:ci' NOT NULL,
val STRING(100) COLLATE 'und:ci',
extraction_dt DATE,
dwh_mapping_dt DATE NOT NULL,
tf_error_fg INTEGER,
record_id STRING(300) NOT NULL,
filename STRING(1000) NOT NULL
);