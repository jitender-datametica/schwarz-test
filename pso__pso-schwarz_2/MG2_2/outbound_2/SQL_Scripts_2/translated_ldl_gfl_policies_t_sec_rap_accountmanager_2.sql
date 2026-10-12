TRUNCATE TABLE ldl_data_production_policies.t_sec_rap_accountmanager_2;


INSERT INTO ldl_data_production_policies.t_sec_rap_accountmanager_2 (acct_mgr_district_sid, acct_mgr_district_nr,
 acct_mgr_district_name, sales_company_nr, iso_country_cd, benchmark_type_id, login_name_email)
(SELECT int_org.acct_mgr_district_sid,
  int_org.acct_mgr_district_nr,
  int_org.acct_mgr_district_name,
  int_org.sales_company_nr,
  int_org.iso_country_cd,
  CAST(bench_type.benchmarking_type_id AS INTEGER) AS benchmark_type_id,
  u.user_name AS login_name_email
 FROM (SELECT acct_mgr_district_sid,
    acct_mgr_district_nr,
    acct_mgr_district_name,
    acct_mgr_emp_sid,
    sales_company_nr,
    iso_country_cd,
    int_org_type_cd,
    int_org_sid
   FROM ldl_data_production_core_dim.t_dim_internal_organization_2
   WHERE dwh_valid_fg
    AND int_org_type_cd = 'ACCOUNT_MANAGER'
    AND acct_mgr_emp_sid <> - 1) AS int_org
  LEFT JOIN ldl_data_production_core_dim.t_dim_benchmarking_type_2 AS bench_type ON bench_type.benchmarking_type_id = 3
  LEFT JOIN ldl_data_production_meta.t_user_2 AS u ON int_org.acct_mgr_emp_sid = u.emp_sid);