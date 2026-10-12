create or replace dynamic table KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW2.MV_AKTIONTHEMA_MARKT_1(
	MANDANT_ID,
	AKTION_ID,
	WUP_ID,
	NB_ID,
	ART_ID,
	KL_ART_ID,
	AKTION_THEMA_ID,
	VK_AKTION_BRUTTO,
	PREISAKTIVIERT_FG,
	WERBE_KAT_ID,
	AKTIONSART_ID,
	DAT_VON,
	DAT_BIS,
	KJWO_WW
) target_lag = '1 hour, 30 minutes' refresh_mode = FULL initialize = ON_CREATE warehouse = WH_KFL_D_DYNAMIC_TABLE_AIS_DE
 as
/*Attribut Aktionsthema Markt: Hier wird auf Ebene Filiale das Aktionsthema ausgegeben. Hier auf Wup_1 Ebene auswertbar*/
SELECT
-- Ermittlung aller Aktion_1, Markt, Artikel_1 Kombinationen aus dbp_data.aktion_art_wup_zu_1 und die aktion_id in der dbp_data.aktion_1 enthalten ist
DISTINCT v01.mandant_id,
v01.aktion_id,
v01.wup_id,
v01.nb_id,
v01.art_id,
v03.kl_art_id,
v01.aktion_thema_id,
v01.vk_aktion_brutto,
--AP0236414/SPEC0318647 erweiterung um Spalten / prescherad 07.08.2025
v02.preisaktiviert_fg,
v02.werbe_kat_id,
v02.aktionsart_id,
--AP0236414/SPEC0311472 dat_von/dat_bis aus dbp_data.aktion_1 anstatt NULL / sschuecke 13.05.2025
v02.dat_von,
v02.dat_bis,
v04.kjwo_ww,
FROM DBP_VIEW.V_AKTION_ART_WUP_ZU_1 v01
JOIN DBP_VIEW.V_AKTION_1 v02
ON v01.mandant_id = v02.mandant_id
AND v01.aktion_id = v02.aktion_id
JOIN DBP_VIEW.V_ART_1 v03
ON v01.mandant_id = v03.mandant_id
AND v01.art_id = v03.art_id
JOIN dbp_view.v_werbewoche_kl_1 v04
ON v02.mandant_id=v04.mandant_id
AND v02.dat_von=v04.dat 
WHERE v01.nb_id = 0
AND v03.dat_bis = '9999-12-31'
AND v02.dat_bis >= '2019-01-01'
AND v01.mandant_id = 1

UNION
SELECT
-- Ermittlung aller Aktionen aus dbp_data.l_bonuskauf_1, die nicht in aktion_art_wup_zu_1 und deren aktion_id wiederum in der dbp_data.aktion_1 enthalten ist
DISTINCT v04.mandant_id,
v04.aktion_id,
NULL AS wup_id,
NULL AS nb_id,
NULL AS art_id,
NULL AS kl_art_id,
'nicht vorhanden' AS aktion_thema_id,
NULL AS vk_aktion_brutto,
NULL AS preisaktiviert_fg,
NULL AS werbe_kat_id,
NULL AS aktionsart_id,
v04.dat_von,
v04.dat_bis,
v05.kjwo_ww,
FROM DBP_VIEW.V_L_BONUSKAUF_1 v04
JOIN dbp_view.v_werbewoche_kl_1 v05
ON v04.mandant_id=v05.mandant_id
AND v04.dat_von=v05.dat 
WHERE (v04.mandant_id, v04.aktion_id) NOT IN (
SELECT
a.mandant_id,
a.aktion_id,
FROM DBP_VIEW.V_AKTION_ART_WUP_ZU_1 a
JOIN DBP_VIEW.V_AKTION_1 b
ON a.mandant_id = b.mandant_id
AND a.aktion_id = b.aktion_id
JOIN DBP_VIEW.V_ART_1 c
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
-- Ermittlung aller restlichen Artikel_1 / Marktkombinationen aus dbp_data.art_1 / dbp_data.wup_1, die nicht in dbp_data.aktion_art_wup_zu_1 enthalten sind 
v01.mandant_id,
'' AS aktion_id,
v02.wup_id,
v02.nb_id,
v01.art_id,
v01.kl_art_id,
'nicht vorhanden' AS aktion_thema_id,
NULL AS vk_aktion_brutto,
NULL AS preisaktiviert_fg,
NULL AS werbe_kat_id,
NULL AS aktionsart_id,
NULL AS dat_von,
NULL AS dat_bis,
NULL AS kjwo_ww
FROM DBP_VIEW.V_ART_1 v01
-- Zuordnung jede wup_id zu jeder art_id
JOIN DBP_VIEW.V_WUP_1 v02
ON v01.mandant_id = v02.mandant_id
AND v02.nb_id = 0
/*WHERE (v01.mandant_id, v01.art_id, v02.wup_id) NOT IN
(SELECT mandant_id, art_id, wup_id FROM DBP_VIEW.V_AKTION_ART_WUP_ZU_1)*/
AND v01.dat_bis = '9999-12-31'
AND v01.mandant_id = 1
;
