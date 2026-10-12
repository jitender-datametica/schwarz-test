CREATE OR REPLACE VIEW kfl_production_dbp_view.v_in_art_per_1 AS SELECT mandant_id,
 in_art_id,
 dat_von,
 dat_bis,
 aktiv_fg,
 katalog_fg,
 einkauf_prueft_fg,
 normalposition_fg,
 td_update,
 td_insert
FROM kfl_production_dbp_data.in_art_per_1;