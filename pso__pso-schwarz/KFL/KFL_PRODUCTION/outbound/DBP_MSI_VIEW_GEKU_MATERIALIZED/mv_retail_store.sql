CREATE OR REPLACE VIEW dbp_msi_view_geku_materialized.mv_retail_store (ext_store_id, mandant_id,
ext_system_name, retail_store_name, retail_store_address, breitengrad, laengengrad, ext_retail_company_id,
competitor_wup_id, wup_id_intern_extern, wup_id, mandant_id_wup, nb_id, drivetime_distance_km) AS SELECT V01.ext_store_id
 ,
 V01.mandant_id,
 V01.ext_system_name,
 V01.retail_store_name,
 V01.retail_store_address,
 V01.breitengrad,
 V01.laengengrad,
 V01.ext_retail_company_id,
 V01.competitor_wup_id,
  CASE
  WHEN V01.wup_id = - 1
  THEN V01.ext_store_id
  ELSE V03.aktuell_wup_id
  END AS wup_id_intern_extern,
 COALESCE(V03.aktuell_wup_id, - 1) AS wup_id,
 COALESCE(v02.mandant_id, - 1) AS mandant_id_wup,
 COALESCE(v02.nb_id, - 1) AS nb_id,
 v02.drivetime_distance_km
FROM dbp_view.v_retail_store AS V01
 INNER JOIN (SELECT ext_store_id,
   MAX(wup_id) AS wup_id,
   MAX(mandant_id) AS mandant_id,
   MAX(nb_id) AS nb_id,
   MIN(drivetime_distance_km) AS drivetime_distance_km
  FROM dbp_view.v_retail_store_distance
  GROUP BY ext_store_id) AS v02 ON V01.ext_store_id = v02.ext_store_id
 INNER JOIN dbp_view.v_wup AS V03 ON v02.wup_id = V03.wup_id AND v02.mandant_id = V03.mandant_id;