CREATE OR REPLACE VIEW kfl_production_dbp_view.v_flw_vkorg_vw_werk_zu_2 AS SELECT mandant_id,
 flw_verkaufsorganisation_id,
 flw_vw_id,
 werk_id,
 system_id,
 td_insert,
 td_update
FROM kfl_production_dbp_data.flw_vkorg_vw_werk_zu_2;