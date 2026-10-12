/* --------------------------------------------------------------------------------
   DDL for table: t_ref_registration_interface_1
   generated from Powerdesigner on Mittwoch, 16. Juli 2025 11:30:53
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_registration_interface_1 (
reg_interface_name STRING(100) NOT NULL
OPTIONS(description='Name of the interface through which the user registered or reregistered for the geographical area in the loyalty program by accepting the legal terms the first time.            A registration or reregistration happens if a customer accepts the legal terms for the first time either at all (initial registration) or after a decline which follows a former registration (reregistration).'),
reg_interface_descr STRING(250)
OPTIONS(description='Description of the interface through which the user registered or reregistered for the geographical area in the loyalty program by accepting the legal terms the first time.            A registration or reregistration happens if a customer accepts the legal terms for the first time either at all (initial registration) or after a decline which follows a former registration (reregistration).'),
reg_interface_grp_cd STRING(100)
OPTIONS(description='Name code of the registration interface group as defined by Business.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (reg_interface_name) NOT ENFORCED
)
OPTIONS(description='List of names of the interfaces through which the user registered or reregistered for the geographical area in the loyalty program by accepting the legal terms the first time.             A registration or reregistration happens if a customer accepts the legal terms for the first time either at all (initial registration) or after a decline which follows a former registration (reregistration).');