/* --------------------------------------------------------------------------------
   DDL for table: T_CHARGE_POINT_PLUGIN_TYPE_2
   generated from Powerdesigner on Mittwoch, 7. Mai 2025 13:39:31
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core_rel.t_charge_point_plugin_type_2 (
charge_point_plugin_type_cd STRING(50) NOT NULL
OPTIONS(description='The unique code identifying the chargepoint connector plugin type.'),
charge_point_plugin_type_name STRING(100) NOT NULL OPTIONS(description='The name describing the connector plugin type.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
dwh_src_file_name STRING(500)
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source'),
PRIMARY KEY (charge_point_plugin_type_cd) NOT ENFORCED
) OPTIONS(description='Minor Entity - Contains the possible types of charge point plugin types. - Source - Manual');