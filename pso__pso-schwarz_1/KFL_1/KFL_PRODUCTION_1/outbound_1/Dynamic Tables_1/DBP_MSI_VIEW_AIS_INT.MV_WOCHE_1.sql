CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ais_int.mv_woche_1
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  v01.kjwo AS kjwo,
  v01.gjwo AS gjwo,
  v01.gjwo_vj AS gjwo_vj,
  v01.kjwo_vj AS kjwo_vj,
  v01.kjwo_vvj AS kjwo_vvj,
  v01.wo_dat_von AS kjwo_dat_von,
  v01.wo_dat_bis AS kjwo_dat_bis,
  v02.akt_kjwo_kl AS akt_kjwo_kl,
  v02.akt_kjwo_kl_komplett AS akt_kjwo_kl_komplett,
  v01.akt_wo_kalendarisch AS akt_kjwo_kalendarisch,
  v01.akt_wo AS akt_wo,
  ROUND(CAST(SUBSTR(TRIM(SUBSTR(CAST(v01.kjwo AS STRING), 1, 39)), 0, 4) AS BIGNUMERIC), 0) AS kj,
  ROUND(CAST(SUBSTR(TRIM(SUBSTR(CAST(v01.gjwo AS STRING), 1, 39)), 0, 4) AS BIGNUMERIC), 0) AS gj,
  v02.akt_kj AS akt_kj,
  v02.akt_kj_komplett AS akt_kj_komplett,
  v03.akt_gj AS akt_gj,
  v03.akt_gj_komplett AS akt_gj_komplett
FROM kfl_production_dbp_view.v_woche_1 AS v01
INNER JOIN kfl_production_dbp_view.v_woche_kj_kl_1 AS v02
  ON v01.kjwo = v02.kjwo_kl
INNER JOIN kfl_production_dbp_view.v_woche_gj_kl_1 AS v03
  ON v01.gjwo = v03.gjwo_kl
WHERE
  v01.kjwo > 200152;
