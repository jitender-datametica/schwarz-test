CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku_materialized.mv_retail_store_2 (ext_store_id, mandant_id,
ext_system_name, retail_store_name, retail_store_address, breitengrad, laengengrad, ext_retail_company_id,
competitor_wup_id, wup_id_intern_extern, wup_id, mandant_id_wup, nb_id, drivetime_distance_km) AS SELECT v01.ext_store_id
 ,
 v01.mandant_id,
 v01.ext_system_name,
 v01.retail_store_name,
 v01.retail_store_address,
 v01.breitengrad,
 v01.laengengrad,
 v01.ext_retail_company_id,
 v01.competitor_wup_id,
  CASE
  WHEN v01.wup_id = - 1
  THEN v01.ext_store_id
  ELSE v03.aktuell_wup_id
  END AS wup_id_intern_extern,
 COALESCE(v03.aktuell_wup_id, - 1) AS wup_id,
 COALESCE(v02.mandant_id, - 1) AS mandant_id_wup,
 COALESCE(v02.nb_id, - 1) AS nb_id,
 v02.drivetime_distance_km
FROM kfl_production_dbp_view.v_retail_store_2 AS v01
 INNER JOIN (SELECT ext_store_id,
   MAX(wup_id) AS wup_id,
   MAX(mandant_id) AS mandant_id,
   MAX(nb_id) AS nb_id,
   MIN(drivetime_distance_km) AS drivetime_distance_km
  FROM kfl_production_dbp_view.v_retail_store_distance_2
  GROUP BY ext_store_id) AS v02 ON v01.ext_store_id = v02.ext_store_id
 INNER JOIN kfl_production_dbp_view.v_wup_2 AS v03 ON v02.wup_id = v03.wup_id AND v02.mandant_id = v03.mandant_id;