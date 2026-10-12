CREATE OR REPLACE VIEW ldl_data_production_policies.v_sec_rap_country_org_cd__int_org_sid (name, country_org_cd,
int_org_sid)
OPTIONS(DESCRIPTION = `SECURITY VIEW FOR THE STANDARD USE CASE FOR A SCENARIO WHERE THE COUNTRY_ORG_CD AND THE INT_ORG_SID COLUMNS NEED TO BE COMBINED`)
AS SELECT DISTINCT CAST(country.role_name AS STRING) AS name,
 CAST(hierarchy.country_org_cd AS STRING) AS country_org_cd,
 CAST(hierarchy.int_org_sid AS STRING) AS int_org_sid
FROM ldl_data_production_policies.t_sec_rap_core_iso_country_cd AS country
 INNER JOIN ldl_data_production_policies.t_sec_rap_org_hierarchy AS hierarchy ON country.iso_country_cd = hierarchy.iso_country_cd
  
UNION ALL
SELECT DISTINCT CAST(company.role_name AS STRING) AS name,
 CAST(hierarchy.country_org_cd AS STRING) AS country_org_cd,
 CAST(hierarchy.int_org_sid AS STRING) AS int_org_sid
FROM ldl_data_production_policies.t_sec_rap_core_sales_company_nr AS company
 INNER JOIN ldl_data_production_policies.t_sec_rap_org_hierarchy AS hierarchy ON company.sales_company_nr = hierarchy.sales_company_nr
  
UNION ALL
SELECT DISTINCT CAST(acctmgr.login_name_email AS STRING) AS name,
 CAST(hierarchy.country_org_cd AS STRING) AS country_org_cd,
 CAST(hierarchy.int_org_sid AS STRING) AS int_org_sid
FROM ldl_data_production_policies.t_sec_rap_accountmanager AS acctmgr
 LEFT JOIN ldl_data_production_policies.t_sec_rap_org_hierarchy AS hierarchy ON acctmgr.acct_mgr_district_nr = hierarchy
  .acct_mgr_district_nr
UNION ALL
SELECT DISTINCT CAST(slsmgr.login_name_email AS STRING) AS name,
 CAST(hierarchy.country_org_cd AS STRING) AS country_value,
 CAST(hierarchy.int_org_sid AS STRING) AS int_org_sid
FROM ldl_data_production_policies.t_sec_rap_salesmanager AS slsmgr
 INNER JOIN ldl_data_production_policies.t_sec_rap_org_hierarchy AS hierarchy ON slsmgr.sales_mgr_district_sid = CAST(hierarchy.sales_mgr_district_sid AS FLOAT64)
  
WHERE hierarchy.int_org_type_cd = 'STORE';