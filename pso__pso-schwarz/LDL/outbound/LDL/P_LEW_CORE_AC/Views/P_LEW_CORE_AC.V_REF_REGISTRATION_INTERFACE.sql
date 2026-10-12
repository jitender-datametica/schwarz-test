CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_ref_registration_interface (reg_interface_name
OPTIONS(description='''Name of the interface through which the user registered or reregistered for the geographical area in the loyalty program by accepting the legal terms the first time.
A registration or reregistration happens if a customer accepts the legal terms for the first time either at all (initial registration) or after a decline which follows a former registration (reregistration).'''),
reg_interface_descr
OPTIONS(description='''Description of the interface through which the user registered or reregistered for the geographical area in the loyalty program by accepting the legal terms the first time.
A registration or reregistration happens if a customer accepts the legal terms for the first time either at all (initial registration) or after a decline which follows a former registration (reregistration).'''),
reg_interface_grp_cd OPTIONS(description='Name code of the registration interface group as defined by Business.'),
dwh_load_id
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created OPTIONS(description='Creation timestamp of the record in the DWH.'), dwh_updated
OPTIONS(description='Timestamp of the last update of the record in the DWH.'))
OPTIONS(DESCRIPTION = '''List of names of the interfaces through which the user registered or reregistered for the geographical area in the loyalty program by accepting the legal terms the first time.
A registration or reregistration happens if a customer accepts the legal terms for the first time either at all (initial registration) or after a decline which follows a former registration (reregistration).''')
AS SELECT reg_interface_name,
 reg_interface_descr,
 reg_interface_grp_cd,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_ref_registration_interface;