CREATE OR REPLACE VIEW DBP_MSI_VIEW_IMS.MV_IN_WG_SPR_ZU_BG AS
-- 31.05.2013 twie: Erstellung Sprachtabelle Warengruppe
-- 20.08.2013/Gia

   SELECT
   v01.mandant_id,
   v01.in_wg_id,
   v01.in_wg_bez,
   v01.in_wg_bez_lang

  FROM dbp_view.v_in_wg_spr_zu v01

   WHERE spr_id = 18
;