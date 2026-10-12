CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_ts_itm_store_stock_hist_2_item_agg_daily_movement_2 (
record_id INTEGER,
client_id BIGNUMERIC(38),
item_sid BIGNUMERIC(38),
loc_sid BIGNUMERIC(38),
storage_loc_cd STRING(20),
inflow_qty NUMERIC(18,5),
outflow_qty NUMERIC(18,5),
dwh_cal_dt DATE,
dwh_load_id BIGNUMERIC(38),
dwh_created DATETIME,
dwh_updated DATETIME,
dwh_mapping_dt DATE,
error_fg BIGNUMERIC(38),
error_descr STRING(1000) COLLATE 'und:ci',
filename STRING(1000) COLLATE 'und:ci',
hist_row_no BIGNUMERIC(38)
);