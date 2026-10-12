CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ims_dt.mv_berichts_pos_invg_spr_zu_2
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  berichts_pos_invest_grp_id AS berichts_pos_invest_grp_id,
  berichts_pos_invest_grp_bez AS berichts_pos_invest_grp_bez
FROM kfl_production_dbp_view.v_berichts_pos_inv_grp_spr_zu_2
WHERE
  spr_id = 22;
