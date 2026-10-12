CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ims_dt.mv_berichts_pos_invg_spr_zu_ro_2
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90,
  max_staleness=INTERVAL '90' MINUTE,
  allow_non_incremental_definition=TRUE
) AS
SELECT
  de.berichts_pos_invest_grp_id AS berichts_pos_invest_grp_id,
  COALESCE(ls.berichts_pos_invest_grp_bez, de.berichts_pos_invest_grp_bez) AS berichts_pos_invest_grp_bez
FROM kfl_production_dbp_view.v_berichts_pos_inv_grp_spr_zu_2 AS de
LEFT JOIN (
  SELECT
    *
  FROM kfl_production_dbp_view.v_berichts_pos_inv_grp_spr_zu_2
  WHERE
    spr_id = 95
) AS ls
  ON de.berichts_pos_invest_grp_id = ls.berichts_pos_invest_grp_id
WHERE
  de.spr_id = 22;
