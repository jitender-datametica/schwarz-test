CREATE OR REPLACE VIEW FE_MSTR_LIFECYCLE.MV_L_LIFECYCLE_RVM_COMPANY
AS SELECT 
  core.t_dim_company.company_id
 ,core.t_dim_company.company_name
 ,core.t_dim_company.country_pol_cd
 ,core.t_dim_company.street_name
 ,core.t_dim_company.lob_cd
 ,core.t_dim_company.house_nr
 ,core.t_dim_company.city_name
 ,core.t_dim_company.zip
FROM 
core.t_dim_company
;