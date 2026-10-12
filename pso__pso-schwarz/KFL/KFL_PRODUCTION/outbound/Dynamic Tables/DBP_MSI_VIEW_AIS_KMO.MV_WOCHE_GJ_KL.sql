CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ais_kmo.mv_woche_gj_kl
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  gjwo_kl AS gjwo_kl,
  gjwo_kl_dat_von AS gjwo_kl_dat_von,
  gjwo_kl_dat_bis AS gjwo_kl_dat_bis,
  akt_gjwo_kl AS akt_gjwo_kl,
  akt_gjwo_kl_komplett AS akt_gjwo_kl_komplett,
  akt_gj AS akt_gj,
  ROUND(
    CAST(SUBSTR(SUBSTR(CAST(CAST(gjwo_kl AS BIGNUMERIC) AS STRING), 1, 6), 1, 4) AS BIGNUMERIC),
    0
  ) AS gj,
  akt_gj_komplett AS akt_gj_komplett
FROM kfl_production_dbp_view.v_woche_gj_kl
WHERE
  gjwo_kl > 200153;
