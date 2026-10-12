/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_AGG_PRODUCT_PROMOTION_1
   GENERATED FROM POWERDESIGNER ON Donnerstag, 15. August 2024 08:55:30
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_core.t_agg_product_promotion_1 (
promo_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='An identifier from source system to uniqly identify the promotion'),
is_after_cancellation_fg BOOL NOT NULL
OPTIONS(description='Flag that indicates if measurements are calculated including cancelled orders (TRUE - cancelled orders included, FLASE - cancelled orders not included)'),
curr_usage_type_cd STRING(5) NOT NULL
OPTIONS(description='The code for the currency usage ( Local Currency vs_1 Global Currency ).'),
prod_sid BIGNUMERIC NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the product'),
wshop_cd STRING(5)
OPTIONS(description='The unique code for the Lidl webshop, where an order can be placed by a customer.The webshop is defined per political country_1 and is run by an Lidl Digital Country_1'),
promo_start_dt DATE OPTIONS(description='Start date of the product promotion in stationary business'),
promo_sale_start_dt DATE OPTIONS(description='Date when sales_1 of promotional goods starts'),
amc_ian_nr STRING(20)
OPTIONS(description='In AMC system there is a one-to-many relationship between product number and ian number - AMC users can create ian numbers in the system. Sometimes these ian numbers don\'t match the SAP ian numbers.'),
curr_cd STRING(5) OPTIONS(description='The code identifying the currency according to ISO-4217.'),
is_first_promotion_fg BOOL
OPTIONS(description='Flag that indicates if it is the first time that a product is part of a promotion in a specific country_1 in a pre defined timeframe'),
is_repeated_fg BOOL
OPTIONS(description='If it is the first time that promotion happens on a specific country_1 then false, else true'),
sale_promo_type_cd STRING(20)
OPTIONS(description='The unique code for that defines the way the product gets promoted e.g. website, flyer, etc.'),
prod_orderable_lvl_cd STRING(5)
OPTIONS(description='Indicator code. It shows if a product is orderable, soon orderable, or not orderable. It is derived from multiple indicators, like stock_indicator, display_indicator, online_indicator'),
first_delivery_cy_week BIGNUMERIC(38,0)
OPTIONS(description='Week when was the first time when the combination of this product & IAN & Charge entered the Warehouse. '),
promo_dur_week_cnt BIGNUMERIC OPTIONS(description='How long was the promotion planned to be active (number of weeks)'),
first_inbound_dt DATE
OPTIONS(description='Min posting date in material movement document for each Product Variant. For Product Level (head level) it is considered the Min date for all the Product Variants. '),
finished_3_prom_weeks_fg BOOL
OPTIONS(description='Flag that indicates if a promotion has passed the first 3 weeks based on the first week start date and current date'),
first_week_start_dt DATE
OPTIONS(description='This is the date when the first week of the promotion started.            Special logic for DE and CZ because these countries focus on promotion weeks and not on promotion dates.            For DE and CZ the promotions always starts on a monday, even if the promotion start date refers to another weekday.'),
passed_sale_weeks_cnt BIGNUMERIC OPTIONS(description='Number of weeks passed after the beginning of the promotion'),
gross_margin_net_val BIGNUMERIC(38,5) OPTIONS(description='Calculated Net Profit Margin (excl. taxes)'),
prod_qty BIGNUMERIC(38,5) OPTIONS(description='Quantity of a particular product ordered'),
wshop_prod_promos_cnt BIGNUMERIC OPTIONS(description='Number of promotions in the same Webshop for the same Product'),
return_prod_qty BIGNUMERIC(38,5) OPTIONS(description='Quantity of a particular product that has been returned'),
tgt_prod_sale_qty BIGNUMERIC(38,0)
OPTIONS(description='Number of products expected to be sold. Product quantities in stock units (no decimal values).'),
prod_price_gross_val BIGNUMERIC(38,5)
OPTIONS(description='Original (listed) gross price of a product. ( includes returns and cancellations)'),
prod_price_net_val BIGNUMERIC(38,5)
OPTIONS(description='Original (listed) net price of a product  ( includes returns and cancellations)'),
alloc_stock_cnt BIGNUMERIC
OPTIONS(description='The reserved stock for a country_1 - this stock is only available for this country_1 (for a certain time period)'),
avail_to_promise_cnt BIGNUMERIC
OPTIONS(description='The amount of stock which is currently available within the specific warehouse.            All of the stock can be sold within the onlineshop and is stored in an internal warehouse.'),
avail_to_sell_cnt BIGNUMERIC
OPTIONS(description='Available for Sale is the high level rack\'s and pick-area\'s stock within the system.'),
blocked_stock_cnt BIGNUMERIC
OPTIONS(description='Stock of a product stored in the warehouse but currently blocked (not usable / not sellable).'),
est_init_promo_stock_cnt BIGNUMERIC(38,5)
OPTIONS(description='Estimated stock present on the starting date of the promotion sales_1'),
supplier_order_qty BIGNUMERIC(38,0)
OPTIONS(description='Number of products ordered from suppliers. If it is zero, it means that nothing was ordered because there is still stock available from another promotion. '),
total_stock_cnt BIGNUMERIC
OPTIONS(description='The sum of (blocked_stock_cnt,blocked_stock_return_cnt,unrestricted_stock_cnt,restricted_stock_cnt,in_transfer_cnt and in_qty_inspection_cnt)'),
receive_on_dock_cnt BIGNUMERIC
OPTIONS(description='"Received on dock" is the incoming goods area\'s stock within the system. In case of a new delivery the stock would be stated first as ROD.'),
wshop_total_stock_cnt BIGNUMERIC
OPTIONS(description='Total stock available per country_1, based on the distribution percentage'),
days_not_orderable_in_promotion_cnt BIGNUMERIC
OPTIONS(description='Number of days a product is not orderable in its promotion period'),
orderable_in_promotion_start_dt DATE
OPTIONS(description='First day a product can be ordered in promotion. Sometimes this is later than the promotion sale start date.'),
plan_ab_qty BIGNUMERIC(38,5)
OPTIONS(description='Planned quantity of units solds for each promotion week. Calculation method is based on estimated initial promotional stock            Contains value up to today.'),
total_plan_ab_qty BIGNUMERIC(38,5)
OPTIONS(description='Planned quantity of units solds for each promotion week. Calculation method is based on estimated initial promotional stock            Contains planned value for entire product life span.'),
plan_amc_qty BIGNUMERIC(38,5)
OPTIONS(description='Planned quantity of units solds for each promotion week. Calculation method - For promotion phase,  the Aktionsmenge field which were planned to be sold in the first three weeks of a promotion * tgt pct quantities per week.            For after-promotion phase, this means the Nachlaufmenge (supplier_order_qty - tgt_prod_qty) which were planned to be sold * the tgt pct per week.            Contains value up to today.'),
total_plan_amc_qty BIGNUMERIC
OPTIONS(description='Planned quantity of units solds for each promotion week. Calculation method - For promotion phase,  the Aktionsmenge field which were planned to be sold in the first three weeks of a promotion * tgt pct quantities per week.            For after-promotion phase, this means the Nachlaufmenge (supplier_order_qty - tgt_prod_qty) which were planned to be sold * the tgt pct per week.            Contains planned value for entire product life span.'),
delta_plan_ab_qty BIGNUMERIC(38,5)
OPTIONS(description='Planned quantity of units solds for each promotion week based on estimated initial promotional stock  -  Quantity of a particular product ordered'),
delta_plan_amc_qty BIGNUMERIC(38,5) OPTIONS(description='plan_amc_qty - Quantity of a particular product ordered'),
orderable_prod_variants_cnt BIGNUMERIC OPTIONS(description='The number of product variants that are orderable'),
active_prod_variants_cnt BIGNUMERIC OPTIONS(description='The total number of product variants that are active'),
promo_sale_price_gross_val BIGNUMERIC(38,5)
OPTIONS(description='Promotion sale price per unit_1 in gross amount (incl. taxes)'),
promo_sale_price_net_val BIGNUMERIC(38,5)
OPTIONS(description='Promotion sale price per unit_1 in net amount (excl. taxes)'),
avg_promo_sale_price_gross_val BIGNUMERIC(38,5)
OPTIONS(description='The average of the pomotion sale prices of all Product Variants of this product. Per unit_1 in gross amount (incl taxes)'),
avg_promo_sale_price_net_val BIGNUMERIC(38,5)
OPTIONS(description='The average of the pomotion sale prices of all Product Variants of this product. Per unit_1 in net amount (excl taxes)'),
promo_purch_price_net_val BIGNUMERIC(38,5)
OPTIONS(description='Promotion purchase price per unit_1 in net amount (excl. taxes)'),
special_analysis_prod_qty BIGNUMERIC(38,5)
OPTIONS(description='Quantity of a particular product ordered during promotion special analysis period.'),
special_analysis_prod_price_net_val BIGNUMERIC(38,5)
OPTIONS(description='Original (listed) net price of a product ( includes returns and cancellations) during promotion special analysis period.'),
special_analysis_gross_margin_net_val BIGNUMERIC(38,5)
OPTIONS(description='Calculated Net Profit Margin (excl. taxes) during promotion special analysis period.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (promo_id, is_after_cancellation_fg, curr_usage_type_cd) NOT ENFORCED
)
OPTIONS(description='A Fact table that aggregates promotion sales_1 up to the level of  Promotion (each promotion has 1 product)., Special Analisys Flag, This granularity is then multiplied to have one row for each combination of [Local/Global currency] x [Special Analysis - True/False] ');