CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.mv_moving_annual_total (mat_kj, mat_kjmo, kjmo) AS SELECT
DISTINCT 'MAT ' || CAST(V01.kj AS STRING) AS mat_kj,
  'MAT ' || CAST(V01.kjmo AS STRING) AS mat_kjmo,
 V02.kjmo
FROM kfl_production_dbp_view.v_tag AS V01
 INNER JOIN kfl_production_dbp_view.v_tag AS V02 ON V02.dat BETWEEN V01.dat_vj AND V01.dat
WHERE V02.kjmo <> V01.kjmo_vj
 AND V01.dat BETWEEN DATE '2020-01-01' AND (CURRENT_DATE);