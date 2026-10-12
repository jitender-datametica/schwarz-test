CREATE OR REPLACE TABLE ldl_production_p_lew_mart_lead.t_agg_avg_buy_price_wh_day_itm (
client_id INTEGER,
loc_sid_wh INTEGER,
wh_id INTEGER,
orig_item_nr INTEGER,
dat_valid_from DATE,
dwh_cal_dt DATE,
sales_net_qty NUMERIC(29,5),
sales_net_val BIGNUMERIC(29,11),
ek_price_val BIGNUMERIC(29,12)
);