CREATE OR REPLACE TABLE szd_production_etl.t_etl_city_chargers_b_1 (
location_sid INTEGER NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the location.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.\n            The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL OPTIONS(description='An indicator showing the current record in history.'),
country_location_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the country_1 location.'),
city_name STRING(100) NOT NULL OPTIONS(description='The name of the city'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
dwh_src_file_name STRING(500)
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source'),
PRIMARY KEY (location_sid, dwh_valid_from_tmsp) NOT ENFORCED
);