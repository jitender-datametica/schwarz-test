CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_ts_tcache_z_ds_zmmx_v_bw_cawn_2_item_property_1 (
record_id INTEGER,
client_id BIGNUMERIC(38),
item_property_sid BIGNUMERIC(38),
src_item_property_id BIGNUMERIC(38),
src_atwrt STRING(50) COLLATE 'und:ci',
item_property_cd STRING(100) COLLATE 'und:ci',
item_property_int_name STRING(100) COLLATE 'und:ci',
item_property_local_name STRING(100) COLLATE 'und:ci',
item_property_descr STRING(1000) COLLATE 'und:ci',
dwh_load_id BIGNUMERIC(38),
dwh_created DATETIME,
dwh_updated DATETIME,
dwh_mapping_dt DATE,
error_fg BIGNUMERIC(38),
error_descr STRING(1000) COLLATE 'und:ci',
filename STRING(1000) COLLATE 'und:ci',
hist_row_no BIGNUMERIC(38)
);