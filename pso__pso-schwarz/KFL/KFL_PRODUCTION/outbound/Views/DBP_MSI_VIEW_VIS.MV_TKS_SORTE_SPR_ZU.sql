CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_tks_sorte_spr_zu AS SELECT DISTINCT mandant_id,
 tks_sorte_id,
 tks_sorte_bez,
 22 AS spr_id
FROM kfl_production_dbp_view.v_vis_tag_tks_sorte AS V01
WHERE mandant_id = 1;