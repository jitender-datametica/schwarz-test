create or replace view V_SEC_RAP_SF_ROLE_USER_2(
	SF_ENTITY_TYPE,
	SF_ROLE_USER_NAME,
	MSTR_LOGIN_ID,
	ROLE_LEVEL,
	COUNTRY_ISO_CD,
	SALES_COMPANY_NR,
	DELIV_COMPANY_NR,
	ACCOUNT_MANAGER_NR,
	SALES_MANAGER_NR,
	DWH_UPDATED_TMSP
) as 
SELECT 
 'ROLE'    AS SF_ENTITY_TYPE 
,UPPER('snow-xx-ldl-rls-country_2-') || iso_country_cd AS sf_role_user_name 
,'' AS mstr_login_id 
,'COUNTRY_2' AS role_level 
,iso_country_cd AS Country_Iso_cd 
,'' AS Sales_company_nr 
,'' AS deliv_company_nr 
,'' AS account_manager_nr 
,'' AS sales_manager_nr 
,CURRENT_DATE() - 7 AS dwh_updated_tmsp
 FROM core_dim.t_dim_internal_organization_2 org
WHERE dwh_valid_fg 
AND int_org_type_cd = 'COMPANY'
AND is_country_org_fg
AND int_org_status_cd = 'ACTIVE'
UNION ALL
SELECT 
 'ROLE'    AS SF_ENTITY_TYPE 
, UPPER('snow-xx-ldl-rls-company-') || iso_country_cd||'-WH'|| SUBSTR(NVL(sales_company_nr,deliv_company_nr),3)  AS sf_role_user_name 
, '' AS mstr_login_id 
, 'COMPANY' AS role_level 
, iso_country_cd AS Country_Iso_cd 
, sales_company_nr AS Sales_company_nr 
, deliv_company_nr AS deliv_company_nr 
, '' AS account_manager_nr 
, '' AS sales_manager_nr 
, CURRENT_DATE() - 7 AS dwh_updated_tmsp
FROM core_dim.t_dim_internal_organization_2 
WHERE dwh_valid_fg 
AND int_org_type_cd = 'COMPANY'
AND NOT is_country_org_fg 
AND int_org_status_cd = 'ACTIVE'
AND ( sales_company_nr IS NOT NULL OR deliv_company_nr IS NOT NULL)
UNION ALL
SELECT 
  'USER' AS SF_ENTITY_TYPE 
, us.user_name AS SF_ROLE_USER_NAME 
, p.emp_nr AS mstr_login_id 
, INT_ORG_TYPE_CD AS role_level 
, org.country_org_cd AS COUNTRY_ISO_CD  
, org.sales_company_nr AS SALES_COMPANY_NR  
, '' AS deliv_company_nr 
, org.acct_mgr_district_nr AS account_manager_nr 
,'' AS sales_manager_nr 
, org.dwh_updated_tmsp AS dwh_updated_tmsp
FROM core_dim.t_dim_internal_organization_2 org
INNER JOIN meta.t_user_2 us
ON org.acct_mgr_emp_sid = us.emp_sid
INNER JOIN core_rel.t_persON_2 p
ON p.person_sid = us.emp_sid
WHERE org.int_org_type_cd = 'ACCOUNT_MANAGER' 
AND org.dwh_valid_fg
AND p.dwh_valid_fg 
UNION ALL
SELECT 
  'USER' AS SF_ENTITY_TYPE 
, us.user_name AS SF_ROLE_USER_NAME 
, p.emp_nr AS mstr_login_id 
, INT_ORG_TYPE_CD AS role_level 
, org.country_org_cd AS COUNTRY_ISO_CD  
, org.sales_company_nr AS SALES_COMPANY_NR  
, '' AS deliv_company_nr 
, org.acct_mgr_district_nr AS account_manager_nr 
, org.sales_mgr_district_nr AS sales_manager_nr 
, org.dwh_updated_tmsp AS dwh_updated_tmsp
FROM core_dim.t_dim_internal_organizatiON_2 org
INNER JOIN meta.t_user_2 us
ON org.sales_mgr_emp_sid = us.emp_sid
INNER JOIN core_rel.t_persON_2 p
ON p.person_sid = us.emp_sid
WHERE org.int_org_type_cd = 'SALES_MANAGER' 
AND org.dwh_valid_fg
AND p.dwh_valid_fg
;