CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ims.mv_berichts_pos_inv_spr_zu_pl_1 AS SELECT DE.berichts_position_invest_id
 ,
 COALESCE(ls.berichts_position_invest_bez, DE.berichts_position_invest_bez) AS berichts_position_invest_bez
FROM kfl_production_dbp_view.v_berichts_pos_invest_spr_zu_1 AS DE
 LEFT JOIN (SELECT *
  FROM kfl_production_dbp_view.v_berichts_pos_invest_spr_zu_1
  WHERE spr_id = 90) AS ls ON DE.berichts_position_invest_id = ls.berichts_position_invest_id
WHERE DE.spr_id = 22;