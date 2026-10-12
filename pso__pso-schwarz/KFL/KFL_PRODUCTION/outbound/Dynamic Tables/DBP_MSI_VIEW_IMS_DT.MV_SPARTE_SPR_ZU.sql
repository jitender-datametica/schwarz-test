CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ims_dt.mv_sparte_spr_zu
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  sparte_id AS sparte_id,
  sparte_bez AS sparte_bez
FROM kfl_production_dbp_view.v_sparte_spr_zu
WHERE
  spr_id = 22;
