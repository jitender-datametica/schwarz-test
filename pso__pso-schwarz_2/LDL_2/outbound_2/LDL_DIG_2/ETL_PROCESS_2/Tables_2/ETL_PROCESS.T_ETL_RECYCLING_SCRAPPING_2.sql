/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_ETL_RECYCLING_SCRAPPING_2
   GENERATED FROM POWERDESIGNER ON Freitag, 17. Mai 2024 11:09:34
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_etl_process.t_etl_recycling_scrapping_2 (
fin_price_type_cd STRING(5) NOT NULL
OPTIONS(description='The type that identifies whether it is Actual (historical) or Plan (static).'),
bus_year BIGNUMERIC NOT NULL OPTIONS(description='The business year as a number in the form YYYY. Eg. 2019'),
month_of_bus_year BIGNUMERIC NOT NULL
OPTIONS(description='The month of the (Lidl) business year (starting in March) as a number using the convention March = 1, April = 2 ... December = 10, January = 11, February = 12. '),
wshop_cd STRING(5) NOT NULL
OPTIONS(description='The unique code for the Lidl webshop, where an order can be placed by a customer.The webshop is defined per political country_2 and is run by an Lidl Digital Country_2'),
prod_sid BIGNUMERIC NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the product'),
recycled_goods_net_eur_val BIGNUMERIC(38,5) OPTIONS(description='Value of products that are recycled and scrapped'),
recycled_and_scrapped_prod_qty BIGNUMERIC(38,5)
OPTIONS(description='Total quantity of products that were either recycled or scrapped. Up until 01-03-2024, the data about recycled and scrapped products was coming in from an excel file which did not indicate if the product was recycled or scrapped. This column therefore contains data about the total quantity of such products until 29-02-2024. From 01-03-2024 onwards the quantity of this products will be equal to the sum of recycled_prod_qty and scrapped_prod_qty.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (fin_price_type_cd, bus_year, month_of_bus_year, wshop_cd, prod_sid) NOT ENFORCED
) OPTIONS(description='ETL Support table  -  input data for the Deckungsbeitragsrechnung /Contribution Margin');