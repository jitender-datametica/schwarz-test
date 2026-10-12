CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ais_int.mv_wug
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  mandant_id AS mandant_id,
  wg_id AS wg_id,
  wug_id AS wug_id,
  TRIM(CAST(wg_id AS STRING FORMAT '000')) || TRIM(CAST(wug_id AS STRING FORMAT '000')) AS wgi_id
FROM kfl_production_dbp_view.v_wug AS v01;
