/* --------------------------------------------------------------------------------
   DDL for table: T_DIM_TRANSHIPMENT_LOCATION
   generated from Powerdesigner on Montag, 22. April 2024 11:13:48
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core.t_dim_transhipment_location (
location_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) of the transhipment location.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL OPTIONS(description='An indicator showing the current record in history.'),
country_location_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Natural Key/Business Key - The unique identifier (surrogate key) of the political country.'),
iso_country_cd STRING(50) NOT NULL OPTIONS(description='Denormalized Attribute - The ISO code of the country.'),
country_name_de STRING(100) NOT NULL OPTIONS(description='Denormalized Attribute - The german name of the country.'),
country_name_en STRING(100) NOT NULL OPTIONS(description='Denormalized Attribute - The english name of the country.'),
transhipment_location_cd STRING(50) NOT NULL
OPTIONS(description='Natural Key/Business Key - The unique code of the transhipment location.'),
transhipment_location_name STRING(100) NOT NULL OPTIONS(description='The name of the transhipment location.'),
city_name STRING(100) OPTIONS(description='The name of the city where the transhipment location is located.'),
transhipment_location_type_cd STRING(50) NOT NULL
OPTIONS(description='The unique code of the type of transhipment location.'),
transhipment_location_type_name STRING(100) NOT NULL
OPTIONS(description='Denormalized Attribute - The name of the transhipment location.'),
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
OPTIONS(description='Major Dimension - At the goods transshipment location, goods are reloaded from one transport medium (e.g. a ship) to another transport medium (e.g. a truck) in order to then be transported on to the destination. - Source - Manual');