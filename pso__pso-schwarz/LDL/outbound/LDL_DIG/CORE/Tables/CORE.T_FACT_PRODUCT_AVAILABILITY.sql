/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_FACT_PRODUCT_AVAILABILITY
   GENERATED FROM POWERDESIGNER ON Donnerstag, 7. März 2024 12:01:24
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_core.t_fact_product_availability (
wshop_cd STRING(5) NOT NULL OPTIONS(description='The unique code for the Lidl webshop'),
cal_dt DATE NOT NULL
OPTIONS(description='The day represented as a calendar date of the form YYYY-MM-DD. YYYY is the calendar year, MM (between 1 and 12) the calendar month and DD the day of the calendar month (between 1 and 31).'),
prod_sid BIGNUMERIC NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the product'),
prod_nr STRING(20) OPTIONS(description='The number for internal onlineshop product, which is country independent'),
active_fg BOOL
OPTIONS(description='An indicator showing the current record from a business perspective, i.e. where the current date is between active_from_dt and active_to_dt'),
is_orderable_fg BOOL OPTIONS(description='Flag shows is product orderable in the webshop on a date'),
is_visible_fg BOOL
OPTIONS(description='Flag shows is product visible in the webshop (can be found by name, category, filter) on a date'),
is_sold_out_fg BOOL OPTIONS(description='Flag that shows if a product is sold out'),
is_avail_in_store_fg BOOL OPTIONS(description='Flag shows if the product is also sold in the lidl stores '),
is_in_stock_fg BOOL
OPTIONS(description='Flag shows if product is in stock. A product can be in stock, but not be sold before e.g. promotion starts.'),
is_replenishment_considered_fg BOOL OPTIONS(description='Flag to indicate if a product should be replenished'),
is_in_campaign_page_fg BOOL
OPTIONS(description='The flag that shows if the product is the part of a campaign page. Campaign Pages are the offer pages with the current weekly only store, only online and store & online offers.'),
avail_lvl_cd STRING(5)
OPTIONS(description='Indicator code for availability (1, Online ausverkauft; 2, Online in Kürze; 3, Bestellbar; Null, Offline)'),
prod_orderable_lvl_cd STRING(5)
OPTIONS(description='Indicator code. It shows if a product is orderable, soon orderable, or not orderable. It is derived from multiple indicators, like stock_indicator, display_indicator, online_indicator'),
is_in_online_catalog_fg BOOL
OPTIONS(description='This flag has no business meaning on its own - it is a necessary but insufficient technical condition for product visibility in the webshop.'),
total_stock_qty BIGNUMERIC(38,5)
OPTIONS(description='Stock Quantity of the product (article) for that day in the webshop - this is the maximum amount that can be ordered in total in all orders.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (prod_sid, wshop_cd, cal_dt) NOT ENFORCED
)
OPTIONS(description='The table contains data at the product level - if a certain product is sellable and availabe for a selected date on a daily basis');