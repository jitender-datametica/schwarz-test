CREATE OR REPLACE VIEW kfl_production_dbp_view.v_mk_art_wup_auswahl AS SELECT wup_id,
 nb_id,
 mandant_id,
 art_id,
 wtag_id,
 aktion_fg,
 dat_von,
 dat_bis,
 avg_menge,
 aktiv_fg,
 anz_tage_0verkauf,
 anz_tage_in_aktion
FROM kfl_production_dbp_data.mk_art_wup_auswahl;