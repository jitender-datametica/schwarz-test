CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ais_int.mv_l_nachhaltigkeitslogo_2
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90,
  max_staleness=INTERVAL '90' MINUTE,
  allow_non_incremental_definition=TRUE
) AS
SELECT
  nachhaltigkeitslogo_id AS nachhaltigkeitslogo_id,
  nachhaltigkeitslogo_bez AS nachhaltigkeitslogo_bez
FROM kfl_production_dbp_view.v_l_nachhaltigkeitslogo_2 AS v01
UNION DISTINCT
SELECT
  -999 AS nachhaltigkeitslogo_id,
  'kein Logo_2' AS nachhaltigkeitslogo_bez;
