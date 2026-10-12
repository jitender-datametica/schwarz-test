/* --------------------------------------------------------------------------------
   DDL for table: T_CHARGE_POINT_ERROR_DEFINITION_2
   generated from Powerdesigner on Freitag, 17. November 2023 11:04:54
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core_rel.t_charge_point_error_definition_2 (
error_definition_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The unique surrogate key of the error definition.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL
OPTIONS(description='An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.'),
charge_point_error_type_cd STRING(250) NOT NULL
OPTIONS(description='The unique code of a possible charge point/charger error'),
manufacturer_party_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the party.'),
manufacturer_error_code_txt STRING(1000) NOT NULL
OPTIONS(description='Descriptive Attribute - A arbitrary error code defined by the manufacturer of the charger model.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
dwh_src_file_name STRING(500)
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source'),
PRIMARY KEY (error_definition_sid, dwh_valid_from_tmsp) NOT ENFORCED
)
OPTIONS(description='Major Entity - This error definition describes an error that can occur on a charge point. The charge point is part of a charger where you can charge your electric car. - Source - IOTCharger');