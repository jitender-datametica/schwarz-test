CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ais_int.mv_ipn_2
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90,
  max_staleness=INTERVAL '90' MINUTE,
  allow_non_incremental_definition=TRUE
) AS
SELECT
  ipn_id,
  ipn_bez
FROM kfl_production_dbp_view.v_ipn_2
UNION DISTINCT
SELECT
  0 AS ipn_id,
  '' AS ipn_bez
FROM kfl_production_dbp_view.v_ipn_2;