/* --------------------------------------------------------------------------------
   DDL for table: T_MAINTENANCE_STATE
   generated from Powerdesigner on Montag, 11. November 2024 08:57:39
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core_rel.t_maintenance_state (
maintenance_state_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The unique id of the maintenance state.'),
maintenance_state_name STRING(100) NOT NULL OPTIONS(description='The name of the maintenace state.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
dwh_src_file_name STRING(500)
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source'),
PRIMARY KEY (maintenance_state_id) NOT ENFORCED
) OPTIONS(description='Minor Entity - An arbitrary maintenance state. - Source - Lexis');