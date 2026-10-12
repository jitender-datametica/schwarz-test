CREATE OR REPLACE VIEW ldl_data_meta.v_sec_rap_sf_role_user_1 (sf_entity_type, sf_role_user_name, mstr_login_id,
role_level, country_iso_cd, sales_company_nr, deliv_company_nr, account_manager_nr, sales_manager_nr, dwh_updated_tmsp)
AS SELECT 'ROLE' AS sf_entity_type,
  UPPER('snow-xx-ldl-rls-country_1-') || iso_country_cd AS sf_role_user_name,
 '' AS mstr_login_id,
 'COUNTRY_1' AS role_level,
 iso_country_cd AS country_iso_cd,
 '' AS sales_company_nr,
 '' AS deliv_company_nr,
 '' AS account_manager_nr,
 '' AS sales_manager_nr,
 DATE_SUB(CURRENT_DATE, INTERVAL 7 DAY) AS dwh_updated_tmsp
FROM ldl_data_core_dim.t_dim_internal_organization_1 AS ORG
WHERE dwh_valid_fg
 AND int_org_type_cd = 'COMPANY'
 AND is_country_org_fg
 AND int_org_status_cd = 'ACTIVE'
UNION ALL
SELECT 'ROLE' AS sf_entity_type,
    UPPER('snow-xx-ldl-rls-company-') || iso_country_cd || '-WH' || SUBSTR(IFNULL(sales_company_nr, deliv_company_nr), 3
   ) AS sf_role_user_name,
 '' AS mstr_login_id,
 'COMPANY' AS role_level,
 iso_country_cd AS country_iso_cd,
 sales_company_nr,
 deliv_company_nr,
 '' AS account_manager_nr,
 '' AS sales_manager_nr,
 DATE_SUB(CURRENT_DATE, INTERVAL 7 DAY) AS dwh_updated_tmsp
FROM ldl_data_core_dim.t_dim_internal_organization_1
WHERE dwh_valid_fg
 AND int_org_type_cd = 'COMPANY'
 AND int_org_status_cd = 'ACTIVE'
 AND (sales_company_nr IS NOT NULL OR deliv_company_nr IS NOT NULL)
 AND NOT is_country_org_fg
UNION ALL
SELECT 'USER' AS sf_entity_type,
 US.user_name AS sf_role_user_name,
 P.emp_nr AS mstr_login_id,
 ORG.int_org_type_cd AS role_level,
 ORG.country_org_cd AS country_iso_cd,
 ORG.sales_company_nr,
 '' AS deliv_company_nr,
 ORG.acct_mgr_district_nr AS account_manager_nr,
 '' AS sales_manager_nr,
 CAST(ORG.dwh_updated_tmsp AS DATE) AS dwh_updated_tmsp
FROM ldl_data_core_dim.t_dim_internal_organization_1 AS ORG
 INNER JOIN ldl_data_meta.t_user_1 AS US ON ORG.acct_mgr_emp_sid = US.emp_sid
 INNER JOIN ldl_data_core_rel.t_person_1 AS P ON US.emp_sid = P.person_sid
WHERE ORG.int_org_type_cd = 'ACCOUNT_MANAGER'
 AND ORG.dwh_valid_fg
 AND P.dwh_valid_fg
UNION ALL
SELECT 'USER' AS sf_entity_type,
 US.user_name AS sf_role_user_name,
 P.emp_nr AS mstr_login_id,
 ORG.int_org_type_cd AS role_level,
 ORG.country_org_cd AS country_iso_cd,
 ORG.sales_company_nr,
 '' AS deliv_company_nr,
 ORG.acct_mgr_district_nr AS account_manager_nr,
 ORG.sales_mgr_district_nr AS sales_manager_nr,
 CAST(ORG.dwh_updated_tmsp AS DATE) AS dwh_updated_tmsp
FROM ldl_data_core_dim.t_dim_internal_organization_1 AS ORG
 INNER JOIN ldl_data_meta.t_user_1 AS US ON ORG.sales_mgr_emp_sid = US.emp_sid
 INNER JOIN ldl_data_core_rel.t_person_1 AS P ON US.emp_sid = P.person_sid
WHERE ORG.int_org_type_cd = 'SALES_MANAGER'
 AND ORG.dwh_valid_fg
 AND P.dwh_valid_fg;