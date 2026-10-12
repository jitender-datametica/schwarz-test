/* --------------------------------------------------------------------------------
   DDL for table: T_DIM_MARITIME_PORT_2
   generated from Powerdesigner on Montag, 22. April 2024 11:13:49
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core.t_dim_maritime_port_2 (
location_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the port.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL OPTIONS(description='An indicator showing the current record in history.'),
port_price_group_cd STRING(50) NOT NULL OPTIONS(description='The code for the price group '),
port_name STRING(100) NOT NULL OPTIONS(description='Natural Key/Business Key - The name of the port.'),
port_short_name STRING(100) OPTIONS(description='Descriptive Attribute - Short name of which the port is known.'),
city_name STRING(100) OPTIONS(description='Descriptive Attribute - Name of the city in which site is situated'),
short_name_business_cd STRING(50) NOT NULL
OPTIONS(description='Derived attribute - Combined country_pol_cd and short name as known by business'),
country_pol_cd STRING(3) NOT NULL OPTIONS(description='The code identifying a political country_2 according to ISO 3166.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_src_file_name STRING(500)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (location_sid, dwh_valid_from_tmsp) NOT ENFORCED
)
OPTIONS(description='Major Dimension - A port is a maritime facility comprising one or more wharves or loading areas, where ships load and discharge cargo. - Source - VMT');