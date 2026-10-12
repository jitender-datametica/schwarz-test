CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_wm_1 (wm_id, wm_name, mandant_id) AS SELECT wm_id,
 wm_name,
 mandant_id
FROM kfl_production_dbp_view.v_wm_1;