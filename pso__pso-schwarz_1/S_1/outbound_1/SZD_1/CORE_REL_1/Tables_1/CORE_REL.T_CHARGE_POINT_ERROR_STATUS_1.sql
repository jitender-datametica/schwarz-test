/* --------------------------------------------------------------------------------
   DDL for table: T_CHARGE_POINT_ERROR_STATUS_1
   generated from Powerdesigner on Montag, 4. Dezember 2023 13:39:43
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core_rel.t_charge_point_error_status_1 (
error_nr BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The unique ID of the occured error.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The date when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The date when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL
OPTIONS(description='An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.'),
charge_point_error_status_type_cd STRING(50) NOT NULL
OPTIONS(description='The unique code of the charge point status_1 error type.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
dwh_src_file_name STRING(500)
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source'),
PRIMARY KEY (error_nr, dwh_valid_from_tmsp) NOT ENFORCED
)
OPTIONS(description='Entity - Transactional - Transaction - Contains the timeline of the status_1 of the the charge point error. - Source - IOTCharger');