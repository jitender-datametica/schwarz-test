/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_FACT_PRODUCT_VARIANT_AVAILABILITY_1
   GENERATED FROM POWERDESIGNER ON Donnerstag, 30. November 2023 16:24:27
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_core.t_fact_product_variant_availability_1 (
wshop_cd STRING(5) NOT NULL OPTIONS(description='The unique code for the Lidl webshop'),
cal_dt DATE NOT NULL
OPTIONS(description='The day represented as a calendar_1 date of the form YYYY-MM_1-DD. YYYY is the calendar_1 year, MM_1 (between 1 and 12) the calendar_1 month and DD the day of the calendar_1 month (between 1 and 31).'),
prod_variant_sid BIGNUMERIC NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the product variant'),
active_fg BOOL
OPTIONS(description='An indicator showing the current record from a business perspective, i.e. where the current date is between active_from_dt and active_to_dt'),
prod_variant_nr STRING(20) OPTIONS(description='The original product variant number'),
is_orderable_fg BOOL OPTIONS(description='Flag shows is article orderable on a date; '),
is_visible_fg BOOL OPTIONS(description='Flag shows is article visible on a date; '),
is_avail_in_store_fg BOOL OPTIONS(description='Available In Store Flag as of Shop System'),
is_in_stock_fg BOOL
OPTIONS(description='Flag, if product is in stock.  A product can be in stock, but not be sold before e.g. promotion starts.'),
is_replenishment_considered_fg BOOL OPTIONS(description='Flag to indicate if a product should be replenished'),
avail_lvl_cd STRING(5)
OPTIONS(description='Indicator code for availability (1, Online ausverkauft; 2, Online in Kürze; 3, Bestellbar; Null, Offline)'),
prod_orderable_lvl_cd STRING(5)
OPTIONS(description='Indicator code. It shows if a product is orderable, soon orderable, or not orderable. It is derived from multiple indicators, like stock_indicator, display_indicator, online_indicator'),
src_catalog_name STRING(100) OPTIONS(description='Source Catalog where extracted from ("Master" or "Online")'),
is_in_promo_fg BOOL OPTIONS(description='Flag, if product is in a campaign /promotion'),
is_in_online_catalog_fg BOOL
OPTIONS(description='This flag has no business meaning on its own - it is a necessary but insufficient technical condition for product visibility in the webshop.'),
max_order_qty BIGNUMERIC(38,5)
OPTIONS(description='Maximum quantity of the article that can be ordered per customer per order'),
total_stock_qty BIGNUMERIC(38,5)
OPTIONS(description='Stock Quantity of the product (article) for that day in the webshop - this is the maximum amount that can be ordered in total in all orders.'),
locale_name STRING(100)
OPTIONS(description='Source Locale, where the status_1 data was reported from (de_de, cz_cz, de_en , etc)'),
is_legacy_fg BOOL
OPTIONS(description='Technical field used to identify legacy data (archived data or not), for further use as a filter condition'),
is_sold_out_fg BOOL OPTIONS(description='Flag that shows if a product is sold out'),
content_classification_rating STRING(20)
OPTIONS(description='This is a Lidl specific rating which expresses the level of content a certain article has and is created with. We differentiate between Discount, Standard & Premium content (or n/a) to specify how much content an article has in the web shop.            The higher the rating the more information & content features are added to the article on its page.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (prod_variant_sid, wshop_cd, cal_dt) NOT ENFORCED
)
OPTIONS(description='For a product variant shows if it was sellable and availabe for a selected date on a daily basis');