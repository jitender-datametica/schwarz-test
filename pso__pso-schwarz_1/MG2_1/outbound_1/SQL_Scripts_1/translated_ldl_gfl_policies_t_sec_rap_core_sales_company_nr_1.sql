TRUNCATE TABLE ldl_data_production_policies.t_sec_rap_core_sales_company_nr_1;


INSERT INTO ldl_data_production_policies.t_sec_rap_core_sales_company_nr_1 (role_name, sales_company_nr)
(SELECT 'SNOW-XX-LDL-RLS-COMPANY-' || SUBSTR(sales_company_nr, 1, 2) || '-WH' || SUBSTR(sales_company_nr, 3) AS
  role_name,
  sales_company_nr
 FROM ldl_data_production_core_dim.t_dim_internal_organization_1
 WHERE dwh_valid_fg
  AND is_sales_company_fg
 GROUP BY role_name,
  sales_company_nr);