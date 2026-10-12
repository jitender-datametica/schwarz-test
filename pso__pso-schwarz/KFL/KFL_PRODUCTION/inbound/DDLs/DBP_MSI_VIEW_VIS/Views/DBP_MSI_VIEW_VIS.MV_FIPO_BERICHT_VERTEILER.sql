CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_FIPO_BERICHT_VERTEILER as
   SELECT

   fipo_bericht_id, fipo_bericht_verteiler_id

   FROM dbp_view.v_fipo_bericht_verteiler
;