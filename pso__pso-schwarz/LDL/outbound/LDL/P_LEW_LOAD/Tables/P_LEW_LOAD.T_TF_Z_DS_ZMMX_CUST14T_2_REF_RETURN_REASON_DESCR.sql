CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tf_z_ds_zmmx_cust14t_2_ref_return_reason_descr (
client_id BIGNUMERIC(38),
lidl_country STRING(40),
z_ds_zmmx_cust14t_ret_reason_k STRING(8),
z_ds_zmmx_cust14t_spras STRING(4),
return_reason_cd STRING(20),
lang_cd STRING(20),
return_reason_descr STRING(100) COLLATE 'und:ci',
extraction_dt DATE,
dwh_mapping_dt DATE,
tf_error_fg INTEGER,
record_id INTEGER,
filename STRING(1000)
);