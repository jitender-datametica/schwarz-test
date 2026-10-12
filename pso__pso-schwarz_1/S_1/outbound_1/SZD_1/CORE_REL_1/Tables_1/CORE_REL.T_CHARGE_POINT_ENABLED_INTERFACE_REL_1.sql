/* --------------------------------------------------------------------------------
   DDL for table: T_CHARGE_POINT_ENABLED_INTERFACE_REL_1
   generated from Powerdesigner on Mittwoch, 15. November 2023 10:33:17
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core_rel.t_charge_point_enabled_interface_rel_1 (
resource_item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the charge point.'),
roaming_interface_cd STRING(50) NOT NULL OPTIONS(description='The unique code of the roaming interface.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL
OPTIONS(description='An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
dwh_src_file_name STRING(500)
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BYTES storage or the shortened file path'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source'),
PRIMARY KEY (resource_item_sid, roaming_interface_cd, dwh_valid_from_tmsp) NOT ENFORCED
)
OPTIONS(description='Bridge Table - Contains the enabled roaming interfaces of the charge points. - Source IOTCharger');