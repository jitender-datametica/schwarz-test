CREATE OR REPLACE TABLE szd_production_core.t_dim_real_estate (
resource_item_sid INTEGER NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the real estate.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL OPTIONS(description='An indicator showing the current record in history.'),
division_party_sid INTEGER NOT NULL
OPTIONS(description='Natural/Business Key - The unique identifier (surrogate key) for the party as a division. Key generation based on META table for party key space.'),
division_cd STRING(50)
OPTIONS(description='Descriptive Attribute - The unique code for each division within the Schwarz Group, i.e.L-Lidl or K-Kaufland'),
division_name STRING(100)
OPTIONS(description='Descriptive Attribute - The name for the division within the Schwarz Group, i.e.Lidl or Kaufland'),
country_location_sid INTEGER NOT NULL
OPTIONS(description='Natural/Business Key - The unique identifier (surrogate key) of the political country.'),
country_cd STRING(50) OPTIONS(description='Descriptive Attribute - The ISO code of the country.'),
country_name STRING(100) OPTIONS(description='Descriptive Attribute - The name of the country.'),
real_estate_nr STRING(250) NOT NULL
OPTIONS(description='Natural/Business Key - The unique code of the real estate within the country.'),
zip STRING(15)
OPTIONS(description='Descriptive Attribute - The zip code of the city/area where the real estate is located.'),
city STRING(100) OPTIONS(description='Descriptive Attribute - The name of the city where the real estate is located.'),
street STRING(1000) OPTIONS(description='Descriptive Attribute - The street name of the address of the real estate.'),
latitude NUMERIC(9,6)
OPTIONS(description='Descriptive Attribute - The latitude part of the geographical position of the real estate.'),
longitude NUMERIC(9,6)
OPTIONS(description='Descriptive Attribute - The longitude part of the geographical position of the real estate.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
dwh_src_file_name STRING(500)
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source'),
PRIMARY KEY (resource_item_sid, dwh_valid_from_tmsp) NOT ENFORCED
)
OPTIONS(description='Major Dimension - A real estate is a building used for a specific purpose. It can be a store, a office building, a parking garage and so on. - Source - IOT Charger');