CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_vkl (vkl_id, gf_id, vkl_name, mandant_id) AS SELECT vkl_id,
 gf_id,
 vkl_name,
 mandant_id
FROM kfl_production_dbp_view.v_vkl
WHERE mandant_id = 1;