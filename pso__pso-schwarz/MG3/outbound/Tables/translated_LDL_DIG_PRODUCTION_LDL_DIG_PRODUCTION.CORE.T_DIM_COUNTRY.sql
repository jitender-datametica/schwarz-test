CREATE OR REPLACE TABLE ldl_dig_production_core.t_dim_country (
country_cd STRING(5) NOT NULL
OPTIONS(description='The unique code for a country according to ISO-3166 Alpha-2. E.g. DE for Germany or FR for France'),
country_name STRING(250) NOT NULL OPTIONS(description='The textual description for the country'),
country_iso3_cd STRING(5) OPTIONS(description='ISO Alpha 3-letter-code'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (country_cd) NOT ENFORCED
) OPTIONS(description='This minor dimension defines the country');