CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ims_dt.mv_jahr_gj_1
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90,
  max_staleness=INTERVAL '90' MINUTE,
  allow_non_incremental_definition=TRUE
) AS
SELECT
  gj AS gj,
  akt_gj AS akt_gj,
  akt_gj_komplett AS akt_gj_komplett,
  CAST(gj AS STRING) AS gj_bez
FROM kfl_production_dbp_view.v_jahr_gj_1
UNION DISTINCT
SELECT
  1900 AS gj,
  -9999 AS akt_gj,
  -9999 AS akt_gj_komplett,
  '' AS gj_bez
FROM kfl_production_dbp_view.v_jahr_gj_1
WHERE
  akt_gj = 0;
