CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ims_dt.mv_berichts_pos_inv_spr_zu_sk
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90,
  max_staleness=INTERVAL '90' MINUTE,
  allow_non_incremental_definition=TRUE
) AS
SELECT
  de.berichts_position_invest_id AS berichts_position_invest_id,
  COALESCE(ls.berichts_position_invest_bez, de.berichts_position_invest_bez) AS berichts_position_invest_bez
FROM kfl_production_dbp_view.v_berichts_pos_invest_spr_zu AS de
LEFT JOIN (
  SELECT
    *
  FROM kfl_production_dbp_view.v_berichts_pos_invest_spr_zu
  WHERE
    spr_id = 108
) AS ls
  ON de.berichts_position_invest_id = ls.berichts_position_invest_id
WHERE
  de.spr_id = 22;
