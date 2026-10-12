/* Updated on 2025-03-25 */
--DELETE FROM LDL_DATA_PRODUCTION.POLICIES.T_SEC_RAP_ORG_HIERARCHY;




INSERT INTO ldl_data_production_policies.t_sec_rap_org_hierarchy (iso_country_cd, sales_company_sid, int_org_sid,
 acct_mgr_district_nr, acct_mgr_district_sid, sales_mgr_district_nr, sales_mgr_district_sid, sales_company_nr,
 int_org_type_cd, curr_int_org_nr, country_org_cd)
(SELECT DISTINCT iso_country_cd,
  CAST(sales_company_sid AS STRING),
  int_org_sid,
  acct_mgr_district_nr,
  SUBSTR(CAST(acct_mgr_district_sid AS STRING), 1, 250) AS acct_mgr_district_sid,
  sales_mgr_district_nr,
  SUBSTR(CAST(sales_mgr_district_sid AS STRING), 1, 250) AS sales_mgr_district_sid,
  sales_company_nr,
  int_org_type_cd,
  curr_int_org_nr,
  country_org_cd
 FROM ldl_data_production_core_dim.t_dim_internal_organization
 WHERE dwh_valid_fg);