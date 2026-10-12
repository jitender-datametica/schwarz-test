CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_L_PLATZIERUNGSSTUFE_2
-- Anfo #597332 Ausschluss der Unter PST, damit in Aggregat nicht gelöscht werden muss / 09.07.2014 sschuecke
-- lsvi0303 04.11.2020 NSR1756519 - all V platzierungstuffen added
(
 mandant_id
,platzierungsstufe_id
,sk_id_apollo
 )
AS
SELECT
mandant_id,
platzierungsstufe_id,
sk_id_apollo
FROM dbp_view.v_l_platzierungsstufe_2
WHERE mandant_id =1

-- es sollen nur Hauptplatzierungsstufen sowie Platzierungsstufen X/Y//Z angezeigt werden
AND (SUBSTRING(platzierungsstufe_id, 1, 1) IN ('X', 'Y', 'Z', 'V')
OR (SUBSTRING(platzierungsstufe_id, 1, 1) NOT IN ('X', 'Y', 'Z', 'V') AND SUBSTRING(platzierungsstufe_id, 3, 1) = 0));