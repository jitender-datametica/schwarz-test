/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_AGG_PRODUCT_SALES_DAILY_1
   GENERATED FROM POWERDESIGNER ON Donnerstag, 15. August 2024 08:13:01
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_core.t_agg_product_sales_daily_1 (
wshop_cd STRING(5) NOT NULL
OPTIONS(description='The unique code for the Lidl webshop, where an order can be placed by a customer. The webshop is defined per political country_1 and is run by an Lidl Digital Country_1'),
cal_dt DATE NOT NULL
OPTIONS(description='The day represented as a calendar_1 date of the form YYYY-MM_1-DD. YYYY is the calendar_1 year, MM_1 (between 1 and 12) the calendar_1 month and DD the day of the calendar_1 month (between 1 and 31).'),
prod_sid BIGNUMERIC NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the product            '),
is_part_of_bundle_header_cnt_fg BOOL NOT NULL
OPTIONS(description='Reporting relevant - if report uses the bundle header count use this flag. Set as\'true\' for bundle header and non-bundle item_1 and\'false\' for bundle position item_1 '),
is_part_of_bundle_pos_cnt_fg BOOL NOT NULL
OPTIONS(description='Reporting relevant - if report uses the bundle header count use this flag. Set as\'true\' for bundle position and non-bundle item_1 and\'false\' for bundle header item_1 '),
prod_nr STRING(20)
OPTIONS(description='The number for internal onlineshop product, which is country_1 independent (Kopfartikelnummer)'),
prod_name STRING(100)
OPTIONS(description='The central name defined for a product by German onlineshop (Kopfartikelbezeichnung)'),
brand_class_cd STRING(5)
OPTIONS(description='The code for the indicating if product is classified as a Lidl own brand_1 or not'),
brand_class_descr STRING(250)
OPTIONS(description='A textual description for the product brand_1 type in group language (German) (Marke/Eigenmarke)            A textual description for the product brand_1 type in group language (German) (Marke/Eigenmarke)'),
delivery_src_type_cd STRING(5)
OPTIONS(description='The code for source location_1 of product from where it is delivered i.e. from supplier_1 or warehouse directly'),
delivery_src_type_descr STRING(250)
OPTIONS(description='The description for source location_1 of product from where it is delivered i.e. from supplier_1 or warehouse directly (Lager/Strecke)'),
prod_org_lvl_name STRING(50)
OPTIONS(description='The Organisation level of a product corresponds to the Lidl Digital structure which owns - or is responsible for - these articles (product variants) in the organization (Organisationsebene)'),
prod_qty BIGNUMERIC(38,5) OPTIONS(description='Quantity of a particular product ordered (Bestellmenge)'),
prod_price_net_eur_val BIGNUMERIC(38,5)
OPTIONS(description='Original (listed) net price of the ordered product in euro (includes returns and cancellations) (Bestellumsatz)'),
cogs_price_net_eur_val BIGNUMERIC(38,5) OPTIONS(description='Cost-of-Goods-sold in euro net (Wareneinsatz)'),
return_prod_order_dt_price_net_eur_val BIGNUMERIC(38,5)
OPTIONS(description='Original (listed) net euro price of all items that were ordered on this date and later returned (Retourenwert (auftragsbezogen))'),
return_prod_order_dt_qty BIGNUMERIC(38,5)
OPTIONS(description='Quantity of all items that were ordered on this date and later returned (Retourenmenge (auftragsbezogen))'),
return_prod_price_net_eur_val BIGNUMERIC(38,5)
OPTIONS(description='Original (listed) net euro price of all items that were ordered before and returned on this date (Retourenwert (physisch))'),
return_prod_qty BIGNUMERIC(38,5)
OPTIONS(description='Quantity of all items that were ordered before and returned on this date'),
cancel_prod_qty BIGNUMERIC(38,5)
OPTIONS(description='Quantity of all items that were ordered on this date and then cancelled'),
cancel_prod_price_net_eur_val BIGNUMERIC(38,5)
OPTIONS(description='Original (listed) net euro price of all items that were ordered on this date and then cancelled (Stornowert)'),
cancel_cogs_price_net_eur_val BIGNUMERIC(38,5)
OPTIONS(description='Cost-of-Goods-sold in euro net for all items that were ordered on this date and then cancelled (Storno Wareneinsatz)'),
prod_coupon_net_eur_val BIGNUMERIC(38,5)
OPTIONS(description='The net euro discount value for the (original/listed) product (cancelled orders are left out of the calculation)'),
delivery_paushal_net_eur_val BIGNUMERIC(38,5)
OPTIONS(description='A net euro paushal for delivery costs (Versandkostenpauschale) (cancelled orders are left out of the calculation)'),
delivery_paushal_coupon_net_eur_val BIGNUMERIC(38,5)
OPTIONS(description='A net euro discount value for paushal delivery cost split per every order position (cancelled orders are left out of the calculation)'),
delivery_cost_net_eur_val BIGNUMERIC(38,5)
OPTIONS(description='Article specific net delivery cost in euro. This cost is optional and mostly article dependent. An example is a fridge which has additional delivery costs (Versandkosten) (cancelled orders are left out of the calculation)'),
prod_sale_type_cd STRING(5)
OPTIONS(description='This code shows if the product is sold as a single item_1 (SI), group article header (GH) - also referred to as "bundle header", or as a group article component (GC) - also referred to as "bundle component"'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (wshop_cd, cal_dt, prod_sid, is_part_of_bundle_header_cnt_fg, is_part_of_bundle_pos_cnt_fg) NOT ENFORCED
)
OPTIONS(description='A fact table that aggregates sales_1 information at the level of product, calendar_1 day and webshop.');