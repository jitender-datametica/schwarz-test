CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_rpw.mv_prozessbereich_spr_zu_2 (system_id, mandant_id,
prozessbereich_id, spr_id, prozessbereich_bez) AS SELECT 7 AS system_id,
 mandant_id,
 prozessbereich_id,
 spr_id,
 prozessbereich_bez
FROM kfl_production_dbp_view.v_prozessbereich_spr_zu_2
WHERE mandant_id = 1
 AND spr_id = 22;