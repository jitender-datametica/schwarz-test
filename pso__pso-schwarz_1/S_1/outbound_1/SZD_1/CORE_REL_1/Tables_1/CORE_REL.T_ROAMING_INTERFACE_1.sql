/* --------------------------------------------------------------------------------
   DDL for table: T_ROAMING_INTERFACE_1
   generated from Powerdesigner on Dienstag, 14. November 2023 11:15:00
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core_rel.t_roaming_interface_1 (
roaming_interface_cd STRING(50) NOT NULL OPTIONS(description='The unique code of the roaming interface.'),
roaming_interface_descr STRING(250) NOT NULL OPTIONS(description='A brief description of the roaming interface.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
dwh_src_file_name STRING(500)
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source'),
PRIMARY KEY (roaming_interface_cd) NOT ENFORCED
)
OPTIONS(description='Minor Entity - The roaming interface determines the type of billing between two different providers (e.g. Lidl and Kaufland). - Source - Manual');