CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tf_z_ds_wlk2_2_item_pos_control_hist_1 (
client_id BIGNUMERIC(38),
lidl_country STRING(40),
z_ds_wlk2_matnr STRING(36),
z_ds_wlk2_vkorg STRING(8),
z_ds_wlk2_vtweg STRING(4),
z_ds_wlk2_werks STRING(8),
src_matnr STRING(40),
src_vkorg STRING(40),
src_werks STRING(40),
distribution_channel_cd STRING(20),
scale_area STRING(20),
deleted_fg BIGNUMERIC(38),
extraction_dt DATE,
dwh_mapping_dt DATE,
tf_error_fg INTEGER,
record_id INTEGER,
filename STRING(1000)
);