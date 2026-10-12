CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tf_tcache_z_ds_zmmx_v_bw_cawn_2_item_property (
client_id BIGNUMERIC(38),
src_atwrt STRING(50) COLLATE 'und:ci',
item_property_cd STRING(100) COLLATE 'und:ci',
src_item_property_id BIGNUMERIC(38),
extraction_dt DATE,
dwh_mapping_dt DATE,
tf_error_fg INTEGER,
record_id INTEGER,
filename STRING(1000) COLLATE 'und:ci'
);