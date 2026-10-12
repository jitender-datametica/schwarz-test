CREATE OR REPLACE VIEW kfl_production_dbp_view.v_fipo_pruefpunkt_1 AS SELECT fipo_pruefpunkt_id,
 fipo_bereich_id,
 fipo_kriterium_id,
 fipo_pruefpunkt_nr,
 dat_von,
 dat_bis,
 fipo_kategorie_id,
 fipo_pruefpunkt_typ
FROM kfl_production_dbp_data.fipo_pruefpunkt_1;