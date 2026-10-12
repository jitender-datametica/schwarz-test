/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_FACT_STOCK_ALLOCATION_ENTITY_DAILY_2
   GENERATED FROM POWERDESIGNER ON Montag, 24. Juli 2023 16:40:05
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_core.t_fact_stock_allocation_entity_daily_2 (
wh_alloc_entity_cd STRING(5) NOT NULL
OPTIONS(description='A code for warehouse allocation unit_2  (LI_DE , LI_CZ, KFL_DE, KFL_CZ , INTEGER etc)'),
prod_sid BIGNUMERIC NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the product'),
cal_dt DATE NOT NULL
OPTIONS(description='The day represented as a calendar_2 date of the form YYYY-MM_2-DD. YYYY is the calendar_2 year, MM_2 (between 1 and 12) the calendar_2 month and DD the day of the calendar_2 month (between 1 and 31). '),
active_fg BOOL OPTIONS(description='An indicator showing the current record from a business perspective,'),
alloc_promo_class_cd STRING(5)
OPTIONS(description='The code for the indicating if product is a part of special offer or normal or special assortiment'),
distribution_pct BIGNUMERIC(38,5)
OPTIONS(description='The amount of stock which is currently available within the specific warehouse. All of the stock can be sold within the onlineshop and is stored in an internal warehouse.'),
prod_nr STRING(20) OPTIONS(description='The number for internal onlineshop product, which is country_2 independent'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (wh_alloc_entity_cd, prod_sid, cal_dt) NOT ENFORCED
)
OPTIONS(description='The table contains the daily calculated allocation of products among allocation entities ( countries )');