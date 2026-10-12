CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tf_map_type_ignore_2_cache_map_type_ignore_hist_1 (
client_id BIGNUMERIC(38,0),
lidl_country STRING(40),
map_type_ignore_bic_zmlila STRING(3) COLLATE 'und:ci',
map_type_ignore_itm_type_id STRING(250) COLLATE 'und:ci',
map_type_ignore_itm_type_group_cd STRING(250) COLLATE 'und:ci',
bic_zmlila STRING(60),
itm_type_id STRING(60),
itm_type_group_cd STRING(60),
deleted_fg BIGNUMERIC(38,0),
extraction_dt DATE,
dwh_mapping_dt DATE,
tf_error_fg INTEGER,
record_id INTEGER,
filename STRING(1000)
);