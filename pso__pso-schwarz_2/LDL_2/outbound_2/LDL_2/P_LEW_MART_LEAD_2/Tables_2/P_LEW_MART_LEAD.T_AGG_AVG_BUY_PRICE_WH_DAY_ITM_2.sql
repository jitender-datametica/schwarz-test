CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_lead.t_agg_avg_buy_price_wh_day_itm_2 (
client_id BIGNUMERIC(38,0),
loc_sid_wh BIGNUMERIC(38,0),
wh_id BIGNUMERIC(38,0),
orig_item_nr BIGNUMERIC(38,0),
dat_valid_from DATE,
dwh_cal_dt DATE,
sales_net_qty NUMERIC(32,5),
sales_net_val BIGNUMERIC(38,11),
ek_price_val BIGNUMERIC(38,12)
);