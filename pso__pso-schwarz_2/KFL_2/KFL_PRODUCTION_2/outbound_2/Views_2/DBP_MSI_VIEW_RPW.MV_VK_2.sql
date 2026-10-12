CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_rpw.mv_vk_2 (vk_id, vk_bez, mandant_id, system_id) AS SELECT vk_id,
 vk_bez,
 mandant_id,
 7 AS system_id
FROM kfl_production_dbp_view.v_vk_2
WHERE mandant_id = 1;