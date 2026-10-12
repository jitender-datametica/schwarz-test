CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_fipo_pruefpunkt_2 AS SELECT fipo_pruefpunkt_id,
 4 AS kmr_quelle_id,
 fipo_pruefpunkt_nr,
 dat_von,
 dat_bis,
 fipo_kategorie_id,
 fipo_pruefpunkt_typ
FROM kfl_production_dbp_view.v_fipo_pruefpunkt_2;