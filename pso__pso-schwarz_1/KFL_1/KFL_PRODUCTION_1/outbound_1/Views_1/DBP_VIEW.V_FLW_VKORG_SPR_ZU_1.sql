CREATE OR REPLACE VIEW kfl_production_dbp_view.v_flw_vkorg_spr_zu_1 AS SELECT mandant_id,
 flw_verkaufsorganisation_id,
 spr_id,
 system_id,
 verkaufsorganisation_bez,
 td_insert,
 td_update
FROM kfl_production_dbp_data.flw_vkorg_spr_zu_1;