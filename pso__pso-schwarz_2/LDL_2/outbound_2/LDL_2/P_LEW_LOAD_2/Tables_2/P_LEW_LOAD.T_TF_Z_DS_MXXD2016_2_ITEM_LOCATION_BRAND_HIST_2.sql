CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tf_z_ds_mxxd2016_2_item_location_brand_hist_2 (
client_id BIGNUMERIC(38),
lidl_country STRING(40),
z_ds_mxxd2016_plant STRING(8),
z_ds_mxxd2016_material STRING(36),
src_matnr STRING(40),
src_werks STRING(40),
src_brand_cd STRING(40),
brand_type_mark STRING(20) COLLATE 'und:ci',
brand_type_label STRING(100) COLLATE 'und:ci',
deleted_fg BIGNUMERIC(38),
extraction_dt DATE,
dwh_mapping_dt DATE,
tf_error_fg INTEGER,
record_id INTEGER,
filename STRING(1000)
);