CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ims.mv_l_profit_center_1 (krk_id, mandant_id, pc_id, wup_id, nb_id) AS
SELECT krk_id,
 mandant_id,
 pc_id,
 wup_id,
 nb_id
FROM kfl_production_dbp_view.v_profit_center_1;