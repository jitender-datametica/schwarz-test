CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tf_map_deliv_type_mov_type_2_cache_map_deliv_type_mov_type_hist (
client_id BIGNUMERIC(38,0),
lidl_country STRING(40),
map_deliv_type_mov_type_bic_zmlila STRING(3) COLLATE 'und:ci',
map_deliv_type_mov_type_order_type_cd STRING(250) COLLATE 'und:ci',
map_deliv_type_mov_type_mov_type_cd STRING(250) COLLATE 'und:ci',
bic_zmlila STRING(60),
order_type_cd STRING(60),
mov_type_cd STRING(60),
deliv_type_cd BIGNUMERIC(38,0),
deleted_fg BIGNUMERIC(38,0),
extraction_dt DATE,
dwh_mapping_dt DATE,
tf_error_fg INTEGER,
record_id INTEGER,
filename STRING(1000)
);