CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_analytics.t_advert_week_subitemgroup_1 (
client_id BIGNUMERIC(38,0) NOT NULL,
adv_week_id BIGNUMERIC(38,0) NOT NULL,
sub_item_grp_sid BIGNUMERIC(38,0) NOT NULL,
item_grp_int_sid BIGNUMERIC(38,0) NOT NULL,
advert_items_pv_cnt BIGNUMERIC(38,0),
advert_items_nf_cnt BIGNUMERIC(38,0),
advert_items_fa_cnt BIGNUMERIC(38,0),
stores_cnt BIGNUMERIC(38,0),
receipts_cnt BIGNUMERIC(38,0),
sales_net_val NUMERIC(18,5),
sales_buy_price_net_val NUMERIC(18,5),
total_receipts_cnt BIGNUMERIC(38,0),
total_sales_net_val NUMERIC(18,5)
);