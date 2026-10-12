CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_PLATZIERUNGSSTUFE_SPR_ZU_1
-- Anfo #597332 Ausschluss der Unter PST, damit in Aggregat nicht gelöscht werden muss / 09.07.2014 sschuecke
(
mandant_id
,platzierungsstufe_id
,spr_id
,platzierungsstufe_bez
)
AS
   SELECT
  mandant_id, platzierungsstufe_id, spr_id, platzierungsstufe_bez
   FROM dbp_view.v_platzierungsstufe_spr_zu_1
   WHERE mandant_id =1
   AND spr_id = 22

   -- es sollen nur Hauptplatzierungsstufen sowie Platzierungsstufen X/Y//Z angezeigt werden
   AND (SUBSTRING(platzierungsstufe_id, 1, 1) IN ('X', 'Y', 'Z')
   OR (SUBSTRING(platzierungsstufe_id, 1, 1) NOT IN ('X', 'Y', 'Z') AND SUBSTRING(platzierungsstufe_id, 3, 1) = 0)) ;