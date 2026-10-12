CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_l_wm_1 (wm_id, wm_name, mandant_id) AS SELECT wm_id,
 wm_name,
 mandant_id
FROM kfl_production_dbp_view.v_wm_1
WHERE mandant_id IN (1, 2);