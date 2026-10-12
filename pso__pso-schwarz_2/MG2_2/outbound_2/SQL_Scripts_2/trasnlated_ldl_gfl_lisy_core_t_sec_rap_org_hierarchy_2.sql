TRUNCATE TABLE ldl_data_production_policies.t_sec_rap_org_hierarchy_2;




INSERT INTO ldl_data_production_policies.t_sec_rap_org_hierarchy_2(country_org_cd,
sales_company_sid,
int_org_sid,
acct_mgr_district_nr,
acct_mgr_district_sid,
sales_mgr_district_nr,
sales_mgr_district_sid,
sales_company_nr,
int_org_type_cd,
curr_int_org_nr)
(SELECT country_2,
  company,
  int_org_sid,
  acct_mgr_district_nr,
  SUBSTR(CAST(acct_mgr_district_sid AS STRING), 1, 250) AS acct_mgr_district_sid,
  sales_mgr_district_nr,
  SUBSTR(CAST(sales_mgr_district_sid AS STRING), 1, 250) AS sales_mgr_district_sid,
  sales_company_nr,
  int_org_type_cd,
  curr_int_org_nr
 FROM (((SELECT DISTINCT country_org_cd AS country_2,
       CAST(sales_company_sid AS STRING) AS company,
       int_org_sid,
       acct_mgr_district_nr,
       acct_mgr_district_sid,
       sales_mgr_district_nr,
       sales_mgr_district_sid,
       sales_company_nr,
       int_org_type_cd,
       curr_int_org_nr
      FROM ldl_data_production_core_dim.t_dim_internal_organization_2
      WHERE dwh_valid_fg
      UNION DISTINCT
      SELECT DISTINCT country_org_cd AS country_2,
       CAST(deliv_company_sid AS STRING) AS company,
       int_org_sid,
       acct_mgr_district_nr,
       acct_mgr_district_sid,
       sales_mgr_district_nr,
       sales_mgr_district_sid,
       sales_company_nr,
       int_org_type_cd,
       curr_int_org_nr
      FROM ldl_data_production_core_dim.t_dim_internal_organization_2
      WHERE dwh_valid_fg)
     UNION DISTINCT
     SELECT DISTINCT country_org_cd AS country_2,
      CAST(bal_sheet_company_sid AS STRING) AS company,
      int_org_sid,
      acct_mgr_district_nr,
      acct_mgr_district_sid,
      sales_mgr_district_nr,
      sales_mgr_district_sid,
      sales_company_nr,
      int_org_type_cd,
      curr_int_org_nr
     FROM ldl_data_production_core_dim.t_dim_internal_organization_2
     WHERE dwh_valid_fg)
    UNION DISTINCT
    SELECT DISTINCT country_org_cd AS country_2,
     CAST(expansion_company_sid AS STRING) AS company,
     int_org_sid,
     acct_mgr_district_nr,
     acct_mgr_district_sid,
     sales_mgr_district_nr,
     sales_mgr_district_sid,
     sales_company_nr,
     int_org_type_cd,
     curr_int_org_nr
    FROM ldl_data_production_core_dim.t_dim_internal_organization_2
    WHERE dwh_valid_fg) AS t11);