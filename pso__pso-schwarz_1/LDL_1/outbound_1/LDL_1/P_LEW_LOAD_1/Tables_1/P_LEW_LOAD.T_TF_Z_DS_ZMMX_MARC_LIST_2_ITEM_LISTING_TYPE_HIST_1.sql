CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tf_z_ds_zmmx_marc_list_2_item_listing_type_hist_1 (
client_id BIGNUMERIC(38),
lidl_country STRING(40),
z_ds_zmmx_marc_list_matnr STRING(36),
z_ds_zmmx_marc_list_werks STRING(8),
src_matnr STRING(40),
src_werks STRING(40),
active_from_dt DATE,
active_to_dt DATE,
list_type_mark STRING(20),
list_type_label STRING(100) COLLATE 'und:ci',
deleted_fg BIGNUMERIC(38),
extraction_dt DATE,
dwh_mapping_dt DATE,
tf_error_fg INTEGER,
record_id INTEGER,
filename STRING(1000)
);