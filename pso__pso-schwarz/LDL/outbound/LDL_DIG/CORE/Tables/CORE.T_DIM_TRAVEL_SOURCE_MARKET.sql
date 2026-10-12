CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_travel_source_market (
trav_source_market_cd STRING(5) NOT NULL OPTIONS(description='The code for the source market in Lidl Travel '),
trav_source_market_name STRING(100) NOT NULL
OPTIONS(description='The description for the source market in Lidl Travel '),
country_cd STRING(5)
OPTIONS(description='The unique code for a country according to ISO-3166 Alpha-2. E.g.\"DE\" for Germany or\"FR\" for France'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (trav_source_market_cd) NOT ENFORCED
)
OPTIONS(description='This minor dimension defines different source markets available for Lidl Travel ( German , Austrian, Swiss French Speaking , etc...)');