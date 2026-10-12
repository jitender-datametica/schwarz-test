CREATE TABLE IF NOT EXISTS ldl_dig_etl_process.t_etl_financial_acct_actual_regional_1 (
bus_year BIGNUMERIC NOT NULL OPTIONS(description='The business year as a number in the form YYYY. Eg. 2019'),
month_of_bus_year BIGNUMERIC NOT NULL
OPTIONS(description='The month of the (Lidl) business year (starting in March) as a number using the convention March = 1, April = 2 ... December = 10, January = 11, February = 12. '),
wshop_cd STRING(5) NOT NULL
OPTIONS(description='The unique code for the Lidl webshop, where an order can be placed by a customer.The webshop is defined per political country_1 and is run by an Lidl Digital Country_1'),
group_acct_nr STRING(20) NOT NULL
OPTIONS(description='For operative accounts ( Chart Of Accounts =\'LDI1\') this is the group account_1 they are asscoiated to. This facilitates reporting at group level'),
is_wine_spirits_fg BOOL NOT NULL
OPTIONS(description='Flag to identify if the values are belonging to the wine/spirits product gs1 category.'),
db_pos_name STRING(200) OPTIONS(description='Name of the Contribution Margin position in German'),
curr_cd STRING(5) OPTIONS(description='Currency in which target is set'),
actual_price_net_eur_val BIGNUMERIC(38,5) OPTIONS(description='Actual price in euro'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (bus_year, month_of_bus_year, wshop_cd, group_acct_nr, is_wine_spirits_fg) NOT ENFORCED
) OPTIONS(description='ETL Support table -  input data for the Deckungsbeitragsrechnung /Contribution Margin');