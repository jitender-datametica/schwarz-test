CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_ts_z_ds_zmmx_v_bw_ausp_2_tcache_z_ds_zmmx_v_bw_ausp_1 (
record_id INTEGER,
bic_zmlila STRING(10),
client_id BIGNUMERIC(38),
item_property_sid INTEGER,
objek STRING(100),
atinn INTEGER,
atwrt STRING(60),
dwh_load_id BIGNUMERIC(38),
dwh_created DATETIME,
dwh_updated DATETIME,
extraction_dt DATE,
dwh_mapping_dt DATE,
error_fg BIGNUMERIC(38),
error_descr STRING(1000) COLLATE 'und:ci',
filename STRING(1000) COLLATE 'und:ci',
hist_row_no BIGNUMERIC(38)
);