CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tf_cbx_item_brand_2_brand_1 (
client_id BIGNUMERIC(38),
lidl_country STRING(40),
cbx_item_brand_cbxitem_brand_code STRING(250),
src_brand_cd STRING(20),
brand_name STRING(100) COLLATE 'und:ci',
brand_type_cd STRING(20) COLLATE 'und:ci',
extraction_dt DATE,
dwh_mapping_dt DATE,
tf_error_fg INTEGER,
record_id INTEGER,
filename STRING(1000)
);