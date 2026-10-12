CREATE OR REPLACE VIEW DBP_MSI_VIEW_IMS.MV_L_IN_ART AS
-- 31.05.2013 twie: Erstellung Lookup für Material

   SELECT
   v01.in_art_id,
   v01.mandant_id,
   v01.in_art_nr,
   v01.in_wg_id

  FROM dbp_view.v_in_art v01
;