CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_F_FLW_GEWICHTSGRENZEN_PER_2
-- 26.10.2011 system_id entfernt
-- 22.08.2014 TWIE: Umstellung von Industrie auf eigene FLW Tabellen
(
mandant_id
--,system_id
,in_art_id
,dat
,gewicht_kg_von
,gewicht_kg_bis
)
AS
   SELECT
   v01.mandant_id, v01.flw_art_id AS in_art_id, v02.dat, v01.gewicht_kg_von, v01.gewicht_kg_bis
   FROM dbp_view.v_flw_gewichtsgrenzen_per_2 v01

   JOIN dbp_view.v_tag_2 v02
   ON v02.dat BETWEEN v01.dat_von AND  v01.dat_bis;