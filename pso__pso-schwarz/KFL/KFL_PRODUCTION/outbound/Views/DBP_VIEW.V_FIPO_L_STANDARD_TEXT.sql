CREATE OR REPLACE VIEW kfl_production_dbp_view.v_fipo_l_standard_text AS SELECT fipo_standard_text_id,
 fipo_pruefpunkt_id,
 fipo_standard_text_nr,
 dat_von,
 dat_bis
FROM kfl_production_dbp_data.fipo_l_standard_text;