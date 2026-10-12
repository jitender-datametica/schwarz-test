/* --------------------------------------------------------------------------------
   DDL for table: T_ERROR_DEFINITION_KEY
   generated from Powerdesigner on Montag, 27. November 2023 10:12:54
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_meta.t_error_definition_key (
error_definition_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the error definition'),
error_definition_key_type_cd STRING(50) NOT NULL
OPTIONS(description='The code for the type of natural key which identifies the error definition.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL
OPTIONS(description='An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.'),
error_definition_nat_key_nr STRING(250) NOT NULL
OPTIONS(description='The natural key which identifies the error definition. In case the natural key consist of several columns, all components get concatenated.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
PRIMARY KEY (error_definition_key_type_cd, dwh_valid_from_tmsp, error_definition_nat_key_nr) NOT ENFORCED
)
OPTIONS(description='Metadata - Keytable - Error Definition - Contains the mapping between surrogate keys and natural keys for business objects for "Error Definitions"  from the subject area "Common ".');