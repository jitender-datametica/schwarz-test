/* --------------------------------------------------------------------------------
   DDL for table: T_CURRENCY_1
   generated from Powerdesigner on Mittwoch, 26. April 2023 09:49:04
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core_rel.t_currency_1 (
curr_cd STRING(50) NOT NULL OPTIONS(description='The code identifying the currency, according to ISO 4217.'),
curr_name STRING(100) NOT NULL OPTIONS(description='The name of the currency.'),
used_in_store_fg BOOL NOT NULL
OPTIONS(description='An indicator showing, if this currency is used in a country_1 where the Schwarz Group operates any stores.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_src_file_name STRING(500)
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source'),
PRIMARY KEY (curr_cd) NOT ENFORCED
) OPTIONS(description='Minor Entity - A system of money that is in use in a country. - Source - Manual');