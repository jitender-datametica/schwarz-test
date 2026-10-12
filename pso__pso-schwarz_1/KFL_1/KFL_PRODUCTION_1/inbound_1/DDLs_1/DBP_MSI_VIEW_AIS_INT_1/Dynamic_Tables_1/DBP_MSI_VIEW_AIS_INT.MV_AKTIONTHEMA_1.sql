CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_AIS_INT.MV_AKTIONTHEMA_1
(
 mandant_id
,aktion_id
,art_id
,kl_art_id
,aktion_thema_id
,vk_aktion_brutto
,dat_von
,dat_bis
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_INT
AS
/*Es wird das Aktionsthema genommen, das die meisten Filialen haben. Auswertung nicht auf Wup_1 Ebene möglich. */
WITH ranked_aktionen AS (
  SELECT
    v01.mandant_id,
    v01.aktion_id,
    v01.art_id,
    v01.kl_art_id,
    v01.aktion_thema_id,
    vk_aktion_brutto,
    v01.dat_von,
    v01.dat_bis,
    v01.anzahl,
    ROW_NUMBER() OVER (PARTITION BY v01.mandant_id, v01.aktion_id, v01.art_id ORDER BY v01.anzahl DESC) AS RANK
  FROM (
    SELECT
      v01.mandant_id,
      v01.aktion_id,
      v01.art_id,
      v03.kl_art_id,
      v01.aktion_thema_id,
      v01.vk_aktion_brutto,
      v02.dat_von,
      v02.dat_bis,
      COUNT (*) AS anzahl
    FROM DBP_VIEW.V_AKTION_ART_WUP_ZU_1 v01
    JOIN DBP_VIEW.V_AKTION_1 v02
    ON v01.mandant_id = v02.mandant_id
    AND v01.aktion_id = v02.aktion_id
    JOIN DBP_VIEW.V_ART_1 v03
    ON v01.mandant_id = v03.mandant_id
    AND v01.art_id = v03.art_id
    AND v03.dat_bis = '9999-12-31'
    WHERE v01.nb_id = 0
    AND v02.dat_bis >= '2019-01-01'
    AND v01.mandant_id = 1
    GROUP BY ALL
  ) v01
)
SELECT
  mandant_id,
  aktion_id,
  art_id,
  kl_art_id,
  aktion_thema_id,
  vk_aktion_brutto,
  dat_von,
  dat_bis
FROM ranked_aktionen
WHERE RANK = 1

UNION

SELECT
  v01.mandant_id,
  v01.aktion_id,
  NULL AS art_id,
  NULL AS kl_art_id,
  'nicht vorhanden' AS aktion_thema_id,
  NULL AS vk_aktion_brutto,
  v01.dat_von,
  v01.dat_bis
FROM DBP_VIEW.V_L_BONUSKAUF_1 v01
WHERE (v01.mandant_id, v01.aktion_id) NOT IN (
  SELECT
    v01.mandant_id,
    v01.aktion_id
  FROM DBP_VIEW.V_AKTION_ART_WUP_ZU_1 v01
  JOIN DBP_VIEW.V_AKTION_1 v02
  ON v01.mandant_id = v02.mandant_id
  AND v01.aktion_id = v02.aktion_id
  JOIN DBP_VIEW.V_ART_1 v03
  ON v01.mandant_id = v03.mandant_id
  AND v01.art_id = v03.art_id
  AND v03.dat_bis = '9999-12-31'
  AND v02.dat_bis >= '2019-01-01'
  WHERE v01.nb_id = 0
  AND v01.mandant_id = 1
  GROUP BY ALL
)
AND v01.dat_bis >= '2019-01-01'
AND v01.mandant_id = 1

UNION
SELECT
  v01.mandant_id,
  '' AS aktion_id,
  v01.art_id,
  v01.kl_art_id,
  'nicht vorhanden' AS aktion_thema_id,
  NULL AS vk_aktion_brutto,
  NULL AS dat_von,
  NULL AS dat_bis
FROM DBP_VIEW.V_ART_1 v01
WHERE v01.dat_bis = '9999-12-31'
AND v01.mandant_id = 1
ORDER BY 1,2,3;