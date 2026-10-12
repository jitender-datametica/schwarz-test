CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tf_map_itm_state_2_cache_map_itm_state_hist_1 (
client_id BIGNUMERIC(38,0),
lidl_country STRING(40),
map_itm_state_bic_zmlila STRING(3) COLLATE 'und:ci',
map_itm_state_itm_state_bges_id STRING(250) COLLATE 'und:ci',
bic_zmlila STRING(60),
itm_state_bges_id STRING(60),
itm_state_descr STRING(300),
mis_itm_state_id BIGNUMERIC(38,0),
mis_state_descr STRING(3000),
deleted_fg BIGNUMERIC(38,0),
extraction_dt DATE,
dwh_mapping_dt DATE,
tf_error_fg INTEGER,
record_id INTEGER,
filename STRING(1000)
);