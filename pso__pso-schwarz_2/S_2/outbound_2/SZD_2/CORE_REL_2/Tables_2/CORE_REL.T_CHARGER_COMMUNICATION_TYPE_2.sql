/* --------------------------------------------------------------------------------
   DDL for table: T_CHARGER_COMMUNICATION_TYPE_2
   generated from Powerdesigner on Donnerstag, 9. November 2023 14:50:01
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core_rel.t_charger_communication_type_2 (
charger_communication_type_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique code of the communication_2 type of a charger.'),
charger_communication_type_name STRING(100) NOT NULL
OPTIONS(description='The technical name of the communication_2 type.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
dwh_src_file_name STRING(500)
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BYTES storage or the shortened file path'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source'),
PRIMARY KEY (charger_communication_type_id) NOT ENFORCED
)
OPTIONS(description='Minor Entity - Defines the possible types/protocols that are used by the charger to communicate. - Source - Manual');