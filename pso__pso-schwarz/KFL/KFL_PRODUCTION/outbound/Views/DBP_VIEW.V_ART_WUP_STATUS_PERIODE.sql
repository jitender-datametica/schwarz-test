CREATE OR REPLACE VIEW kfl_production_dbp_view.v_art_wup_status_periode AS SELECT art_id,
 mandant_id,
 wup_id,
 nb_id,
 gjmo,
 menge_bestand_umlag_bme,
 menge_bestand_transit_bme,
 menge_bestand_geb_leergut,
 gjmo_bis,
 marc_fg,
 vk_brutto,
 td_update,
 td_insert
FROM kfl_production_dbp_data.art_wup_status_periode;