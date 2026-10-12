CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.MV_REGALACHSE_2
-- Anforderung #585220
-- Anfo #597332 Ausschluss der Unter PST, damit in Aggregat nicht gelöscht werden muss / 09.07.2014 sschuecke
(
mandant_id
,regalachse_id
,layoutbaustein_id
,layoutbaustein_version
,dat_von
,dat_bis_neu
,fbb_nr
,platzierungsstufe_id
,wup_id
,nb_id
,achsgruppe_id
,regalachse_flaeche
,achs_nr
)
AS
   SELECT
  mandant_id,
   regalachse_id,
   layoutbaustein_id,
   layoutbaustein_version,
   dat_von,
   CASE WHEN SUBSTR(fbb_nr, 1, 4) >= 'P150' AND dat_bis <> '9999-12-31' THEN dat_bis +150 ELSE dat_bis END AS dat_bis_neu,
   fbb_nr,
   platzierungsstufe_id,
   wup_id,
   nb_id,
   achsgruppe_id,
   regalachse_flaeche,
   SUBSTRING(fbb_nr, LENGTH(fbb_nr) -3,  3) AS  achs_nr
   FROM dbp_view.v_regalachse_2
   WHERE mandant_id <> 1

   -- es sollen nur Hauptplatzierungsstufen sowie Platzierungsstufen X/Y//Z angezeigt werden
   AND (SUBSTRING(platzierungsstufe_id, 1, 1) IN ('X', 'Y', 'Z')
   OR (SUBSTRING(platzierungsstufe_id, 1, 1) NOT IN ('X', 'Y', 'Z') AND SUBSTRING(platzierungsstufe_id, 3, 1) = 0))

   -- Nur  aktuelle Regalachsen sollen angezeigt werden, dat_bis >= DATE
   AND dat_bis_neu >= CURRENT_DATE
   QUALIFY ROW_NUMBER() OVER (PARTITION BY mandant_id, fbb_nr ORDER BY dat_bis_neu DESC NULLS LAST) = 1;