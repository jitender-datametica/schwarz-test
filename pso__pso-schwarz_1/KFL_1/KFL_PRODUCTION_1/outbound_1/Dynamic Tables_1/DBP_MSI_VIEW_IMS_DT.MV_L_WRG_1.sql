CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ims_dt.mv_l_wrg_1
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  wrg_id AS wrg_id,
  wrg_bez AS wrg_bez
FROM kfl_production_dbp_view.v_wrg_1;
