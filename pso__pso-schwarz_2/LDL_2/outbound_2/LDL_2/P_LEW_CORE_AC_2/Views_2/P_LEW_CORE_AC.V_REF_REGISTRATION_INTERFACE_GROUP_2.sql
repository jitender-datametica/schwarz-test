CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_ref_registration_interface_group_2 (reg_interface_grp_cd
OPTIONS(description='Name code of the registration interface group as defined by Business.'), reg_interface_grp_descr
OPTIONS(description='Description of the registration interface group as defined by Business.'), dwh_load_id
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created OPTIONS(description='Creation timestamp of the record in the DWH.'), dwh_updated
OPTIONS(description='Timestamp of the last update of the record in the DWH.'))
OPTIONS(DESCRIPTION = `LIST OF GROUPS OF NAMES OF THE REGISTRATION INTERFACES. THIS TABLE KEEPS STATIC INFORMATION BASED ON GROUPS DEFINED BY BUSINESS.`)
AS SELECT reg_interface_grp_cd,
 reg_interface_grp_descr,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_ref_registration_interface_group_2;