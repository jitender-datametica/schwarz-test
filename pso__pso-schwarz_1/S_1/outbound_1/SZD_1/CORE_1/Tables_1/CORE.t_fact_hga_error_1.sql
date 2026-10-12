/* --------------------------------------------------------------------------------
   DDL for table: T_FACT_HGA_ERROR_1
   generated from Powerdesigner on Mittwoch, 15. Februar 2023 17:17:20
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core.t_fact_hga_error_1 (
hga_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the hot beverage machine which is loacted in a store'),
error_tmsp TIMESTAMP NOT NULL OPTIONS(description='The timestamp of the error occurence '),
hga_error_cd STRING(250) NOT NULL OPTIONS(description='The code of error occured (error name)'),
hga_error_type_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The unique identifier for the hga error type'),
error_status_fg BOOL NOT NULL OPTIONS(description='The indicator for the status_1 of error (true or false)'),
is_in_operation_fg BOOL NOT NULL
OPTIONS(description='The indicator for hot beverage automate beeing in operation = true, if only partial failure, if total failure then false'),
manufacturer_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for a company which produces deposit machines.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
PRIMARY KEY (hga_sid, error_tmsp, hga_error_cd, error_status_fg) NOT ENFORCED
) OPTIONS(description='Transactional facts capturing the error code, status_1 and timestamp when the error occured');