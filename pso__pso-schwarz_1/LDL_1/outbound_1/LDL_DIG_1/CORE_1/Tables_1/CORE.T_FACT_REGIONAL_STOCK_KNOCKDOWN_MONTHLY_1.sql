/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_FACT_REGIONAL_STOCK_KNOCKDOWN_MONTHLY_1
   GENERATED FROM POWERDESIGNER ON Freitag, 26. Mai 2023 09:22:18
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_core.t_fact_regional_stock_knockdown_monthly_1 (
bus_year BIGNUMERIC NOT NULL OPTIONS(description='The business year as a number in the form YYYY. Eg. 2019'),
month_of_bus_year BIGNUMERIC NOT NULL
OPTIONS(description='The month of the (Lidl) business year (starting in March) as a number using the convention March = 1, April = 2 ... December = 10, January = 11, February = 12. '),
wshop_cd STRING(5) NOT NULL
OPTIONS(description='The unique code for the Lidl webshop, where an order can be placed by a customer.The webshop is defined per political country_1 and is run by an Lidl Digital Country_1'),
prod_variant_sid BIGNUMERIC NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the product variant'),
prod_variant_nr STRING(20) OPTIONS(description='The product variant number'),
prod_sid BIGNUMERIC OPTIONS(description='The unique identifier (surrogate key) for the product'),
prod_nr STRING(20) OPTIONS(description='The number for internal onlineshop product, which is country_1 independent'),
total_stock_cnt BIGNUMERIC
OPTIONS(description='Sum of stock items stored in the warehouse, that lost part of their value'),
prod_price_knockdown_net_eur_val BIGNUMERIC(38,5)
OPTIONS(description='Total amount of loss in value of the products which are present in stock'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (bus_year, month_of_bus_year, wshop_cd, prod_variant_sid) NOT ENFORCED
)
OPTIONS(description='The table contains the total monthly quantity per webshop of articles in stock and their depreciation value (knock down/write-down) needed for accounting purposes.');