CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_pit_onprem.t_advert_week_theme (
client_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL,
adv_week_id BIGNUMERIC(38,0) DEFAULT 888853 NOT NULL,
adv_theme_sid BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL,
advert_items_pv_cnt BIGNUMERIC(38,0) DEFAULT 0,
advert_items_nf_cnt BIGNUMERIC(38,0) DEFAULT 0,
advert_items_fa_cnt BIGNUMERIC(38,0) DEFAULT 0,
stores_cnt BIGNUMERIC(38,0),
receipts_cnt BIGNUMERIC(38,0),
sales_net_val BIGNUMERIC(38,5),
sales_buy_price_net_val BIGNUMERIC(38,5),
total_receipts_cnt BIGNUMERIC(38,0),
total_sales_net_val BIGNUMERIC(38,5),
PRIMARY KEY (client_id, adv_week_id, adv_theme_sid) NOT ENFORCED
);