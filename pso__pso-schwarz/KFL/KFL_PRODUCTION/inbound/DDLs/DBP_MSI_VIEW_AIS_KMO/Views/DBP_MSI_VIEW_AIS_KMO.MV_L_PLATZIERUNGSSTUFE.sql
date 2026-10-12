CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.MV_L_PLATZIERUNGSSTUFE
-- Anfo #597332 Ausschluss der Unter PST, damit in Aggregat nicht gelöscht werden muss / 09.07.2014 sschuecke
(
mandant_id
,platzierungsstufe_id
,sk_id_apollo
)
AS
   SELECT
   v01.mandant_id,
   v01.platzierungsstufe_id,
   v01.sk_id_apollo
   FROM dbp_view.v_l_platzierungsstufe v01
   WHERE v01.mandant_id  <>1

   -- es sollen nur Hauptplatzierungsstufen sowie Platzierungsstufen X/Y//Z angezeigt werden
   AND (SUBSTRING(platzierungsstufe_id, 1, 1) IN ('X', 'Y', 'Z')
   OR (SUBSTRING(platzierungsstufe_id, 1, 1) NOT IN ('X', 'Y', 'Z') AND SUBSTRING(platzierungsstufe_id, 3, 1) = 0)) ;