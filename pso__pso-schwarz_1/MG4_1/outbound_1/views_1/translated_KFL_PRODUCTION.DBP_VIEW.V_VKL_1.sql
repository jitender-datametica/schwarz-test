CREATE OR REPLACE VIEW kfl_production_dbp_view.v_vkl_1 (vkl_id, mandant_id, gf_id, vkl_name, td_insert, td_update) AS
SELECT vkl_id,
 mandant_id,
 gf_id,
 vkl_name,
 td_insert,
 td_update
FROM kfl_production_dbp_data.vkl_1;