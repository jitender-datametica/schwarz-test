CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ims_dt.mv_profit_center_spr_zu
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  pc_id AS pc_id,
  krk_id AS krk_id,
  mandant_id AS mandant_id,
  pc_bez AS pc_bez
FROM kfl_production_dbp_view.v_profit_center_spr_zu
WHERE
  spr_id = 22;
