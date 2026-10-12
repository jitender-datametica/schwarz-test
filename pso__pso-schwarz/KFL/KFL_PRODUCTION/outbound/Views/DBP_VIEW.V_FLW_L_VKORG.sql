CREATE OR REPLACE VIEW kfl_production_dbp_view.v_flw_l_vkorg AS SELECT mandant_id,
 flw_verkaufsorganisation_id,
 system_id,
 td_insert,
 td_update
FROM kfl_production_dbp_data.flw_l_vkorg;