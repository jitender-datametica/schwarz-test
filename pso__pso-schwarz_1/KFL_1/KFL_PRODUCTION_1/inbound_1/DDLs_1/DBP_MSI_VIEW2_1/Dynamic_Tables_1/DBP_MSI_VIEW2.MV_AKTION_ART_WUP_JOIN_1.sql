CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW2.MV_AKTION_ART_WUP_JOIN_1
(
	AKTION_ID,
	MANDANT_ID,
	DAT_VON,
	DAT_BIS,
	KJWO,
	VK_AKTION_BRUTTO,
	ART_ID,
	WUP_ID,
	NB_ID,
	VK_BRUTTO,
	AKTIONSART_ID,
	SAP_WERBE_KAT_ID,
	PREISAKTIVIERUNG,
	AKTION_THEMA_ID,
	WERBE_KAT_ID
) TARGET_LAG = '1 HOUR, 30 MINUTES' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_DE
AS
SELECT
v01.aktion_id, 
v01.mandant_id, 
v01.dat_von, 
v01.dat_bis, 
v05.kjwo, 
v02.vk_aktion_brutto, 
v02.art_id, 
v02.wup_id, 
v02.nb_id, 
v06.vk_brutto, 
v01.aktionsart_id, 
v07.sap_werbe_kat_id,
CASE WHEN v01.preisaktiviert_fg = 1 THEN 'x' ELSE ' ' END AS preisaktivierung, 
v02.aktion_thema_id, 
v07.werbe_kat_id

FROM dbp_view.v_aktion_1   v01
INNER JOIN dbp_view.v_aktion_art_wup_zu_1    v02
ON  v02.aktion_id = v01.aktion_id
AND v02.mandant_id = v01.mandant_id
INNER JOIN dbp_view.v_tag_1 v03
ON  v03.dat = v01.dat_von
INNER JOIN dbp_view.v_tag_1 v04
ON  v04.dat = v01.dat_bis
INNER JOIN dbp_view.v_woche_1 v05
ON  v05.kjwo BETWEEN v03.kjwo AND v04.kjwo
INNER JOIN dbp_view.v_art_wup_zu_per_1 v06
ON  v02.art_id = v06.art_id
AND v02.mandant_id = v06.mandant_id
AND v02.wup_id = v06.wup_id
AND v02.nb_id = v06.nb_id
AND v06.dat_von <= v01.dat_von
AND v06.dat_bis >= v01.dat_von
INNER JOIN dbp_view.v_l_werbekat_1 v07
ON  v01.werbe_kat_id = v07.werbe_kat_id

WHERE v02.grund_sperrung IS NULL
AND   v01.mandant_id = 1;
