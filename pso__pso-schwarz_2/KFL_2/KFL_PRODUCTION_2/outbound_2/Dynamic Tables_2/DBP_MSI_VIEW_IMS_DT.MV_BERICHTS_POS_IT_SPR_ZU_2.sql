CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ims_dt.mv_berichts_pos_it_spr_zu_2
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  berichts_position_it_id AS berichts_position_it_id,
  CASE
    WHEN berichts_position_it_id < 10
    THEN '0' || SUBSTR(CAST(berichts_position_it_id AS STRING), 1, 1)
    ELSE SUBSTR(CAST(berichts_position_it_id AS STRING), 1, 2)
  END AS berichts_position_it_char_id,
  berichts_position_it_bez AS berichts_position_it_bez
FROM kfl_production_dbp_view.v_berichts_pos_it_spr_zu_2
WHERE
  spr_id = 22;
