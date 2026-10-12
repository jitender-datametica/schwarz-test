/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_ETL_FINANCIAL_PRICE
   GENERATED FROM POWERDESIGNER ON Freitag, 13. Januar 2023 17:51:58
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_etl_process.t_etl_financial_price (
fin_price_type_cd STRING(5) NOT NULL
OPTIONS(description='The type that identifies whether it is Actual (historical) or Plan (static).'),
wshop_cd STRING(5) NOT NULL
OPTIONS(description='The unique code for the Lidl webshop, where an order can be placed by a customer.The webshop is defined per political country and is run by an Lidl Digital Country'),
price_condition STRING(100) NOT NULL OPTIONS(description='Price Condition'),
prod_size_type_group_cd STRING(5) NOT NULL
OPTIONS(description='A code for product size classification grouped in the bigger buckets -\'Kleinteil\',\'Großteil\', etc'),
pack_size_handle_group_cd STRING(5) NOT NULL
OPTIONS(description='A code for packaging size classification grouped in the bigger buckets based on how many effort is required to handle it -\' 1 person\'  ,\'2 persons\' etc'),
is_wine_spirits_fg BOOL NOT NULL
OPTIONS(description='Flag to identify if the values are belonging to the wine/spirits product gs1 category.'),
valid_from_dt DATE NOT NULL OPTIONS(description='The start date that determines the validity of the price.'),
valid_to_dt DATE OPTIONS(description='The end date that determines the validity of the price.'),
price_eur_val BIGNUMERIC(38,5) OPTIONS(description='Valid price in given currency'),
return_qty_pct BIGNUMERIC(38,5) OPTIONS(description='Return quantity percentage'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (fin_price_type_cd, price_condition, wshop_cd, prod_size_type_group_cd, pack_size_handle_group_cd,
 valid_from_dt, is_wine_spirits_fg) NOT ENFORCED
) OPTIONS(description='ETL Support table -   input data for the Deckungsbeitragsrechnung /Contribution Margin');