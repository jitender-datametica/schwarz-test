CREATE OR REPLACE VIEW ldl_data_production_policies.v_sec_rap_iso_country_cd__int_org_sid_1 (name, iso_country_cd,
int_org_sid) AS SELECT DISTINCT CAST(country.role_name AS STRING) AS name,
 CAST(country.iso_country_cd AS STRING) AS iso_country_cd,
 CAST(hierarchy.int_org_sid AS STRING) AS int_org_sid
FROM ldl_data_production_policies.t_sec_rap_core_iso_country_cd_1 AS country_1
 INNER JOIN ldl_data_production_policies.t_sec_rap_org_hierarchy_1 AS hierarchy_1 ON country.iso_country_cd = hierarchy.iso_country_cd
  
UNION ALL
SELECT DISTINCT CAST(company.role_name AS STRING) AS name,
 CAST(hierarchy.iso_country_cd AS STRING) AS iso_country_cd,
 CAST(hierarchy.int_org_sid AS STRING) AS int_org_sid
FROM ldl_data_production_policies.t_sec_rap_core_sales_company_nr_1 AS company
 INNER JOIN ldl_data_production_policies.t_sec_rap_org_hierarchy_1 AS hierarchy_1 ON company.sales_company_nr = hierarchy.sales_company_nr
  
UNION ALL
SELECT DISTINCT CAST(acctmgr.login_name_email AS STRING) AS name,
 CAST(acctmgr.iso_country_cd AS STRING) AS iso_country_cd,
 CAST(hierarchy.int_org_sid AS STRING) AS int_org_sid
FROM ldl_data_production_policies.t_sec_rap_accountmanager_1 AS acctmgr
 LEFT JOIN ldl_data_production_policies.t_sec_rap_org_hierarchy_1 AS hierarchy_1 ON acctmgr.acct_mgr_district_nr = hierarchy_1
  .acct_mgr_district_nr
UNION ALL
SELECT DISTINCT CAST(slsmgr.login_name_email AS STRING) AS name,
 CAST(slsmgr.iso_country_cd AS STRING) AS country_value,
 CAST(hierarchy.int_org_sid AS STRING) AS int_org_sid
FROM ldl_data_production_policies.t_sec_rap_salesmanager_1 AS slsmgr
 INNER JOIN ldl_data_production_policies.t_sec_rap_org_hierarchy_1 AS hierarchy_1 ON slsmgr.sales_mgr_district_sid = CAST(hierarchy.sales_mgr_district_sid AS FLOAT64)
  
WHERE hierarchy.int_org_type_cd = 'STORE';