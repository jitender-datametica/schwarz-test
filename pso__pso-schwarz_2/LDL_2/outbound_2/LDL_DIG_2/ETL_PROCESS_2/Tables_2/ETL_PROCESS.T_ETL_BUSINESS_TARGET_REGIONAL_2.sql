/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_ETL_BUSINESS_TARGET_REGIONAL_2
   GENERATED FROM POWERDESIGNER ON Montag, 19. Dezember 2022 10:39:25
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_etl_process.t_etl_business_target_regional_2 (
bus_year BIGNUMERIC NOT NULL OPTIONS(description='The business year as a number in the form YYYY. Eg. 2019'),
month_of_bus_year BIGNUMERIC NOT NULL
OPTIONS(description='The month of the (Lidl) business year (starting in March) as a number using the convention March = 1, April = 2 ... December = 10, January = 11, February = 12. '),
wshop_cd STRING(5) NOT NULL
OPTIONS(description='The unique code for the Lidl webshop, where an order can be placed by a customer.The webshop is defined per political country_2 and is run by an Lidl Digital Country_2'),
delivery_src_type_cd STRING(5) NOT NULL
OPTIONS(description='The code for source location_2 of product from where it is delivered i.e. from supplier_2 or warehouse directly'),
prod_food_class_cd STRING(5) NOT NULL
OPTIONS(description='The code for the indicating if product is a food or non food'),
brand_class_cd STRING(5) NOT NULL
OPTIONS(description='The code for the indicating if product is classified as a Lidl own brand_2 or not'),
prod_org_lvl_name STRING(50) NOT NULL
OPTIONS(description='The Organisation level is a mapped field for every category in the GS1 article categorization system on level 4. Every Brickcode has a mapped Organisation level, which can be compared to the old Shop categorie 1, but now based first on the Brickcode structure. The Organisation level is a mapping to transfer the GS1 article categorization system to the structures of Lidl Digital.'),
db_pos_name STRING(200) NOT NULL OPTIONS(description='Name of the Contribution Margin position in German'),
is_wine_spirits_fg BOOL NOT NULL
OPTIONS(description='Flag to identify if the values are belonging to the wine/spirits product gs1 category.'),
curr_cd STRING(5) OPTIONS(description='Currency in which target is set'),
tgt_price_net_eur_val BIGNUMERIC(38,5) OPTIONS(description='Planned price in euro'),
prod_qty BIGNUMERIC(38,5) OPTIONS(description='Product quantity'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (bus_year, month_of_bus_year, wshop_cd, delivery_src_type_cd, prod_food_class_cd, brand_class_cd,
 prod_org_lvl_name, db_pos_name, is_wine_spirits_fg) NOT ENFORCED
) OPTIONS(description='ETL Support table -   input data for the Deckungsbeitragsrechnung /Contribution Margin');