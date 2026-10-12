CREATE OR REPLACE VIEW kfl_production_dbp_view.v_art_wup_fehlartikel_2 AS SELECT art_id,
 mandant_id,
 wup_id,
 nb_id,
 dat_letzter_we,
 dat_letzter_umsatz,
 fehlartikel_kz
FROM kfl_production_dbp_data.art_wup_fehlartikel_2;