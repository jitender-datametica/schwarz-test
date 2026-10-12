CREATE OR REPLACE TABLE szd_production_meta.t_error_definition_key_1 (
error_definition_sid INTEGER NOT NULL
OPTIONS(description='the unique identifier (surrogate key) for the error definition'),
error_definition_key_type_cd STRING(50) NOT NULL
OPTIONS(description='the code for the type of natural key which identifies the error definition.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='the point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='the point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL
OPTIONS(description='an indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.'),
error_definition_nat_key_nr STRING(250) NOT NULL
OPTIONS(description='the natural key which identifies the error definition. in case the natural key consist of several columns, all components get concatenated.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='the point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='the point in time when this record was last modified. (in case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
PRIMARY KEY (error_definition_key_type_cd, dwh_valid_from_tmsp, error_definition_nat_key_nr) NOT ENFORCED
)
OPTIONS(description='metadata - keytable - error definition - contains the mapping between surrogate keys and natural keys for business objects for "error definitions" from the subject area "common".');