CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_lead.t_agg_str_adv (
client_id BIGNUMERIC(38,0),
loc_sid_store_move_to BIGNUMERIC(38,0),
loc_sid_wh BIGNUMERIC(38,0),
wh_id BIGNUMERIC(38,0),
flg_itm_grp BIGNUMERIC(38,0),
dat_adv DATE,
qty_sales_1_day NUMERIC(18,4),
qty_sales_3_day NUMERIC(18,4),
qty_sales_7_day NUMERIC(18,4),
qty_stc_real_1_day NUMERIC(18,4),
qty_stc_real_3_day NUMERIC(18,4),
qty_stc_real_7_day NUMERIC(18,4),
qty_delivery_1_day NUMERIC(18,4),
qty_delivery_3_day NUMERIC(18,4),
qty_delivery_7_day NUMERIC(18,4),
timestamp_mod DATETIME
);