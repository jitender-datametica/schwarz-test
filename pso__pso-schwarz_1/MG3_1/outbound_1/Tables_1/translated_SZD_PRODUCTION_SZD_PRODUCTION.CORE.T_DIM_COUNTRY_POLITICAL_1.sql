CREATE OR REPLACE TABLE szd_production_core.t_dim_country_political_1 (
location_sid INTEGER NOT NULL OPTIONS(description='The unique identifier (surrogate key) of the political country.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL OPTIONS(description='An indicator showing the current record in history.'),
iso_country_cd STRING(50) NOT NULL OPTIONS(description='Natural Key/Business Key - The ISO code of the country.'),
country_name_de STRING(100) NOT NULL OPTIONS(description='Denormalized Attribute - The german name of the country.'),
country_name_en STRING(100) NOT NULL OPTIONS(description='Denormalized Attribute - The english name of the country.'),
curr_cd STRING(3) NOT NULL OPTIONS(description='Denormalized Attribute - The code of the currency used in the country.'),
latitude NUMERIC(9,6) OPTIONS(description='The latitude of the geographical position of the country.'),
longitude NUMERIC(9,6) OPTIONS(description='The longitude of the geographical position of the country.'),
eu_member_fg BOOL NOT NULL OPTIONS(description='Flag indicating whether the country_1 is member of the EU.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
dwh_src_file_name STRING(500)
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source'),
PRIMARY KEY (location_sid, dwh_valid_from_tmsp) NOT ENFORCED
)
OPTIONS(description='Major Dimension - Contains the political countries with their codes, names in different languages and used currencies. - Source - Manual');