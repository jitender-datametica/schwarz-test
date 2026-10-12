CREATE OR REPLACE VIEW DBP_MSI_VIEW_IMS.MV_GINFO_BAUFORM_SPR_ZU_1 AS
-- 11.04.2013 twie: Sprachzuordung für GINFO Bauform

   SELECT
   ginfo_bauform_id,
   ginfo_bauform_bez

   FROM dbp_view.v_ginfo_bauform_spr_zu_1

   WHERE  spr_id = 22;