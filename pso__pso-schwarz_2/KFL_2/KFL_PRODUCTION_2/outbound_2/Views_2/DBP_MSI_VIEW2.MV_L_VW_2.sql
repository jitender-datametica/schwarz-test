CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_l_vw_2 (vw_id, vw_bez, vk_id, mandant_id, vwvt_bez, sap_vw_id,
kl_id) AS SELECT vw_id,
 TRIM(vw_bez) AS vw_bez,
 vk_id,
 mandant_id,
 TRIM(vwvt_bez) AS vwvt_bez,
 sap_vw_id,
 1 AS kl_id
FROM kfl_production_dbp_view.v_l_vw_2
WHERE mandant_id = 1
 AND vwart_id = 1
 AND vw_id IN (1, 2, 3, 6);