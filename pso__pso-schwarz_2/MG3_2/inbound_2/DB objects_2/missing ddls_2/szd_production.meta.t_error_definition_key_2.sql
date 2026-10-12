CREATE OR REPLACE TABLE szd_production.meta.t_error_definition_key_2 (
    error_definition_sid NUMBER(38,0) NOT NULL COMMENT 'the unique identifier (surrogate key) for the error definition',
    error_definition_key_type_cd VARCHAR(50) NOT NULL COMMENT 'the code for the type of natural key which identifies the error definition.',
    dwh_valid_from_tmsp TIMESTAMP_LTZ(9) NOT NULL COMMENT 'the point in time when this record became valid.',
    dwh_valid_to_tmsp TIMESTAMP_LTZ(9) NOT NULL COMMENT 'the point in time when this record was no longer valid.',
    dwh_valid_fg BOOLEAN NOT NULL COMMENT 'an indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
    error_definition_nat_key_nr VARCHAR(250) NOT NULL COMMENT 'the natural key which identifies the error definition. in case the natural key consist of several columns, all components get concatenated.',
    dwh_created_tmsp TIMESTAMP_LTZ(9) NOT NULL COMMENT 'the point in time when this record was inserted into the table.',
    dwh_updated_tmsp TIMESTAMP_LTZ(9) NOT NULL COMMENT 'the point in time when this record was last modified. (in case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
    CONSTRAINT pk_t_error_definition_key PRIMARY KEY (error_definition_key_type_cd, dwh_valid_from_tmsp, error_definition_nat_key_nr)
) 
COMMENT = 'metadata - keytable - error definition - contains the mapping between surrogate keys and natural keys for business objects for "error definitions" from the subject area "common".';