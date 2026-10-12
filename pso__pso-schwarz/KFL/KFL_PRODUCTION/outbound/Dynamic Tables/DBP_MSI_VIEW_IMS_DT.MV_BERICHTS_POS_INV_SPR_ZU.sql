CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ims_dt.mv_berichts_pos_inv_spr_zu
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  berichts_position_invest_id AS berichts_position_invest_id,
  berichts_position_invest_bez AS berichts_position_invest_bez
FROM kfl_production_dbp_view.v_berichts_pos_invest_spr_zu
WHERE
  spr_id = 22;
