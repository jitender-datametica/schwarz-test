CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_AIS_INT.MV_AKTIONTHEMA_MARKT_2
(
 mandant_id
,aktion_id
,wup_id
,nb_id
,art_id
,kl_art_id
,aktion_thema_id
,vk_aktion_brutto
,dat_von
,dat_bis
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_INT
AS
/*Attribut Aktionsthema Markt: Hier wird auf Ebene Filiale das Aktionsthema ausgegeben. Hier auf Wup_2 Ebene auswertbar*/
SELECT
-- Ermittlung aller Aktion_2, Markt, Artikel_2 Kombinationen aus dbp_data.aktion_art_wup_zu_2 und die aktion_id in der dbp_data.aktion_2 enthalten ist
DISTINCT v01.mandant_id,
v01.aktion_id,
v01.wup_id,
v01.nb_id,
v01.art_id,
v03.kl_art_id,
v01.aktion_thema_id,
v01.vk_aktion_brutto,
NULL AS dat_von,
NULL AS dat_bis
FROM DBP_VIEW.V_AKTION_ART_WUP_ZU_2 v01
JOIN DBP_VIEW.V_AKTION_2 v02
ON v01.mandant_id = v02.mandant_id
AND v01.aktion_id = v02.aktion_id
JOIN DBP_VIEW.V_ART_2 v03
ON v01.mandant_id = v03.mandant_id
AND v01.art_id = v03.art_id
WHERE v01.nb_id = 0
AND v03.dat_bis = '9999-12-31'
AND v02.dat_bis >= '2019-01-01'
AND v01.mandant_id = 1

UNION
SELECT
-- Ermittlung aller Aktionen aus dbp_data.l_bonuskauf_2, die nicht in aktion_art_wup_zu_2 und deren aktion_id wiederum in der dbp_data.aktion_2 enthalten ist
DISTINCT v04.mandant_id,
v04.aktion_id,
NULL AS wup_id,
NULL AS nb_id,
NULL AS art_id,
NULL AS kl_art_id,
'nicht vorhanden' AS aktion_thema_id,
NULL AS vk_aktion_brutto,
v04.dat_von,
v04.dat_bis
FROM DBP_VIEW.V_L_BONUSKAUF_2 v04
WHERE (v04.mandant_id, v04.aktion_id) NOT IN (
SELECT
a.mandant_id,
a.aktion_id,
FROM DBP_VIEW.V_AKTION_ART_WUP_ZU_2 a
JOIN DBP_VIEW.V_AKTION_2 b
ON a.mandant_id = b.mandant_id
AND a.aktion_id = b.aktion_id
JOIN DBP_VIEW.V_ART_2 c
ON a.mandant_id = c.mandant_id
AND a.art_id = c.art_id
WHERE a.nb_id = 0
AND c.dat_bis = '9999-12-31'
AND b.dat_bis >= '2019-01-01'
AND a.mandant_id = 1
GROUP BY ALL)
AND v04.dat_bis >= '2019-01-01'
AND v04.mandant_id = 1
GROUP BY ALL

UNION
SELECT
-- Ermittlung aller restlichen Artikel_2 / Marktkombinationen aus dbp_data.art_2 / dbp_data.wup_2, die nicht in dbp_data.aktion_art_wup_zu_2 enthalten sind 
v01.mandant_id,
'' AS aktion_id,
v02.wup_id,
v02.nb_id,
v01.art_id,
v01.kl_art_id,
'nicht vorhanden' AS aktion_thema_id,
NULL AS vk_aktion_brutto,
NULL AS dat_von,
NULL AS dat_bis
FROM DBP_VIEW.V_ART_2 v01
-- Zuordnung jede wup_id zu jeder art_id
JOIN DBP_VIEW.V_WUP_2 v02
ON v01.mandant_id = v02.mandant_id
AND v02.nb_id = 0
/*WHERE (v01.mandant_id, v01.art_id, v02.wup_id) NOT IN
(SELECT mandant_id, art_id, wup_id FROM DBP_VIEW.V_AKTION_ART_WUP_ZU_2)*/
AND v01.dat_bis = '9999-12-31'
AND v01.mandant_id = 1
;