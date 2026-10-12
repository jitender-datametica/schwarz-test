CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.mv_lagerbew_det_display_2 AS SELECT mandant_id,
 lagerbew_beleg_id,
 lagerbew_beleg_pos_id,
 kj,
 lager_bewart_id,
 art_id,
 wup_id,
 nb_id,
 gp_id,
 soll_haben_kz,
 best_beleg_id,
 menge_lagerbew_kolli,
 menge_lagerbew_bme,
 betrag_lagerbew,
 dat_buch,
 display_art_id,
 line_id,
 lagerbew_beleg_pos_mutter_id
FROM kfl_production_dbp_data.lagerbew_det_2
WHERE lager_bewart_id IN ('319', '317', '101', '102', '901', '902') AND mandant_id <> 1
 OR lager_bewart_id IN ('319', '317', '101', '102', '901', '902', '905', '906', '913', '915') AND mandant_id = 1;