CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_rpw.mv_verursacher_spr_zu (system_id, mandant_id, verursacher_id,
spr_id, verursacher_bez) AS SELECT 7 AS system_id,
 mandant_id,
 verursacher_id,
 spr_id,
 verursacher_bez
FROM kfl_production_dbp_view.v_verursacher_spr_zu
WHERE mandant_id = 1
 AND spr_id = 22;