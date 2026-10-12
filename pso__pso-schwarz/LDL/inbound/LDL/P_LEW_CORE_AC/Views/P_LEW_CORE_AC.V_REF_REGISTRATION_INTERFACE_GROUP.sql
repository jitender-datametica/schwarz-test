CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_REF_REGISTRATION_INTERFACE_GROUP (
   reg_interface_grp_cd                     COMMENT 'Name code of the registration interface group as defined by Business.'
  ,reg_interface_grp_descr                  COMMENT 'Description of the registration interface group as defined by Business.'
  ,dwh_load_id                              COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.'
  ,dwh_created                              COMMENT 'Creation timestamp of the record in the DWH.'
  ,dwh_updated                              COMMENT 'Timestamp of the last update of the record in the DWH.'
)
COMMENT = 'List of groups of names of the registration interfaces. This table keeps static information based on groups defined by Business.'
AS SELECT
   reg_interface_grp_cd
  ,reg_interface_grp_descr
  ,dwh_load_id
  ,dwh_created
  ,dwh_updated
FROM P_LEW_CORE.T_REF_REGISTRATION_INTERFACE_GROUP
;