CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW2.MV_LISTUNG_MARKT_KW_2
(
	MANDANT_ID,
	WG_ID,
	OWG_ID,
	ART_ID,
	WUP_ID,
	NB_ID,
	KREISTYP_GRUPPE_ID,
	KJWO,
	ABSATZ,
	ABSATZ_SA,
	ABSATZ_AF,
	ANZ_WO_MIT_ABSATZ,
	ANZ_WO_MIT_ABSATZ_SA,
	ANZ_WO_MIT_ABSATZ_AF
) TARGET_LAG = '1 HOUR, 30 MINUTES' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_DE
AS
SELECT
v01.mandant_id, 
v03.wg_id, 
v05.owg_id, 
v01.art_id, 
v01.wup_id, 
v01.nb_id, 
v04.kreistyp_gruppe_id, 
v02.kjwo, 
ZEROIFNULL(SUM(v01.menge)) AS absatz, 
ZEROIFNULL(SUM(CASE WHEN v01.bewart_id = 1002 THEN v01.menge END)) AS absatz_sa, 
ZEROIFNULL(SUM(CASE WHEN v01.bewart_id = 1001 THEN v01.menge END)) AS absatz_af, 
ZEROIFNULL(CASE WHEN absatz > 0 THEN COUNT(DISTINCT v02.kjwo) END) AS anzahl_wochen_mit_absatz, 
ZEROIFNULL(CASE WHEN absatz_sa > 0 AND absatz_sa IS NOT NULL THEN COUNT(DISTINCT CASE WHEN v01.bewart_id = 1002 THEN v02.kjwo END) END) AS anzahl_wochen_mit_absatz_sa, 
ZEROIFNULL(CASE WHEN absatz_af > 0 AND absatz_af IS NOT NULL THEN COUNT(DISTINCT CASE WHEN v01.bewart_id = 1001 THEN v02.kjwo END) END) AS anzahl_wochen_mit_absatz_af

FROM dbp_view.v_artbew_wo_sum_2 v01

JOIN dbp_view.v_woche_kj_kl_2 v02
ON v01.kjwo_kl = v02.kjwo_kl

JOIN dbp_view.v_art_wg_zu_per_2 v03
ON v03.art_id = v01.art_id
AND v01.mandant_id = v03.mandant_id

JOIN dbp_view.v_wup_2 v04
ON  v01.wup_id = v04.wup_id
AND v01.nb_id = v04.nb_id
AND v01.mandant_id = v04.mandant_id

JOIN dbp_view.v_wg_per_2 v05
ON v03.wg_id = v05.wg_id
AND v03.mandant_id = v05.mandant_id
AND v05.arthiertyp_id = 2
AND v05.dat_bis = '9999-12-31'

WHERE v01.mandant_id = 1
AND v03.arthiertyp_id = 2
AND v03.dat_bis = '9999-12-31'
GROUP BY 1,2,3,4,5,6,7,8;
