CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_wm (wm_id, wm_name, mandant_id) AS SELECT wm_id,
 wm_name,
 mandant_id
FROM kfl_production_dbp_view.v_wm
WHERE mandant_id = 1;