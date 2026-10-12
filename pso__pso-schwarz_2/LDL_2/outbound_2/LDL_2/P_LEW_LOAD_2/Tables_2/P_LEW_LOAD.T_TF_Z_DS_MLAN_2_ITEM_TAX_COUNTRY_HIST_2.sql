CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tf_z_ds_mlan_2_item_tax_country_hist_2 (
client_id BIGNUMERIC(38),
lidl_country STRING(40),
z_ds_mlan_matnr STRING(36),
z_ds_mlan_aland STRING(6),
src_matnr STRING(40),
src_land1 STRING(40),
country_pol_cd STRING(20),
tax_class_cd STRING(20),
tax_indicator_cd STRING(20),
deleted_fg BIGNUMERIC(38),
extraction_dt DATE,
dwh_mapping_dt DATE,
tf_error_fg INTEGER,
record_id INTEGER,
filename STRING(1000)
);