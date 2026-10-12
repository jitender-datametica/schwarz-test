/* L20 Role Attributes */


/* L10 Role Attributes */


/* L10 Roles Filter */


/* L20 Container Roles Filter */


-- '*' including passthrough roles


-- '*' including passthrough roles


/* func authentification, func acl */


/* L20 Role Attributes */


/* L10 Role Attributes */


/* data security filter - seperate select statement per ORG_UNIT_LEVEL_NAME due to different join conditions */


/* L20 Role Attributes */


/* L10 Role Attributes */


/* L20 Role Attributes */


/* L10 Role Attributes */


/* L20 Role Attributes */


/* L10 Role Attributes */


/* data policy - seperate select statement per ORG_UNIT_LEVEL_NAME due to different join conditions */


/* L20 Role Attributes */


/* L10 Role Attributes */


/* L20 Role Attributes */


/* L10 Role Attributes */


CREATE OR REPLACE VIEW ldl_data_production_meta.v_sec_conf_container_role_bundling_1 AS WITH cte_pre_select_level AS (SELECT
   cont_role.org_unit_level_name,
   cont_role.ressort_name,
   cont_role.business_role_name,
   cont.idp_container_type_cd,
   cont.container_name,
   cont.container_name_separator,
   cont_role.technical_role_group_type_cd,
   cont_role.technical_role_type_cd,
   cont_role.technical_role_name,
   cont_role.role_name_separator,
   idp_workf_role.workforce_id,
   CONCAT(cont.container_name, cont.container_name_separator, cont_role.technical_role_name) AS idp_role_full_name,
   cont.container_purpose_type_name
  FROM ldl_data_production_meta.t_sec_conf_components_container_role_1 AS cont_role
   LEFT JOIN ldl_data_production_meta.t_sec_conf_container_1 AS cont ON cont_role.technical_role_type_cd = cont.technical_role_type_cd
    
   LEFT JOIN ldl_data_production_meta.t_sec_conf_idp_role_workforceid_1 AS idp_workf_role ON idp_workf_role.idp_full_role_name
     = CONCAT(cont.container_name, cont.container_name_separator, cont_role.technical_role_name)), cte_pre_join_level AS
  (SELECT cont.org_unit_level_name,
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
    FROM cte_pre_select_level) AS cont_role
   LEFT JOIN (SELECT *
    FROM cte_pre_select_level) AS cont ON cont_role.org_unit_level_name = cont.org_unit_level_name AND (cont_role.ressort_name
          = cont.ressort_name OR cont_role.ressort_name = '*') AND (cont_role.business_role_name = cont.business_role_name
         OR cont_role.business_role_name = '*') AND cont_role.technical_role_group_type_cd = cont.technical_role_group_type_cd
     
  WHERE cont_role.technical_role_type_cd IN ('func authentification', 'func acl')) (SELECT *
  FROM (SELECT *
     FROM cte_pre_join_level
     UNION ALL
     SELECT *
     FROM cte_pre_join_level
     UNION ALL
     SELECT *
     FROM cte_pre_join_level
     UNION ALL
     SELECT *
     FROM cte_pre_join_level
     UNION ALL
     SELECT *
     FROM cte_pre_join_level
     UNION ALL
     SELECT *
     FROM cte_pre_join_level));