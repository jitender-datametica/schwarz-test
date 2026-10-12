CREATE TABLE IF NOT EXISTS ldl_p_lew_bil.t_agg_inv_return_item_store_day_2 (
client_id BIGNUMERIC(38,0),
loc_sid_store BIGNUMERIC(38,0),
src_orig_store_nr BIGNUMERIC(38,0),
src_wh_id BIGNUMERIC(38,0),
item_sid BIGNUMERIC(38,0),
dwh_cal_dt DATE NOT NULL,
cy_month BIGNUMERIC(38,0),
ship_qty NUMERIC(18,5),
gross_val NUMERIC(18,5),
sales_net_val NUMERIC(18,5)
) CLUSTER BY dwh_cal_dt;