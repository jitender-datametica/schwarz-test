CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ais_int.mv_quartal_gj_1
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  gjqu AS gjqu,
  akt_gjqu AS akt_gjqu,
  akt_gjqu_komplett AS akt_gjqu_komplett,
  gj AS gj,
  akt_gj AS akt_gj,
  akt_gj_komplett AS akt_gj_komplett
FROM kfl_production_dbp_view.v_quartal_gj_1
WHERE
  gjqu > 201004;
