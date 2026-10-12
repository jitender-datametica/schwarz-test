CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_REF_REGISTRATION_INTERFACE_2 (
   reg_interface_name                       COMMENT 'Name of the interface through which the user registered or reregistered for the geographical area in the loyalty program by accepting the legal terms the first time.
A registration or reregistration happens if a customer accepts the legal terms for the first time either at all (initial registration) or after a decline which follows a former registration (reregistration).'
  ,reg_interface_descr                      COMMENT 'Description of the interface through which the user registered or reregistered for the geographical area in the loyalty program by accepting the legal terms the first time.
A registration or reregistration happens if a customer accepts the legal terms for the first time either at all (initial registration) or after a decline which follows a former registration (reregistration).'
  ,reg_interface_grp_cd                     COMMENT 'Name code of the registration interface group as defined by Business.'
  ,dwh_load_id                              COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.'
  ,dwh_created                              COMMENT 'Creation timestamp of the record in the DWH.'
  ,dwh_updated                              COMMENT 'Timestamp of the last update of the record in the DWH.'
)
COMMENT = 'List of names of the interfaces through which the user registered or reregistered for the geographical area in the loyalty program by accepting the legal terms the first time.
A registration or reregistration happens if a customer accepts the legal terms for the first time either at all (initial registration) or after a decline which follows a former registration (reregistration).'
AS SELECT
   reg_interface_name
  ,reg_interface_descr
  ,reg_interface_grp_cd
  ,dwh_load_id
  ,dwh_created
  ,dwh_updated
FROM P_LEW_CORE.T_REF_REGISTRATION_INTERFACE_2
;