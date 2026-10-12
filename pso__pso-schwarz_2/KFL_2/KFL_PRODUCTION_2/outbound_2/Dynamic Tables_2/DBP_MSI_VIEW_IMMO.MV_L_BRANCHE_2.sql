CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_immo.mv_l_branche_2
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  branche_id AS branche_id,
  branche_bez AS branche_bez
FROM kfl_production_dbp_view.v_immo_l_branche_2 AS v0
WHERE
  mandant_id = 1
UNION DISTINCT
SELECT
  0 AS branche_id,
  '' AS branche_bez
FROM kfl_production_dbp_view.v_mandant_2;
