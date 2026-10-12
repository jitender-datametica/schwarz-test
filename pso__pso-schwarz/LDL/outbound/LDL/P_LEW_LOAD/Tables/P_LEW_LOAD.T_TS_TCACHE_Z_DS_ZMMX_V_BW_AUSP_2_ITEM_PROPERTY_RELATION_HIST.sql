CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_ts_tcache_z_ds_zmmx_v_bw_ausp_2_item_property_relation_hist (
record_id INTEGER,
client_id BIGNUMERIC(38),
item_property_sid INTEGER,
item_sid NUMERIC(20,0),
deleted_fg BIGNUMERIC(38),
dwh_valid_from DATE,
dwh_valid_to DATE,
dwh_load_id BIGNUMERIC(38),
dwh_created DATETIME,
dwh_updated DATETIME,
dwh_mapping_dt DATE,
error_fg BIGNUMERIC(38),
error_descr STRING(1000) COLLATE 'und:ci',
filename STRING(1000) COLLATE 'und:ci',
hist_row_no BIGNUMERIC(38)
);