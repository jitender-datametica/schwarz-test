CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_pit_onprem.t_pit_pv_sales_client_day_item (
client_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL,
dwh_cal_dt DATE NOT NULL,
item_sid BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL,
sales_net_val BIGNUMERIC(38,5) NOT NULL,
return_net_val BIGNUMERIC(38,5) NOT NULL,
discount_net_val BIGNUMERIC(38,5) NOT NULL,
till_discount_net_val BIGNUMERIC(38,5) NOT NULL,
sales_qty BIGNUMERIC(38,5) NOT NULL,
return_qty BIGNUMERIC(38,5) NOT NULL,
discount_qty BIGNUMERIC(38,5) NOT NULL,
distinct_receipt_count BIGNUMERIC(38,5) NOT NULL,
sales_price_net BIGNUMERIC(38,5),
median_distinct_receipt_count BIGNUMERIC(38,5) NOT NULL,
median_sales_price_net BIGNUMERIC(38,5),
PRIMARY KEY (client_id, dwh_cal_dt, item_sid) NOT ENFORCED
);