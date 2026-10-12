CREATE OR REPLACE VIEW kfl_production_dbp_view.v_lagerbew_art_bewart_zu_1 AS SELECT art_id,
 mandant_id,
 lager_bewart_id,
 wup_id,
 nb_id,
 dat_buch_first,
 dat_buch_last,
 dat_erfasst_first,
 dat_erfasst_last
FROM kfl_production_dbp_data.lagerbew_art_bewart_zu_1;