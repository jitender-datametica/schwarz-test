CREATE OR REPLACE TABLE szd_production_etl.t_etl_real_estate_chargers_a (
resource_item_sid INTEGER NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the resource item.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL OPTIONS(description='An indicator showing the current record in history.'),
street_address_location_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the location.'),
country_location_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the political country.'),
division_party_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the party as a division. Key generation based on META table for party key space.'),
real_estate_nr STRING(250) NOT NULL OPTIONS(description='The unique code of the real estate within the country.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
dwh_src_file_name STRING(500)
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source'),
PRIMARY KEY (resource_item_sid, dwh_valid_from_tmsp) NOT ENFORCED
);