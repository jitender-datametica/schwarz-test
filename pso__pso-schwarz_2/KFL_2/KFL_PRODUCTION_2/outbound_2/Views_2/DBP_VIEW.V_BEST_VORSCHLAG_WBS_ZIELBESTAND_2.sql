CREATE OR REPLACE VIEW kfl_production_dbp_view.v_best_vorschlag_wbs_zielbestand_2 AS SELECT mandant_id,
 wup_id,
 art_id,
 nb_id,
 aktion_id,
 dat_bedarf_von,
 dat_bedarf_bis,
 dat_letzte_nachversorgung,
 zielendbestand_bme
FROM kfl_production_dbp_data.best_vorschlag_wbs_zielbestand_2;