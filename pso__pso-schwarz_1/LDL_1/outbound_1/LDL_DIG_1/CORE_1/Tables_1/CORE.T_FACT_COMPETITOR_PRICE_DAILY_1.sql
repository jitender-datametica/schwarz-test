/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_FACT_COMPETITOR_PRICE_DAILY_1
   GENERATED FROM POWERDESIGNER ON Donnerstag, 25. Juli 2024 11:04:58
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_core.t_fact_competitor_price_daily_1 (
competitor_price_id STRING(20) NOT NULL
OPTIONS(description='The unique code for the Competitor Price. As we can have more prices from the same competitor in the same day, the ID allows us to differentiate them.'),
prod_variant_sid BIGNUMERIC OPTIONS(description='The unique identifier (surrogate key) for the product variant'),
curr_cd STRING(5) OPTIONS(description='The code identifying the currency according to ISO-4217.'),
cal_dt DATE
OPTIONS(description='The day represented as a calendar_1 date of the form YYYY-MM_1-DD. YYYY is the calendar_1 year, MM_1 (between 1 and 12) the calendar_1 month and DD the day of the calendar_1 month (between 1 and 31).'),
competitor_cd STRING(20) OPTIONS(description='The unique code for the Competitor.'),
wshop_cd STRING(5)
OPTIONS(description='The unique code for the Lidl webshop, where an order can be placed by a customer.The webshop is defined per political country_1 and is run by an Lidl Digital Country_1'),
prod_variant_nr STRING(20) OPTIONS(description='The product variant number'),
price_src_name STRING(100) OPTIONS(description='Price comparison website on which competitor price was found.'),
competitor_sale_price_gross_local_val BIGNUMERIC(38,5) OPTIONS(description='Sales_1 price from the competitor.'),
competitor_ship_price_gross_local_val BIGNUMERIC(38,5) OPTIONS(description='Shipping price from the competitor.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (competitor_price_id) NOT ENFORCED
)
OPTIONS(description='A fact table that records the prices for product variants from competitors on daily basis. Competitor is an organization that engages in economic competition with LIDL webshops. e.g Amazon.de, Mediamarkt.de etc.                          The granularity (Business Key) of the table is represented by the combination of competitor_cd, prod_variant_sid, price_src_name and cal_dt,');