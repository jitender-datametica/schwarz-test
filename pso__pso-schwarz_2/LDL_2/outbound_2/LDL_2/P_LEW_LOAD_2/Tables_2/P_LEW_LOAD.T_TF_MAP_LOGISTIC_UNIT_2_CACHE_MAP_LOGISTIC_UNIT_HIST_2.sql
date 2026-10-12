CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tf_map_logistic_unit_2_cache_map_logistic_unit_hist_2 (
client_id BIGNUMERIC(38,0),
lidl_country STRING(40),
map_logistic_unit_bic_zmlila STRING(3) COLLATE 'und:ci',
map_logistic_unit_uom_id STRING(250) COLLATE 'und:ci',
bic_zmlila STRING(60),
uom_id STRING(60),
logistic_unit_cd BIGNUMERIC(38,0),
deleted_fg BIGNUMERIC(38,0),
extraction_dt DATE,
dwh_mapping_dt DATE,
tf_error_fg INTEGER,
record_id INTEGER,
filename STRING(1000)
);