CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tf_map_priority_groups_2_cache_map_priority_groups_hist_1 (
client_id BIGNUMERIC(38,0),
lidl_country STRING(40),
map_priority_groups_bic_zmlila STRING(3) COLLATE 'und:ci',
map_priority_groups_prcs_grp_cd STRING(250) COLLATE 'und:ci',
bic_zmlila STRING(60),
prcs_grp_cd STRING(60),
valid_from DATE,
prcs_grp_prio BIGNUMERIC(38,0),
valid_to DATE,
deleted_fg BIGNUMERIC(38,0),
extraction_dt DATE,
dwh_mapping_dt DATE,
tf_error_fg INTEGER,
record_id INTEGER,
filename STRING(1000)
);