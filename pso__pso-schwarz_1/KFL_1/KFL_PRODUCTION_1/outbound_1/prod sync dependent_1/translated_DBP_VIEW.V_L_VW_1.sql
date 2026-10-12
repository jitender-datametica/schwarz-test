CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_vw_1 (vw_id, mandant_id, spr_id, vk_id, vw_bez, vwvt_bez, vwart_id,
sap_vw_id, td_insert, td_update) AS SELECT vw_id,
 mandant_id,
 spr_id,
 vk_id,
 vw_bez,
 vwvt_bez,
 vwart_id,
 sap_vw_id,
 td_insert,
 td_update
FROM kfl_production_dbp_data.l_vw_1;