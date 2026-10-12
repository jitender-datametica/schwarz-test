/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_AGG_SALES_DAILY_2
   GENERATED FROM POWERDESIGNER ON Montag, 29. Juli 2024 14:57:11
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_core.t_agg_sales_daily_2 (
wshop_cd STRING(5) NOT NULL
OPTIONS(description='The unique code for the Lidl webshop, where an order can be placed by a customer. The webshop is defined per political country_2 and is run by an Lidl Digital Country_2'),
cal_dt DATE NOT NULL
OPTIONS(description='The day represented as a calendar_2 date of the form YYYY-MM_2-DD. YYYY is the calendar_2 year, MM_2 (between 1 and 12) the calendar_2 month and DD the day of the calendar_2 month (between 1 and 31).'),
order_cnt BIGNUMERIC OPTIONS(description='Number of orders'),
total_prod_price_net_eur_val BIGNUMERIC(38,5)
OPTIONS(description='Total sum of original (listed) net euro price of ordered items (includes returns and cancellations) (Bestellumsatz)'),
tgt_revenue_net_eur_val BIGNUMERIC(38,5) OPTIONS(description='Planned net revenue before returns in euro'),
cogs_price_net_eur_val BIGNUMERIC(38,5) OPTIONS(description='Cost-of-Goods-sold in euro net (Wareneinsatz)'),
tgt_cogs_net_eur_val BIGNUMERIC(38,5)
OPTIONS(description='Planned Cost-of-Goods-sold in euro net, calculated as a difference between target revenue and target margin (Wareneinsatz (Plan))'),
total_return_prod_order_dt_price_net_eur_val BIGNUMERIC(38,5)
OPTIONS(description='Total sum of original (listed) price of all items that were ordered on this date and later returned (in EUR, excl. taxes) (Retourenwert (auftragsbezogen))'),
total_return_prod_price_net_eur_val BIGNUMERIC(38,5)
OPTIONS(description='Total sum of original (listed) price of all items that were ordered before and returned on this date (in EUR, excl. taxes) (Retourenwert (physisch))'),
total_cancel_prod_price_net_eur_val BIGNUMERIC(38,5)
OPTIONS(description='Total sum of original (listed) price of all items that were ordered on this date and then cancelled (in EUR, excl. taxes) (Stornowert)'),
cancel_cogs_price_net_eur_val BIGNUMERIC(38,5)
OPTIONS(description='Cost-of-Goods-sold in euro net for all items that were ordered on this date and then cancelled (Storno Wareneinsatz)'),
total_prod_coupon_net_eur_val BIGNUMERIC(38,5)
OPTIONS(description='Total net euro discount value for all ordered (original/listed) products (cancelled orders are left out of the calculation)'),
total_delivery_paushal_net_eur_val BIGNUMERIC(38,5)
OPTIONS(description='Total net euro paushal for delivery costs (Versandkostenpauschale) (cancelled orders are left out of the calculation)'),
total_delivery_paushal_coupon_net_eur_val BIGNUMERIC(38,5)
OPTIONS(description='Total net euro discount value for paushal delivery cost split per every order position (cancelled orders are left out of the calculation)'),
total_delivery_cost_net_eur_val BIGNUMERIC(38,5)
OPTIONS(description='Total net euro delivery costs for all ordered products (Versandkosten) (cancelled orders are left out of the calculation)'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (wshop_cd, cal_dt) NOT ENFORCED
) OPTIONS(description='A fact table that aggregates sales_2 information at the level of calendar_2 day and webshop.');