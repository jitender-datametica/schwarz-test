CREATE OR REPLACE VIEW kfl_production_dbp_view.v_fipo_l_bereich AS SELECT fipo_bereich_id,
 fipo_pruef_modul_id,
 fipo_bereich_nr,
 fipo_bereich_gruppe_id
FROM kfl_production_dbp_data.fipo_l_bereich;