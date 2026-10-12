CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tf_map_price_groups_2_cache_map_price_groups_hist_2 (
client_id BIGNUMERIC(38,0),
lidl_country STRING(40),
map_price_groups_bic_zmlila STRING(3) COLLATE 'und:ci',
map_price_groups_prcs_grp_cd STRING(250) COLLATE 'und:ci',
bic_zmlila STRING(60),
prcs_grp_cd STRING(60),
lang_cd STRING(60),
prcs_grp_descr STRING(300),
deleted_fg BIGNUMERIC(38,0),
extraction_dt DATE,
dwh_mapping_dt DATE,
tf_error_fg INTEGER,
record_id INTEGER,
filename STRING(1000)
);