CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_analytics.t_ftm_turnover_2 (
client_id BIGNUMERIC(38,0),
country_code STRING(5),
dat_formdate DATE,
cy_week BIGNUMERIC(38,0),
store_id BIGNUMERIC(38,0),
orig_store_nr BIGNUMERIC(38,0),
item_id BIGNUMERIC(38,0),
orig_item_nr BIGNUMERIC(38,0),
itemgroup_int_id BIGNUMERIC(38,0),
subitemgroup_id BIGNUMERIC(38,0),
item_type STRING(50),
sales_net_val BIGNUMERIC(38,5),
sales_pieces_ejr BIGNUMERIC(38,5),
buying_val BIGNUMERIC(38,5),
sales_based_margin BIGNUMERIC(38,5),
sales_based_margin_pct BIGNUMERIC(38,5)
);