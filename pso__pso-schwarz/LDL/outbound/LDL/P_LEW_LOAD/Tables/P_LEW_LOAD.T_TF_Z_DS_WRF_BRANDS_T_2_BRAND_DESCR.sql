CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tf_z_ds_wrf_brands_t_2_brand_descr (
client_id BIGNUMERIC(38),
lidl_country STRING(40),
z_ds_wrf_brands_t_spras STRING(4),
z_ds_wrf_brands_t_kmbrnd STRING(8),
src_brand_cd STRING(40),
brand_text_spras STRING(40),
lang_cd STRING(20),
brand_descr STRING(100) COLLATE 'und:ci',
extraction_dt DATE,
dwh_mapping_dt DATE,
tf_error_fg INTEGER,
record_id INTEGER,
filename STRING(1000)
);