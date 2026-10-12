CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_vw_1 (vw_id, vw_bez, vk_id, mandant_id, vwvt_bez) AS SELECT vw_id,
 vw_bez,
 vk_id,
 mandant_id,
 vwvt_bez
FROM kfl_production_dbp_view.v_l_vw_1;