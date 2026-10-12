CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_immo.mv_l_kj_jahr_2
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  kj AS kj,
  akt_kj AS akt_kj,
  akt_kj_komplett AS akt_kj_komplett
FROM kfl_production_dbp_view.v_jahr_kj_2;
