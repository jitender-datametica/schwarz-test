// all countries


// all companies


// all stores of accountmanagers belonging to the same company


// all stores of salesmanagers belonging to the same accountmanager


CREATE OR REPLACE VIEW ldl_data_production_policies.v_sec_rap_benchmark_parent_1 (name, parent)
OPTIONS(DESCRIPTION = `SECURITY VIEW FOR THE BENCHMARKING USE CASE OR THE ORGANIZATIONAL HIERARCHY_1 TABLE FOR A SCENARIO WHERE THE COUNTRY_ORG_CD AND THE INT_ORG_SID COLUMNS NEED TO BE COMBINED`)
AS SELECT DISTINCT role_name AS name,
 'INTEGER' AS parent
FROM ldl_data_production_policies.t_sec_rap_core_iso_country_cd_1
UNION ALL
SELECT DISTINCT comp.role_name AS name,
 hierarchy.country_org_cd AS parent
FROM ldl_data_production_policies.t_sec_rap_core_sales_company_nr_1 AS comp
 LEFT JOIN ldl_data_production_policies.t_sec_rap_org_hierarchy_1 AS hierarchy_1 ON comp.sales_company_nr = hierarchy.sales_company_nr
  
UNION ALL
SELECT DISTINCT login_name_email AS name,
 sales_company_nr AS parent
FROM ldl_data_production_policies.t_sec_rap_accountmanager_1
UNION ALL
SELECT DISTINCT slsmgr.login_name_email AS name,
 CAST(acctmgr.acct_mgr_district_name AS STRING) AS parent
FROM ldl_data_production_policies.t_sec_rap_salesmanager_1 AS slsmgr
 LEFT JOIN ldl_data_production_policies.t_sec_rap_accountmanager_1 AS acctmgr ON slsmgr.acct_mgr_district_sid = acctmgr.acct_mgr_district_sid;