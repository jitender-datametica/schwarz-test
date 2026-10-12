CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_rpw.mv_problemgruppe_spr_zu_2 (system_id, mandant_id, problemgruppe_id
, spr_id, problemgruppe_bez) AS SELECT 7 AS system_id,
 mandant_id,
 problemgruppe_id,
 spr_id,
 problemgruppe_bez
FROM kfl_production_dbp_view.v_problemgruppe_spr_zu_2
WHERE spr_id = 22
 AND mandant_id = 1;