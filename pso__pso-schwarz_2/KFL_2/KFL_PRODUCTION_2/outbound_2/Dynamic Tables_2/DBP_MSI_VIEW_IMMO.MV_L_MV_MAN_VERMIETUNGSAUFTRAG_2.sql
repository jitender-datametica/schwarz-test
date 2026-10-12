CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_immo.mv_l_mv_man_vermietungsauftrag_2
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  man_vermietungsauftrag_id AS man_vermietungsauftrag_id,
  man_vermietungsauftrag_bez AS man_vermietungsauftrag_bez
FROM kfl_production_dbp_view.v_immo_l_man_vermietungsauftrag_2 AS v0
WHERE
  mandant_id = 1;
