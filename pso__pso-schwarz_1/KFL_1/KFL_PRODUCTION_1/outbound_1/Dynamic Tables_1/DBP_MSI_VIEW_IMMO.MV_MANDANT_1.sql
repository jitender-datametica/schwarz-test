CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_immo.mv_mandant_1
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  mandant_id AS mandant_id,
  mandant_bez AS mandant_bez,
  mandant_kbez AS mandant_kbez
FROM kfl_production_dbp_view.v_mandant_1 AS m;
