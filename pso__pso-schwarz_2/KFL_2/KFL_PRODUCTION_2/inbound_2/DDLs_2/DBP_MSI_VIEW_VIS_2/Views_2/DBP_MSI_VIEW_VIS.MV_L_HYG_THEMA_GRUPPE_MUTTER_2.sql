CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_L_HYG_THEMA_GRUPPE_MUTTER_2 as
   -- LOOKUP Gruppierung von Hygiene - Thema (pro GJ)
   -- Abloesung Konsolidierungen
   -- gruppe_mutter entspricht einer Konsolidierung
   -- 2015KW26 : Initial

   SELECT DISTINCT
   v01.hyg_thema_gruppe_mutter_id
   FROM dbp_msi_view_vis.ts_hyg_thema_gruppen_zu_2  v01
;