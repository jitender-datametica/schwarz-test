CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ims.mv_berichts_pos_invg_spr_zu_ro AS SELECT DE.berichts_pos_invest_grp_id
 ,
 COALESCE(ls.berichts_pos_invest_grp_bez, DE.berichts_pos_invest_grp_bez) AS berichts_pos_invest_grp_bez
FROM kfl_production_dbp_view.v_berichts_pos_inv_grp_spr_zu AS DE
 LEFT JOIN (SELECT *
  FROM kfl_production_dbp_view.v_berichts_pos_inv_grp_spr_zu
  WHERE spr_id = 95) AS ls ON DE.berichts_pos_invest_grp_id = ls.berichts_pos_invest_grp_id
WHERE DE.spr_id = 22;