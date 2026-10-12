CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_FIPO_PRUEFPUNKT_1 as

   SELECT
   fipo_pruefpunkt_id, 4 AS kmr_quelle_id, fipo_pruefpunkt_nr, dat_von, dat_bis, fipo_kategorie_id, fipo_pruefpunkt_typ

   FROM dbp_view.v_fipo_pruefpunkt_1
;