CREATE TABLE IF NOT EXISTS ldl_dig_core.t_agg_promotion_sales_daily_1 (
wshop_cd STRING(5) NOT NULL
OPTIONS(description='The unique code for the Lidl webshop, where an order can be placed by a customer.The webshop is defined per political country_1 and is run by an Lidl Digital Country_1'),
promo_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='An identifier from source system to uniqly identify the promotion'),
prod_variant_sid BIGNUMERIC NOT NULL OPTIONS(description='Ordered product'),
cust_order_dt DATE NOT NULL OPTIONS(description='The date when order was made'),
promo_start_dt DATE OPTIONS(description='Start date of the product promotion in stationary business'),
promo_sale_start_dt DATE OPTIONS(description='Date when sales_1 of promotional goods starts'),
is_special_analysis_fg BOOL
OPTIONS(description='This flag is true if the customer order date is between analysis start date and analysis end date, otherwise is false which means outside this time range. The flag will hold null as value If the analysis dates are null, which means no specific analysis period is defined for a promotion type happening on a certain country_1'),
curr_cd STRING(5) OPTIONS(description='Currency code in which order has been payed'),
prod_price_net_local_val BIGNUMERIC(38,5)
OPTIONS(description='Original (listed) net price of a product in local currency'),
prod_price_gross_local_val BIGNUMERIC(38,5) OPTIONS(description='Order gross price in local currency'),
cogs_price_net_local_val BIGNUMERIC(38,5)
OPTIONS(description='Cost-of-Goods-sold, short: CoGs. Needed for calc of margin (= revenue - cogs )'),
prod_qty BIGNUMERIC(38,5) OPTIONS(description='Quantity of a particular product ordered'),
cancel_prod_price_net_local_val BIGNUMERIC(38,5)
OPTIONS(description='Original (listed) net price of a product in local currency'),
cancel_prod_price_gross_local_val BIGNUMERIC(38,5)
OPTIONS(description='Order gross price of cancelled products in local currency'),
cancel_prod_qty BIGNUMERIC(38,5) OPTIONS(description='Quantity of a particular product ordered'),
return_prod_price_net_local_val BIGNUMERIC(38,5)
OPTIONS(description='Original (listed) net price of a product in local currency'),
return_prod_price_gross_local_val BIGNUMERIC(38,5)
OPTIONS(description='Order gross price of returned products in local currency'),
return_prod_qty BIGNUMERIC(38,5) OPTIONS(description='Quantity of a particular product ordered'),
total_prod_price_net_local_val BIGNUMERIC(38,5)
OPTIONS(description='Total original (listed) net price of a product in local currency'),
total_prod_price_gross_local_val BIGNUMERIC(38,5)
OPTIONS(description='Order gross price excluding the cancellations and returns in local currency'),
total_prod_qty BIGNUMERIC(38,5) OPTIONS(description='Total quantity of a particular product ordered'),
promo_sale_cluster_cd BIGNUMERIC
OPTIONS(description='A code for aggregation of sales_1 orders assigned to a promotion based on the customer order date'),
prod_variant_nr STRING(20) OPTIONS(description='The product variant number'),
avail_lvl_cd STRING(5)
OPTIONS(description='Indicator code for availability (1, Online ausverkauft; 2, Online in Kürze; 3, Bestellbar; Null, Offline)'),
prod_orderable_lvl_cd STRING(5)
OPTIONS(description='Indicator code. It shows if a product is orderable, soon orderable, or not orderable. It is derived from multiple indicators, like stock_indicator, display_indicator, online_indicator'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
src_table_name STRING(100) OPTIONS(description='The name of the source tables'),
PRIMARY KEY (promo_id, prod_variant_sid, cust_order_dt) NOT ENFORCED
) OPTIONS(description='The fact that analises the quantity of goods sold since beginning of promotion');