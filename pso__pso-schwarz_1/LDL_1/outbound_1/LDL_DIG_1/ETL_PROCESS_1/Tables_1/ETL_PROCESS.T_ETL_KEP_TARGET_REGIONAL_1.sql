/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_ETL_KEP_TARGET_REGIONAL_1
   GENERATED FROM POWERDESIGNER ON Montag, 19. Dezember 2022 10:41:42
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_etl_process.t_etl_kep_target_regional_1 (
bus_year BIGNUMERIC NOT NULL OPTIONS(description='The business year as a number in the form YYYY. Eg. 2019'),
month_of_bus_year BIGNUMERIC NOT NULL
OPTIONS(description='The month of the (Lidl) business year (starting in March) as a number using the convention March = 1, April = 2 ... December = 10, January = 11, February = 12. '),
wshop_cd STRING(5) NOT NULL
OPTIONS(description='The unique code for the Lidl webshop, where an order can be placed by a customer.The webshop is defined per political country_1 and is run by an Lidl Digital Country_1'),
pack_size_handle_group_cd STRING(5) NOT NULL
OPTIONS(description='A code for packaging size classification grouped in the bigger buckets based on how many effort is required to handle it -\' 1 person\'  ,\'2 persons\' etc'),
acct_nr STRING(20) NOT NULL
OPTIONS(description='Number of the Account. The there are postings in the GL they are booked to this account_1 number'),
is_wine_spirits_fg BOOL NOT NULL
OPTIONS(description='Flag to identify if the values are belonging to the wine/spirits product gs1 category.'),
delivery_src_type_cd STRING(5)
OPTIONS(description='The code for source location_1 of product from where it is delivered i.e. from supplier_1 or warehouse directly'),
db_pos_name STRING(200) OPTIONS(description='Name of the Contribution Margin position in German'),
curr_cd STRING(5) OPTIONS(description='Currency in which target is set'),
tgt_price_net_eur_val BIGNUMERIC(38,5) OPTIONS(description='Planned price in euro'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (bus_year, month_of_bus_year, wshop_cd, pack_size_handle_group_cd, acct_nr, is_wine_spirits_fg) NOT ENFORCED
) OPTIONS(description='ETL Support table -   input data for the Deckungsbeitragsrechnung /Contribution Margin');