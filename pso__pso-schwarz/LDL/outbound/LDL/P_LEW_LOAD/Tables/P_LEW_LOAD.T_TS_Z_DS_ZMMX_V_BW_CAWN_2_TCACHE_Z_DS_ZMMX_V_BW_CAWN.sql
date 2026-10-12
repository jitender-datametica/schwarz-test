CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_ts_z_ds_zmmx_v_bw_cawn_2_tcache_z_ds_zmmx_v_bw_cawn (
record_id INTEGER,
client_id BIGNUMERIC(38),
bic_zmlila STRING(40) COLLATE 'und:ci',
atwrt STRING(50) COLLATE 'und:ci',
atinn BIGNUMERIC(38),
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