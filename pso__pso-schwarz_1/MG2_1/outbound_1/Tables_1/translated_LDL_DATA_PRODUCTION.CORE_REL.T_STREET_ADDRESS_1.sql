CREATE OR REPLACE TABLE ldl_data_production_core_rel.t_street_address_1 (
street_addr_sid INTEGER NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the postal address.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL
OPTIONS(description='An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.'),
country_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the country_1, in which this address_1 is located.'),
iso_country_cd STRING(2) NOT NULL OPTIONS(description='The code identifying the country_1 according to ISO 3166.'),
country_name STRING(100) NOT NULL OPTIONS(description='The name by which the country_1 is known,'),
city_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the city, in which this address_1 is located.'),
city_name STRING(100) NOT NULL OPTIONS(description='The name by which the city is known,'),
district_sid INTEGER
OPTIONS(description='The unique identifier (surrogate key) for the district, in which this address_1 is located.'),
district_name STRING(100) OPTIONS(description='The name by which the district is known,'),
postal_cd_area_sid INTEGER
OPTIONS(description='The unique identifier (surrogate key) for postal code area, in which this address_1 is located.'),
zip STRING(15)
OPTIONS(description='A code used by the postal service to identify a geographical area. E.g. 74072 for Heilbronn in Germany'),
street_name STRING(100)
OPTIONS(description='The name of the street, in which this address_1 is located. (This includes names of squares and similar locations.)'),
house_nr STRING(100) OPTIONS(description='The number of a house in a street.'),
reporting_country_sid INTEGER
OPTIONS(description='The unique identifier (surrogate key) for the reporting country. (i.e. a country_1 definition which is different from a geographical country_1)'),
reporting_country_cd STRING(20) OPTIONS(description='The code which identifies the reporting country_1'),
lon NUMERIC(9,6) OPTIONS(description='The longitude component of the geographical coordinates of this address.'),
lat NUMERIC(9,6) OPTIONS(description='The latitude component of the geographical coordinates of this address.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (street_addr_sid, dwh_valid_from_tmsp) NOT ENFORCED
)
OPTIONS(description='A physical mailing address_1, typically consisting of a street name, a house number, a city or village with a zip code and (optionally) a country.');