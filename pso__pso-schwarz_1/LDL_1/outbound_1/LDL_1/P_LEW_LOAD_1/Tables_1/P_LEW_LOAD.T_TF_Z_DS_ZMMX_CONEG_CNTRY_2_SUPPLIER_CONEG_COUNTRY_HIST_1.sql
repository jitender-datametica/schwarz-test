CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tf_z_ds_zmmx_coneg_cntry_2_supplier_coneg_country_hist_1 (
client_id BIGNUMERIC(38),
lidl_country STRING(40),
z_ds_zmmx_coneg_cntry_lifnr STRING(20),
z_ds_zmmx_coneg_cntry_conegot_coun STRING(6),
src_lifnr STRING(40),
src_country_lidl_cd_conegot STRING(40),
country_cd_conegot STRING(20),
deleted_fg BIGNUMERIC(38),
extraction_dt DATE,
dwh_mapping_dt DATE,
tf_error_fg INTEGER,
record_id INTEGER,
filename STRING(1000)
);