CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tf_z_ds_zmmx_v_wrpl_w001_2_item_replenishment_hist (
client_id BIGNUMERIC(38),
lidl_country STRING(40),
z_ds_zmmx_v_wrpl_w001_werks STRING(8),
z_ds_zmmx_v_wrpl_w001_kunnr STRING(20),
z_ds_zmmx_v_wrpl_w001_matnr STRING(36),
src_matnr STRING(40),
src_werks STRING(40),
min_nominal_stock NUMERIC(18,5),
min_order_qty NUMERIC(18,5),
deleted_fg BIGNUMERIC(38),
extraction_dt DATE,
dwh_mapping_dt DATE,
tf_error_fg INTEGER,
record_id INTEGER,
filename STRING(1000)
);