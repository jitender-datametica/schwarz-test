CREATE OR REPLACE VIEW ldl_data_production_policies.v_sec_rap_hierarchy_int_org_sid (name, int_org_sid)
OPTIONS(DESCRIPTION = `SECURITY VIEW FOR THE ORGANIZATIONAL HIERARCHY TABLE BASED ON THE INT_ORG_SID COLUMN`) AS SELECT
DISTINCT country.role_name AS name,
 CAST(hierarchy.int_org_sid AS STRING) AS int_org_sid
FROM ldl_data_production_policies.t_sec_rap_core_iso_country_cd AS country
 LEFT JOIN ldl_data_production_policies.t_sec_rap_org_hierarchy AS hierarchy ON country.iso_country_cd = hierarchy.iso_country_cd
  
UNION ALL
SELECT DISTINCT pos.role_name AS name,
 CAST(hierarchy.int_org_sid AS STRING) AS int_org_sid
FROM ldl_data_production_policies.t_sec_rap_core_sales_company_nr AS pos
 LEFT JOIN ldl_data_production_policies.t_sec_rap_org_hierarchy AS hierarchy ON pos.sales_company_nr = hierarchy.sales_company_nr
  
UNION ALL
SELECT DISTINCT acctmngr.login_name_email AS name,
 CAST(hierarchy.int_org_sid AS STRING) AS int_org_sid
FROM ldl_data_production_policies.t_sec_rap_accountmanager AS acctmngr
 INNER JOIN ldl_data_production_policies.t_sec_rap_org_hierarchy AS hierarchy ON acctmngr.acct_mgr_district_sid = CAST(hierarchy.acct_mgr_district_sid AS FLOAT64)
  
UNION ALL
SELECT slsmngr.login_name_email AS name,
 CAST(hierarchy.int_org_sid AS STRING) AS int_org_sid
FROM ldl_data_production_policies.t_sec_rap_salesmanager AS slsmngr
 INNER JOIN ldl_data_production_policies.t_sec_rap_org_hierarchy AS hierarchy ON slsmngr.sales_mgr_district_sid = CAST(hierarchy.sales_mgr_district_sid AS FLOAT64);