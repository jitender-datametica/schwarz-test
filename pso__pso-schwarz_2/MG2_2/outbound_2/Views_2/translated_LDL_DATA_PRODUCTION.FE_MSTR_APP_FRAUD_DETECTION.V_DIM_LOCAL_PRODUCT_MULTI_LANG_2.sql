CREATE OR REPLACE VIEW ldl_data_production_fe_mstr_app_fraud_detection.v_dim_local_product_multi_lang_2
OPTIONS(DESCRIPTION = `THIS DIMENSION CONTAINS THE PROPERTIES OF A PRODUCT, AS THEY ARE DEFINED BY A COUNTRY_2 ORGANIZATION.`)
AS WITH cte_product AS (SELECT org.country_org_sid,
   org.country_org_cd,
   main.prod_sid,
   main.prod_nr,
   main.prod_name,
   main.prod_descr
  FROM ldl_data_production_core_dim.t_dim_product_2 AS main
   INNER JOIN ldl_data_production_core_dim.t_dim_internal_organization_2 AS org ON TRUE
  WHERE main.dwh_valid_fg
   AND org.dwh_valid_fg
   AND org.is_country_org_fg) (SELECT COALESCE(main0.prod_sid, prod.prod_sid) AS prod_sid,
   COALESCE(main0.country_org_sid, prod.country_org_sid) AS country_org_sid,
   COALESCE(main0.country_org_cd, prod.country_org_cd) AS country_org_cd,
   COALESCE(main0.local_prod_nr, prod.prod_nr) AS local_prod_nr,
   COALESCE(main0.local_prod_name, prod.prod_name) AS local_prod_name,
   COALESCE(main0.local_prod_descr, prod.prod_descr) AS local_prod_descr
  FROM cte_product AS prod
   LEFT JOIN ldl_data_production_core_dim.t_dim_local_product_2 AS main0 ON prod.prod_sid = main0.prod_sid AND prod.country_org_sid
       = main0.country_org_sid AND main0.dwh_valid_fg);