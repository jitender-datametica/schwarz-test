CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_ts_lil_code_2_lil_code (
record_id STRING(1000) COLLATE 'und:ci',
main_code STRING(100) COLLATE 'und:ci',
sub_code STRING(100) COLLATE 'und:ci',
key_field STRING(100) COLLATE 'und:ci',
val STRING(100) COLLATE 'und:ci',
dwh_load_id BIGNUMERIC(38),
dwh_created DATETIME,
dwh_updated DATETIME,
dwh_mapping_dt DATE,
error_fg BIGNUMERIC(38),
error_descr STRING(1000) COLLATE 'und:ci',
filename STRING(1000) COLLATE 'und:ci',
hist_row_no BIGNUMERIC(38)
);