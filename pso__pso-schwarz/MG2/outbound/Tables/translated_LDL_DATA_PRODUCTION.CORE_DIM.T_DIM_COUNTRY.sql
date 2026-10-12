CREATE OR REPLACE TABLE ldl_data_production_core_dim.t_dim_country (
iso_country_cd STRING(2) NOT NULL OPTIONS(description='The code identifying the country according to ISO 3166.'),
country_name STRING(100) NOT NULL
OPTIONS(description='The name by which the country is known, in group language, i.e. German'),
country_name_de STRING(100) OPTIONS(description='The name by which the country is known, in German.'),
country_name_en STRING(100) OPTIONS(description='The name by which the country is known, in English.'),
curr_cd STRING(3) NOT NULL OPTIONS(description='The code identifying the currency according to ISO-4217.'),
official_lang_cd STRING(2) NOT NULL
OPTIONS(description='The code identifying the primary language which is used in this country.'),
stores_exist_fg BOOL NOT NULL
OPTIONS(description='An indicator showing, if the Schwarz Group operates any stores in this country.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (iso_country_cd) NOT ENFORCED
)
OPTIONS(description='A political country, i.e. a geopolitical region with a sovereign governing. E.g. Germany, France, UK, ...');