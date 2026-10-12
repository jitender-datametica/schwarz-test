CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku.mv_retail_company (ext_retail_company_id, ext_system_name,
mandant_id, retail_company_code, retail_company_name, competitor_fg, sec_kz) AS SELECT V01.ext_retail_company_id,
 V01.ext_system_name,
 V01.mandant_id,
 V01.retail_company_code,
 V01.retail_company_name,
 V01.competitor_fg,
 2 AS sec_kz
FROM kfl_production_dbp_view.v_retail_company AS V01
 INNER JOIN (SELECT V21.ext_retail_company_id
  FROM kfl_production_dbp_view.v_retail_store AS V21
   INNER JOIN kfl_production_dbp_view.v_retail_store_distance AS V22 ON V21.ext_store_id = V22.ext_store_id
  GROUP BY V21.ext_retail_company_id) AS v02 ON V01.ext_retail_company_id = v02.ext_retail_company_id;