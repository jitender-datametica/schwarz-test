CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_immo.mv_l_kennzeichen_1
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90,
  max_staleness=INTERVAL '90' MINUTE,
  allow_non_incremental_definition=TRUE
) AS
SELECT DISTINCT
  0 AS kz_id,
  'NEIN' AS kz_bez,
  'N' AS kz_kbez
FROM kfl_production_dbp_view.v_mandant_1
UNION ALL
SELECT DISTINCT
  1 AS kz_id,
  'JA' AS kz_bez,
  'J' AS kz_kbez
FROM kfl_production_dbp_view.v_mandant_1;
