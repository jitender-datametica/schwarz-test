CREATE OR REPLACE VIEW ldl_data_meta.v_sec_conf_role_level AS SELECT CONT_ROLE.org_unit_level_name,
 CONT_ROLE.ressort_name,
 CONT_ROLE.business_role_name,
 CONT.idp_container_type_cd,
 CONT.container_name,
 CONT_ROLE.technical_role_type_cd,
 CONCAT(CONT.container_name, CONT.container_name_separator, CONT_ROLE.technical_role_name) AS idp_role_full_name,
 CONT_ROLE.technical_role_name,
 IDP_WORKF.workforce_id,
 CONT_ROLE.role_descr AS role_label_description,
 CONT.container_purpose_type_name
FROM ldl_data_meta.t_sec_conf_components_container_role AS CONT_ROLE
 LEFT JOIN ldl_data_meta.t_sec_conf_container AS CONT ON CONT_ROLE.technical_role_type_cd = CONT.technical_role_type_cd
 LEFT JOIN ldl_data_meta.t_sec_conf_idp_role_workforceid AS IDP_WORKF ON UPPER(IDP_WORKF.idp_full_role_name) = UPPER(CONCAT(CONT
    .container_name, CONT.container_name_separator, CONT_ROLE.technical_role_name))
WHERE CONT_ROLE.technical_role_type_cd IN ('data policy', 'data security filter', 'func acl', 'func authentification');