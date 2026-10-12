CREATE OR REPLACE VIEW ldl_data_meta.v_sec_conf_filter_predicate_params_1 (sf_role_user_name, predicate_param_name, value
, value_type, conf_tmsp) AS SELECT DISTINCT MAIN.sf_role_user_name,
 PT.predicate_param_name,
  CASE
  WHEN PT.predicate_param_name = 'acc_mgr_nr'
  THEN CAST(MAIN.account_manager_nr AS STRING)
  WHEN PT.predicate_param_name = 'bench_std'
  THEN '1'
  WHEN PT.predicate_param_name = 'bench_type'
  THEN CASE
   WHEN MAIN.role_level = 'SALES_MANAGER'
   THEN '2'
   WHEN MAIN.role_level = 'ACCOUNT_MANAGER'
   THEN '3'
   WHEN MAIN.role_level = 'COMPANY'
   THEN '4'
   WHEN MAIN.role_level = 'REGION_1'
   THEN '5'
   WHEN MAIN.role_level = 'COUNTRY_1'
   THEN '6'
   ELSE '7'
   END
  WHEN PT.predicate_param_name = 'country_iso'
  THEN CAST(MAIN.country_iso_cd AS STRING)
  WHEN PT.predicate_param_name = 'deliv_company_nr'
  THEN CAST(MAIN.deliv_company_nr AS STRING)
  WHEN PT.predicate_param_name = 'sales_company_nr'
  THEN CAST(MAIN.sales_company_nr AS STRING)
  WHEN PT.predicate_param_name = 'sales_mgr_nr'
  THEN CAST(MAIN.sales_manager_nr AS STRING)
  ELSE NULL
  END AS value,
  CASE
  WHEN PT.predicate_param_name = 'bench_std'
  THEN 'INT32'
  WHEN PT.predicate_param_name = 'bench_type'
  THEN 'INT32'
  ELSE 'STRING'
  END AS value_type,
 MAIN.dwh_updated_tmsp AS conf_tmsp
FROM ldl_data_meta.v_sec_rap_sf_role_user_1 AS MAIN
 INNER JOIN ldl_data_meta.t_sec_conf_predicate_parameter_1 AS PT ON TRUE
WHERE CASE
   WHEN PT.predicate_param_name = 'acc_mgr_nr'
   THEN CAST(MAIN.account_manager_nr AS STRING)
   WHEN PT.predicate_param_name = 'bench_std'
   THEN '1'
   WHEN PT.predicate_param_name = 'bench_type'
   THEN CASE
    WHEN MAIN.role_level = 'SALES_MANAGER'
    THEN '2'
    WHEN MAIN.role_level = 'ACCOUNT_MANAGER'
    THEN '3'
    WHEN MAIN.role_level = 'COMPANY'
    THEN '4'
    WHEN MAIN.role_level = 'REGION_1'
    THEN '5'
    WHEN MAIN.role_level = 'COUNTRY_1'
    THEN '6'
    ELSE '7'
    END
   WHEN PT.predicate_param_name = 'country_iso'
   THEN CAST(MAIN.country_iso_cd AS STRING)
   WHEN PT.predicate_param_name = 'deliv_company_nr'
   THEN CAST(MAIN.deliv_company_nr AS STRING)
   WHEN PT.predicate_param_name = 'sales_company_nr'
   THEN CAST(MAIN.sales_company_nr AS STRING)
   WHEN PT.predicate_param_name = 'sales_mgr_nr'
   THEN CAST(MAIN.sales_manager_nr AS STRING)
   ELSE NULL
   END <> '';