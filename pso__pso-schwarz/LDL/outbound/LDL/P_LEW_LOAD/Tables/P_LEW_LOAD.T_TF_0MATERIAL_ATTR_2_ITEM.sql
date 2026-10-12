CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tf_0material_attr_2_item (
client_id BIGNUMERIC(38),
lidl_country STRING(40),
material_attr_matnr STRING(36),
src_matnr STRING(20),
src_orig_item_nr STRING(20),
src_dat_valid_from DATE,
src_case_size STRING(20),
src_matnr_config STRING(40),
item_name STRING(100) COLLATE 'und:ci',
log_var_cd STRING(20),
config_item_cd STRING(20),
item_eks_cd STRING(20),
extraction_dt DATE,
dwh_mapping_dt DATE,
tf_error_fg INTEGER,
record_id INTEGER,
filename STRING(1000)
);