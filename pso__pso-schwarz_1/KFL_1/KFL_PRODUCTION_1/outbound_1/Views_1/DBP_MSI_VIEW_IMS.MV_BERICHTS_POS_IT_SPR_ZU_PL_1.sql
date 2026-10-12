CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ims.mv_berichts_pos_it_spr_zu_pl_1 AS SELECT DE.berichts_position_it_id
 ,
  CASE
  WHEN DE.berichts_position_it_id < 10
  THEN '0' || SUBSTR(CAST(DE.berichts_position_it_id AS STRING), 1, 1)
  ELSE SUBSTR(CAST(DE.berichts_position_it_id AS STRING), 1, 2)
  END AS berichts_position_it_char_id,
 COALESCE(ls.berichts_position_it_bez, DE.berichts_position_it_bez) AS berichts_position_it_bez
FROM kfl_production_dbp_view.v_berichts_pos_it_spr_zu_1 AS DE
 LEFT JOIN (SELECT *
  FROM kfl_production_dbp_view.v_berichts_pos_it_spr_zu_1
  WHERE spr_id = 90) AS ls ON DE.berichts_position_it_id = ls.berichts_position_it_id
WHERE DE.spr_id = 22;