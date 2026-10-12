CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_FIPO_L_KATEGORIE_1 as

   SELECT
   fipo_kategorie_id, fipo_kategorie_nr, fipo_bereich_id

   FROM dbp_view.v_fipo_l_kategorie_1
;