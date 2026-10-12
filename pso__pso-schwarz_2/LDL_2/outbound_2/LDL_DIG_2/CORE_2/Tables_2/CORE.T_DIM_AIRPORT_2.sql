CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_airport_2 (
airport_cd STRING(5) NOT NULL OPTIONS(description='The three letter code for international airports in the world'),
country_cd STRING(5) NOT NULL
OPTIONS(description='The unique code for a country_2 according to ISO-3166 Alpha-2. E.g.\"DE\" for Germany or\"FR\" for France'),
airport_city_name STRING(100) NOT NULL OPTIONS(description='The city name in which the airport is located'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (airport_cd) NOT ENFORCED
) OPTIONS(description='This minor dimension defines the airport and their city details');