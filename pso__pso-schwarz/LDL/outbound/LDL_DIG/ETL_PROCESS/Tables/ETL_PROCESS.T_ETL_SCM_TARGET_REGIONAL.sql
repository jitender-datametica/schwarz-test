/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_ETL_SCM_TARGET_REGIONAL
   GENERATED FROM POWERDESIGNER ON Montag, 19. Dezember 2022 10:40:40
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_etl_process.t_etl_scm_target_regional (
bus_year BIGNUMERIC NOT NULL OPTIONS(description='The business year as a number in the form YYYY. Eg. 2019'),
month_of_bus_year BIGNUMERIC NOT NULL
OPTIONS(description='The month of the (Lidl) business year (starting in March) as a number using the convention March = 1, April = 2 ... December = 10, January = 11, February = 12. '),
wshop_cd STRING(5) NOT NULL
OPTIONS(description='The unique code for the Lidl webshop, where an order can be placed by a customer.The webshop is defined per political country and is run by an Lidl Digital Country'),
prod_size_type_group_cd STRING(5) NOT NULL
OPTIONS(description='A code for product size classification grouped in the bigger buckets -\'Kleinteil\',\'Großteil\', etc'),
pack_size_handle_group_cd STRING(5) NOT NULL
OPTIONS(description='A code for packaging size classification grouped in the bigger buckets based on how many effort is required to handle it -\' 1 person\'  ,\'2 persons\' etc'),
db_pos_name STRING(200) NOT NULL OPTIONS(description='Name of the Contribution Margin position in German'),
is_wine_spirits_fg BOOL NOT NULL
OPTIONS(description='Flag to identify if the values are belonging to the wine/spirits product gs1 category.'),
delivery_src_type_cd STRING(5)
OPTIONS(description='The code for source location of product from where it is delivered i.e. from supplier or warehouse directly'),
prod_qty BIGNUMERIC(38,5) OPTIONS(description='Product quantity'),
pack_qty BIGNUMERIC(38,5) OPTIONS(description='Packaging quantity'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (bus_year, month_of_bus_year, wshop_cd, prod_size_type_group_cd, pack_size_handle_group_cd,
 is_wine_spirits_fg, db_pos_name) NOT ENFORCED
) OPTIONS(description='ETL Support table -   input data for the Deckungsbeitragsrechnung /Contribution Margin');