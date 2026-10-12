CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ims_dt.mv_berichts_pos_it_spr_zu_pl
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90,
  max_staleness=INTERVAL '90' MINUTE,
  allow_non_incremental_definition=TRUE
) AS
SELECT
  de.berichts_position_it_id AS berichts_position_it_id,
  CASE
    WHEN de.berichts_position_it_id < 10
    THEN '0' || SUBSTR(CAST(de.berichts_position_it_id AS STRING), 1, 1)
    ELSE SUBSTR(CAST(de.berichts_position_it_id AS STRING), 1, 2)
  END AS berichts_position_it_char_id,
  COALESCE(ls.berichts_position_it_bez, de.berichts_position_it_bez) AS berichts_position_it_bez
FROM kfl_production_dbp_view.v_berichts_pos_it_spr_zu AS de
LEFT JOIN (
  SELECT
    *
  FROM kfl_production_dbp_view.v_berichts_pos_it_spr_zu
  WHERE
    spr_id = 90
) AS ls
  ON de.berichts_position_it_id = ls.berichts_position_it_id
WHERE
  de.spr_id = 22;
