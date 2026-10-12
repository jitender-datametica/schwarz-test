CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_KL_ART as
   -- Lookup-View für KL Artikel
   --

   SELECT
   CASE WHEN kl_art_id = 0
   THEN art_id
   ELSE kl_art_id
   END AS kl_art_id, mandant_id, art_id
   FROM dbp_view.v_art
   WHERE dat_bis = '9999-12-31';