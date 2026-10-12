CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_PRUEFLOS_QUAL_MELDUNG_ZU_2

-- 14.04.2011 AL Erstellt
-- Laut SAP existiert fachlich eine_2 eindeutige Zuordnung zwischen einem Prueflos und einer Qualitaetsmeldung.
--  Durch Fehler in den Daten, kommt zu den Datenkanstellationen, wo ein Prueflos mehereren Qualitaetsmeldungen
--  zugeordnet wird. Die Eindeutigkeit wird fuer die Auswertungszwecke durch Zuordnung zu QM mit minimaler Nummer
-- hergestellt.
-- 22.08.2014 TWIE: Umstellung von Industrie auf eigene FLW Tabellen
(
mandant_id
,prueflos_id
,qual_meldung_id
)
AS

   SELECT v01.mandant_id, v01.prueflos_id, MIN(v01.qual_meldung_id) AS qual_meldung_id
   FROM dbp_view.v_flw_pruefmerkmal_ergebnis_2 v01
   INNER JOIN dbp_view.v_flw_pruef_los_2 v02
   ON v01.prueflos_id =v02.prueflos_id                   AND
   v01.mandant_id = v02.mandant_id
   WHERE qual_meldung_id <> 0
   GROUP BY v01.mandant_id, v01.prueflos_id;