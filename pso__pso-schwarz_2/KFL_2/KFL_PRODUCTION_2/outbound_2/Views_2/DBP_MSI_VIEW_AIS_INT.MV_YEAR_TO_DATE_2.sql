CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.mv_year_to_date_2 (ytd_kj, ytd_kjmo, kjmo) AS SELECT DISTINCT
  'YTD ' || CAST(V01.kj AS STRING) AS ytd_kj,
  'YTD ' || CAST(V01.kjmo AS STRING) AS ytd_kjmo,
 V02.kjmo
FROM kfl_production_dbp_view.v_tag_2 AS V01
 INNER JOIN kfl_production_dbp_view.v_tag_2 AS V02 ON V01.kj = V02.kj
WHERE V02.kjmo <= V01.kjmo
 AND V01.dat BETWEEN DATE '2020-01-01' AND (CURRENT_DATE);