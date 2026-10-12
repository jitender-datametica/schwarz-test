CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_ts_z_ds_zmmx_v_bw_inob_2_tcache_z_ds_zmmx_v_bw_inob_2 (
record_id INTEGER,
bic_zmlila STRING(10),
client_id BIGNUMERIC(38),
item_sid NUMERIC(20,0),
objek STRING(100),
cuobj STRING(100),
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