CREATE OR REPLACE VIEW kfl_production_dbp_view.v_flw_art_kunde_vkorg_vw_zu AS SELECT flw_art_id,
 mandant_id,
 flw_kunde_id,
 flw_verkaufsorganisation_id,
 flw_vw_id,
 mandant_id_kunde,
 flw_art_id_kunde,
 td_insert,
 td_update
FROM kfl_production_dbp_data.flw_art_kunde_vkorg_vw_zu;