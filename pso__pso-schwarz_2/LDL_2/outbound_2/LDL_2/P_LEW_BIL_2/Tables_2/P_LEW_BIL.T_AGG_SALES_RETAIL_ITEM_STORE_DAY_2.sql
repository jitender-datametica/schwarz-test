CREATE TABLE IF NOT EXISTS ldl_p_lew_bil.t_agg_sales_retail_item_store_day_2 (
client_id BIGNUMERIC(38,0) NOT NULL,
loc_sid_store BIGNUMERIC(38,0) NOT NULL,
src_orig_store_nr BIGNUMERIC(38,0),
src_wh_id BIGNUMERIC(38,0),
item_sid BIGNUMERIC(38,0) NOT NULL,
dwh_cal_dt DATE NOT NULL,
cy_month BIGNUMERIC(38,0),
retail_val NUMERIC(18,5),
retail_net_val NUMERIC(18,5),
qty_act NUMERIC(18,5),
dwh_updated DATETIME NOT NULL
) CLUSTER BY dwh_cal_dt;