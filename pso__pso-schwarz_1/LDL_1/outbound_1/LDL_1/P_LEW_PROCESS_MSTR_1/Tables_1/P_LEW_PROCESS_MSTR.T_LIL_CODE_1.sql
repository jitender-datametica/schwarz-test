CREATE TABLE IF NOT EXISTS ldl_p_lew_process_mstr.t_lil_code_1 (
main_code STRING(100) COLLATE 'und:ci' NOT NULL,
sub_code STRING(100) COLLATE 'und:ci' NOT NULL,
key_field STRING(100) COLLATE 'und:ci' NOT NULL,
val STRING(100) COLLATE 'und:ci',
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL
);