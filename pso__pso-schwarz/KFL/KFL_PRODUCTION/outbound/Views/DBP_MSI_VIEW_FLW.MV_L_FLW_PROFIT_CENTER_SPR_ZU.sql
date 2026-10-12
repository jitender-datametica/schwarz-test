CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_l_flw_profit_center_spr_zu (mandant_id, pc_id, spr_id, krk_id
, pc_bez) AS SELECT V01.mandant_id,
 V01.pc_id,
 V01.spr_id,
 V01.krk_id,
 V01.pc_bez
FROM kfl_production_dbp_view.v_profit_center_spr_zu AS V01
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_spr_zu AS V02 ON V01.spr_id = V02.spr_id;