CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_L_VK_KONZEPT as
   -- LOOKUP : Verkaufskonzept
   -- Keine eigene Tabelle, befuellt aus spr_zu
   -- 2012KW46 : Initial (nur DE)

   SELECT DISTINCT
   v01.mandant_id, v01.vk_konzept_id
   FROM dbp_msi_v_view.v_vk_konzept_spr_zu v01;