/* --------------------------------------------------------------------------------
   DDL for table: T_DIM_HGA_ERROR_GROUP
   generated from Powerdesigner on Dienstag, 29. April 2025 16:03:42
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core.t_dim_hga_error_group (
hga_error_grp_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The numerical identifier for an error group of hot beverage machine'),
manufacturer_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for a company which produces deposit machines.'),
hga_error_grp_name STRING(100) NOT NULL OPTIONS(description='The default descriptive name for an error group'),
hga_error_grp_name_de STRING(100) NOT NULL OPTIONS(description='The descriptive name for an error group in German.'),
hga_error_grp_name_en STRING(100) NOT NULL OPTIONS(description='The descriptive name for an error group in English.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
PRIMARY KEY (hga_error_grp_sid) NOT ENFORCED
)
OPTIONS(description='The dimension holds the different error categories of hot beverage machines manufactured by Sielaff and Gerhardt');