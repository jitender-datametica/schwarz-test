/* --------------------------------------------------------------------------------
   DDL for table: T_DIM_HGA_ERROR_2
   generated from Powerdesigner on Dienstag, 29. April 2025 16:02:17
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core.t_dim_hga_error_2 (
hga_error_cd STRING(50) NOT NULL OPTIONS(description='The unique code for the hot beverage machine error'),
hga_error_grp_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The  unique identifier (surrogate key) for an error group of hot beverage machine'),
manufacturer_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for a company which produces deposit machines.'),
hga_error_descr STRING(250) OPTIONS(description='The default textual description for error code'),
hga_error_descr_de STRING(250) NOT NULL OPTIONS(description='The textual description for error code in German.'),
hga_error_descr_en STRING(250) NOT NULL OPTIONS(description='The textual description for error code in English.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
PRIMARY KEY (hga_error_cd) NOT ENFORCED
)
OPTIONS(description='The dimension holds the different error data of hot beverage machines manufactured by Sielaff and Gerhardt');