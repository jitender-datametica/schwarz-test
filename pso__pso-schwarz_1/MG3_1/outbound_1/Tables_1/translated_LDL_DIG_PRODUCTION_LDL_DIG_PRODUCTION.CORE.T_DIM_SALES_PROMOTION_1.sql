CREATE OR REPLACE TABLE ldl_dig_production_core.t_dim_sales_promotion_1 (
wshop_cd STRING(5)
OPTIONS(description='The unique code for the Lidl webshop, where an order can be placed by a customer.The webshop is defined per political country_1 and is run by an Lidl Digital Country_1'),
prod_sid INTEGER OPTIONS(description='The unique identifier (surrogate key) for the product'),
promo_nr STRING(20) OPTIONS(description='Unique season ID (Primary Key) in the source system'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL OPTIONS(description='An indicator showing the current record in history.'),
sale_promo_type_cd STRING(20)
OPTIONS(description='The unique code for that defines the way the product gets promoted e.g. website, flyer, etc.'),
promo_dur_week_cnt INTEGER OPTIONS(description='How long was the promotion planned to be active (number of weeks)'),
is_repeated_fg BOOL
OPTIONS(description='If it is the first time that promotion happens on a specific country_1 then false, else true'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
amc_ian_nr STRING(20)
OPTIONS(description='In AMC system there is a one-to-many relationship between product number and ian number - AMC users can create ian numbers in the system. Sometimes these ian numbers don\'t match the SAP ian numbers.'),
supplier_order_qty INTEGER
OPTIONS(description='Number of products ordered from suppliers. If it is zero, it means that nothing was ordered because there is still stock available from another promotion. '),
first_week_start_dt DATE
OPTIONS(description='This is the date when the first week of the promotion started.\n            Special logic for DE and CZ because these countries focus on promotion weeks and not on promotion dates.\n            For DE and CZ the promotions always starts on a monday, even if the promotion start date refers to another weekday.'),
analysis_start_dt DATE
OPTIONS(description='For this analysis, only the sales_1 orders with an order date in between this start and end date will be considered. For BM promotion type (magazine) in Germany, the start date will be the first day of the month based on promotion start date, otherwise the start date will be the promotion sales_1 start date.'),
analysis_end_dt DATE
OPTIONS(description=' For this analysis, only the sales_1 orders with an order date in between this start and end date will be considered.'),
src_table_name STRING(100) OPTIONS(description='The name of the source tables'),
promo_descr STRING(250) OPTIONS(description='Description of the promotion'),
tgt_prod_sale_qty INTEGER
OPTIONS(description='Number of products expected to be sold. Product quantities in stock units (no decimal values).'),
promo_start_dt DATE OPTIONS(description='Start date of the product promotion in stationary business'),
promo_sale_start_dt DATE OPTIONS(description='Date when sales_1 of promotional goods starts'),
is_catalog_prod_fg BOOL
OPTIONS(description='When catalog article is equal to true, the product will keep the same IAN Number in different periods.'),
promo_id INTEGER NOT NULL OPTIONS(description='An identifier from source system to uniqly identify the promotion'),
first_delivery_cy_week INTEGER
OPTIONS(description='Week when was the first time when the combination of this product & IAN & Charge entered the Warehouse. '),
tgt_prod_receive_cy_week INTEGER
OPTIONS(description='Calendar_1 week when the promotion products are received. If there is a delivery split it will only appear one date - the minimum date.'),
is_tv_promo_fg BOOL
OPTIONS(description='This Fag indicates whether during a certain promotion a television promotion is planned while the other promotion is ongoing.'),
sale_promo_status_cd STRING(25) OPTIONS(description='The unique code for the status_1 of a promotion/delivery.'),
return_cond_descr STRING(250)
OPTIONS(description='In case if we as a company are not able to sell all products, we have in some cases agreements with the supplier_1 where they are taking back the non sold goods.'),
prod_nr STRING(20) OPTIONS(description='The number for internal onlineshop product, which is country_1 independent'),
promo_sale_end_dt DATE OPTIONS(description='Date when sales_1 of promotional goods end'),
assortment_plan_period_nr STRING(20)
OPTIONS(description='The period number of the Ausmusterung which shows when the Ausmusterung was.e.g.1904 - Ausmusterung 2019 April'),
promo_season_cd STRING(50)
OPTIONS(description='The unique code for the promotional season (e.g. CARNIVAL, AUTUMN_WINTER, SPRING_SUMMER, HALLOWEEN, CHRISTMAS, etc.)'),
campaign_descr STRING(250) OPTIONS(description='A description or name of the campaign represented by this promotion.'),
campaign_start_dt DATE
OPTIONS(description='The campaign start date as a german local time date.The campaign start date defines the full period of availability for the promotional articles online, not just the official advertising date. While the formal promotion start date for the articles is on Monday (aligning with physical store promotions), online shop launch and sell the articles at least 7 days prior to this date.'),
campaign_end_dt DATE OPTIONS(description='The campaign end date as a german local time date'),
PRIMARY KEY (promo_id, dwh_valid_from_tmsp) NOT ENFORCED
)
OPTIONS(description='A table indication which products are part of the promotions relevant for LD selling goods\n\n             Promotion (Thema) is a general topic from the purchasing department during the\""Ausmusterung\"". Articles are clustered in topics to provide a full assortment for a week ( comparable with\""Greek Week\"" or\""XXL offer week\"" from food department).The countries have around 200 articles to chose from and on the Ausmusterung they know that these articles are perfectly fitting together for a predefined topic.\n\n             Campagn (for example Black Week, SummerSale) is unique per Onlineshop and is defined by the country. The country_1 managers can give the articles in the AMC the special campaign name and then work with it (e. g. filter for these articles).');