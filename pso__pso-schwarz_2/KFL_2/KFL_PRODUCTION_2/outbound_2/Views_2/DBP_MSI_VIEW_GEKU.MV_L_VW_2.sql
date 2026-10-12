CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku.mv_l_vw_2 AS SELECT vw_id,
 TRIM(vw_bez) AS vw_bez,
 vk_id,
 mandant_id,
 TRIM(vwvt_bez) AS vwvt_bez,
 sap_vw_id
FROM kfl_production_dbp_view.v_l_vw_2
WHERE mandant_id = 1 AND vw_id IN (0, 1, 2, 3)
 OR mandant_id <> 1 AND vw_id = 0;