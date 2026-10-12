CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tf_map_pcwo_id_2_cache_map_pcwo_id_hist_2 (
client_id BIGNUMERIC(38,0),
lidl_country STRING(40),
map_pcwo_id_mov_type_cd STRING(250) COLLATE 'und:ci',
map_pcwo_id_mov_reason_cd STRING(250) COLLATE 'und:ci',
bic_zmlila STRING(60),
pcwo_reason_id BIGNUMERIC(38,0),
mov_type_cd STRING(60),
mov_reason_cd STRING(60),
mov_reason_descr STRING(300),
deleted_fg BIGNUMERIC(38,0),
extraction_dt DATE,
dwh_mapping_dt DATE,
tf_error_fg INTEGER,
record_id INTEGER,
filename STRING(1000)
);