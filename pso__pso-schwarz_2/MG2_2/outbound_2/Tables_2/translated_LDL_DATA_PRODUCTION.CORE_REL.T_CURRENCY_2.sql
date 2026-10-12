CREATE OR REPLACE TABLE ldl_data_production_core_rel.t_currency_2 (
curr_cd STRING(3) NOT NULL OPTIONS(description='The code identifying the currency, according to ISO 4217.'),
lang_cd STRING(2) NOT NULL OPTIONS(description='The code identifying the language.'),
curr_name STRING(100) NOT NULL OPTIONS(description='The name of the currency.'),
used_in_stores_fg BOOL NOT NULL
OPTIONS(description='An indicator showing, if this currency is used in a country_2 where the Schwarz Group operates any stores.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (curr_cd, lang_cd) NOT ENFORCED
) OPTIONS(description='A system of money that is in use in a country.');