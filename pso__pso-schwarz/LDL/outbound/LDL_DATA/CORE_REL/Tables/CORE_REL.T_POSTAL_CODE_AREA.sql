CREATE TABLE IF NOT EXISTS ldl_data_core_rel.t_postal_code_area (
postal_cd_area_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the postal code area.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL
OPTIONS(description='An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.'),
country_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the country.'),
iso_country_cd STRING(2) NOT NULL OPTIONS(description='The code identifying the country according to ISO 3166.'),
country_name STRING(100) NOT NULL OPTIONS(description='The name by which the country is known,'),
zip STRING(15) NOT NULL
OPTIONS(description='A code used by the postal service to identify a geographical area. E.g. 74072 for Heilbronn in Germany'),
postal_cd_area_name STRING(100) NOT NULL OPTIONS(description='The name by which the postal code area is known,'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (postal_cd_area_sid, dwh_valid_from_tmsp) NOT ENFORCED
) OPTIONS(description='The geographical area which is identified by a zip code.');