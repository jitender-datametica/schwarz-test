CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_l_vkl_1 (vkl_id, gf_id, vkl_name, mandant_id) AS SELECT vkl_id,
 gf_id,
 vkl_name,
 mandant_id
FROM kfl_production_dbp_view.v_vkl_1
WHERE mandant_id IN (1, 2);