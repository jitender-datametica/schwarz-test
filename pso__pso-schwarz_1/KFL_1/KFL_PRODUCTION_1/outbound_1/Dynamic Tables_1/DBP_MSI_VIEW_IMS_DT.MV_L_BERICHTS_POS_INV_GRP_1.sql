CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ims_dt.mv_l_berichts_pos_inv_grp_1
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  berichts_pos_invest_grp_id,
   ahk_aufwand_id
FROM kfl_production_dbp_view.v_l_berichts_pos_inv_grp_1;