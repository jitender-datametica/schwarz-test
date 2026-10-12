CREATE OR REPLACE TABLE szd_production_core_rel.t_country_political (
location_sid INTEGER NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the political country.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL OPTIONS(description='An indicator showing the current record in history.'),
iso_country_cd STRING(50) NOT NULL
OPTIONS(description='Natural/Business Key - The code identifying the country according to ISO 3166.'),
country_name STRING(100) NOT NULL OPTIONS(description='The name of the country in the default language.'),
lang_cd STRING(2) NOT NULL OPTIONS(description='The code identifying the language.'),
curr_cd STRING(50) NOT NULL
OPTIONS(description='The code identifying the official currency of the country, according to ISO 4217.'),
latitude NUMERIC(9,6) OPTIONS(description='The latitude of the geographical position of the country.'),
longitude NUMERIC(9,6) OPTIONS(description='The longitude of the geographical position of the country.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_src_file_name STRING(500) NOT NULL
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source'),
PRIMARY KEY (location_sid, dwh_valid_from_tmsp, lang_cd) NOT ENFORCED
)
OPTIONS(description='Major Entity - A geopolitical region with a sovereign governing. E.g. Germany, France, UK, ... - Source - Manual');