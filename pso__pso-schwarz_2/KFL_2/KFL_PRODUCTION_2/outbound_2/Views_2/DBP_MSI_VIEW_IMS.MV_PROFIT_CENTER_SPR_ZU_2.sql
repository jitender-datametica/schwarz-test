CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ims.mv_profit_center_spr_zu_2 (pc_id, krk_id, mandant_id, pc_bez) AS
SELECT pc_id,
 krk_id,
 mandant_id,
 pc_bez
FROM kfl_production_dbp_view.v_profit_center_spr_zu_2
WHERE spr_id = 22;