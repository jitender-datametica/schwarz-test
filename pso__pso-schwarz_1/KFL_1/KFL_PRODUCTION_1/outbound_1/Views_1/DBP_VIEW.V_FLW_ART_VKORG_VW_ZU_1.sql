CREATE OR REPLACE VIEW kfl_production_dbp_view.v_flw_art_vkorg_vw_zu_1 AS SELECT mandant_id,
 flw_art_id,
 flw_verkaufsorganisation_id,
 flw_vw_id,
 system_id,
 art_status_id,
 verk_menge_einh_id,
 td_insert,
 td_update
FROM kfl_production_dbp_data.flw_art_vkorg_vw_zu_1;