CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_vk_2 (vk_id, vk_bez, mandant_id) AS SELECT vk_id,
 vk_bez,
 mandant_id
FROM kfl_production_dbp_view.v_vk_2
WHERE mandant_id = 1
 AND vk_id NOT IN (0);