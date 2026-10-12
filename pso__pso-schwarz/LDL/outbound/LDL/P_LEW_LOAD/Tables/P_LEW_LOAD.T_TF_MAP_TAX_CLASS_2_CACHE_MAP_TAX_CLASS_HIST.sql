CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tf_map_tax_class_2_cache_map_tax_class_hist (
client_id BIGNUMERIC(38,0),
lidl_country STRING(40),
map_tax_class_bic_zmlila STRING(3) COLLATE 'und:ci',
map_tax_class_tax_class STRING(250) COLLATE 'und:ci',
bic_zmlila STRING(60),
tax_class STRING(60),
vat_id BIGNUMERIC(38,0),
deleted_fg BIGNUMERIC(38,0),
extraction_dt DATE,
dwh_mapping_dt DATE,
tf_error_fg INTEGER,
record_id INTEGER,
filename STRING(1000)
);