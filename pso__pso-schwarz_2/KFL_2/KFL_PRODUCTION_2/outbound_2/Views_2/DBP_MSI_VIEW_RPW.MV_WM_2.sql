CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_rpw.mv_wm_2 (wm_id, wm_name, mandant_id, system_id) AS SELECT wm_id,
 wm_name,
 mandant_id,
 7 AS system_id
FROM kfl_production_dbp_view.v_wm_2
WHERE mandant_id = 1;