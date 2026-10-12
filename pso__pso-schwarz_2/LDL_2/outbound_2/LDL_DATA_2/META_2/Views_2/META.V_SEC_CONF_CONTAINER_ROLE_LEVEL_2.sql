CREATE OR REPLACE VIEW ldl_data_meta.v_sec_conf_container_role_level_2 AS SELECT CONT_ROLE.org_unit_level_name,
 CONT_ROLE.ressort_name,
 CONT_ROLE.business_role_name,
 CONT.idp_container_type_cd,
 CONT.container_name,
 CONT_ROLE.technical_role_type_cd,
 CONCAT(CONT.container_name, CONT.container_name_separator, CONT_ROLE.technical_role_name) AS idp_role_full_name,
 CONT_ROLE.technical_role_name,
 IDP_WORKF.workforce_id,
 CONT_ROLE.role_descr AS role_label_description
FROM ldl_data_meta.t_sec_conf_components_container_role_2 AS CONT_ROLE
 LEFT JOIN ldl_data_meta.t_sec_conf_container_2 AS CONT ON CONT_ROLE.technical_role_type_cd = CONT.technical_role_type_cd
 LEFT JOIN ldl_data_meta.t_sec_conf_idp_role_workforceid_2 AS IDP_WORKF ON IDP_WORKF.idp_full_role_name = CONCAT(CONT.container_name
   , CONT.container_name_separator, CONT_ROLE.technical_role_name)
WHERE CONT.technical_role_type_cd IN ('container data', 'container func');