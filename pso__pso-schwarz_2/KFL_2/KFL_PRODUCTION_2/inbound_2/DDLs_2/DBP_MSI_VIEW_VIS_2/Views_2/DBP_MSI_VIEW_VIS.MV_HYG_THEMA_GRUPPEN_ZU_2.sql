CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_HYG_THEMA_GRUPPEN_ZU_2 as
   -- ZUORDNUNG Gruppierung von Hygiene - Thema pro GJ
   -- Abloesung Konsolidierungen
   -- gruppe_mutter entspricht einer Konsolidierung, gruppe_2 enthaelt ein/mehrere themen
   -- 2015KW26 : Initial

   SELECT
   fk.frage_katalog_id, tgz.hyg_thema_gruppe_mutter_id, tgz.hyg_thema_gruppe_id, tgz.gj, tgz.hyg_thema_id
   FROM dbp_msi_view_vis.ts_hyg_thema_gruppen_zu_2  tgz

   JOIN dbp_view.v_hyg_frage_katalog_2 fk
   ON tgz.gj = fk.gj
   ;