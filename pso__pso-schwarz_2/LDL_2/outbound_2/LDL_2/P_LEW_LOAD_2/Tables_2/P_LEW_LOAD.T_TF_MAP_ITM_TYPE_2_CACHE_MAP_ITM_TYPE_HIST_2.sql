CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tf_map_itm_type_2_cache_map_itm_type_hist_2 (
client_id BIGNUMERIC(38,0),
lidl_country STRING(40),
map_itm_type_bic_zmlila STRING(3) COLLATE 'und:ci',
map_itm_type_descr STRING(250) COLLATE 'und:ci',
map_itm_type_list_type_cd STRING(250) COLLATE 'und:ci',
bic_zmlila STRING(60),
descr STRING(300),
list_type_cd STRING(60),
buying_list_type_id BIGNUMERIC(38,0),
buying_list_type_desc STRING(300),
deleted_fg BIGNUMERIC(38,0),
extraction_dt DATE,
dwh_mapping_dt DATE,
tf_error_fg INTEGER,
record_id INTEGER,
filename STRING(1000)
);