CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_VK_KONZEPT_SPR_ZU as
   -- SPRACHE : Verkaufskonzept Bezeichnung
   -- Befuellung Tabelle ueber INIT-Skript
   -- 2012KW46 : Initiial (nur DE)

   SELECT
   v01.mandant_id, v01.vk_konzept_id, v01.vk_konzept_bez
   FROM dbp_msi_v_view.v_vk_konzept_spr_zu v01
   WHERE v01.spr_id = 22 --DE
;