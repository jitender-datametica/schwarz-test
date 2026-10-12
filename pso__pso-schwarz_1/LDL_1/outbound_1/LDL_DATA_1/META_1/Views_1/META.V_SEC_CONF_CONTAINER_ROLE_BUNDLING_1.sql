CREATE OR REPLACE VIEW ldl_data_meta.v_sec_conf_container_role_bundling_1 AS WITH CTE_PRE_SELECT_LEVEL AS (SELECT
   CONT_ROLE.org_unit_level_name,
   CONT_ROLE.ressort_name,
   CONT_ROLE.business_role_name,
   CONT.idp_container_type_cd,
   CONT.container_name,
   CONT.container_name_separator,
   CONT_ROLE.technical_role_group_type_cd,
   CONT_ROLE.technical_role_type_cd,
   CONT_ROLE.technical_role_name,
   CONT_ROLE.role_name_separator,
   IDP_WORKF_ROLE.workforce_id,
   CONCAT(CONT.container_name, CONT.container_name_separator, CONT_ROLE.technical_role_name) AS idp_role_full_name,
   CONT.container_purpose_type_name
  FROM ldl_data_meta.t_sec_conf_components_container_role_1 AS CONT_ROLE
   LEFT JOIN ldl_data_meta.t_sec_conf_container_1 AS CONT ON CONT_ROLE.technical_role_type_cd = CONT.technical_role_type_cd
    
   LEFT JOIN ldl_data_meta.t_sec_conf_idp_role_workforceid_1 AS IDP_WORKF_ROLE ON IDP_WORKF_ROLE.idp_full_role_name =
    CONCAT(CONT.container_name, CONT.container_name_separator, CONT_ROLE.technical_role_name)), CTE_PRE_JOIN_LEVEL AS (SELECT
   cont.org_unit_level_name,
   cont.ressort_name,
   cont.business_role_name,
   CONCAT(cont.org_unit_level_name, ' - ', cont.ressort_name, ' - ', cont.business_role_name) AS full_department_name,
   cont.idp_container_type_cd AS l20_idp_container_type_cd,
   cont.container_name AS l20_container_name,
   cont.technical_role_group_type_cd AS l20_technical_role_group_type_cd,
   cont.technical_role_type_cd AS l20_technical_role_type_cd,
   cont.technical_role_name AS l20_technical_role_name,
   cont.idp_role_full_name AS l20_idp_role_full_name,
   cont.workforce_id AS l20_workforce_id,
   cont.container_purpose_type_name AS l20_container_purpose_type_name,
   cont.container_name_separator,
   cont_role.idp_container_type_cd AS l10_idp_container_type_cd,
   cont_role.technical_role_group_type_cd AS l10_technical_role_group_type_cd,
   cont_role.technical_role_type_cd AS l10_technical_role_type_cd,
   cont_role.technical_role_name AS l10_technical_role_name,
   cont_role.idp_role_full_name AS l10_idp_role_full_name,
   cont_role.workforce_id AS l10_workforce_id,
   cont_role.container_purpose_type_name AS l10_container_purpose_type_name,
   cont_role.role_name_separator
  FROM (SELECT *
    FROM CTE_PRE_SELECT_LEVEL) AS cont_role
   LEFT JOIN (SELECT *
    FROM CTE_PRE_SELECT_LEVEL) AS cont ON cont_role.org_unit_level_name = cont.org_unit_level_name AND (cont_role.ressort_name
          = cont.ressort_name OR cont_role.ressort_name = '*') AND (cont_role.business_role_name = cont.business_role_name
         OR cont_role.business_role_name = '*') AND cont_role.technical_role_group_type_cd = cont.technical_role_group_type_cd
     
  WHERE cont_role.technical_role_type_cd IN ('func authentification', 'func acl')) (SELECT *
  FROM (SELECT *
     FROM CTE_PRE_JOIN_LEVEL
     UNION ALL
     SELECT *
     FROM CTE_PRE_JOIN_LEVEL
     UNION ALL
     SELECT *
     FROM CTE_PRE_JOIN_LEVEL
     UNION ALL
     SELECT *
     FROM CTE_PRE_JOIN_LEVEL
     UNION ALL
     SELECT *
     FROM CTE_PRE_JOIN_LEVEL
     UNION ALL
     SELECT *
     FROM CTE_PRE_JOIN_LEVEL));