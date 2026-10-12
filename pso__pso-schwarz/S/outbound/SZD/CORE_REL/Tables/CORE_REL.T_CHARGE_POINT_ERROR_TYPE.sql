/* --------------------------------------------------------------------------------
   DDL for table: T_CHARGE_POINT_ERROR_TYPE
   generated from Powerdesigner on Donnerstag, 9. November 2023 13:27:21
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core_rel.t_charge_point_error_type (
charge_point_error_type_cd STRING(250) NOT NULL
OPTIONS(description='The unique code of a possible charge point/charger error type'),
charge_point_error_type_descr STRING(250) NOT NULL OPTIONS(description='A brief description of this error type.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
dwh_src_file_name STRING(500)
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source'),
PRIMARY KEY (charge_point_error_type_cd) NOT ENFORCED
)
OPTIONS(description='Minor Entity - Defines the possible error type codes that can occur on a charge point or charger. - Source - Manual');