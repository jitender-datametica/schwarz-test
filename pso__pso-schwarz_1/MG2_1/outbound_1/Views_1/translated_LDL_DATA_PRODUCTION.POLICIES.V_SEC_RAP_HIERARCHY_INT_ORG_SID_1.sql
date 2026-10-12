CREATE OR REPLACE VIEW ldl_data_production_policies.v_sec_rap_hierarchy_int_org_sid_1 (name, int_org_sid)
OPTIONS(DESCRIPTION = `SECURITY VIEW FOR THE ORGANIZATIONAL HIERARCHY_1 TABLE BASED ON THE INT_ORG_SID COLUMN`) AS SELECT
DISTINCT country.role_name AS name,
 CAST(hierarchy.int_org_sid AS STRING) AS int_org_sid
FROM ldl_data_production_policies.t_sec_rap_core_iso_country_cd_1 AS country_1
 LEFT JOIN ldl_data_production_policies.t_sec_rap_org_hierarchy_1 AS hierarchy_1 ON country.iso_country_cd = hierarchy.iso_country_cd
  
UNION ALL
SELECT DISTINCT pos.role_name AS name,
 CAST(hierarchy.int_org_sid AS STRING) AS int_org_sid
FROM ldl_data_production_policies.t_sec_rap_core_sales_company_nr_1 AS pos
 LEFT JOIN ldl_data_production_policies.t_sec_rap_org_hierarchy_1 AS hierarchy_1 ON pos.sales_company_nr = hierarchy.sales_company_nr
  
UNION ALL
SELECT DISTINCT acctmngr.login_name_email AS name,
 CAST(hierarchy.int_org_sid AS STRING) AS int_org_sid
FROM ldl_data_production_policies.t_sec_rap_accountmanager_1 AS acctmngr
 INNER JOIN ldl_data_production_policies.t_sec_rap_org_hierarchy_1 AS hierarchy_1 ON acctmngr.acct_mgr_district_sid = CAST(hierarchy.acct_mgr_district_sid AS FLOAT64)
  
UNION ALL
SELECT slsmngr.login_name_email AS name,
 CAST(hierarchy.int_org_sid AS STRING) AS int_org_sid
FROM ldl_data_production_policies.t_sec_rap_salesmanager_1 AS slsmngr
 INNER JOIN ldl_data_production_policies.t_sec_rap_org_hierarchy_1 AS hierarchy_1 ON slsmngr.sales_mgr_district_sid = CAST(hierarchy.sales_mgr_district_sid AS FLOAT64);