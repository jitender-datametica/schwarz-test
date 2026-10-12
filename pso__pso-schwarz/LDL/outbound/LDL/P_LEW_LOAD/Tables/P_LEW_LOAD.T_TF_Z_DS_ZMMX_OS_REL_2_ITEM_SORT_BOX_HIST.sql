CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tf_z_ds_zmmx_os_rel_2_item_sort_box_hist (
client_id BIGNUMERIC(38),
lidl_country STRING(40),
z_ds_zmmx_os_rel_matnr_hl STRING(36),
z_ds_zmmx_os_rel_matnr STRING(36),
src_matnr_sort_box STRING(40),
src_matnr STRING(40),
deleted_fg BIGNUMERIC(38),
extraction_dt DATE,
dwh_mapping_dt DATE,
tf_error_fg INTEGER,
record_id INTEGER,
filename STRING(1000)
);