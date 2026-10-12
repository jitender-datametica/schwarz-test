/* --------------------------------------------------------------------------------
   DDL for table: T_CHARGE_POINT_CONNECTOR_TYPE_1
   generated from Powerdesigner on Mittwoch, 15. November 2023 09:22:46
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core_rel.t_charge_point_connector_type_1 (
charge_point_connector_type_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The unique code of the connector type.'),
charge_point_connector_type_name STRING(100) NOT NULL
OPTIONS(description='Natural/Business Key - The name of the connector type.'),
charge_point_connector_type_power_meas BIGNUMERIC(38,5) NOT NULL
OPTIONS(description='The power of the connector type in kW.'),
power_type_cd STRING(50) NOT NULL OPTIONS(description='The code for the type of power.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
dwh_src_file_name STRING(500)
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source'),
PRIMARY KEY (charge_point_connector_type_id) NOT ENFORCED
)
OPTIONS(description='Minor Entity - Describes the properties of a charge point like the type of power. - Source - Manual');