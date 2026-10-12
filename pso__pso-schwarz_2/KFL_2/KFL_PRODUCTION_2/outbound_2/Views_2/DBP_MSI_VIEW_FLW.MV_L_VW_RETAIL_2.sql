CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_l_vw_retail_2 (vw_id, vw_ret_bez, vk_id, mandant_id, vwvt_bez)
AS SELECT vw_id,
 vw_bez AS vw_ret_bez,
 vk_id,
 mandant_id,
 vwvt_bez
FROM kfl_production_dbp_view.v_l_vw_2
WHERE mandant_id IN (1, 2)
 AND vwart_id = 1
 AND vw_id IN (6, 10);