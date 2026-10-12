/* --------------------------------------------------------------------------------
   DDL for table: T_CHARGE_POINT_ERROR_STATUS_TYPE
   generated from Powerdesigner on Freitag, 17. November 2023 13:30:05
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core_rel.t_charge_point_error_status_type (
charge_point_error_status_type_cd STRING(50) NOT NULL
OPTIONS(description='The unique code of the charge point status error type.'),
charge_point_error_status_type_descr STRING(250) NOT NULL
OPTIONS(description='A brief description of the charge point error status type.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
dwh_src_file_name STRING(500)
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source'),
PRIMARY KEY (charge_point_error_status_type_cd) NOT ENFORCED
) OPTIONS(description='Minor Entity - Defines the possible states a charge point error can have. - Source - Manual');