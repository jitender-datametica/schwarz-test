CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ios.mv_l_vw_2 (vw_id, mandant_id, spr_id, vk_id, vw_bez, vwvt_bez,
vwart_id, sap_vw_id) AS SELECT vw_id,
 mandant_id,
 spr_id,
 vk_id,
 vw_bez,
 vwvt_bez,
 vwart_id,
 sap_vw_id
FROM kfl_production_dbp_view.v_l_vw_2;