CREATE OR REPLACE VIEW kfl_production_dbp_view.v_vkl AS SELECT vkl_id,
 mandant_id,
 gf_id,
 vkl_name,
 td_insert,
 td_update
FROM kfl_production_dbp_data.vkl;