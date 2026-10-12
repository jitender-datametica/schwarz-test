CREATE OR REPLACE VIEW ldl_data_production_meta.v_sec_conf_role_level_1 (org_unit_level_name, ressort_name,
business_role_name, idp_container_type_cd, container_name, technical_role_type_cd, idp_role_full_name,
technical_role_name, workforce_id, role_label_description, container_purpose_type_name) AS SELECT cont_role.org_unit_level_name
 ,
 cont_role.ressort_name,
 cont_role.business_role_name,
 cont.idp_container_type_cd,
 cont.container_name,
 cont_role.technical_role_type_cd,
 CONCAT(cont.container_name, cont.container_name_separator, cont_role.technical_role_name) AS idp_role_full_name,
 cont_role.technical_role_name,
 idp_workf.workforce_id,
 cont_role.role_descr AS role_label_description,
 cont.container_purpose_type_name
FROM ldl_data_production_meta.t_sec_conf_components_container_role_1 AS cont_role
 LEFT JOIN ldl_data_production_meta.t_sec_conf_container_1 AS cont ON cont_role.technical_role_type_cd = cont.technical_role_type_cd
  
 LEFT JOIN ldl_data_production_meta.t_sec_conf_idp_role_workforceid_1 AS idp_workf ON UPPER(idp_workf.idp_full_role_name)
  = UPPER(CONCAT(cont.container_name, cont.container_name_separator, cont_role.technical_role_name))
WHERE cont_role.technical_role_type_cd IN ('data policy', 'data security filter', 'func acl', 'func authentification');