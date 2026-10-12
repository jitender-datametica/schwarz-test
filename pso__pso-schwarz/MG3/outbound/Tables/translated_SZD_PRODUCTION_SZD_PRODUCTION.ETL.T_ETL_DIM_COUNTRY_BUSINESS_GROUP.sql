CREATE OR REPLACE TABLE szd_production_etl.t_etl_dim_country_business_group (
location_group_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the location group. Key generation based on META table for party key space.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
country_business_group_cd STRING(50) NOT NULL
OPTIONS(description='Natural/Business Key -  identifying the country group'),
country_business_group_name STRING(100) NOT NULL
OPTIONS(description='Descriptive Attribute - the name of the country group'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_src_file_name STRING(500)
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source'),
PRIMARY KEY (location_group_sid, dwh_valid_from_tmsp) NOT ENFORCED
);