CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_l_tks_sorte AS SELECT DISTINCT mandant_id,
 tks_sorte_id
FROM kfl_production_dbp_view.v_vis_tag_tks_sorte AS V01
WHERE mandant_id = 1;