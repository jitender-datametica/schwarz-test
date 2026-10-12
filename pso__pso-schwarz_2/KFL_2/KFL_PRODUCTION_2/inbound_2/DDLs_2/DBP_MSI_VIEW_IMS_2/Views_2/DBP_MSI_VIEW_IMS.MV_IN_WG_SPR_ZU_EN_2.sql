CREATE OR REPLACE VIEW DBP_MSI_VIEW_IMS.MV_IN_WG_SPR_ZU_EN_2 AS
-- 31.05.2013 twie: Erstellung Sprachtabelle Warengruppe

   SELECT
   v01.mandant_id,
   v01.in_wg_id,
   v01.in_wg_bez,
   v01.in_wg_bez_lang

  FROM dbp_view.v_in_wg_spr_zu_2 v01

   WHERE spr_id = 24;