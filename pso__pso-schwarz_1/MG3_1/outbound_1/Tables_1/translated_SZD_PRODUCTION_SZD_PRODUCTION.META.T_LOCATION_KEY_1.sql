CREATE OR REPLACE TABLE szd_production_meta.t_location_key_1 (
location_sid INTEGER NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the location.'),
location_key_type_cd STRING(50) NOT NULL
OPTIONS(description='The code for the type of natural key which identifies the location.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL
OPTIONS(description='An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.'),
location_nat_key_nr STRING(250) NOT NULL
OPTIONS(description='The natural key which identifies the location.In case the natural key consist of several columns, all components get concatenated.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
PRIMARY KEY (location_key_type_cd, dwh_valid_from_tmsp, location_nat_key_nr) NOT ENFORCED
)
OPTIONS(description='Metadata - Keytable - Location_1 - Contains the mapping between surrogate keys and natural keys for business objects from the subject area\"Location_1\".');