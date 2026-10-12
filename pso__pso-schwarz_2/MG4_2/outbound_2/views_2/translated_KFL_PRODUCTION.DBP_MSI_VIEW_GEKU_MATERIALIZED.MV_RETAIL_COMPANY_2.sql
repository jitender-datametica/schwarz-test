CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku_materialized.mv_retail_company_2 (ext_retail_company_id,
ext_system_name, mandant_id, retail_company_code, retail_company_name, competitor_fg, sec_kz) AS SELECT v01.ext_retail_company_id
 ,
 v01.ext_system_name,
 v01.mandant_id,
 v01.retail_company_code,
 v01.retail_company_name,
 v01.competitor_fg,
 2 AS sec_kz
FROM kfl_production_dbp_view.v_retail_company_2 AS v01
 INNER JOIN (SELECT v21.ext_retail_company_id
  FROM kfl_production_dbp_view.v_retail_store_2 AS v21
   INNER JOIN kfl_production_dbp_view.v_retail_store_distance_2 AS v22 ON v21.ext_store_id = v22.ext_store_id
  GROUP BY v21.ext_retail_company_id) AS v02 ON v01.ext_retail_company_id = v02.ext_retail_company_id;