/* --------------------------------------------------------------------------------
   DDL for table: t_ref_registration_interface_group_1
   generated from Powerdesigner on Mittwoch, 16. Juli 2025 11:29:45
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_registration_interface_group_1 (
reg_interface_grp_cd STRING(100) NOT NULL
OPTIONS(description='Name code of the registration interface group as defined by Business.'),
reg_interface_grp_descr STRING(250)
OPTIONS(description='Description of the registration interface group as defined by Business.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (reg_interface_grp_cd) NOT ENFORCED
)
OPTIONS(description='List of groups of names of the registration interfaces. This table keeps static information based on groups defined by Business.');