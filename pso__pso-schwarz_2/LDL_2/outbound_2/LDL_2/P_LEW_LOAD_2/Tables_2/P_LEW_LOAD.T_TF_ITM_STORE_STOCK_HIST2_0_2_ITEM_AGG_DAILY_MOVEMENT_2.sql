CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tf_itm_store_stock_hist2_0_2_item_agg_daily_movement_2 (
client_id BIGNUMERIC(38) NOT NULL,
lidl_country STRING(40) NOT NULL,
itm_store_stock_hist2_0_stor_loc STRING(8) NOT NULL,
itm_store_stock_hist2_0_plant STRING(8) NOT NULL,
itm_store_stock_hist2_0_material STRING(36) NOT NULL,
itm_store_stock_hist2_0_calday DATE NOT NULL,
src_matnr STRING(40),
src_werks STRING(40),
storage_loc_cd STRING(20) NOT NULL,
inflow_qty NUMERIC(18,5),
outflow_qty NUMERIC(18,5),
dwh_cal_dt DATE NOT NULL,
extraction_dt DATE,
dwh_mapping_dt DATE NOT NULL,
tf_error_fg INTEGER,
record_id STRING(300) NOT NULL,
filename STRING(1000) NOT NULL
);