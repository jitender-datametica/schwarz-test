CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tf_itm_store_stock_hist_2_item_agg_daily_movement_2 (
client_id BIGNUMERIC(38),
lidl_country STRING(40),
itm_store_stock_hist_material STRING(36),
itm_store_stock_hist_plant STRING(8),
itm_store_stock_hist_stor_loc STRING(8),
src_matnr STRING(40),
src_werks STRING(40),
storage_loc_cd STRING(20),
inflow_qty NUMERIC(18,5),
outflow_qty NUMERIC(18,5),
dwh_cal_dt DATE,
extraction_dt DATE,
dwh_mapping_dt DATE,
tf_error_fg INTEGER,
record_id INTEGER,
filename STRING(1000)
);