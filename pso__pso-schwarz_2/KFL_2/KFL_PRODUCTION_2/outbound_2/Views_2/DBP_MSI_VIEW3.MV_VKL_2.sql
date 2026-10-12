CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_vkl_2 (gf_id, mandant_id, vkl_id, vkl_name) AS SELECT gf_id,
 mandant_id,
 vkl_id,
 vkl_name
FROM kfl_production_dbp_view.v_vkl_2;