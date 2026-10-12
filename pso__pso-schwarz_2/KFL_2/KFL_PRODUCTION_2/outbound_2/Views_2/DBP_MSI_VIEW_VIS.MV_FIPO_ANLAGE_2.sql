CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_fipo_anlage_2 AS SELECT V01.fipo_anlage_id,
 V01.fipo_antwort_id,
  TRIM(V02.fipo_anlage_url) || TRIM(SUBSTR(CAST(V01.fipo_anlage_id AS STRING), 1, 39)) AS fipo_webservice
FROM kfl_production_dbp_view.v_fipo_anlage_2 AS V01
 INNER JOIN kfl_production_dbp_msi_v_view.v_fipo_webservice_url_2 AS V02 ON V01.dat_bis >= CURRENT_DATE;