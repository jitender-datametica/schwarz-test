/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_AGG_PRODUCT_PROMOTION_CLUSTER_1
   GENERATED FROM POWERDESIGNER ON Donnerstag, 15. August 2024 08:56:16
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_core.t_agg_product_promotion_cluster_1 (
promo_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='An identifier from source system to uniqly identify the promotion'),
promo_sale_cluster_cd BIGNUMERIC NOT NULL
OPTIONS(description='A code for aggregation of sales_1 orders assigned to a promotion based on the customer order date. One Promotion contains several Promotion Clusters'),
is_after_cancellation_fg BOOL NOT NULL
OPTIONS(description='Flag that indicates if measurements are calculated including cancelled orders (TRUE - cancelled orders included, FLASE - cancelled orders not included)'),
curr_usage_type_cd STRING(5) NOT NULL
OPTIONS(description='The code for the currency usage ( Local Currency vs_1 Global Currency ).'),
prod_sid BIGNUMERIC NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the product'),
wshop_cd STRING(5)
OPTIONS(description='The unique code for the Lidl webshop, where an order can be placed by a customer.The webshop is defined per political country_1 and is run by an Lidl Digital Country_1'),
promo_start_dt DATE OPTIONS(description='Start date of the product promotion in stationary business'),
promo_sale_start_dt DATE OPTIONS(description='Date when sales_1 of promotional goods starts'),
curr_cd STRING(5) OPTIONS(description='The code identifying the currency according to ISO-4217.'),
is_first_promotion_fg BOOL
OPTIONS(description='Flag that indicates if it is the first time that a product is part of a promotion in a specific country_1 in a pre defined timeframe'),
is_repeated_fg BOOL
OPTIONS(description='If it is the first time that promotion happens on a specific country_1 then false, else true'),
sale_promo_type_cd STRING(20)
OPTIONS(description='The unique code for that defines the way the product gets promoted e.g. website, flyer, etc.'),
current_promo_sale_cluster_cd BIGNUMERIC
OPTIONS(description='Code of the Promotion Sale Cluster which is currently active (based on promotion start date and current date)'),
is_current_promo_sale_cluster_fg BOOL
OPTIONS(description='True for the row where Promotion Sale Cluster CD is equal to Current Promotion Sale Cluster CD. Otherwise value is FALSE'),
first_delivery_cy_week BIGNUMERIC(38,0)
OPTIONS(description='Week when was the first time when the combination of this product & IAN & Charge entered the Warehouse. '),
promo_dur_week_cnt BIGNUMERIC OPTIONS(description='How long was the promotion planned to be active (number of weeks)'),
first_inbound_dt DATE
OPTIONS(description='Min posting date in material movement document for each Product Variant. For Product Level (head level) it is considered the Min date for all the Product Variants. '),
finished_3_prom_weeks_fg BOOL
OPTIONS(description='Flag that indicates if a promotion has passed the first 3 weeks based on the first week start date and current date'),
first_week_start_dt DATE
OPTIONS(description='This is the date when the first week of the promotion started.            Special logic for DE and CZ because these countries focus on promotion weeks and not on promotion dates.            For DE and CZ the promotions always starts on a monday, even if the promotion start date refers to another weekday.'),
prod_qty BIGNUMERIC(38,5) OPTIONS(description='Quantity of a particular product ordered'),
return_prod_qty BIGNUMERIC(38,5) OPTIONS(description='Quantity of a particular product that has been returned'),
cum_prod_qty BIGNUMERIC(38,5)
OPTIONS(description='Accumulated quantity of a particular product ordered - includes all quantities of the previous Promotion Clusters'),
cum_return_prod_qty BIGNUMERIC(38,5)
OPTIONS(description='Accumulated returned quantity of a particular product - includes all quantities of the previous Promotion Clusters'),
gross_margin_net_val BIGNUMERIC(38,5) OPTIONS(description='Calculated Net Profit Margin'),
cum_gross_margin_net_val BIGNUMERIC(38,5)
OPTIONS(description='Accumulated Calculated Gross Margin - includes all amounts of the previous Promotion clusters (excl. taxes)'),
prod_price_gross_val BIGNUMERIC(38,5)
OPTIONS(description='Original (listed) gross price of a product. (includes returns and cancellations)'),
prod_price_net_val BIGNUMERIC(38,5)
OPTIONS(description='Original (listed) net price of a product ( includes returns and cancellations)'),
cum_prod_price_gross_val BIGNUMERIC(38,5)
OPTIONS(description='Accumulated total original (listed) net price of a product - includes all amouns of the previous Promotion clusters (incl taxes)'),
cum_prod_price_net_val BIGNUMERIC(38,5)
OPTIONS(description='Accumulated total original (listed) net price of a product - includes all amouns of the previous Promotion clusters (excl taxes)'),
plan_ab_qty BIGNUMERIC(38,5)
OPTIONS(description='Planned quantity of units solds for each promotion week. Calculation method is based on estimated initial promotional stock'),
plan_amc_qty BIGNUMERIC(38,5)
OPTIONS(description='Planned quantity of units solds for each promotion week. Calculation method - For promotion phase,  the Aktionsmenge field which were planned to be sold in the first three weeks of a promotion * tgt pct quantities per week.            For after-promotion phase, this means the Nachlaufmenge (supplier_order_qty - tgt_prod_qty) which were planned to be sold * the tgt pct per week.'),
cum_plan_amc_qty BIGNUMERIC(38,5)
OPTIONS(description='Accumulated planned quantity of units solds for each promotion week. Sums PLAN_AMC_QTY of the previous Promotion Clusters            For after-promotion phase, this means the Nachlaufmenge (supplier_order_qty - tgt_prod_qty) which were planned to be sold * the tgt pct per week.'),
cum_plan_ab_qty BIGNUMERIC(38,5)
OPTIONS(description='Accumulated planned quantity of units solds for each promotion week. Sums PLAN_AB_QTY of the previous Promotion Clustters'),
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
PRIMARY KEY (promo_id, promo_sale_cluster_cd, is_after_cancellation_fg, curr_usage_type_cd) NOT ENFORCED
)
OPTIONS(description='A Fact table that aggregates promotion sales_1 up to the level of  Promotion Cluster (a period which is part of promotion)., Special Analisys Flag, This granularity is then multiplied to have one row for each combination of [Local/Global currency] x [Special Analysis - True/False] . Product is not part of the PK because for each Promotion we have exactly 1 product');