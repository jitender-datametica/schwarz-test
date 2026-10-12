CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_pm_1 (pm_id, pm_bez, mandant_id, spr_id) AS SELECT pm_id,
 pm_bez,
 mandant_id,
 spr_id
FROM kfl_production_dbp_view.v_pm_1
WHERE mandant_id = 1;