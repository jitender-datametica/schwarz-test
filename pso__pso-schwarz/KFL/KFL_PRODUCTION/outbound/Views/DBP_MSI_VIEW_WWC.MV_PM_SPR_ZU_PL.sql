CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_pm_spr_zu_pl (pm_id, pm_bez, mandant_id, spr_id) AS SELECT
 pm_id,
 pm_bez,
 mandant_id,
 spr_id
FROM kfl_production_dbp_view.v_pm
WHERE spr_id = 90;