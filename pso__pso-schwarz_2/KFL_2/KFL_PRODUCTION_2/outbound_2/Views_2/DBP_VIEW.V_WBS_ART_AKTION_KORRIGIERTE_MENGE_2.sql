CREATE OR REPLACE VIEW kfl_production_dbp_view.v_wbs_art_aktion_korrigierte_menge_2 AS SELECT mandant_id,
 wup_id,
 nb_id,
 art_id,
 dat_von_aktion,
 dat_bis_aktion,
 zeitraum_korrigierte_menge
FROM kfl_production_dbp_data.wbs_art_aktion_korrigierte_menge_2;