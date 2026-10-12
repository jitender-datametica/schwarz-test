CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ais_int.mv_quartal_kj_2
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  kjqu AS kjqu,
  akt_kjqu AS akt_kjqu,
  akt_kjqu_komplett AS akt_kjqu_komplett,
  kj AS kj,
  akt_kj AS akt_kj,
  akt_kj_komplett AS akt_kj_komplett
FROM kfl_production_dbp_view.v_quartal_kj_2
WHERE
  kjqu > 201004;
