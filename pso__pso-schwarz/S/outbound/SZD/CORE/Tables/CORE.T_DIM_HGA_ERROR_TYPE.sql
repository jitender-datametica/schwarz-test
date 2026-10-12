/* --------------------------------------------------------------------------------
   DDL for table: T_DIM_HGA_ERROR_TYPE
   generated from Powerdesigner on Mittwoch, 15. Februar 2023 17:17:20
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core.t_dim_hga_error_type (
hga_error_type_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The unique identifier for the hga error type'),
hga_error_type_descr STRING(250) NOT NULL
OPTIONS(description='Name for the hga error type. Partial or total failure are possible values'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
PRIMARY KEY (hga_error_type_id) NOT ENFORCED
)
OPTIONS(description='Minor Dimension - for describing the different error types. Partial or total failure are possible values. Source - extracted from SPROD-File under machine/errors/type element.');