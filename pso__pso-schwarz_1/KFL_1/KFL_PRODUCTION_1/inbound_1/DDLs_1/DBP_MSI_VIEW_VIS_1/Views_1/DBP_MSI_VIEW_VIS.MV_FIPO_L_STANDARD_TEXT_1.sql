CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_FIPO_L_STANDARD_TEXT_1 as
   SELECT

   fipo_standard_text_id, fipo_standard_text_nr, dat_von, dat_bis
   --,fipo_pruefpunkt_id    --Verbindung nicht relevant


   FROM
   dbp_view.v_fipo_l_standard_text_1
   ;