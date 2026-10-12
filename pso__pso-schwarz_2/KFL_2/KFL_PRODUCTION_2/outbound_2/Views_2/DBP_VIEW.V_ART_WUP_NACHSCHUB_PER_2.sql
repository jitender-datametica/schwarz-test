CREATE OR REPLACE VIEW kfl_production_dbp_view.v_art_wup_nachschub_per_2 AS SELECT mandant_id,
 art_id,
 wup_id,
 nb_id,
 dat_von,
 dat_bis,
 menge_bestand_soll_max,
 td_update,
 td_insert
FROM kfl_production_dbp_data.art_wup_nachschub_per_2;