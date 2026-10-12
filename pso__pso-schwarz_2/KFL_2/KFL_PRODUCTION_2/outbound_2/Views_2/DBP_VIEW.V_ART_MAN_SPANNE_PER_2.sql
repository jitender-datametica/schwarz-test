CREATE OR REPLACE VIEW kfl_production_dbp_view.v_art_man_spanne_per_2 AS SELECT art_id,
 mandant_id,
 konditionsart_id,
 dat_von,
 ek_faktor,
 dat_bis,
 loesch_fg,
 system_id
FROM kfl_production_dbp_data.art_man_spanne_per_2;