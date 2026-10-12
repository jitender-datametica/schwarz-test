CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tf_z_ds_zlax008_cust4t_2_packaging_type_1 (
client_id BIGNUMERIC(38),
lidl_country STRING(40),
z_ds_zlax008_cust4t_zz_pack_type STRING(12),
z_ds_zlax008_cust4t_langu STRING(4),
src_zz_pack_type STRING(20),
pack_type_name STRING(100) COLLATE 'und:ci',
extraction_dt DATE,
dwh_mapping_dt DATE,
tf_error_fg INTEGER,
record_id INTEGER,
filename STRING(1000)
);