CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_immo.mv_l_gj_jahr_1
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  gj AS gj,
  akt_gj AS akt_gj,
  akt_gj_komplett AS akt_gj_komplett
FROM kfl_production_dbp_view.v_jahr_gj_1;
