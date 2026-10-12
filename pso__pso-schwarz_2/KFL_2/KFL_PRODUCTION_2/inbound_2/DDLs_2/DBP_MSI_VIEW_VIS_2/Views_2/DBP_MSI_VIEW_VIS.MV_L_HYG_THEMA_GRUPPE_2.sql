CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_L_HYG_THEMA_GRUPPE_2 as
   -- LOOKUP Gruppierung von Hygiene - Thema (pro GJ)
   -- Abloesung Konsolidierungen
   -- gruppe_2 enthaelt ein/mehrere themen
   -- 2015KW26 : Initial

   SELECT
   v01.hyg_thema_gruppe_id
   FROM dbp_msi_view_vis.ts_l_hyg_thema_gruppe_2  v01
;