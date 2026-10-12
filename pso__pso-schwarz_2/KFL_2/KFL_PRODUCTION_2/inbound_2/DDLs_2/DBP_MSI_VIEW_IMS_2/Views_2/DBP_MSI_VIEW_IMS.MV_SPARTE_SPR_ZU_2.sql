CREATE OR REPLACE VIEW DBP_MSI_VIEW_IMS.MV_SPARTE_SPR_ZU_2 AS
-- 22.03.2013 twie: Sprachzuordung für Sparten

   SELECT
   sparte_id,
   sparte_bez

   FROM dbp_view.v_sparte_spr_zu_2

   WHERE  spr_id=22;