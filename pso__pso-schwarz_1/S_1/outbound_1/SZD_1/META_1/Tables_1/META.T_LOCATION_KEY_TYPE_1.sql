/* --------------------------------------------------------------------------------
   DDL for table: T_LOCATION_KEY_TYPE_1
   generated from Powerdesigner on Donnerstag, 30. November 2023 09:39:09
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_meta.t_location_key_type_1 (
location_key_type_cd STRING(50) NOT NULL
OPTIONS(description='The code for the type of natural key which identifies the location.'),
location_key_type_name STRING(100) NOT NULL
OPTIONS(description='The name of the type of natural key which identifies the location.'),
location_key_type_descr STRING(250) NOT NULL
OPTIONS(description='A textual description for the type of natural key, detailing its format and the meaning of the components.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
PRIMARY KEY (location_key_type_cd) NOT ENFORCED
)
OPTIONS(description='Metadata - Keytable - Location_1 - Contains the types that shares the key space for the subject area "Location_1".');