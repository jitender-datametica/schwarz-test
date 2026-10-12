CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_rpw.mv_vkl_2 (vkl_id, gf_id, vkl_name, mandant_id, system_id) AS SELECT
 vkl_id,
 gf_id,
 vkl_name,
 mandant_id,
 7 AS system_id
FROM kfl_production_dbp_view.v_vkl_2
WHERE mandant_id = 1;