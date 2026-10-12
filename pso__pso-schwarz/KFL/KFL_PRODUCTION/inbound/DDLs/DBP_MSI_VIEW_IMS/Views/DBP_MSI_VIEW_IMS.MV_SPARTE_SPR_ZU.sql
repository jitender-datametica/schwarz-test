CREATE OR REPLACE VIEW DBP_MSI_VIEW_IMS.MV_SPARTE_SPR_ZU AS
-- 22.03.2013 twie: Sprachzuordung für Sparten

   SELECT
   sparte_id,
   sparte_bez

   FROM dbp_view.v_sparte_spr_zu

   WHERE  spr_id=22;