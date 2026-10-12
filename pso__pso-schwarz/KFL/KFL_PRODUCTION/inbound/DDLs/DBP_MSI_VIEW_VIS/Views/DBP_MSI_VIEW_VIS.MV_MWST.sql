CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_MWST as
   -- aktuellen MwSt-Sätze
   --

   SELECT
   mwst_id, mandant_id, mwst, mwst_bez
   FROM dbp_view.v_mwst_per
   WHERE dat_bis = '9999-12-31';