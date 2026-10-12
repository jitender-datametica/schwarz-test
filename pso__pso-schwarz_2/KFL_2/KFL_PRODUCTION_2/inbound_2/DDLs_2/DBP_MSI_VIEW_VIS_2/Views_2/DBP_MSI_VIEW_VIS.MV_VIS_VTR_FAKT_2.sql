CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_VIS_VTR_FAKT_2(
	MANDANT_ID,
	NB_ID,
	VS_ID,
	VKL_ID,
	WUP_ID,
	WRG_ID,
	GJ,
	KJMO,
	VTR_ID,
	FILIST,
	FILIST2,
	FILKVJ,
	FILKVJ2,
	FILPLAN,
	FILPLAN2,
	REGIST,
	REGIST2,
	REGKVJ,
	REGKVJ2,
	LANDIST,
	LANDIST2,
	LANDKVJ,
	LANDKVJ2,
	FILMO_RANG,
	FILGJ_RANG,
	VKLMO_RANG,
	VKLGJ_RANG,
	FILMO_WERT,
	FILGJ_WERT,
	VKLMO_WERT,
	VKLGJ_WERT
) AS 
/* 
	VTR FAKT DENORM : Ranking Vertrieb
	Filiale IST/VJ/Plan + Referenz Region_2/Land_2 + Ranking Filiale/VKL_2 pro Monat_2/GJ 
	2023-08-01 ssch0611 : Initial_01 AP0176993 
	2023-09-06 ssch0611 : Update_091 Kennzahlen
	2023-10-18 ssch0611 : AP0163999 > SUB021/SUB022 Kasse/Kassentyp-Join 
	2023-11-02 ssch0611 : Feedback Tests. Absatz ohne Pfand. Inventur_2 Rank DESC. Übernahmequote Rank DESC.
	2024-01-10 ssch0611 : Release Version
	2024-02-12 ssch0611 : Zusätzlicher Zeitfilter (Akt. BS) für Ranking am Monatsanfang
	2024-04-09 ssch0611 : Filialfilter GJ2024
	2024-09-09 ssch0611 : Filialumgliederung [P1760-DWH] komplette Umstellung auf mv_views + CTE
	2025-01-30 ssch0611 : Abschriften_2 Berechung Vorzeichen gefixed.
*/ 
 
WITH /* VTR000 : CTE VIS Aggregate */
  monat_fakt_wup AS ( /* MV_VIS_MONAT_FAKT_WUP_2 gruppiert */
		SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id
		, wup.vs_id, CASE WHEN wup.vkl_id>0 THEN wup.vkl_id ELSE (1000+vis.mandant_id*100+wup.vs_id*10)*-1::INTEGER END AS vkl_id
		, COALESCE(wup.dat_eroeffnung_alt, wup.dat_eroeffnung) AS neo_dat
		, wup.dat_bis AS stl_dat
		, zeit.gj, zeit.kjmo, zeit.max_dat
		, ker.akt_buchungs_schluss AS akt_bs
		, SUM(vis.ums_netto)      AS ums_ist
		, SUM(vis.ums_netto_kvj)  AS ums_kvj
		, SUM(vis.ums_netto_plan) AS ums_plan
		, SUM(vis.anz_kunde)     AS knd_ist
		, SUM(vis.anz_kunde_kvj) AS knd_kvj
		, knd_ist / 10000 AS knd_10t_ist
		, knd_kvj / 10000 AS knd_10t_kvj
		, SUM(vis.pers_std)      AS std_ist
		, SUM(vis.pers_std_kvj)  AS std_kvj
		, SUM(vis.pers_std_plan) AS std_plan
		, SUM(vis.pers_kosten)      AS kst_ist
		, SUM(vis.pers_kosten_kvj)  AS kst_kvj
		, SUM(vis.pers_kosten_plan) AS kst_plan
		FROM DBP_MSI_VIEW_VIS.MV_VIS_MONAT_FAKT_WUP_2 vis
		INNER JOIN DBP_DATA.MONAT_2 zeit_2
		ON zeit.kjmo = vis.kjmo 
		AND zeit.akt_gj IN (-1, 0) AND zeit.akt_mo < 0 /* 2 GJ */
		INNER JOIN DBP_DATA.L_BUCHUNGSSTATUS_KER_2 ker
		ON ker.kj_ker_mo_id = vis.kjmo
		INNER JOIN dbp_data.wup_2 wup_2 
		ON wup.wup_id = vis.wup_id AND wup.mandant_id = vis.mandant_id 
		/* Standard Filter VTC : Filiale + definierte NB. Datum Eröffnung fix + GJ Schließung dynamisch */
		AND (wup.nb_id=0 OR wup.wup_id IN (0,2,22,28,43,46,124,8980,8987,8991,100000,100002,100022,100028,100043,100046,100124))
		AND wup.dat_eroeffnung<'2090-12-31' 
		AND (EXTRACT(YEAR FROM wup.dat_bis) + CASE WHEN EXTRACT(MONTH FROM wup.dat_bis) < 3 THEN -1 ELSE 0 END) > (zeit.gj + 1) 
		GROUP BY ALL
)
, monat_fakt_wg AS ( /* MV_VIS_MONAT_FAKT_WG_2 gruppiert */
		SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id
		, wup.vs_id, CASE WHEN wup.vkl_id>0 THEN wup.vkl_id ELSE (1000+vis.mandant_id*100+wup.vs_id*10)*-1::INTEGER END AS vkl_id
		, COALESCE(wup.dat_eroeffnung_alt, wup.dat_eroeffnung) AS neo_dat
		, wup.dat_bis AS stl_dat
		, zeit.gj, zeit.kjmo, zeit.max_dat
		, ker.akt_buchungs_schluss AS akt_bs
		, SUM(vis.ums_netto)     AS ums_ist
		, SUM(vis.ums_netto_kvj) AS ums_kvj
		, SUM(vis.menge)     AS mng_ist
		, SUM(vis.menge_kvj) AS mng_kvj
		, SUM(CASE WHEN vis.abt_id = 5 THEN vis.ums_netto ELSE 0 END)     AS ums_uf_ist
		, SUM(CASE WHEN vis.abt_id = 5 THEN vis.ums_netto_kvj ELSE 0 END) AS ums_uf_kvj
		, SUM(CASE WHEN wg.owg_id <> 1092 THEN vis.menge ELSE 0 END)     AS mng_opf_ist
		, SUM(CASE WHEN wg.owg_id <> 1092 THEN vis.menge_kvj ELSE 0 END) AS mng_opf_kvj
		FROM DBP_MSI_VIEW_VIS.MV_VIS_MONAT_FAKT_WG_2 vis
		JOIN DBP_MSI_VIEW_VIS.MV_WG_INT_2 wg
		ON wg.wg_id = vis.wg_id
		INNER JOIN DBP_DATA.MONAT_2 zeit_2
		ON zeit.kjmo = vis.kjmo 
		AND zeit.akt_gj IN (-1, 0) AND zeit.akt_mo < 0 /* 2 GJ */
		INNER JOIN DBP_DATA.L_BUCHUNGSSTATUS_KER_2 ker
		ON ker.kj_ker_mo_id = vis.kjmo
		INNER JOIN dbp_data.wup_2 wup_2 
		ON wup.wup_id = vis.wup_id AND wup.mandant_id = vis.mandant_id 
		/* Standard Filter VTC : Filiale + definierte NB. Datum Eröffnung fix + GJ Schließung dynamisch */
		AND (wup.nb_id=0 OR wup.wup_id IN (0,2,22,28,43,46,124,8980,8987,8991,100000,100002,100022,100028,100043,100046,100124))
		AND wup.dat_eroeffnung<'2090-12-31' 
		AND (EXTRACT(YEAR FROM wup.dat_bis) + CASE WHEN EXTRACT(MONTH FROM wup.dat_bis) < 3 THEN -1 ELSE 0 END) > (zeit.gj + 1) 
		GROUP BY ALL
) 
, tag_abschriften_wg AS ( /* MV_VIS_TAG_ABSCHRIFTEN_WG_2 gruppiert */
	SELECT vis.mandant_id, vis.wup_id, vis.wrg_id, zeit.kjmo
	, SUM(CASE 
		WHEN vis.mandant_id IN (6) AND vis.abschriftart_id = 2 THEN 1 
		WHEN vis.mandant_id IN (3) AND vis.abschriftart_id = 11 THEN 1 
		WHEN vis.mandant_id IN (2,4,5,7,8) AND vis.abschriftart_id = 7 THEN 1 
		WHEN vis.mandant_id IN (2,5) AND vis.abschriftart_id = 10 THEN 1 
		WHEN vis.mandant_id NOT IN (1) AND vis.abschriftart_id = 20 THEN 1 
		ELSE -1 END * vis.abschrift_netto) AS abs_op_ist
	, SUM(CASE 
		WHEN vis.mandant_id IN (6) AND vis.abschriftart_id = 2 THEN 1 
		WHEN vis.mandant_id IN (3) AND vis.abschriftart_id = 11 THEN 1 
		WHEN vis.mandant_id IN (2,4,5,7,8) AND vis.abschriftart_id = 7 THEN 1 
		WHEN vis.mandant_id IN (2,5) AND vis.abschriftart_id = 10 THEN 1 
		WHEN vis.mandant_id NOT IN (1) AND vis.abschriftart_id = 20 THEN 1 
		ELSE -1 END * vis.abschrift_netto_kvj) AS abs_op_kvj 
	, SUM(CASE WHEN vis.abt_id = 5 
		THEN CASE
			WHEN vis.mandant_id IN (6) AND vis.abschriftart_id = 2 THEN 1 
			WHEN vis.abt_id = 5 AND vis.mandant_id IN (3) AND vis.abschriftart_id = 11 THEN 1 
			WHEN vis.abt_id = 5 AND vis.mandant_id IN (2,4,5,7,8) AND vis.abschriftart_id = 7 THEN 1 
			WHEN vis.abt_id = 5 AND vis.mandant_id IN (2,5) AND vis.abschriftart_id = 10 THEN 1 
			WHEN vis.abt_id = 5 AND vis.mandant_id NOT IN (1) AND vis.abschriftart_id = 20 THEN 1 
			ELSE -1 END
		ELSE 0 END * vis.abschrift_netto) AS abs_uf_ist
	, SUM(CASE WHEN vis.abt_id = 5 THEN CASE
			WHEN vis.abt_id = 5 AND vis.mandant_id IN (6) AND vis.abschriftart_id = 2 THEN 1 
			WHEN vis.abt_id = 5 AND vis.mandant_id IN (3) AND vis.abschriftart_id = 11 THEN 1 
			WHEN vis.abt_id = 5 AND vis.mandant_id IN (2,4,5,7,8) AND vis.abschriftart_id = 7 THEN 1 
			WHEN vis.abt_id = 5 AND vis.mandant_id IN (2,5) AND vis.abschriftart_id = 10 THEN 1 
			WHEN vis.abt_id = 5 AND vis.mandant_id NOT IN (1) AND vis.abschriftart_id = 20 THEN 1 
			ELSE -1 END
		ELSE 0 END * vis.abschrift_netto_kvj) AS abs_uf_kvj
	, SUM(CASE WHEN abs_thema.abschriftart_thema_int_id = 1 
		THEN CASE
			WHEN vis.mandant_id IN (6) AND vis.abschriftart_id = 2 THEN 1 
			WHEN vis.mandant_id IN (3) AND vis.abschriftart_id = 11 THEN 1 
			WHEN vis.mandant_id IN (2,4,5,7,8) AND vis.abschriftart_id = 7 THEN 1 
			WHEN vis.mandant_id IN (2,5) AND vis.abschriftart_id = 10 THEN 1 
			WHEN vis.mandant_id NOT IN (1) AND vis.abschriftart_id = 20 THEN 1 
			ELSE -1 END
		ELSE 0 END * vis.abschrift_netto) AS abs_ta_ist
	, SUM(CASE WHEN abs_thema.abschriftart_thema_int_id = 1 
		THEN CASE 
			WHEN vis.mandant_id IN (6) AND vis.abschriftart_id = 2 THEN 1 
			WHEN vis.mandant_id IN (3) AND vis.abschriftart_id = 11 THEN 1 
			WHEN vis.mandant_id IN (2,4,5,7,8) AND vis.abschriftart_id = 7 THEN 1 
			WHEN vis.mandant_id IN (2,5) AND vis.abschriftart_id = 10 THEN 1 
			WHEN vis.mandant_id NOT IN (1) AND vis.abschriftart_id = 20 THEN 1 
			ELSE -1 END
		ELSE 0 END * vis.abschrift_netto_kvj) AS abs_ta_kvj
	, SUM(CASE WHEN abs_thema.abschriftart_thema_int_id = 4 
		THEN CASE
			WHEN vis.mandant_id IN (6) AND vis.abschriftart_id = 2 THEN 1 
			WHEN vis.mandant_id IN (3) AND vis.abschriftart_id = 11 THEN 1 
			WHEN vis.mandant_id IN (2,4,5,7,8) AND vis.abschriftart_id = 7 THEN 1 
			WHEN vis.mandant_id IN (2,5) AND vis.abschriftart_id = 10 THEN 1 
			WHEN vis.mandant_id NOT IN (1) AND vis.abschriftart_id = 20 THEN 1 
			ELSE -1 END
		ELSE 0 END * vis.abschrift_netto) AS abs_pa_ist
	, SUM(CASE WHEN abs_thema.abschriftart_thema_int_id = 4 
		THEN CASE 
			WHEN vis.mandant_id IN (6) AND vis.abschriftart_id = 2 THEN 1 
			WHEN vis.mandant_id IN (3) AND vis.abschriftart_id = 11 THEN 1 
			WHEN vis.mandant_id IN (2,4,5,7,8) AND vis.abschriftart_id = 7 THEN 1 
			WHEN vis.mandant_id IN (2,5) AND vis.abschriftart_id = 10 THEN 1 
			WHEN vis.mandant_id NOT IN (1) AND vis.abschriftart_id = 20 THEN 1 
			ELSE -1 END
		ELSE 0 END * vis.abschrift_netto_kvj) AS abs_pa_kvj
	FROM dbp_msi_view_vis.MV_VIS_TAG_ABSCHRIFTEN_WG_2	vis
	JOIN dbp_msi_view_vis.MV_ABSCHRIFTART_INT_ZU_2 abs_art
		ON abs_art.abschriftart_id = vis.abschriftart_id AND abs_art.mandant_id = vis.mandant_id 
	JOIN dbp_msi_view_vis.MV_ABSCHRIFTART_INT_THEMA_ZU_2 abs_thema
		ON abs_thema.abschriftart_int_id = abs_art.abschriftart_int_id
		AND abs_thema.abschriftart_thema_int_id IN (1, 4)
	INNER JOIN DBP_DATA.TAG_2 zeit1
		ON zeit1.dat = vis.dat
	INNER JOIN DBP_DATA.MONAT_2 zeit_2
		ON zeit.kjmo = zeit1.kjmo 
		AND zeit.akt_gj IN (-1, 0) AND zeit.akt_mo < 0  /* 2 GJ */
	INNER JOIN dbp_data.wup_2 wup_2 
		ON wup.wup_id = vis.wup_id AND wup.mandant_id = vis.mandant_id /* Standard Filter VTC : Filiale + definierte NB. Datum Eröffnung fix + GJ Schließung dynamisch */
		AND (wup.nb_id=0 OR wup.wup_id IN (0,2,22,28,43,46,124,8980,8987,8991,100000,100002,100022,100028,100043,100046,100124))
		AND wup.dat_eroeffnung<'2090-12-31' 
		AND (EXTRACT(YEAR FROM wup.dat_bis) + CASE WHEN EXTRACT(MONTH FROM wup.dat_bis) < 3 THEN -1 ELSE 0 END) > (zeit.gj + 1) 
	GROUP BY ALL
) 
, tag_fwws_wg AS ( /* MV_VIS_TAG_FWWS_WG_2 gruppiert */
		SELECT vis.mandant_id, vis.nb_id, vis.wup_id
		, zeit.kjmo
		, SUM(vis.anz_artikel_autodispo_dm12) AS auto_dispo
		, SUM(vis.anz_artikel_exc214)         AS minus_best
		, SUM(CASE WHEN vis.dispomerkmal IN ('10', '11', '14') OR vis.mandant_id <> 1 THEN vis.anz_artikel_exc209 ELSE NULL END) AS null_best
		FROM DBP_MSI_VIEW_VIS.MV_VIS_TAG_FWWS_WG_2 vis
		INNER JOIN DBP_DATA.MONAT_2 zeit_2
		ON zeit.kjmo = vis.kjmo AND zeit.akt_gj IN (-1, 0) AND zeit.akt_mo < 0
		INNER JOIN dbp_data.wup_2 wup_2 
		ON wup.wup_id = vis.wup_id AND wup.mandant_id = vis.mandant_id 
		/* Standard Filter VTC : Filiale + definierte NB. Datum Eröffnung fix + GJ Schließung dynamisch */
		AND (wup.nb_id=0 OR wup.wup_id IN (0,2,22,28,43,46,124,8980,8987,8991,100000,100002,100022,100028,100043,100046,100124))
		AND wup.dat_eroeffnung<'2090-12-31' 
		AND (EXTRACT(YEAR FROM wup.dat_bis) + CASE WHEN EXTRACT(MONTH FROM wup.dat_bis) < 3 THEN -1 ELSE 0 END) > (zeit.gj + 1) 
		WHERE vis.abt_id IN (5,6,7,8) /* ohne Nebengeschäft, ohne Schrott */
		GROUP BY ALL
) 
,  zaehl_auftrag AS ( /* MV_VIS_ZAEHL_AUFTRAG_2 gruppiert ohne wrg_2 */
		SELECT vis.mandant_id, vis.nb_id, vis.wup_id
		, zeit.kjmo
		, SUM(CASE WHEN vis.dat_auftrag IS NOT NULL THEN 1 ELSE 0 END) AS auftrag
		, SUM(CASE WHEN vis.dat_zaehl   IS NOT NULL THEN 1 ELSE 0 END) AS gezaehlt
		FROM DBP_MSI_VIEW_VIS.MV_VIS_ZAEHL_AUFTRAG_2 vis
		INNER JOIN DBP_DATA.TAG_2 zeit1
		ON zeit1.dat = vis.dat_auftrag
		INNER JOIN DBP_DATA.MONAT_2 zeit_2
		ON zeit.kjmo = zeit1.kjmo AND zeit.akt_gj IN (-1, 0) AND zeit.akt_mo < 0
		INNER JOIN DBP_MSI_VIEW_VIS.MV_ART_WG_ZU_2 art_2
		ON art.art_id = vis.art_id AND art.mandant_id = vis.mandant_id
		INNER JOIN DBP_MSI_VIEW_VIS.MV_WG_INT_2 wg
		ON wg.wg_id = art.wg_id
		INNER JOIN DBP_MSI_VIEW_VIS.MV_OWG_INT_2 owg
		ON owg.owg_id = wg.owg_id
		INNER JOIN DBP_MSI_VIEW_VIS.MV_HWG_INT_2 hwg
		ON hwg.hwg_id = owg.hwg_id
		INNER JOIN dbp_data.wup_2 wup_2 
		ON wup.wup_id = vis.wup_id AND wup.mandant_id = vis.mandant_id 
		/* Standard Filter VTC : Filiale + definierte NB. Datum Eröffnung fix + GJ Schließung dynamisch */
		AND (wup.nb_id=0 OR wup.wup_id IN (0,2,22,28,43,46,124,8980,8987,8991,100000,100002,100022,100028,100043,100046,100124))
		AND wup.dat_eroeffnung<'2090-12-31' 
		AND (EXTRACT(YEAR FROM wup.dat_bis) + CASE WHEN EXTRACT(MONTH FROM wup.dat_bis) < 3 THEN -1 ELSE 0 END) > (zeit.gj + 1) 
		WHERE vis.zaehl_grund_id IN ('214','299','300','301','310','311','320','330','340','350','360','814','999') /* definierte Zählgründe */
		AND hwg.abt_id IN (5,6,7,8) /* Abteilung ohne Nebengeschäft */
		GROUP BY ALL
) /* Ende CTE */
 
 
/* VTR100 Umsatz netto inkl. BS */ 
SELECT mandant_id, nb_id, vs_id, vkl_id, wup_id, wrg_id, gj, kjmo, 100::INTEGER AS VTR_ID 
, ist_fil  AS FILIST,  NULL AS FILIST2 
, kvj_fil  AS FILKVJ,  NULL AS FILKVJ2 
, plan_fil AS FILPLAN, NULL AS FILPLAN2 
, ist_reg  AS REGIST,  NULL AS REGIST2 
, kvj_reg  AS REGKVJ,  NULL AS REGKVJ2 
, ist_land AS LANDIST, NULL AS LANDIST2 
, kvj_land AS LANDKVJ, NULL AS LANDKVJ2 
/* Rang absteigend = IST-Plan Prozent (Umsatz netto) inkl. BS */
, CASE WHEN bs_fg*neo_fg=1 THEN DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, kjmo, vs_id ORDER BY fil_mo DESC NULLS LAST) END AS FILMO_RANG
, CASE WHEN neo_fg*stl_fg=1 THEN DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, gj, vs_id ORDER BY fil_gj DESC NULLS LAST) END AS FILGJ_RANG
, CASE WHEN bs_fg*zf_fg=1 THEN DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, kjmo, vs_id ORDER BY vkl_mo DESC NULLS LAST) END AS VKLMO_RANG
, CASE WHEN zf_fg*stl_fg=1 THEN DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, gj, vs_id ORDER BY vkl_gj DESC NULLS LAST) END AS VKLGJ_RANG
, CASE WHEN bs_fg*neo_fg=1 THEN fil_mo END AS FILMO_WERT
, CASE WHEN neo_fg*stl_fg=1 THEN fil_gj END AS FILGJ_WERT
, CASE WHEN bs_fg*zf_fg=1 THEN vkl_mo END AS VKLMO_WERT
, CASE WHEN zf_fg*stl_fg=1 THEN vkl_gj END AS VKLGJ_WERT
FROM ( /* VTR100 Umsatz netto */
	SELECT sub.mandant_id, sub.nb_id, sub.wup_id, sub.wrg_id, sub.vs_id, sub.vkl_id, sub.gj, sub.kjmo
	, sub.ums_ist AS ist_fil
	, sub.ums_plan AS plan_fil
	, sub.ums_kvj AS kvj_fil
	/* Referenz Region_2/Land_2 */
	, SUM(sub.ums_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vs_id) AS ist_reg
	, SUM(sub.ums_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vs_id) AS kvj_reg
	, SUM(sub.ums_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo) AS ist_land
	, SUM(sub.ums_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo) AS kvj_land
	/* Rang : neo_fg = Filialen mind. 1 GJ offen, ohne Schließungmonat, ohne Ausschluss-Liste */
	, CASE WHEN sub.stl_dat > sub.max_dat 
		AND sub.gj > (EXTRACT(YEAR FROM sub.neo_dat)+CASE WHEN EXTRACT(MONTH FROM sub.neo_dat)<3 THEN -1 ELSE 0 END)+1 
		AND sub.nb_id=0 
		AND NOT ( /* Ausschluss Getränkemärkte, Zeltverkauf etc 2024-04-08 */
			(sub.mandant_id=1 AND sub.wup_id IN (1263,1273,2583,3166,6623,7220,8120,8563,8940,5876)) /* DE */ 
			OR (sub.mandant_id=7 AND sub.wup_id IN (1110,1410,6210,6310,6410)) /* RO */ 
			OR (sub.mandant_id=3 AND sub.wup_id IN (1010)) /* PL */
		) THEN 1 ELSE 0 END AS neo_fg
	/* Rang GJ : stl_fg = Filialen ohne Schließungen */
	, CASE WHEN sub.stl_dat BETWEEN TO_DATE(TO_CHAR(sub.gj)||'-03-01','YYYY-MM_2-DD') 
	  AND ADD_MONTHS(TO_DATE(TO_CHAR(sub.gj)||'-03-01','YYYY-MM_2-DD'),12)-1 
	  THEN 0 ELSE 1 END AS stl_fg 
	/* Rang VKL_2 : zf_fg = filialen ohne dummy_2 vkl_2 */
	, CASE WHEN sub.nb_id=0 AND sub.vkl_id>0 THEN 1 ELSE 0 END AS zf_fg
	/* Rang BS : bs_fg = Nur Monate vor Buchungsschluss, wichtig am Monatsanfang*/
	, CASE WHEN sub.akt_bs <= 0 THEN 1 ELSE 0 END AS bs_fg
	/* Setup Rang : filiale monat_2 */
	, (neo_fg*sub.ums_ist)  AS ist_fil_mo
	, (neo_fg*sub.ums_plan) AS plan_fil_mo
	/* Setup Rang : filiale gj inkl. BS */
	, SUM(bs_fg*neo_fg*stl_fg*sub.ums_ist)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.wup_id) AS ist_fil_gj
	, SUM(bs_fg*neo_fg*stl_fg*sub.ums_plan) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.wup_id) AS plan_fil_gj
	/* Setup Rang : vkl_2 monat_2 */
	, SUM(neo_fg*zf_fg*sub.ums_ist)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vkl_id) AS ist_vkl_mo
	, SUM(neo_fg*zf_fg*sub.ums_plan) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vkl_id) AS plan_vkl_mo
	/* Setup Rang : vkl_2 gj inkl. BS */
	, SUM(bs_fg*neo_fg*zf_fg*stl_fg*sub.ums_ist)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.vkl_id) AS ist_vkl_gj
	, SUM(bs_fg*neo_fg*zf_fg*stl_fg*sub.ums_plan) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.vkl_id) AS plan_vkl_gj
	/* Rang absteigend = IST-Plan Prozent (Umsatz netto) */
	, NULLIFZERO(neo_fg)		* ((ist_fil_mo-plan_fil_mo)/(NULLIFZERO(plan_fil_mo))) AS fil_mo
	, NULLIFZERO(neo_fg*stl_fg)	* ((ist_fil_gj-plan_fil_gj)/(NULLIFZERO(plan_fil_gj))) AS fil_gj
	, NULLIFZERO(zf_fg)			* ((ist_vkl_mo-plan_vkl_mo)/(NULLIFZERO(plan_vkl_mo))) AS vkl_mo
	, NULLIFZERO(zf_fg*stl_fg)	* ((ist_vkl_gj-plan_vkl_gj)/(NULLIFZERO(plan_vkl_gj))) AS vkl_gj
	FROM monat_fakt_wup sub
) vtr 
 
/* VTR110 Umsatz Ultra-Frische */ 
UNION ALL SELECT mandant_id, nb_id, vs_id, vkl_id, wup_id, wrg_id, gj, kjmo, 110::INTEGER AS VTR_ID 
, ist_fil  AS FILIST,  NULL AS FILIST2 
, kvj_fil  AS FILKVJ,  NULL AS FILKVJ2 
, NULL     AS FILPLAN, NULL AS FILPLAN2 /* kein plan */
, ist_reg  AS REGIST,  NULL AS REGIST2 
, kvj_reg  AS REGKVJ,  NULL AS REGKVJ2 
, ist_land AS LANDIST, NULL AS LANDIST2 
, kvj_land AS LANDKVJ, NULL AS LANDKVJ2 
/* kein Rang (Umsatz Ultra-Frische) */
, NULL AS FILMO_RANG, NULL AS FILGJ_RANG, NULL AS VKLMO_RANG, NULL AS VKLGJ_RANG 
, NULL AS FILMO_WERT, NULL AS FILGJ_WERT, NULL AS VKLMO_WERT, NULL AS VKLGJ_WERT 
FROM ( /* VTR110 Umsatz Ultra-Frische */
	SELECT sub.mandant_id, sub.nb_id, sub.wup_id, sub.wrg_id, sub.vs_id, sub.vkl_id, sub.gj, sub.kjmo
	, sub1.ums_uf_ist AS ist_fil
	, sub1.ums_uf_kvj AS kvj_fil
	/* Referenz Region_2/Land_2 */
	, SUM(sub1.ums_uf_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vs_id) AS ist_reg
	, SUM(sub1.ums_uf_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vs_id) AS kvj_reg
	, SUM(sub1.ums_uf_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo) AS ist_land
	, SUM(sub1.ums_uf_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo) AS kvj_land
	/* kein Rang */
	FROM monat_fakt_wup sub
	LEFT OUTER JOIN monat_fakt_wg sub1
	ON sub1.wup_id = sub.wup_id AND sub1.mandant_id = sub.mandant_id
	AND sub1.wrg_id = sub.wrg_id AND sub1.kjmo = sub.kjmo
) vtr 
 
/* VTR120 Umsatz SA */  
UNION ALL SELECT mandant_id, nb_id, vs_id, vkl_id, wup_id, wrg_id, gj, kjmo, 120::INTEGER AS VTR_ID 
, ist_fil  AS FILIST,  NULL AS FILIST2 
, kvj_fil  AS FILKVJ,  NULL AS FILKVJ2 
, NULL     AS FILPLAN, NULL AS FILPLAN2 /* kein plan */
, ist_reg  AS REGIST,  NULL AS REGIST2 
, kvj_reg  AS REGKVJ,  NULL AS REGKVJ2 
, ist_land AS LANDIST, NULL AS LANDIST2 
, kvj_land AS LANDKVJ, NULL AS LANDKVJ2 
/* kein Rang (Umsatz SA) */
, NULL AS FILMO_RANG, NULL AS FILGJ_RANG, NULL AS VKLMO_RANG, NULL AS VKLGJ_RANG 
, NULL AS FILMO_WERT, NULL AS FILGJ_WERT, NULL AS VKLMO_WERT, NULL AS VKLGJ_WERT 
FROM ( /* VTR120 Umsatz SA */
	SELECT sub.mandant_id, sub.nb_id, sub.wup_id, sub.wrg_id, sub.vs_id, sub.vkl_id, sub.gj, sub.kjmo
	, sub1.ums_sa_ist AS ist_fil
	, sub2.ums_sa_kvj AS kvj_fil
	/* Referenz Region_2/Land_2 */
	, SUM(sub1.ums_sa_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vs_id) AS ist_reg
	, SUM(sub2.ums_sa_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vs_id) AS kvj_reg
	, SUM(sub1.ums_sa_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo) AS ist_land
	, SUM(sub2.ums_sa_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo) AS kvj_land
	/* kein Rang (Umsatz SA) */
	FROM monat_fakt_wup sub
	LEFT OUTER JOIN ( /* MV_ARTBEW_MO_SUM_2 IST gruppiert */
		SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id
		, zeit.kjmo
		, SUM(vis.umsatz_netto) AS ums_artb_ist
		, SUM(CASE WHEN vis.bewart_id = 1002 THEN vis.umsatz_netto ELSE 0 END) AS ums_sa_ist
		, SUM(CASE WHEN vis.bewart_id = 1001 THEN vis.umsatz_netto ELSE 0 END) AS ums_af_ist /* Reserve AF */
		FROM DBP_MSI_VIEW_VIS.MV_ARTBEW_MO_SUM_2 vis
		INNER JOIN DBP_DATA.MONAT_2 zeit_2
		ON zeit.kjmo = vis.kjmo AND zeit.akt_gj IN (-1, 0) AND zeit.akt_mo < 0
		INNER JOIN dbp_data.wup_2 wup_2 
		ON wup.wup_id = vis.wup_id AND wup.mandant_id = vis.mandant_id 
		/* Standard Filter VTC : Filiale + definierte NB. Datum Eröffnung fix + GJ Schließung dynamisch */
		AND (wup.nb_id=0 OR wup.wup_id IN (0,2,22,28,43,46,124,8980,8987,8991,100000,100002,100022,100028,100043,100046,100124))
		AND wup.dat_eroeffnung<'2090-12-31' 
		AND (EXTRACT(YEAR FROM wup.dat_bis) + CASE WHEN EXTRACT(MONTH FROM wup.dat_bis) < 3 THEN -1 ELSE 0 END) > (zeit.gj + 1) 
		GROUP BY vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.kjmo
	) sub1 
	ON sub1.wup_id = sub.wup_id AND sub1.mandant_id = sub.mandant_id
	AND sub1.wrg_id = sub.wrg_id AND sub1.kjmo = sub.kjmo
	LEFT OUTER JOIN ( /* MV_ARTBEW_MO_SUM_2 KVJ gruppiert */
		SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id
		, zeit.kjmo
		, SUM(vis.umsatz_netto) AS ums_artb_kvj
		, SUM(CASE WHEN vis.bewart_id = 1002 THEN vis.umsatz_netto ELSE 0 END) AS ums_sa_kvj
		, SUM(CASE WHEN vis.bewart_id = 1001 THEN vis.umsatz_netto ELSE 0 END) AS ums_af_kvj /* Reserve AF */
		FROM DBP_MSI_VIEW_VIS.MV_ARTBEW_MO_SUM_2 vis
		INNER JOIN DBP_DATA.MONAT_2 zeit_2
		ON zeit.kjmo = vis.kjmo+100 AND zeit.akt_gj IN (-1, 0) AND zeit.akt_mo < 0
		INNER JOIN dbp_data.wup_2 wup_2 
		ON wup.wup_id = vis.wup_id AND wup.mandant_id = vis.mandant_id 
		/* Standard Filter VTC : Filiale + definierte NB. Datum Eröffnung fix + GJ Schließung dynamisch */
		AND (wup.nb_id=0 OR wup.wup_id IN (0,2,22,28,43,46,124,8980,8987,8991,100000,100002,100022,100028,100043,100046,100124))
		AND wup.dat_eroeffnung<'2090-12-31' 
		AND (EXTRACT(YEAR FROM wup.dat_bis) + CASE WHEN EXTRACT(MONTH FROM wup.dat_bis) < 3 THEN -1 ELSE 0 END) > (zeit.gj + 1) 
		GROUP BY vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.kjmo
	) sub2 
	ON sub2.wup_id = sub.wup_id AND sub2.mandant_id = sub.mandant_id
	AND sub2.wrg_id = sub.wrg_id AND sub2.kjmo = sub.kjmo   
) vtr 
 
/* VTR125 Umsatzanteil SA */ 
UNION ALL SELECT mandant_id, nb_id, vs_id, vkl_id, wup_id, wrg_id, gj, kjmo, 125::INTEGER AS VTR_ID 
, ist_fil  AS FILIST,  ist_fil2  AS FILIST2 
, kvj_fil  AS FILKVJ,  kvj_fil2  AS FILKVJ2 
, NULL     AS FILPLAN, NULL AS FILPLAN2 /* kein plan */
, ist_reg  AS REGIST,  ist_reg2  AS REGIST2 
, kvj_reg  AS REGKVJ,  kvj_reg2  AS REGKVJ2 
, ist_land AS LANDIST, ist_land2 AS LANDIST2 
, kvj_land AS LANDKVJ, kvj_land2 AS LANDKVJ2 
/* kein Rang (Umsatzanteil SA) */
, NULL AS FILMO_RANG, NULL AS FILGJ_RANG, NULL AS VKLMO_RANG, NULL AS VKLGJ_RANG 
, NULL AS FILMO_WERT, NULL AS FILGJ_WERT, NULL AS VKLMO_WERT, NULL AS VKLGJ_WERT 
FROM ( /* VTR125 Umsatzanteil SA */
	SELECT sub.mandant_id, sub.nb_id, sub.wup_id, sub.wrg_id, sub.vs_id, sub.vkl_id, sub.gj, sub.kjmo
	, sub1.ums_sa_ist AS ist_fil
	, sub2.ums_sa_kvj AS kvj_fil
	, sub1.ums_artb_ist AS ist_fil2
	, sub2.ums_artb_kvj AS kvj_fil2
	/* Referenz Region_2/Land_2 */
	, SUM(sub1.ums_sa_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vs_id) AS ist_reg
	, SUM(sub2.ums_sa_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vs_id) AS kvj_reg
	, SUM(sub1.ums_artb_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vs_id) AS ist_reg2
	, SUM(sub2.ums_artb_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vs_id) AS kvj_reg2
	, SUM(sub1.ums_sa_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo) AS ist_land
	, SUM(sub2.ums_sa_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo) AS kvj_land
	, SUM(sub1.ums_artb_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo) AS ist_land2
	, SUM(sub2.ums_artb_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo) AS kvj_land2
	/* kein Rang (Umsatzanteil SA) */
	FROM monat_fakt_wup sub
	LEFT OUTER JOIN ( /* MV_ARTBEW_MO_SUM_2 IST gruppiert */
		SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id
		, zeit.kjmo
		, SUM(vis.umsatz_netto) AS ums_artb_ist
		, SUM(CASE WHEN vis.bewart_id = 1002 THEN vis.umsatz_netto ELSE 0 END) AS ums_sa_ist
		, SUM(CASE WHEN vis.bewart_id = 1001 THEN vis.umsatz_netto ELSE 0 END) AS ums_af_ist /* Reserve AF */
		FROM DBP_MSI_VIEW_VIS.MV_ARTBEW_MO_SUM_2 vis
		INNER JOIN DBP_DATA.MONAT_2 zeit_2
		ON zeit.kjmo = vis.kjmo AND zeit.akt_gj IN (-1, 0) AND zeit.akt_mo < 0
		INNER JOIN dbp_data.wup_2 wup_2 
		ON wup.wup_id = vis.wup_id AND wup.mandant_id = vis.mandant_id 
		/* Standard Filter VTC : Filiale + definierte NB. Datum Eröffnung fix + GJ Schließung dynamisch */
		AND (wup.nb_id=0 OR wup.wup_id IN (0,2,22,28,43,46,124,8980,8987,8991,100000,100002,100022,100028,100043,100046,100124))
		AND wup.dat_eroeffnung<'2090-12-31' 
		AND (EXTRACT(YEAR FROM wup.dat_bis) + CASE WHEN EXTRACT(MONTH FROM wup.dat_bis) < 3 THEN -1 ELSE 0 END) > (zeit.gj + 1) 
		GROUP BY vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.kjmo
	) sub1 
	ON sub1.wup_id = sub.wup_id AND sub1.mandant_id = sub.mandant_id
	AND sub1.wrg_id = sub.wrg_id AND sub1.kjmo = sub.kjmo
	LEFT OUTER JOIN ( /* MV_ARTBEW_MO_SUM_2 KVJ gruppiert */
		SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id
		, zeit.kjmo
		, SUM(vis.umsatz_netto) AS ums_artb_kvj
		, SUM(CASE WHEN vis.bewart_id = 1002 THEN vis.umsatz_netto ELSE 0 END) AS ums_sa_kvj
		, SUM(CASE WHEN vis.bewart_id = 1001 THEN vis.umsatz_netto ELSE 0 END) AS ums_af_kvj /* Reserve AF */
		FROM DBP_MSI_VIEW_VIS.MV_ARTBEW_MO_SUM_2 vis
		INNER JOIN DBP_DATA.MONAT_2 zeit_2
		ON zeit.kjmo = vis.kjmo+100 AND zeit.akt_gj IN (-1, 0) AND zeit.akt_mo < 0
		INNER JOIN dbp_data.wup_2 wup_2 
		ON wup.wup_id = vis.wup_id AND wup.mandant_id = vis.mandant_id 
		/* Standard Filter VTC : Filiale + definierte NB. Datum Eröffnung fix + GJ Schließung dynamisch */
		AND (wup.nb_id=0 OR wup.wup_id IN (0,2,22,28,43,46,124,8980,8987,8991,100000,100002,100022,100028,100043,100046,100124))
		AND wup.dat_eroeffnung<'2090-12-31' 
		AND (EXTRACT(YEAR FROM wup.dat_bis) + CASE WHEN EXTRACT(MONTH FROM wup.dat_bis) < 3 THEN -1 ELSE 0 END) > (zeit.gj + 1) 
		GROUP BY vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.kjmo
	) sub2 
	ON sub2.wup_id = sub.wup_id AND sub2.mandant_id = sub.mandant_id
	AND sub2.wrg_id = sub.wrg_id AND sub2.kjmo = sub.kjmo   
) vtr 
 
/* VTR140 Absatz (ohne Pfand) */ 
UNION ALL SELECT mandant_id, nb_id, vs_id, vkl_id, wup_id, wrg_id, gj, kjmo, 140::INTEGER AS VTR_ID 
, ist_fil  AS FILIST,  NULL AS FILIST2 
, kvj_fil  AS FILKVJ,  NULL AS FILKVJ2 
, NULL     AS FILPLAN, NULL AS FILPLAN2 /* kein plan */
, ist_reg  AS REGIST,  NULL AS REGIST2 
, kvj_reg  AS REGKVJ,  NULL AS REGKVJ2 
, ist_land AS LANDIST, NULL AS LANDIST2 
, kvj_land AS LANDKVJ, NULL AS LANDKVJ2 
/* kein Rang (Absatz) */
, NULL AS FILMO_RANG, NULL AS FILGJ_RANG, NULL AS VKLMO_RANG, NULL AS VKLGJ_RANG 
, NULL AS FILMO_WERT, NULL AS FILGJ_WERT, NULL AS VKLMO_WERT, NULL AS VKLGJ_WERT 
FROM ( /* VTR140 Absatz */
	SELECT sub.mandant_id, sub.nb_id, sub.wup_id, sub.wrg_id, sub.vs_id, sub.vkl_id, sub.gj, sub.kjmo
	, sub1.mng_opf_ist AS ist_fil
	, sub1.mng_opf_kvj AS kvj_fil
	/* Referenz Region_2/Land_2 */
	, SUM(sub1.mng_opf_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vs_id) AS ist_reg
	, SUM(sub1.mng_opf_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vs_id) AS kvj_reg
	, SUM(sub1.mng_opf_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo) AS ist_land
	, SUM(sub1.mng_opf_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo) AS kvj_land
	/* Rang : neo_fg = Filialen mind. 1 GJ offen, ohne Schließungmonat, ohne Ausschluss-Liste */
	, CASE WHEN sub.stl_dat > sub.max_dat 
		AND sub.gj > (EXTRACT(YEAR FROM sub.neo_dat)+CASE WHEN EXTRACT(MONTH FROM sub.neo_dat)<3 THEN -1 ELSE 0 END)+1 
		AND sub.nb_id=0 
		AND NOT ( /* Ausschluss Getränkemärkte, Zeltverkauf etc 2024-04-08 */
			(sub.mandant_id=1 AND sub.wup_id IN (1263,1273,2583,3166,6623,7220,8120,8563,8940,5876)) /* DE */ 
			OR (sub.mandant_id=7 AND sub.wup_id IN (1110,1410,6210,6310,6410)) /* RO */ 
			OR (sub.mandant_id=3 AND sub.wup_id IN (1010)) /* PL */
		) THEN 1 ELSE 0 END AS neo_fg
	/* Rang GJ : stl_fg = Filialen ohne Schließungen */
	, CASE WHEN sub.stl_dat BETWEEN TO_DATE(TO_CHAR(sub.gj)||'-03-01','YYYY-MM_2-DD') 
	  AND ADD_MONTHS(TO_DATE(TO_CHAR(sub.gj)||'-03-01','YYYY-MM_2-DD'),12)-1 
	  THEN 0 ELSE 1 END AS stl_fg 
	/* Rang VKL_2 : zf_fg = filialen ohne dummy_2 vkl_2 */
	, CASE WHEN sub.nb_id=0 AND sub.vkl_id>0 THEN 1 ELSE 0 END AS zf_fg
	/* Setup Rang : filiale monat_2 */
	, (neo_fg*sub1.mng_opf_ist) AS ist_fil_mo
	, (neo_fg*sub1.mng_opf_kvj) AS kvj_fil_mo
	/* Setup Rang : filiale gj */
	, SUM(neo_fg*stl_fg*sub1.mng_opf_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.wup_id) AS ist_fil_gj
	, SUM(neo_fg*stl_fg*sub1.mng_opf_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.wup_id) AS kvj_fil_gj
	/* Setup Rang : vkl_2 monat_2 */
	, SUM(neo_fg*zf_fg*sub1.mng_opf_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vkl_id) AS ist_vkl_mo
	, SUM(neo_fg*zf_fg*sub1.mng_opf_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vkl_id) AS kvj_vkl_mo
	/* Setup Rang : vkl_2 gj */
	, SUM(neo_fg*zf_fg*stl_fg*sub1.mng_opf_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.vkl_id) AS ist_vkl_gj
	, SUM(neo_fg*zf_fg*stl_fg*sub1.mng_opf_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.vkl_id) AS kvj_vkl_gj
	/* not used : Rang absteigend = IST-KVJ Prozent (Absatz) */
	, NULLIFZERO(neo_fg)		* ((ist_fil_mo-kvj_fil_mo)/(NULLIFZERO(kvj_fil_mo))) AS fil_mo
	, NULLIFZERO(neo_fg*stl_fg)	* ((ist_fil_gj-kvj_fil_gj)/(NULLIFZERO(kvj_fil_gj))) AS fil_gj
	, NULLIFZERO(zf_fg)			* ((ist_vkl_mo-kvj_vkl_mo)/(NULLIFZERO(kvj_vkl_mo))) AS vkl_mo
	, NULLIFZERO(zf_fg*stl_fg)	* ((ist_vkl_gj-kvj_vkl_gj)/(NULLIFZERO(kvj_vkl_gj))) AS vkl_gj
	FROM monat_fakt_wup sub
	LEFT OUTER JOIN monat_fakt_wg sub1
	ON sub1.wup_id = sub.wup_id AND sub1.mandant_id = sub.mandant_id
	AND sub1.wrg_id = sub.wrg_id AND sub1.kjmo = sub.kjmo
) vtr 
 
/* VTR160 Kundenanzahl */ 
UNION ALL SELECT mandant_id, nb_id, vs_id, vkl_id, wup_id, wrg_id, gj, kjmo, 160::INTEGER AS VTR_ID 
, ist_fil  AS FILIST,  NULL AS FILIST2 
, kvj_fil  AS FILKVJ,  NULL AS FILKVJ2 
, NULL     AS FILPLAN, NULL AS FILPLAN2 /* kein plan */
, ist_reg  AS REGIST,  NULL AS REGIST2 
, kvj_reg  AS REGKVJ,  NULL AS REGKVJ2 
, ist_land AS LANDIST, NULL AS LANDIST2 
, kvj_land AS LANDKVJ, NULL AS LANDKVJ2 
/* kein Rang (Kundenanzahl) */
, NULL AS FILMO_RANG, NULL AS FILGJ_RANG, NULL AS VKLMO_RANG, NULL AS VKLGJ_RANG 
, NULL AS FILMO_WERT, NULL AS FILGJ_WERT, NULL AS VKLMO_WERT, NULL AS VKLGJ_WERT 
FROM ( /* VTR160 Kundenanzahl */
	SELECT sub.mandant_id, sub.nb_id, sub.wup_id, sub.wrg_id, sub.vs_id, sub.vkl_id, sub.gj, sub.kjmo
	, sub.knd_ist AS ist_fil
	, sub.knd_kvj AS kvj_fil
	/* Referenz Region_2/Land_2 */
	, SUM(sub.knd_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vs_id) AS ist_reg
	, SUM(sub.knd_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vs_id) AS kvj_reg
	, SUM(sub.knd_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo) AS ist_land
	, SUM(sub.knd_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo) AS kvj_land
	/* Rang : neo_fg = Filialen mind. 1 GJ offen, ohne Schließungmonat, ohne Ausschluss-Liste */
	, CASE WHEN sub.stl_dat > sub.max_dat 
		AND sub.gj > (EXTRACT(YEAR FROM sub.neo_dat)+CASE WHEN EXTRACT(MONTH FROM sub.neo_dat)<3 THEN -1 ELSE 0 END)+1 
		AND sub.nb_id=0 
		AND NOT ( /* Ausschluss Getränkemärkte, Zeltverkauf etc 2024-04-08 */
			(sub.mandant_id=1 AND sub.wup_id IN (1263,1273,2583,3166,6623,7220,8120,8563,8940,5876)) /* DE */ 
			OR (sub.mandant_id=7 AND sub.wup_id IN (1110,1410,6210,6310,6410)) /* RO */ 
			OR (sub.mandant_id=3 AND sub.wup_id IN (1010)) /* PL */
		) THEN 1 ELSE 0 END AS neo_fg
	/* Rang GJ : stl_fg = Filialen ohne Schließungen */
	, CASE WHEN sub.stl_dat BETWEEN TO_DATE(TO_CHAR(sub.gj)||'-03-01','YYYY-MM_2-DD') 
	  AND ADD_MONTHS(TO_DATE(TO_CHAR(sub.gj)||'-03-01','YYYY-MM_2-DD'),12)-1 
	  THEN 0 ELSE 1 END AS stl_fg 
	/* Rang VKL_2 : zf_fg = filialen ohne dummy_2 vkl_2 */
	, CASE WHEN sub.nb_id=0 AND sub.vkl_id>0 THEN 1 ELSE 0 END AS zf_fg
	/* Setup Rang : filiale monat_2 */
	, (neo_fg*sub.knd_ist)  AS ist_fil_mo
	, (neo_fg*sub.knd_kvj)  AS kvj_fil_mo
	/* Setup Rang : filiale gj */
	, SUM(neo_fg*stl_fg*sub.knd_ist)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.wup_id) AS ist_fil_gj
	, SUM(neo_fg*stl_fg*sub.knd_kvj)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.wup_id) AS kvj_fil_gj
	/* Setup Rang : vkl_2 monat_2 */
	, SUM(neo_fg*zf_fg*sub.knd_ist)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vkl_id) AS ist_vkl_mo
	, SUM(neo_fg*zf_fg*sub.knd_kvj)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vkl_id) AS kvj_vkl_mo
	/* Setup Rang : vkl_2 gj */
	, SUM(neo_fg*zf_fg*stl_fg*sub.knd_ist)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.vkl_id) AS ist_vkl_gj
	, SUM(neo_fg*zf_fg*stl_fg*sub.knd_kvj)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.vkl_id) AS kvj_vkl_gj
	/* not used : Rang absteigend = IST-KVJ Prozent (Kundenanzahl) */
	, NULLIFZERO(neo_fg)		*((ist_fil_mo-kvj_fil_mo)/(NULLIFZERO(kvj_fil_mo))) AS fil_mo
	, NULLIFZERO(neo_fg*stl_fg)	*((ist_fil_gj-kvj_fil_gj)/(NULLIFZERO(kvj_fil_gj))) AS fil_gj
	, NULLIFZERO(zf_fg) 		*((ist_vkl_mo-kvj_vkl_mo)/(NULLIFZERO(kvj_vkl_mo))) AS vkl_mo
	, NULLIFZERO(zf_fg*stl_fg)	*((ist_vkl_gj-kvj_vkl_gj)/(NULLIFZERO(kvj_vkl_gj))) AS vkl_gj
	FROM monat_fakt_wup sub
) vtr 
 
/* VTR180 Ø-Bon */ 
UNION ALL SELECT mandant_id, nb_id, vs_id, vkl_id, wup_id, wrg_id, gj, kjmo, 180::INTEGER AS VTR_ID 
, ist_fil  AS FILIST,  ist_fil2  AS FILIST2 
, kvj_fil  AS FILKVJ,  kvj_fil2  AS FILKVJ2 
, NULL     AS FILPLAN, NULL      AS FILPLAN2 /* kein Plan */
, ist_reg  AS REGIST,  ist_reg2  AS REGIST2 
, kvj_reg  AS REGKVJ,  kvj_reg2  AS REGKVJ2 
, ist_land AS LANDIST, ist_land2 AS LANDIST2 
, kvj_land AS LANDKVJ, kvj_land2 AS LANDKVJ2 
/* kein Rang (Ø-Bon) */
, NULL AS FILMO_RANG, NULL AS FILGJ_RANG, NULL AS VKLMO_RANG, NULL AS VKLGJ_RANG 
, NULL AS FILMO_WERT, NULL AS FILGJ_WERT, NULL AS VKLMO_WERT, NULL AS VKLGJ_WERT 
FROM ( /* VTR180 Ø-Bon */
	SELECT sub.mandant_id, sub.nb_id, sub.wup_id, sub.wrg_id, sub.vs_id, sub.vkl_id, sub.gj, sub.kjmo
	, sub.ums_ist AS ist_fil
	, sub.ums_kvj AS kvj_fil
	, sub.knd_ist AS ist_fil2
	, sub.knd_kvj AS kvj_fil2
	/* Referenz Region_2/Land_2 */
	, SUM(sub.ums_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vs_id) AS ist_reg
	, SUM(sub.ums_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vs_id) AS kvj_reg
	, SUM(sub.ums_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo) AS ist_land
	, SUM(sub.ums_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo) AS kvj_land
	, SUM(sub.knd_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vs_id) AS ist_reg2
	, SUM(sub.knd_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vs_id) AS kvj_reg2
	, SUM(sub.knd_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo) AS ist_land2
	, SUM(sub.knd_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo) AS kvj_land2
	/* Rang : neo_fg = Filialen mind. 1 GJ offen, ohne Schließungmonat, ohne Ausschluss-Liste */
	, CASE WHEN sub.stl_dat > sub.max_dat 
		AND sub.gj > (EXTRACT(YEAR FROM sub.neo_dat)+CASE WHEN EXTRACT(MONTH FROM sub.neo_dat)<3 THEN -1 ELSE 0 END)+1 
		AND sub.nb_id=0 
		AND NOT ( /* Ausschluss Getränkemärkte, Zeltverkauf etc 2024-04-08 */
			(sub.mandant_id=1 AND sub.wup_id IN (1263,1273,2583,3166,6623,7220,8120,8563,8940,5876)) /* DE */ 
			OR (sub.mandant_id=7 AND sub.wup_id IN (1110,1410,6210,6310,6410)) /* RO */ 
			OR (sub.mandant_id=3 AND sub.wup_id IN (1010)) /* PL */
		) THEN 1 ELSE 0 END AS neo_fg
	/* Rang GJ : stl_fg = Filialen ohne Schließungen */
	, CASE WHEN sub.stl_dat BETWEEN TO_DATE(TO_CHAR(sub.gj)||'-03-01','YYYY-MM_2-DD') 
	  AND ADD_MONTHS(TO_DATE(TO_CHAR(sub.gj)||'-03-01','YYYY-MM_2-DD'),12)-1 
	  THEN 0 ELSE 1 END AS stl_fg 
	/* Rang VKL_2 : zf_fg = filialen ohne dummy_2 vkl_2 */
	, CASE WHEN sub.nb_id=0 AND sub.vkl_id>0 THEN 1 ELSE 0 END AS zf_fg
	/* Setup Rang :filiale monat_2 */
	, (neo_fg*sub.ums_ist) AS ist_fil_mo
	, (neo_fg*sub.ums_kvj) AS kvj_fil_mo
	, (neo_fg*sub.knd_ist) AS ist_fil_mo2
	, (neo_fg*sub.knd_kvj) AS kvj_fil_mo2
	/* Setup Rang :filiale gj */
	, SUM(neo_fg*stl_fg*sub.ums_ist)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.wup_id) AS ist_fil_gj
	, SUM(neo_fg*stl_fg*sub.ums_kvj)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.wup_id) AS kvj_fil_gj
	, SUM(neo_fg*stl_fg*sub.knd_ist)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.wup_id) AS ist_fil_gj2
	, SUM(neo_fg*stl_fg*sub.knd_kvj)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.wup_id) AS kvj_fil_gj2
	/* Setup Rang :vkl_2 monat_2 (werte mit neo_fg, rang ohne neo_fg) */
	, SUM(neo_fg*zf_fg*sub.ums_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vkl_id) AS ist_vkl_mo
	, SUM(neo_fg*zf_fg*sub.ums_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vkl_id) AS kvj_vkl_mo
	, SUM(neo_fg*zf_fg*sub.knd_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vkl_id) AS ist_vkl_mo2
	, SUM(neo_fg*zf_fg*sub.knd_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vkl_id) AS kvj_vkl_mo2
	/* Setup Rang :vkl_2 gj */
	, SUM(neo_fg*zf_fg*stl_fg*sub.ums_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.vkl_id) AS ist_vkl_gj
	, SUM(neo_fg*zf_fg*stl_fg*sub.ums_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.vkl_id) AS kvj_vkl_gj
	, SUM(neo_fg*zf_fg*stl_fg*sub.knd_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.vkl_id) AS ist_vkl_gj2
	, SUM(neo_fg*zf_fg*stl_fg*sub.knd_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.vkl_id) AS kvj_vkl_gj2
	/* not used : Rang absteigend = IST-KVJ absolut (Ø-Bon) */
	, NULLIFZERO(neo_fg)	   *((ist_fil_mo/NULLIFZERO(ist_fil_mo2))-(kvj_fil_mo/NULLIFZERO(kvj_fil_mo2))) AS fil_mo
	, NULLIFZERO(neo_fg*stl_fg)*((ist_fil_gj/NULLIFZERO(ist_fil_gj2))-(kvj_fil_gj/NULLIFZERO(kvj_fil_gj2))) AS fil_gj
	, NULLIFZERO(zf_fg)		   *((ist_vkl_mo/NULLIFZERO(ist_vkl_mo2))-(kvj_vkl_mo/NULLIFZERO(kvj_vkl_mo2))) AS vkl_mo
	, NULLIFZERO(zf_fg*stl_fg) *((ist_vkl_gj/NULLIFZERO(ist_vkl_gj2))-(kvj_vkl_gj/NULLIFZERO(kvj_vkl_gj2))) AS vkl_gj 
	FROM monat_fakt_wup sub
) vtr 
 
/* VTR200 Nettostunden */ 
UNION ALL SELECT mandant_id, nb_id, vs_id, vkl_id, wup_id, wrg_id, gj, kjmo, 200::INTEGER AS VTR_ID 
, ist_fil  AS FILIST,  NULL AS FILIST2 
, kvj_fil  AS FILKVJ,  NULL AS FILKVJ2 
, plan_fil AS FILPLAN, NULL AS FILPLAN2 
, ist_reg  AS REGIST,  NULL AS REGIST2 
, kvj_reg  AS REGKVJ,  NULL AS REGKVJ2 
, ist_land AS LANDIST, NULL AS LANDIST2 
, kvj_land AS LANDKVJ, NULL AS LANDKVJ2 
/* Rang absteigend: IST-Plan prozent (Nettostunden) */
, CASE WHEN neo_fg=1 THEN DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, kjmo, vs_id ORDER BY fil_mo DESC NULLS LAST) END AS FILMO_RANG
, CASE WHEN neo_fg*stl_fg=1 THEN DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, gj, vs_id ORDER BY fil_gj DESC NULLS LAST) END AS FILGJ_RANG
, CASE WHEN zf_fg=1 THEN DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, kjmo, vs_id ORDER BY vkl_mo DESC NULLS LAST) END AS VKLMO_RANG
, CASE WHEN zf_fg*stl_fg=1 THEN DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, gj, vs_id ORDER BY vkl_gj DESC NULLS LAST) END AS VKLGJ_RANG
, CASE WHEN neo_fg=1 THEN fil_mo END AS FILMO_WERT
, CASE WHEN neo_fg*stl_fg=1 THEN fil_gj END AS FILGJ_WERT
, CASE WHEN zf_fg=1 THEN vkl_mo END AS VKLMO_WERT
, CASE WHEN zf_fg*stl_fg=1 THEN vkl_gj END AS VKLGJ_WERT
FROM ( /* VTR200 Nettostunden */
	SELECT sub.mandant_id, sub.nb_id, sub.wup_id, sub.wrg_id, sub.vs_id, sub.vkl_id, sub.gj, sub.kjmo
	, sub.std_ist AS ist_fil
	, sub.std_kvj AS kvj_fil
	, sub.std_plan AS plan_fil
	/* Referenz Region_2/Land_2 */
	, SUM(sub.std_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vs_id) AS ist_reg
	, SUM(sub.std_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vs_id) AS kvj_reg
	, SUM(sub.std_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo) AS ist_land
	, SUM(sub.std_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo) AS kvj_land
	/* Rang : neo_fg = Filialen mind. 1 GJ offen, ohne Schließungmonat, ohne Ausschluss-Liste */
	, CASE WHEN sub.stl_dat > sub.max_dat 
		AND sub.gj > (EXTRACT(YEAR FROM sub.neo_dat)+CASE WHEN EXTRACT(MONTH FROM sub.neo_dat)<3 THEN -1 ELSE 0 END)+1 
		AND sub.nb_id=0 
		AND NOT ( /* Ausschluss Getränkemärkte, Zeltverkauf etc 2024-04-08 */
			(sub.mandant_id=1 AND sub.wup_id IN (1263,1273,2583,3166,6623,7220,8120,8563,8940,5876)) /* DE */ 
			OR (sub.mandant_id=7 AND sub.wup_id IN (1110,1410,6210,6310,6410)) /* RO */ 
			OR (sub.mandant_id=3 AND sub.wup_id IN (1010)) /* PL */
		) THEN 1 ELSE 0 END AS neo_fg
	/* Rang GJ : stl_fg = Filialen ohne Schließungen */
	, CASE WHEN sub.stl_dat BETWEEN TO_DATE(TO_CHAR(sub.gj)||'-03-01','YYYY-MM_2-DD') 
	  AND ADD_MONTHS(TO_DATE(TO_CHAR(sub.gj)||'-03-01','YYYY-MM_2-DD'),12)-1 
	  THEN 0 ELSE 1 END AS stl_fg 
	/* Rang VKL_2 : zf_fg = filialen ohne dummy_2 vkl_2 */
	, CASE WHEN sub.nb_id=0 AND sub.vkl_id>0 THEN 1 ELSE 0 END AS zf_fg
	/* Setup Rang :filiale monat_2 */
	, (neo_fg*sub.std_ist)  AS ist_fil_mo
	, (neo_fg*sub.std_plan) AS plan_fil_mo
	/* Setup Rang :filiale gj */
	, SUM(neo_fg*stl_fg*sub.std_ist)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.wup_id) AS ist_fil_gj
	, SUM(neo_fg*stl_fg*sub.std_plan) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.wup_id) AS plan_fil_gj
	/* Setup Rang :vkl_2 monat_2 - werte mit neo_fg, rang ohne neo_fg */
	, SUM(neo_fg*zf_fg*sub.std_ist)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vkl_id) AS ist_vkl_mo
	, SUM(neo_fg*zf_fg*sub.std_plan) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vkl_id) AS plan_vkl_mo
	/* Setup Rang :vkl_2 gj */
	, SUM(neo_fg*zf_fg*stl_fg*sub.std_ist)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.vkl_id) AS ist_vkl_gj
	, SUM(neo_fg*zf_fg*stl_fg*sub.std_plan) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.vkl_id) AS plan_vkl_gj
	/* Rang absteigend: IST-Plan prozent (Nettostunden) */
	, NULLIFZERO(neo_fg)        * ((ist_fil_mo-NULLIFZERO(plan_fil_mo))/(NULLIFZERO(plan_fil_mo))) AS fil_mo
	, NULLIFZERO(neo_fg*stl_fg) * ((ist_fil_gj-NULLIFZERO(plan_fil_gj))/(NULLIFZERO(plan_fil_gj))) AS fil_gj
	, NULLIFZERO(zf_fg)         * ((ist_vkl_mo-NULLIFZERO(plan_vkl_mo))/(NULLIFZERO(plan_vkl_mo))) AS vkl_mo
	, NULLIFZERO(zf_fg*stl_fg)  * ((ist_vkl_gj-NULLIFZERO(plan_vkl_gj))/(NULLIFZERO(plan_vkl_gj))) AS vkl_gj 
	FROM monat_fakt_wup sub
) vtr 
 
/* VTR210 Nettoleistung */ 
UNION ALL SELECT mandant_id, nb_id, vs_id, vkl_id, wup_id, wrg_id, gj, kjmo, 210::INTEGER AS VTR_ID 
, ist_fil  AS FILIST,  ist_fil2  AS FILIST2 
, kvj_fil  AS FILKVJ,  kvj_fil2  AS FILKVJ2 
, plan_fil AS FILPLAN, plan_fil2 AS FILPLAN2 
, ist_reg  AS REGIST,  ist_reg2  AS REGIST2 
, kvj_reg  AS REGKVJ,  kvj_reg2  AS REGKVJ2 
, ist_land AS LANDIST, ist_land2 AS LANDIST2 
, kvj_land AS LANDKVJ, kvj_land2 AS LANDKVJ2 
/* Rang absteigend: IST-Plan absolut (Umsatz/Nettostunden) */
, CASE WHEN bs_fg*neo_fg=1 THEN DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, kjmo, vs_id ORDER BY fil_mo DESC NULLS LAST) END AS FILMO_RANG
, CASE WHEN neo_fg*stl_fg=1 THEN DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, gj, vs_id ORDER BY fil_gj DESC NULLS LAST) END AS FILGJ_RANG
, CASE WHEN bs_fg*zf_fg=1 THEN DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, kjmo, vs_id ORDER BY vkl_mo DESC NULLS LAST) END AS VKLMO_RANG
, CASE WHEN zf_fg*stl_fg=1 THEN DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, gj, vs_id ORDER BY vkl_gj DESC NULLS LAST) END AS VKLGJ_RANG
, CASE WHEN bs_fg*neo_fg=1 THEN fil_mo END AS FILMO_WERT
, CASE WHEN neo_fg*stl_fg=1 THEN fil_gj END AS FILGJ_WERT
, CASE WHEN bs_fg*zf_fg=1 THEN vkl_mo END AS VKLMO_WERT
, CASE WHEN zf_fg*stl_fg=1 THEN vkl_gj END AS VKLGJ_WERT
FROM ( /* VTR210 Nettoleistung */
	SELECT sub.mandant_id, sub.nb_id, sub.wup_id, sub.wrg_id, sub.vs_id, sub.vkl_id, sub.gj, sub.kjmo
	, sub.ums_ist AS ist_fil
	, sub.ums_plan AS plan_fil
	, sub.ums_kvj AS kvj_fil
	, sub.std_ist AS ist_fil2
	, sub.std_plan AS plan_fil2
	, sub.std_kvj AS kvj_fil2
	/* Referenz Region_2/Land_2 */
	, SUM(sub.ums_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vs_id) AS ist_reg
	, SUM(sub.ums_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vs_id) AS kvj_reg
	, SUM(sub.ums_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo) AS ist_land
	, SUM(sub.ums_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo) AS kvj_land
	, SUM(sub.std_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vs_id) AS ist_reg2
	, SUM(sub.std_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vs_id) AS kvj_reg2
	, SUM(sub.std_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo) AS ist_land2
	, SUM(sub.std_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo) AS kvj_land2
	/* Rang : neo_fg = Filialen mind. 1 GJ offen, ohne Schließungmonat, ohne Ausschluss-Liste */
	, CASE WHEN sub.stl_dat > sub.max_dat 
		AND sub.gj > (EXTRACT(YEAR FROM sub.neo_dat)+CASE WHEN EXTRACT(MONTH FROM sub.neo_dat)<3 THEN -1 ELSE 0 END)+1 
		AND sub.nb_id=0 
		AND NOT ( /* Ausschluss Getränkemärkte, Zeltverkauf etc 2024-04-08 */
			(sub.mandant_id=1 AND sub.wup_id IN (1263,1273,2583,3166,6623,7220,8120,8563,8940,5876)) /* DE */ 
			OR (sub.mandant_id=7 AND sub.wup_id IN (1110,1410,6210,6310,6410)) /* RO */ 
			OR (sub.mandant_id=3 AND sub.wup_id IN (1010)) /* PL */
		) THEN 1 ELSE 0 END AS neo_fg
	/* Rang GJ : stl_fg = Filialen ohne Schließungen */
	, CASE WHEN sub.stl_dat BETWEEN TO_DATE(TO_CHAR(sub.gj)||'-03-01','YYYY-MM_2-DD') 
	  AND ADD_MONTHS(TO_DATE(TO_CHAR(sub.gj)||'-03-01','YYYY-MM_2-DD'),12)-1 
	  THEN 0 ELSE 1 END AS stl_fg 
	/* Rang VKL_2 : zf_fg = filialen ohne dummy_2 vkl_2 */
	, CASE WHEN sub.nb_id=0 AND sub.vkl_id>0 THEN 1 ELSE 0 END AS zf_fg
	/* Rang BS : bs_fg = Nur Monate vor Buchungsschluss, wichtig am Monatsanfang*/
	, CASE WHEN sub.akt_bs <= 0 THEN 1 ELSE 0 END AS bs_fg
	/* Setup Rang :filiale monat_2 */
	, (neo_fg*sub.ums_ist)  AS ist_fil_mo
	, (neo_fg*sub.ums_plan) AS plan_fil_mo
	, (neo_fg*sub.std_ist)  AS ist_fil_mo2
	, (neo_fg*sub.std_plan) AS plan_fil_mo2
	/* Setup Rang :filiale gj inkl BS*/
	, SUM(bs_fg*neo_fg*stl_fg*sub.ums_ist)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.wup_id) AS ist_fil_gj
	, SUM(bs_fg*neo_fg*stl_fg*sub.ums_plan) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.wup_id) AS plan_fil_gj
	, SUM(bs_fg*neo_fg*stl_fg*sub.std_ist)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.wup_id) AS ist_fil_gj2
	, SUM(bs_fg*neo_fg*stl_fg*sub.std_plan) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.wup_id) AS plan_fil_gj2
	/* Setup Rang :vkl_2 monat_2 - werte mit neo_fg, rang ohne neo_fg */
	, SUM(neo_fg*zf_fg*sub.ums_ist)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vkl_id) AS ist_vkl_mo
	, SUM(neo_fg*zf_fg*sub.ums_plan) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vkl_id) AS plan_vkl_mo
	, SUM(neo_fg*zf_fg*sub.std_ist)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vkl_id) AS ist_vkl_mo2
	, SUM(neo_fg*zf_fg*sub.std_plan) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vkl_id) AS plan_vkl_mo2
	/* Setup Rang :vkl_2 gj inkl BS */
	, SUM(bs_fg*neo_fg*zf_fg*stl_fg*sub.ums_ist)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.vkl_id) AS ist_vkl_gj
	, SUM(bs_fg*neo_fg*zf_fg*stl_fg*sub.ums_plan) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.vkl_id) AS plan_vkl_gj
	, SUM(bs_fg*neo_fg*zf_fg*stl_fg*sub.std_ist)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.vkl_id) AS ist_vkl_gj2
	, SUM(bs_fg*neo_fg*zf_fg*stl_fg*sub.std_plan) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.vkl_id) AS plan_vkl_gj2
	/* Rang absteigend: IST-Plan absolut (Umsatz/Nettostunden) */
	, NULLIFZERO(neo_fg)       *((ist_fil_mo/NULLIFZERO(ist_fil_mo2))-(plan_fil_mo/NULLIFZERO(plan_fil_mo2))) AS fil_mo
	, NULLIFZERO(neo_fg*stl_fg)*((ist_fil_gj/NULLIFZERO(ist_fil_gj2))-(plan_fil_gj/NULLIFZERO(plan_fil_gj2))) AS fil_gj
	, NULLIFZERO(zf_fg)        *((ist_vkl_mo/NULLIFZERO(ist_vkl_mo2))-(plan_vkl_mo/NULLIFZERO(plan_vkl_mo2))) AS vkl_mo
	, NULLIFZERO(zf_fg*stl_fg) *((ist_vkl_gj/NULLIFZERO(ist_vkl_gj2))-(plan_vkl_gj/NULLIFZERO(plan_vkl_gj2))) AS vkl_gj 
	FROM monat_fakt_wup sub
) vtr 
 
/* VTR220 Nettostückleistung (ohne Pfand)*/ 
UNION ALL SELECT mandant_id, nb_id, vs_id, vkl_id, wup_id, wrg_id, gj, kjmo, 220::INTEGER AS VTR_ID 
, ist_fil  AS FILIST,  ist_fil2  AS FILIST2 
, kvj_fil  AS FILKVJ,  kvj_fil2  AS FILKVJ2 
, NULL     AS FILPLAN, NULL      AS FILPLAN2 /* kein plan */
, ist_reg  AS REGIST,  ist_reg2  AS REGIST2 
, kvj_reg  AS REGKVJ,  kvj_reg2  AS REGKVJ2 
, ist_land AS LANDIST, ist_land2 AS LANDIST2 
, kvj_land AS LANDKVJ, kvj_land2 AS LANDKVJ2 
/* kein Rang (Nettostückleistung) */
, NULL AS FILMO_RANG, NULL AS FILGJ_RANG, NULL AS VKLMO_RANG, NULL AS VKLGJ_RANG 
, NULL AS FILMO_WERT, NULL AS FILGJ_WERT, NULL AS VKLMO_WERT, NULL AS VKLGJ_WERT 
FROM ( /* VTR220 Nettostückleistung (ohne Pfand) */
	SELECT sub.mandant_id, sub.nb_id, sub.wup_id, sub.wrg_id, sub.vs_id, sub.vkl_id, sub.gj, sub.kjmo
	, sub1.mng_opf_ist AS ist_fil
	, sub1.mng_opf_kvj AS kvj_fil
	, sub.std_ist AS ist_fil2
	, sub.std_kvj AS kvj_fil2
	/* Referenz Region_2/Land_2 */
	, SUM(sub1.mng_opf_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vs_id) AS ist_reg
	, SUM(sub1.mng_opf_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vs_id) AS kvj_reg
	, SUM(sub1.mng_opf_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo) AS ist_land
	, SUM(sub1.mng_opf_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo) AS kvj_land
	, SUM(sub.std_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vs_id) AS ist_reg2
	, SUM(sub.std_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vs_id) AS kvj_reg2
	, SUM(sub.std_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo) AS ist_land2
	, SUM(sub.std_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo) AS kvj_land2
	/* Rang : neo_fg = Filialen mind. 1 GJ offen, ohne Schließungmonat, ohne Ausschluss-Liste */
	, CASE WHEN sub.stl_dat > sub.max_dat 
		AND sub.gj > (EXTRACT(YEAR FROM sub.neo_dat)+CASE WHEN EXTRACT(MONTH FROM sub.neo_dat)<3 THEN -1 ELSE 0 END)+1 
		AND sub.nb_id=0 
		AND NOT ( /* Ausschluss Getränkemärkte, Zeltverkauf etc 2024-04-08 */
			(sub.mandant_id=1 AND sub.wup_id IN (1263,1273,2583,3166,6623,7220,8120,8563,8940,5876)) /* DE */ 
			OR (sub.mandant_id=7 AND sub.wup_id IN (1110,1410,6210,6310,6410)) /* RO */ 
			OR (sub.mandant_id=3 AND sub.wup_id IN (1010)) /* PL */
		) THEN 1 ELSE 0 END AS neo_fg
	/* Rang GJ : stl_fg = Filialen ohne Schließungen */
	, CASE WHEN sub.stl_dat BETWEEN TO_DATE(TO_CHAR(sub.gj)||'-03-01','YYYY-MM_2-DD') 
	  AND ADD_MONTHS(TO_DATE(TO_CHAR(sub.gj)||'-03-01','YYYY-MM_2-DD'),12)-1 
	  THEN 0 ELSE 1 END AS stl_fg 
	/* Rang VKL_2 : zf_fg = filialen ohne dummy_2 vkl_2 */
	, CASE WHEN sub.nb_id=0 AND sub.vkl_id>0 THEN 1 ELSE 0 END AS zf_fg
	/* Setup Rang :filiale monat_2 */
	, (neo_fg*sub1.mng_opf_ist)  AS ist_fil_mo
	, (neo_fg*sub1.mng_opf_kvj)  AS kvj_fil_mo
	, (neo_fg*sub.std_ist)  AS ist_fil_mo2
	, (neo_fg*sub.std_kvj)  AS kvj_fil_mo2
	/* Setup Rang :filiale gj */
	, SUM(neo_fg*stl_fg*sub1.mng_opf_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.wup_id) AS ist_fil_gj
	, SUM(neo_fg*stl_fg*sub1.mng_opf_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.wup_id) AS kvj_fil_gj
	, SUM(neo_fg*stl_fg*sub.std_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.wup_id) AS ist_fil_gj2
	, SUM(neo_fg*stl_fg*sub.std_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.wup_id) AS kvj_fil_gj2
	/* Setup Rang :vkl_2 monat_2 - werte mit neo_fg, rang ohne neo_fg */
	, SUM(neo_fg*zf_fg*sub1.mng_opf_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vkl_id) AS ist_vkl_mo
	, SUM(neo_fg*zf_fg*sub1.mng_opf_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vkl_id) AS kvj_vkl_mo
	, SUM(neo_fg*zf_fg*sub.std_ist)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vkl_id) AS ist_vkl_mo2
	, SUM(neo_fg*zf_fg*sub.std_plan) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vkl_id) AS kvj_vkl_mo2
	/* Setup Rang :vkl_2 gj */
	, SUM(neo_fg*zf_fg*stl_fg*sub1.mng_opf_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.vkl_id) AS ist_vkl_gj
	, SUM(neo_fg*zf_fg*stl_fg*sub1.mng_opf_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.vkl_id) AS kvj_vkl_gj
	, SUM(neo_fg*zf_fg*stl_fg*sub.std_ist)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.vkl_id) AS ist_vkl_gj2
	, SUM(neo_fg*zf_fg*stl_fg*sub.std_plan) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.vkl_id) AS kvj_vkl_gj2
	/* not used : Rang absteigend: IST-KVJ absolut (Nettostückleistung) */
	, NULLIFZERO(neo_fg)       *((ist_fil_mo/NULLIFZERO(ist_fil_mo2))-(kvj_fil_mo/NULLIFZERO(kvj_fil_mo2))) AS fil_mo
	, NULLIFZERO(neo_fg*stl_fg)*((ist_fil_gj/NULLIFZERO(ist_fil_gj2))-(kvj_fil_gj/NULLIFZERO(kvj_fil_gj2))) AS fil_gj
	, NULLIFZERO(zf_fg)        *((ist_vkl_mo/NULLIFZERO(ist_vkl_mo2))-(kvj_vkl_mo/NULLIFZERO(kvj_vkl_mo2))) AS vkl_mo
	, NULLIFZERO(zf_fg*stl_fg) *((ist_vkl_gj/NULLIFZERO(ist_vkl_gj2))-(kvj_vkl_gj/NULLIFZERO(kvj_vkl_gj2))) AS vkl_gj 
	FROM monat_fakt_wup sub
	LEFT OUTER JOIN monat_fakt_wg sub1 
	ON sub1.wup_id = sub.wup_id AND sub1.mandant_id = sub.mandant_id
	AND sub1.wrg_id = sub.wrg_id AND sub1.kjmo = sub.kjmo
) vtr 
 
/* VTR240 Kassierleistung */ 
UNION ALL SELECT mandant_id, nb_id, vs_id, vkl_id, wup_id, wrg_id, gj, kjmo, 240::INTEGER  AS VTR_ID 
, ist_fil  AS FILIST,  ist_fil2 AS FILIST2 
, kvj_fil  AS FILKVJ,  kvj_fil2 AS FILKVJ2 
, NULL     AS FILPLAN, NULL AS FILPLAN2 /* kein plan */
, ist_reg  AS REGIST,  ist_reg2 AS REGIST2 
, kvj_reg  AS REGKVJ,  kvj_reg2 AS REGKVJ2 
, ist_land AS LANDIST, ist_land2 AS LANDIST2 
, kvj_land AS LANDKVJ, kvj_land2 AS LANDKVJ2 
/* Rang aufsteigend = IST (Kassierleistung) */
, CASE WHEN bs_fg*neo_fg=1 THEN DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, kjmo, vs_id ORDER BY fil_mo DESC NULLS LAST) END AS FILMO_RANG
, CASE WHEN neo_fg*stl_fg=1 THEN DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, gj, vs_id ORDER BY fil_gj DESC NULLS LAST) END AS FILGJ_RANG
, CASE WHEN bs_fg*zf_fg=1 THEN DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, kjmo, vs_id ORDER BY vkl_mo DESC NULLS LAST) END AS VKLMO_RANG
, CASE WHEN zf_fg*stl_fg=1 THEN DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, gj, vs_id ORDER BY vkl_gj DESC NULLS LAST) END AS VKLGJ_RANG
, CASE WHEN bs_fg*neo_fg=1 THEN fil_mo END AS FILMO_WERT
, CASE WHEN neo_fg*stl_fg=1 THEN fil_gj END AS FILGJ_WERT
, CASE WHEN bs_fg*zf_fg=1 THEN vkl_mo END AS VKLMO_WERT
, CASE WHEN zf_fg*stl_fg=1 THEN vkl_gj END AS VKLGJ_WERT  
FROM ( /* VTR240 Kassierleistung */
	SELECT sub.mandant_id, sub.nb_id, sub.wup_id, sub.wrg_id, sub.vs_id, sub.vkl_id, sub.gj, sub.kjmo
	, sub3.ums_pos_ist AS ist_fil
	, sub3.kass_std_ist AS ist_fil2
	, sub4.ums_pos_kvj AS kvj_fil
	, sub4.kass_std_kvj AS kvj_fil2
	/* Referenz Region_2/Land_2 */
	, SUM(sub3.ums_pos_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vs_id) AS ist_reg
	, SUM(sub3.kass_std_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vs_id) AS ist_reg2
	, SUM(sub4.ums_pos_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vs_id) AS kvj_reg
	, SUM(sub4.kass_std_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vs_id) AS kvj_reg2
	, SUM(sub3.ums_pos_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo) AS ist_land
	, SUM(sub3.kass_std_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo) AS ist_land2
	, SUM(sub4.ums_pos_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo) AS kvj_land
	, SUM(sub4.kass_std_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo) AS kvj_land2
	/* Rang : neo_fg = Filialen mind. 1 GJ offen, ohne Schließungmonat, ohne Ausschluss-Liste */
	, CASE WHEN sub.stl_dat > sub.max_dat 
		AND sub.gj > (EXTRACT(YEAR FROM sub.neo_dat)+CASE WHEN EXTRACT(MONTH FROM sub.neo_dat)<3 THEN -1 ELSE 0 END)+1 
		AND sub.nb_id=0 
		AND NOT ( /* Ausschluss Getränkemärkte, Zeltverkauf etc 2024-04-08 */
			(sub.mandant_id=1 AND sub.wup_id IN (1263,1273,2583,3166,6623,7220,8120,8563,8940,5876)) /* DE */ 
			OR (sub.mandant_id=7 AND sub.wup_id IN (1110,1410,6210,6310,6410)) /* RO */ 
			OR (sub.mandant_id=3 AND sub.wup_id IN (1010)) /* PL */
		) THEN 1 ELSE 0 END AS neo_fg
	/* Rang GJ : stl_fg = Filialen ohne Schließungen */
	, CASE WHEN sub.stl_dat BETWEEN TO_DATE(TO_CHAR(sub.gj)||'-03-01','YYYY-MM_2-DD') 
	  AND ADD_MONTHS(TO_DATE(TO_CHAR(sub.gj)||'-03-01','YYYY-MM_2-DD'),12)-1 
	  THEN 0 ELSE 1 END AS stl_fg 
	/* Rang VKL_2 : zf_fg = filialen ohne dummy_2 vkl_2 */
	, CASE WHEN sub.nb_id=0 AND sub.vkl_id>0 THEN 1 ELSE 0 END AS zf_fg
	/* Rang BS : bs_fg = Nur Monate vor Buchungsschluss, wichtig am Monatsanfang*/
	, CASE WHEN sub.akt_bs <= 0 THEN 1 ELSE 0 END AS bs_fg
	/* Setup Rang : filiale monat_2 */
	, (neo_fg*sub3.ums_pos_ist) AS ist_fil_mo
	, (neo_fg*sub3.kass_std_ist) AS ist_fil_mo2
		/* Setup Rang : filiale gj */
	, SUM(bs_fg*neo_fg*stl_fg*sub3.ums_pos_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.wup_id) AS ist_fil_gj
	, SUM(bs_fg*neo_fg*stl_fg*sub3.kass_std_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.wup_id) AS ist_fil_gj2
		/* Setup Rang : vkl_2 monat_2 */
	, SUM(neo_fg*zf_fg*sub3.ums_pos_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vkl_id) AS ist_vkl_mo
	, SUM(neo_fg*zf_fg*sub3.kass_std_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vkl_id) AS ist_vkl_mo2
	/* Setup Rang : vkl_2 gj */
	, SUM(bs_fg*neo_fg*zf_fg*stl_fg*sub3.ums_pos_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.vkl_id) AS ist_vkl_gj
	, SUM(bs_fg*neo_fg*zf_fg*stl_fg*sub3.kass_std_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.vkl_id) AS ist_vkl_gj2
	/* Rang absteigend = IST (Kassierleistung) */
	, NULLIFZERO(neo_fg)        * ist_fil_mo/NULLIFZERO(ist_fil_mo2) AS fil_mo
	, NULLIFZERO(neo_fg*stl_fg) * ist_fil_gj/NULLIFZERO(ist_fil_gj2) AS fil_gj
	, NULLIFZERO(zf_fg)         * ist_vkl_mo/NULLIFZERO(ist_vkl_mo2) AS vkl_mo
	, NULLIFZERO(zf_fg*stl_fg)  * ist_vkl_gj/NULLIFZERO(ist_vkl_gj2) AS vkl_gj
	FROM monat_fakt_wup sub
	LEFT OUTER JOIN ( /* SUB021 VIS_TAG_KASSE_IST (aus mv_view) */
		SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id 
		, zeit.kjmo
		, SUM(vis.umsatz_netto) AS ums_kass_ist
		, SUM(vis.anz_kunden) AS knd_kass_ist
		, SUM(CASE WHEN ktp.kasse_typ_id IN (1) THEN vis.umsatz_netto END) AS ums_pos_ist
		, SUM(CASE WHEN ktp.kasse_typ_id IN (1) THEN vis.anz_kunden END) AS knd_pos_ist
		, SUM(CASE WHEN ktp.kasse_typ_id IN (8,9,10,11) THEN vis.umsatz_netto ELSE 0 END) AS ums_sco_ist
		, SUM(CASE WHEN ktp.kasse_typ_id IN (8,9,10,11) THEN vis.anz_kunden ELSE 0 END) AS knd_sco_ist
		, SUM(CASE WHEN ktp.kasse_typ_id IN (1) THEN vis.anz_artikel END) AS art_anz_ist
		, SUM(CASE WHEN ktp.kasse_typ_id IN (1) THEN vis.anz_artikel END)/100000.00 AS art_100t_ist
		, SUM(CASE WHEN ktp.kasse_typ_id IN (1) THEN vis.registrierzeit/60.0000 END) AS scan_min_ist
		, SUM(CASE WHEN ktp.kasse_typ_id IN (1) THEN vis.kassierzeit/3600.0000 END) AS kass_std_ist
		FROM DBP_MSI_VIEW_VIS.MV_VIS_TAG_KASSE_2 vis
		JOIN DBP_MSI_VIEW_VIS.MV_KASSE_TYP_PER_2 ktp
		ON ktp.mandant_id = vis.mandant_id AND ktp.wup_id = vis.wup_id 
		AND ktp.dat = vis.dat AND ktp.kasse_nr = vis.kasse_nr
		INNER JOIN dbp_data.tag_2 zeit1
		ON zeit1.dat = vis.dat
		INNER JOIN DBP_DATA.MONAT_2 zeit_2
		ON zeit.kjmo = zeit1.kjmo AND zeit.akt_gj IN (-1, 0) AND zeit.akt_mo < 0
		INNER JOIN dbp_data.wup_2 wup_2 
		ON wup.wup_id = vis.wup_id AND wup.mandant_id = vis.mandant_id 
		/* Standard Filter VTC : Filiale + definierte NB. Datum Eröffnung fix + GJ Schließung dynamisch */
		AND (wup.nb_id=0 OR wup.wup_id IN (0,2,22,28,43,46,124,8980,8987,8991,100000,100002,100022,100028,100043,100046,100124))
		AND wup.dat_eroeffnung<'2090-12-31' 
		AND (EXTRACT(YEAR FROM wup.dat_bis) + CASE WHEN EXTRACT(MONTH FROM wup.dat_bis) < 3 THEN -1 ELSE 0 END) > (zeit.gj + 1) 
		/* Kassentyp 1 = POS (Checkout) + 8,9,10,11 = SCO (Express + Paystation) */
		WHERE ktp.kasse_typ_id IN (1,8,9,10,11) 
		GROUP BY vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.kjmo
	) sub3
	ON sub3.mandant_id = sub.mandant_id AND sub3.wup_id = sub.wup_id
	AND sub3.wrg_id = sub.wrg_id AND sub3.kjmo = sub.kjmo
	LEFT OUTER JOIN ( /* SUB022 VIS_TAG_KASSE_KVJ (aus mv_view) */
		SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id 
		, zeit.kjmo
		, SUM(vis.umsatz_netto) AS ums_kass_kvj
		, SUM(vis.anz_kunden) AS knd_kass_kvj
		, SUM(CASE WHEN ktp.kasse_typ_id IN (1) THEN vis.umsatz_netto END) AS ums_pos_kvj
		, SUM(CASE WHEN ktp.kasse_typ_id IN (1) THEN vis.anz_kunden END) AS knd_pos_kvj
		, SUM(CASE WHEN ktp.kasse_typ_id IN (8,9,10,11) THEN vis.umsatz_netto ELSE 0 END) AS ums_sco_kvj
		, SUM(CASE WHEN ktp.kasse_typ_id IN (8,9,10,11) THEN vis.anz_kunden ELSE 0 END) AS knd_sco_kvj
		, SUM(CASE WHEN ktp.kasse_typ_id IN (1) THEN vis.anz_artikel END) AS art_anz_kvj
		, SUM(CASE WHEN ktp.kasse_typ_id IN (1) THEN vis.anz_artikel END)/100000.00 AS art_100t_kvj
		, SUM(CASE WHEN ktp.kasse_typ_id IN (1) THEN vis.registrierzeit/60.0000 END) AS scan_min_kvj
		, SUM(CASE WHEN ktp.kasse_typ_id IN (1) THEN vis.kassierzeit/3600.0000 END) AS kass_std_kvj
		FROM DBP_MSI_VIEW_VIS.MV_VIS_TAG_KASSE_2 vis
		JOIN DBP_MSI_VIEW_VIS.MV_KASSE_TYP_PER_2 ktp
		ON ktp.mandant_id = vis.mandant_id AND ktp.wup_id = vis.wup_id 
		AND ktp.dat = vis.dat AND ktp.kasse_nr = vis.kasse_nr
 		INNER JOIN dbp_data.tag_2 zeit1
		ON zeit1.dat = vis.dat
		/* Transformation KVJ */
		INNER JOIN DBP_DATA.MONAT_2 zeit_2
		ON zeit.kjmo = zeit1.kjmo+100 AND zeit.akt_gj IN (-1, 0) AND zeit.akt_mo < 0
		INNER JOIN dbp_data.wup_2 wup_2 
		ON wup.wup_id = vis.wup_id AND wup.mandant_id = vis.mandant_id 
		/* Standard Filter VTC : Filiale + definierte NB. Datum Eröffnung fix + GJ Schließung dynamisch */
		AND (wup.nb_id=0 OR wup.wup_id IN (0,2,22,28,43,46,124,8980,8987,8991,100000,100002,100022,100028,100043,100046,100124))
		AND wup.dat_eroeffnung<'2090-12-31' 
		AND (EXTRACT(YEAR FROM wup.dat_bis) + CASE WHEN EXTRACT(MONTH FROM wup.dat_bis) < 3 THEN -1 ELSE 0 END) > (zeit.gj + 1) 
		/* Kassentyp 1 = POS (Checkout) + 8,9,10,11 = SCO (Express + Paystation) */
		WHERE ktp.kasse_typ_id IN (1,8,9,10,11) 
		GROUP BY vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.kjmo
	) sub4
	ON sub4.mandant_id = sub.mandant_id AND sub4.wup_id = sub.wup_id
	AND sub4.wrg_id = sub.wrg_id AND sub4.kjmo = sub.kjmo
) vtr 
 
/* VTR250 Scans pro Minute */ 
UNION ALL SELECT mandant_id, nb_id, vs_id, vkl_id, wup_id, wrg_id, gj, kjmo, 250::INTEGER  AS VTR_ID 
, ist_fil  AS FILIST,  ist_fil2 AS FILIST2 
, kvj_fil  AS FILKVJ,  kvj_fil2 AS FILKVJ2 
, NULL     AS FILPLAN, NULL AS FILPLAN2 /* kein plan */
, ist_reg  AS REGIST,  ist_reg2 AS REGIST2 
, kvj_reg  AS REGKVJ,  kvj_reg2 AS REGKVJ2 
, ist_land AS LANDIST, ist_land2 AS LANDIST2 
, kvj_land AS LANDKVJ, kvj_land2 AS LANDKVJ2 
/* Rang aufsteigend = IST (Scans pro Minute) */
, CASE WHEN bs_fg*neo_fg=1 THEN DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, kjmo, vs_id ORDER BY fil_mo DESC NULLS LAST) END AS FILMO_RANG
, CASE WHEN neo_fg*stl_fg=1 THEN DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, gj, vs_id ORDER BY fil_gj DESC NULLS LAST) END AS FILGJ_RANG
, CASE WHEN bs_fg*zf_fg=1 THEN DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, kjmo, vs_id ORDER BY vkl_mo DESC NULLS LAST) END AS VKLMO_RANG
, CASE WHEN zf_fg*stl_fg=1 THEN DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, gj, vs_id ORDER BY vkl_gj DESC NULLS LAST) END AS VKLGJ_RANG
, CASE WHEN bs_fg*neo_fg=1 THEN fil_mo END AS FILMO_WERT
, CASE WHEN neo_fg*stl_fg=1 THEN fil_gj END AS FILGJ_WERT
, CASE WHEN bs_fg*zf_fg=1 THEN vkl_mo END AS VKLMO_WERT
, CASE WHEN zf_fg*stl_fg=1 THEN vkl_gj END AS VKLGJ_WERT  
FROM ( /* VTR250 Scans pro Minute */
	SELECT sub.mandant_id, sub.nb_id, sub.wup_id, sub.wrg_id, sub.vs_id, sub.vkl_id, sub.gj, sub.kjmo
	, sub3.art_anz_ist AS ist_fil
	, sub3.scan_min_ist AS ist_fil2
	, sub4.art_anz_kvj AS kvj_fil
	, sub4.scan_min_kvj AS kvj_fil2
	/* Referenz Region_2/Land_2 */
	, SUM(sub3.art_anz_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vs_id) AS ist_reg
	, SUM(sub3.scan_min_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vs_id) AS ist_reg2
	, SUM(sub4.art_anz_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vs_id) AS kvj_reg
	, SUM(sub4.scan_min_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vs_id) AS kvj_reg2
	, SUM(sub3.art_anz_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo) AS ist_land
	, SUM(sub3.scan_min_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo) AS ist_land2
	, SUM(sub4.art_anz_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo) AS kvj_land
	, SUM(sub4.scan_min_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo) AS kvj_land2
	/* Rang : neo_fg = Filialen mind. 1 GJ offen, ohne Schließungmonat, ohne Ausschluss-Liste */
	, CASE WHEN sub.stl_dat > sub.max_dat 
		AND sub.gj > (EXTRACT(YEAR FROM sub.neo_dat)+CASE WHEN EXTRACT(MONTH FROM sub.neo_dat)<3 THEN -1 ELSE 0 END)+1 
		AND sub.nb_id=0 
		AND NOT ( /* Ausschluss Getränkemärkte, Zeltverkauf etc 2024-04-08 */
			(sub.mandant_id=1 AND sub.wup_id IN (1263,1273,2583,3166,6623,7220,8120,8563,8940,5876)) /* DE */ 
			OR (sub.mandant_id=7 AND sub.wup_id IN (1110,1410,6210,6310,6410)) /* RO */ 
			OR (sub.mandant_id=3 AND sub.wup_id IN (1010)) /* PL */
		) THEN 1 ELSE 0 END AS neo_fg
	/* Rang GJ : stl_fg = Filialen ohne Schließungen */
	, CASE WHEN sub.stl_dat BETWEEN TO_DATE(TO_CHAR(sub.gj)||'-03-01','YYYY-MM_2-DD') 
	  AND ADD_MONTHS(TO_DATE(TO_CHAR(sub.gj)||'-03-01','YYYY-MM_2-DD'),12)-1 
	  THEN 0 ELSE 1 END AS stl_fg 
	/* Rang VKL_2 : zf_fg = filialen ohne dummy_2 vkl_2 */
	, CASE WHEN sub.nb_id=0 AND sub.vkl_id>0 THEN 1 ELSE 0 END AS zf_fg
	/* Rang BS : bs_fg = Nur Monate vor Buchungsschluss, wichtig am Monatsanfang*/
	, CASE WHEN sub.akt_bs <= 0 THEN 1 ELSE 0 END AS bs_fg
	/* Setup Rang : filiale monat_2 */
	, (neo_fg*sub3.art_anz_ist) AS ist_fil_mo
	, (neo_fg*sub3.scan_min_ist) AS ist_fil_mo2
	/* Setup Rang : filiale gj */
	, SUM(bs_fg*neo_fg*stl_fg*sub3.art_anz_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.wup_id) AS ist_fil_gj
	, SUM(bs_fg*neo_fg*stl_fg*sub3.scan_min_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.wup_id) AS ist_fil_gj2
	/* Setup Rang : vkl_2 monat_2 */
	, SUM(neo_fg*zf_fg*sub3.art_anz_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vkl_id) AS ist_vkl_mo
	, SUM(neo_fg*zf_fg*sub3.scan_min_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vkl_id) AS ist_vkl_mo2
	/* Setup Rang : vkl_2 gj */
	, SUM(bs_fg*neo_fg*zf_fg*stl_fg*sub3.art_anz_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.vkl_id) AS ist_vkl_gj
	, SUM(bs_fg*neo_fg*zf_fg*stl_fg*sub3.scan_min_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.vkl_id) AS ist_vkl_gj2
	/* Rang aufsteigend = IST (Scans pro Minute) */
	, NULLIFZERO(neo_fg)        * ist_fil_mo/NULLIFZERO(ist_fil_mo2) AS fil_mo
	, NULLIFZERO(neo_fg*stl_fg) * ist_fil_gj/NULLIFZERO(ist_fil_gj2) AS fil_gj
	, NULLIFZERO(zf_fg)         * ist_vkl_mo/NULLIFZERO(ist_vkl_mo2) AS vkl_mo
	, NULLIFZERO(zf_fg*stl_fg)  * ist_vkl_gj/NULLIFZERO(ist_vkl_gj2) AS vkl_gj
	FROM monat_fakt_wup sub
	LEFT OUTER JOIN ( /* SUB021 VIS_TAG_KASSE_IST (aus mv_view) */
		SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id 
		, zeit.kjmo
		, SUM(vis.umsatz_netto) AS ums_kass_ist
		, SUM(vis.anz_kunden) AS knd_kass_ist
		, SUM(CASE WHEN ktp.kasse_typ_id IN (1) THEN vis.umsatz_netto END) AS ums_pos_ist
		, SUM(CASE WHEN ktp.kasse_typ_id IN (1) THEN vis.anz_kunden END) AS knd_pos_ist
		, SUM(CASE WHEN ktp.kasse_typ_id IN (8,9,10,11) THEN vis.umsatz_netto ELSE 0 END) AS ums_sco_ist
		, SUM(CASE WHEN ktp.kasse_typ_id IN (8,9,10,11) THEN vis.anz_kunden ELSE 0 END) AS knd_sco_ist
		, SUM(CASE WHEN ktp.kasse_typ_id IN (1) THEN vis.anz_artikel END) AS art_anz_ist
		, SUM(CASE WHEN ktp.kasse_typ_id IN (1) THEN vis.anz_artikel END)/100000.00 AS art_100t_ist
		, SUM(CASE WHEN ktp.kasse_typ_id IN (1) THEN vis.registrierzeit/60.0000 END) AS scan_min_ist
		, SUM(CASE WHEN ktp.kasse_typ_id IN (1) THEN vis.kassierzeit/3600.0000 END) AS kass_std_ist
		FROM DBP_MSI_VIEW_VIS.MV_VIS_TAG_KASSE_2 vis
		JOIN DBP_MSI_VIEW_VIS.MV_KASSE_TYP_PER_2 ktp
		ON ktp.mandant_id = vis.mandant_id AND ktp.wup_id = vis.wup_id 
		AND ktp.dat = vis.dat AND ktp.kasse_nr = vis.kasse_nr
		INNER JOIN dbp_data.tag_2 zeit1
		ON zeit1.dat = vis.dat
		INNER JOIN DBP_DATA.MONAT_2 zeit_2
		ON zeit.kjmo = zeit1.kjmo AND zeit.akt_gj IN (-1, 0) AND zeit.akt_mo < 0
		INNER JOIN dbp_data.wup_2 wup_2 
		ON wup.wup_id = vis.wup_id AND wup.mandant_id = vis.mandant_id 
		/* Standard Filter VTC : Filiale + definierte NB. Datum Eröffnung fix + GJ Schließung dynamisch */
		AND (wup.nb_id=0 OR wup.wup_id IN (0,2,22,28,43,46,124,8980,8987,8991,100000,100002,100022,100028,100043,100046,100124))
		AND wup.dat_eroeffnung<'2090-12-31' 
		AND (EXTRACT(YEAR FROM wup.dat_bis) + CASE WHEN EXTRACT(MONTH FROM wup.dat_bis) < 3 THEN -1 ELSE 0 END) > (zeit.gj + 1) 
		/* Kassentyp 1 = POS (Checkout) + 8,9,10,11 = SCO (Express + Paystation) */
		WHERE ktp.kasse_typ_id IN (1,8,9,10,11) 
		GROUP BY vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.kjmo
	) sub3
	ON sub3.mandant_id = sub.mandant_id AND sub3.wup_id = sub.wup_id
	AND sub3.wrg_id = sub.wrg_id AND sub3.kjmo = sub.kjmo
	LEFT OUTER JOIN ( /* SUB022 VIS_TAG_KASSE_KVJ (aus mv_view) */
		SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id 
		, zeit.kjmo
		, SUM(vis.umsatz_netto) AS ums_kass_kvj
		, SUM(vis.anz_kunden) AS knd_kass_kvj
		, SUM(CASE WHEN ktp.kasse_typ_id IN (1) THEN vis.umsatz_netto END) AS ums_pos_kvj
		, SUM(CASE WHEN ktp.kasse_typ_id IN (1) THEN vis.anz_kunden END) AS knd_pos_kvj
		, SUM(CASE WHEN ktp.kasse_typ_id IN (8,9,10,11) THEN vis.umsatz_netto ELSE 0 END) AS ums_sco_kvj
		, SUM(CASE WHEN ktp.kasse_typ_id IN (8,9,10,11) THEN vis.anz_kunden ELSE 0 END) AS knd_sco_kvj
		, SUM(CASE WHEN ktp.kasse_typ_id IN (1) THEN vis.anz_artikel END) AS art_anz_kvj
		, SUM(CASE WHEN ktp.kasse_typ_id IN (1) THEN vis.anz_artikel END)/100000.00 AS art_100t_kvj
		, SUM(CASE WHEN ktp.kasse_typ_id IN (1) THEN vis.registrierzeit/60.0000 END) AS scan_min_kvj
		, SUM(CASE WHEN ktp.kasse_typ_id IN (1) THEN vis.kassierzeit/3600.0000 END) AS kass_std_kvj
		FROM DBP_MSI_VIEW_VIS.MV_VIS_TAG_KASSE_2 vis
		JOIN DBP_MSI_VIEW_VIS.MV_KASSE_TYP_PER_2 ktp
		ON ktp.mandant_id = vis.mandant_id AND ktp.wup_id = vis.wup_id 
		AND ktp.dat = vis.dat AND ktp.kasse_nr = vis.kasse_nr
		INNER JOIN dbp_data.tag_2 zeit1
		ON zeit1.dat = vis.dat
		INNER JOIN DBP_DATA.MONAT_2 zeit_2
		ON zeit.kjmo = zeit1.kjmo+100 AND zeit.akt_gj IN (-1, 0) AND zeit.akt_mo < 0 /* Transformation KVJ */
		INNER JOIN dbp_data.wup_2 wup_2 
		ON wup.wup_id = vis.wup_id AND wup.mandant_id = vis.mandant_id 
		/* Standard Filter VTC : Filiale + definierte NB. Datum Eröffnung fix + GJ Schließung dynamisch */
		AND (wup.nb_id=0 OR wup.wup_id IN (0,2,22,28,43,46,124,8980,8987,8991,100000,100002,100022,100028,100043,100046,100124))
		AND wup.dat_eroeffnung<'2090-12-31' 
		AND (EXTRACT(YEAR FROM wup.dat_bis) + CASE WHEN EXTRACT(MONTH FROM wup.dat_bis) < 3 THEN -1 ELSE 0 END) > (zeit.gj + 1) 
		/* Kassentyp 1 = POS (Checkout) + 8,9,10,11 = SCO (Express + Paystation) */
		WHERE ktp.kasse_typ_id IN (1,8,9,10,11) 
		GROUP BY vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.kjmo
	) sub4
	ON sub4.mandant_id = sub.mandant_id AND sub4.wup_id = sub.wup_id
	AND sub4.wrg_id = sub.wrg_id AND sub4.kjmo = sub.kjmo
) vtr 
 
/* VTR270 Personalkosten_2 */ 
UNION ALL SELECT mandant_id, nb_id, vs_id, vkl_id, wup_id, wrg_id, gj, kjmo, 270::INTEGER  AS VTR_ID 
, ist_fil   AS FILIST,  NULL AS FILIST2 
, kvj_fil   AS FILKVJ,  NULL AS FILKVJ2 
, NULL      AS FILPLAN, NULL AS FILPLAN2 /* kein Plan auf Ebene Filiale*/
, ist_reg   AS REGIST,  NULL AS REGIST2 
, kvj_reg   AS REGKVJ,  NULL AS REGKVJ2 
, ist_land  AS LANDIST, NULL AS LANDIST2 
, kvj_land  AS LANDKVJ, NULL AS LANDKVJ2 
/* kein Rang : Personalkosten_2 */
, CASE WHEN neo_fg=1 THEN DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, kjmo, vs_id ORDER BY fil_mo DESC NULLS LAST) END AS FILMO_RANG
, CASE WHEN neo_fg*stl_fg=1 THEN DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, gj, vs_id ORDER BY fil_gj DESC NULLS LAST) END AS FILGJ_RANG
, CASE WHEN zf_fg=1 THEN DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, kjmo, vs_id ORDER BY vkl_mo DESC NULLS LAST) END AS VKLMO_RANG
, CASE WHEN zf_fg*stl_fg=1 THEN DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, gj, vs_id ORDER BY vkl_gj DESC NULLS LAST) END AS VKLGJ_RANG
, CASE WHEN neo_fg=1 THEN fil_mo END AS FILMO_WERT
, CASE WHEN neo_fg*stl_fg=1 THEN fil_gj END AS FILGJ_WERT
, CASE WHEN zf_fg=1 THEN vkl_mo END AS VKLMO_WERT
, CASE WHEN zf_fg*stl_fg=1 THEN vkl_gj END AS VKLGJ_WERT
FROM ( /* VTR270 Personalkosten_2 */
	SELECT sub.mandant_id, sub.nb_id, sub.wup_id, sub.wrg_id, sub.vs_id, sub.vkl_id, sub.gj, sub.kjmo
	, sub.kst_ist AS ist_fil
	, sub.kst_kvj AS kvj_fil
	, sub.kst_plan AS plan_fil
	/* Referenz Region_2/Land_2 */
	, SUM(sub.kst_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vs_id) AS ist_reg
	, SUM(sub.kst_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vs_id) AS kvj_reg
	, SUM(sub.kst_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo) AS ist_land
	, SUM(sub.kst_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo) AS kvj_land
	/* Rang : neo_fg = Filialen mind. 1 GJ offen, ohne Schließungmonat, ohne Ausschluss-Liste */
	, CASE WHEN sub.stl_dat > sub.max_dat 
		AND sub.gj > (EXTRACT(YEAR FROM sub.neo_dat)+CASE WHEN EXTRACT(MONTH FROM sub.neo_dat)<3 THEN -1 ELSE 0 END)+1 
		AND sub.nb_id=0 
		AND NOT ( /* Ausschluss Getränkemärkte, Zeltverkauf etc 2024-04-08 */
			(sub.mandant_id=1 AND sub.wup_id IN (1263,1273,2583,3166,6623,7220,8120,8563,8940,5876)) /* DE */ 
			OR (sub.mandant_id=7 AND sub.wup_id IN (1110,1410,6210,6310,6410)) /* RO */ 
			OR (sub.mandant_id=3 AND sub.wup_id IN (1010)) /* PL */
		) THEN 1 ELSE 0 END AS neo_fg
	/* Rang GJ : stl_fg = Filialen ohne Schließungen */
	, CASE WHEN sub.stl_dat BETWEEN TO_DATE(TO_CHAR(sub.gj)||'-03-01','YYYY-MM_2-DD') 
	  AND ADD_MONTHS(TO_DATE(TO_CHAR(sub.gj)||'-03-01','YYYY-MM_2-DD'),12)-1 
	  THEN 0 ELSE 1 END AS stl_fg 
	/* Rang VKL_2 : zf_fg = filialen ohne dummy_2 vkl_2 */
	, CASE WHEN sub.nb_id=0 AND sub.vkl_id>0 THEN 1 ELSE 0 END AS zf_fg
	/* Setup Rang :filiale monat_2 */
	, (neo_fg*sub.kst_ist)  AS ist_fil_mo
	, (neo_fg*sub.kst_kvj)  AS kvj_fil_mo
	/* Setup Rang :filiale gj */
	, SUM(neo_fg*stl_fg*sub.kst_ist)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.wup_id) AS ist_fil_gj
	, SUM(neo_fg*stl_fg*sub.kst_kvj)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.wup_id) AS kvj_fil_gj
	/* Setup Rang :vkl_2 monat_2 - werte mit neo_fg, rang ohne neo_fg */
	, SUM(neo_fg*zf_fg*neo_fg*stl_fg) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vkl_id) AS ist_vkl_mo
	, SUM(neo_fg*zf_fg*sub.kst_kvj)   OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vkl_id) AS kvj_vkl_mo
	/* Setup Rang :vkl_2 gj */
	, SUM(neo_fg*zf_fg*stl_fg*sub.kst_ist)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.vkl_id) AS ist_vkl_gj
	, SUM(neo_fg*zf_fg*stl_fg*sub.kst_kvj)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.vkl_id) AS kvj_vkl_gj
	/* kein Rang : Personalkosten_2 */
	, NULLIFZERO(neo_fg)	   *((ist_fil_mo-NULLIFZERO(kvj_fil_mo))-(NULLIFZERO(kvj_fil_mo))) AS fil_mo
	, NULLIFZERO(neo_fg*stl_fg)*((ist_fil_gj-NULLIFZERO(kvj_fil_gj))-(NULLIFZERO(kvj_fil_gj))) AS fil_gj
	, NULLIFZERO(zf_fg)		   *((ist_vkl_mo-NULLIFZERO(kvj_vkl_mo))-(NULLIFZERO(kvj_vkl_mo))) AS vkl_mo
	, NULLIFZERO(zf_fg*stl_fg) *((ist_vkl_gj-NULLIFZERO(kvj_vkl_gj))-(NULLIFZERO(kvj_vkl_gj))) AS vkl_gj 
	FROM monat_fakt_wup sub
) vtr 
 
/* VTR275 Personalkosten_2 (%) */ 
UNION ALL SELECT mandant_id, nb_id, vs_id, vkl_id, wup_id, wrg_id, gj, kjmo, 275::INTEGER  AS VTR_ID 
, ist_fil  AS FILIST,  ist_fil2  AS FILIST2 
, kvj_fil  AS FILKVJ,  kvj_fil2  AS FILKVJ2 
, NULL     AS FILPLAN, NULL      AS FILPLAN2  /* kein Plan auf Ebene Filiale*/
, ist_reg  AS REGIST, ist_reg2   AS REGIST2 
, kvj_reg  AS REGKVJ, kvj_reg2   AS REGKVJ2 
, ist_land AS LANDIST, ist_land2 AS LANDIST2 
, kvj_land AS LANDKVJ, kvj_land2 AS LANDKVJ2 
/* Rang absteigend: IST proz. (Personalkosten_2 PK%) */ 
, CASE WHEN bs_fg*neo_fg=1 THEN DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, kjmo, vs_id ORDER BY fil_mo DESC NULLS LAST) END AS FILMO_RANG
, CASE WHEN neo_fg*stl_fg=1 THEN DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, gj, vs_id ORDER BY fil_gj DESC NULLS LAST) END AS FILGJ_RANG
, CASE WHEN bs_fg*zf_fg=1 THEN DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, kjmo, vs_id ORDER BY vkl_mo DESC NULLS LAST) END AS VKLMO_RANG
, CASE WHEN zf_fg*stl_fg=1 THEN DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, gj, vs_id ORDER BY vkl_gj DESC NULLS LAST) END AS VKLGJ_RANG
, CASE WHEN bs_fg*neo_fg=1 THEN fil_mo END AS FILMO_WERT
, CASE WHEN neo_fg*stl_fg=1 THEN fil_gj END AS FILGJ_WERT
, CASE WHEN bs_fg*zf_fg=1 THEN vkl_mo END AS VKLMO_WERT
, CASE WHEN zf_fg*stl_fg=1 THEN vkl_gj END AS VKLGJ_WERT
FROM ( /* VTR275 Personalkosten_2 PK% */
	SELECT sub.mandant_id, sub.nb_id, sub.wup_id, sub.wrg_id, sub.vs_id, sub.vkl_id, sub.gj, sub.kjmo
	, sub.ums_ist AS ist_fil2
	, sub.ums_plan AS plan_fil2
	, sub.ums_kvj AS kvj_fil2
	, sub.kst_ist AS ist_fil
	, sub.kst_plan AS plan_fil
	, sub.kst_kvj AS kvj_fil
	/* Referenz Region_2/Land_2 */
	, SUM(sub.ums_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vs_id) AS ist_reg2
	, SUM(sub.ums_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vs_id) AS kvj_reg2
	, SUM(sub.ums_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo) AS ist_land2
	, SUM(sub.ums_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo) AS kvj_land2
	, SUM(sub.kst_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vs_id) AS ist_reg
	, SUM(sub.kst_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vs_id) AS kvj_reg
	, SUM(sub.kst_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo) AS ist_land
	, SUM(sub.kst_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo) AS kvj_land
	/* Rang : neo_fg = Filialen mind. 1 GJ offen, ohne Schließungmonat, ohne Ausschluss-Liste */
	, CASE WHEN sub.stl_dat > sub.max_dat 
		AND sub.gj > (EXTRACT(YEAR FROM sub.neo_dat)+CASE WHEN EXTRACT(MONTH FROM sub.neo_dat)<3 THEN -1 ELSE 0 END)+1 
		AND sub.nb_id=0 
		AND NOT ( /* Ausschluss Getränkemärkte, Zeltverkauf etc 2024-04-08 */
			(sub.mandant_id=1 AND sub.wup_id IN (1263,1273,2583,3166,6623,7220,8120,8563,8940,5876)) /* DE */ 
			OR (sub.mandant_id=7 AND sub.wup_id IN (1110,1410,6210,6310,6410)) /* RO */ 
			OR (sub.mandant_id=3 AND sub.wup_id IN (1010)) /* PL */
		) THEN 1 ELSE 0 END AS neo_fg
	/* Rang GJ : stl_fg = Filialen ohne Schließungen */
	, CASE WHEN sub.stl_dat BETWEEN TO_DATE(TO_CHAR(sub.gj)||'-03-01','YYYY-MM_2-DD') 
	  AND ADD_MONTHS(TO_DATE(TO_CHAR(sub.gj)||'-03-01','YYYY-MM_2-DD'),12)-1 
	  THEN 0 ELSE 1 END AS stl_fg 
	/* Rang VKL_2 : zf_fg = filialen ohne dummy_2 vkl_2 */
	, CASE WHEN sub.nb_id=0 AND sub.vkl_id>0 THEN 1 ELSE 0 END AS zf_fg
	/* Rang BS : bs_fg = Nur Monate vor Buchungsschluss, wichtig am Monatsanfang*/
	, CASE WHEN sub.akt_bs <= 0 THEN 1 ELSE 0 END AS bs_fg
	/* Setup Rang :filiale monat_2 */
	, (neo_fg*sub.ums_ist)  AS ist_fil_mo2
	, (neo_fg*sub.ums_kvj)  AS kvj_fil_mo2
	, (neo_fg*sub.kst_ist)  AS ist_fil_mo
	, (neo_fg*sub.kst_kvj)  AS kvj_fil_mo
	/* Setup Rang :filiale gj */
	, SUM(bs_fg*neo_fg*stl_fg*sub.ums_ist)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.wup_id) AS ist_fil_gj2
	, SUM(bs_fg*neo_fg*stl_fg*sub.ums_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.wup_id) AS kvj_fil_gj2
	, SUM(bs_fg*neo_fg*stl_fg*sub.kst_ist)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.wup_id) AS ist_fil_gj
	, SUM(bs_fg*neo_fg*stl_fg*sub.kst_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.wup_id) AS kvj_fil_gj
	/* Setup Rang :vkl_2 monat_2 - werte mit neo_fg, rang ohne neo_fg */
	, SUM(neo_fg*zf_fg*sub.ums_ist)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vkl_id) AS ist_vkl_mo2
	, SUM(neo_fg*zf_fg*sub.ums_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vkl_id) AS kvj_vkl_mo2
	, SUM(neo_fg*zf_fg*sub.kst_ist)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vkl_id) AS ist_vkl_mo
	, SUM(neo_fg*zf_fg*sub.kst_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vkl_id) AS kvj_vkl_mo
	/* Setup Rang :vkl_2 gj */
	, SUM(bs_fg*neo_fg*zf_fg*stl_fg*sub.ums_ist)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.vkl_id) AS ist_vkl_gj2
	, SUM(bs_fg*neo_fg*zf_fg*stl_fg*sub.ums_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.vkl_id) AS kvj_vkl_gj2
	, SUM(bs_fg*neo_fg*zf_fg*stl_fg*sub.kst_ist)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.vkl_id) AS ist_vkl_gj
	, SUM(bs_fg*neo_fg*zf_fg*stl_fg*sub.kst_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.vkl_id) AS kvj_vkl_gj
	/* Rang absteigend: IST (Personalkosten_2 PK%) */
	, NULLIFZERO(neo_fg)       * (ist_fil_mo/NULLIFZERO(ist_fil_mo2)) AS fil_mo
	, NULLIFZERO(neo_fg*stl_fg)* (ist_fil_gj/NULLIFZERO(ist_fil_gj2)) AS fil_gj
	, NULLIFZERO(zf_fg)        * (ist_vkl_mo/NULLIFZERO(ist_vkl_mo2)) AS vkl_mo
	, NULLIFZERO(zf_fg*stl_fg) * (ist_vkl_gj/NULLIFZERO(ist_vkl_gj2)) AS vkl_gj 
	FROM monat_fakt_wup sub
) vtr 
 
/* VTR300 Abschriften_2 operativ */ 
UNION ALL SELECT mandant_id, nb_id, vs_id, vkl_id, wup_id, wrg_id, gj, kjmo, 300::INTEGER AS VTR_ID 
, ist_fil  AS FILIST,  NULL AS FILIST2 
, kvj_fil  AS FILKVJ,  NULL AS FILKVJ2 
, NULL     AS FILPLAN, NULL AS FILPLAN2 /* kein plan */
, ist_reg  AS REGIST,  NULL AS REGIST2 
, kvj_reg  AS REGKVJ,  NULL AS REGKVJ2 
, ist_land AS LANDIST, NULL AS LANDIST2 
, kvj_land AS LANDKVJ, NULL AS LANDKVJ2
/* kein Ranking */
, NULL AS FILMO_RANG, NULL AS FILGJ_RANG
, NULL AS VKLMO_RANG, NULL AS VKLGJ_RANG
, NULL AS FILMO_WERT, NULL AS FILGJ_WERT
, NULL AS VKLMO_WERT, NULL AS VKLGJ_WERT
FROM ( /* VTR300 Abschriften_2 operativ */
	SELECT sub.mandant_id, sub.nb_id, sub.wup_id, sub.wrg_id, sub.vs_id, sub.vkl_id, sub.gj, sub.kjmo
	, sub1.abs_op_ist AS ist_fil
	, sub1.abs_op_kvj AS kvj_fil
	/* Referenz Region_2/Land_2 */
	, SUM(sub1.abs_op_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vs_id) AS ist_reg
	, SUM(sub1.abs_op_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vs_id) AS kvj_reg
	, SUM(sub1.abs_op_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo) AS ist_land
	, SUM(sub1.abs_op_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo) AS kvj_land
	/* kein Ranking */
	FROM monat_fakt_wup sub
	LEFT OUTER JOIN tag_abschriften_wg sub1
	ON sub1.wup_id = sub.wup_id AND sub1.mandant_id = sub.mandant_id
	AND sub1.wrg_id = sub.wrg_id AND sub1.kjmo = sub.kjmo
) vtr 
 
/* VTR310 Abschriften_2 operativ (%) */
UNION ALL SELECT mandant_id, nb_id, vs_id, vkl_id, wup_id, wrg_id, gj, kjmo, 310::INTEGER AS VTR_ID 
, ist_fil  AS FILIST,  ist_fil2  AS FILIST2 
, kvj_fil  AS FILKVJ,  kvj_fil2  AS FILKVJ2 
, plan_fil AS FILPLAN, plan_fil2 AS FILPLAN2 
, ist_reg  AS REGIST,  ist_reg2  AS REGIST2 
, kvj_reg  AS REGKVJ,  kvj_reg2  AS REGKVJ2 
, ist_land AS LANDIST, ist_land2 AS LANDIST2 
, kvj_land AS LANDKVJ, kvj_land2 AS LANDKVJ2 
/* Rang absteigend: IST-Plan prozentpkt (Abschriften_2 operativ) */
, CASE WHEN bs_fg*neo_fg=1 THEN DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, kjmo, vs_id ORDER BY fil_mo DESC NULLS LAST) END AS FILMO_RANG
, CASE WHEN neo_fg*stl_fg=1 THEN DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, gj, vs_id ORDER BY fil_gj DESC NULLS LAST) END AS FILGJ_RANG
, CASE WHEN bs_fg*zf_fg=1 THEN DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, kjmo, vs_id ORDER BY vkl_mo DESC NULLS LAST) END AS VKLMO_RANG
, CASE WHEN zf_fg*stl_fg=1 THEN DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, gj, vs_id ORDER BY vkl_gj DESC NULLS LAST) END AS VKLGJ_RANG
, CASE WHEN bs_fg*neo_fg=1        THEN fil_mo*100 END AS FILMO_WERT
, CASE WHEN neo_fg*stl_fg=1 THEN fil_gj*100 END AS FILGJ_WERT
, CASE WHEN bs_fg*zf_fg=1         THEN vkl_mo*100 END AS VKLMO_WERT
, CASE WHEN zf_fg*stl_fg=1  THEN vkl_gj*100 END AS VKLGJ_WERT
FROM ( /* VTR310 Abschriften_2 operativ proz */
	SELECT sub.mandant_id, sub.nb_id, sub.wup_id, sub.wrg_id, sub.vs_id, sub.vkl_id, sub.gj, sub.kjmo
	, sub0.ums_ist AS ist_fil2
	, sub0.ums_kvj AS kvj_fil2
	, sub1.abs_op_ist AS ist_fil
	, sub1.abs_op_kvj AS kvj_fil
	, sub2.ums_plan AS plan_fil2
	, sub2.abs_op_plan AS plan_fil
	/* Referenz Region_2/Land_2 */
	, SUM(sub0.ums_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vs_id) AS ist_reg2
	, SUM(sub0.ums_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vs_id) AS kvj_reg2
	, SUM(sub0.ums_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo) AS ist_land2
	, SUM(sub0.ums_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo) AS kvj_land2
	, SUM(sub1.abs_op_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vs_id) AS ist_reg
	, SUM(sub1.abs_op_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vs_id) AS kvj_reg
	, SUM(sub1.abs_op_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo) AS ist_land
	, SUM(sub1.abs_op_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo) AS kvj_land
	/* Rang : neo_fg = Filialen mind. 1 GJ offen, ohne Schließungmonat, ohne Ausschluss-Liste */
	, CASE WHEN sub.stl_dat > sub.max_dat 
		AND sub.gj > (EXTRACT(YEAR FROM sub.neo_dat)+CASE WHEN EXTRACT(MONTH FROM sub.neo_dat)<3 THEN -1 ELSE 0 END)+1 
		AND sub.nb_id=0 
		AND NOT ( /* Ausschluss Getränkemärkte, Zeltverkauf etc 2024-04-08 */
			(sub.mandant_id=1 AND sub.wup_id IN (1263,1273,2583,3166,6623,7220,8120,8563,8940,5876)) /* DE */ 
			OR (sub.mandant_id=7 AND sub.wup_id IN (1110,1410,6210,6310,6410)) /* RO */ 
			OR (sub.mandant_id=3 AND sub.wup_id IN (1010)) /* PL */
		) THEN 1 ELSE 0 END AS neo_fg
	/* Rang GJ : stl_fg = Filialen ohne Schließungen */
	, CASE WHEN sub.stl_dat BETWEEN TO_DATE(TO_CHAR(sub.gj)||'-03-01','YYYY-MM_2-DD') 
	  AND ADD_MONTHS(TO_DATE(TO_CHAR(sub.gj)||'-03-01','YYYY-MM_2-DD'),12)-1 
	  THEN 0 ELSE 1 END AS stl_fg 
	/* Rang VKL_2 : zf_fg = filialen ohne dummy_2 vkl_2 */
	, CASE WHEN sub.nb_id=0 AND sub.vkl_id>0 THEN 1 ELSE 0 END AS zf_fg
	/* Rang BS : bs_fg = Nur Monate vor Buchungsschluss, wichtig am Monatsanfang*/
	, CASE WHEN sub.akt_bs <= 0 THEN 1 ELSE 0 END AS bs_fg
	/* Setup Rang :filiale monat_2 */
	, (neo_fg*sub0.ums_ist) AS ist_fil_mo2
	, (neo_fg*sub2.ums_plan) AS plan_fil_mo2
	, (neo_fg*sub1.abs_op_ist) AS ist_fil_mo
	, (neo_fg*sub2.abs_op_plan) AS plan_fil_mo
	/* Setup Rang :filiale gj */
	, SUM(bs_fg*neo_fg*stl_fg*sub0.ums_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.wup_id) AS ist_fil_gj2
	, SUM(bs_fg*neo_fg*stl_fg*sub2.ums_plan) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.wup_id) AS plan_fil_gj2
	, SUM(bs_fg*neo_fg*stl_fg*sub1.abs_op_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.wup_id) AS ist_fil_gj
	, SUM(bs_fg*neo_fg*stl_fg*sub2.abs_op_plan) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.wup_id) AS plan_fil_gj
	/* Setup Rang :vkl_2 monat_2 - werte mit neo_fg, rang ohne neo_fg */
	, SUM(neo_fg*zf_fg*sub0.ums_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vkl_id) AS ist_vkl_mo2
	, SUM(neo_fg*zf_fg*sub2.ums_plan) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vkl_id) AS plan_vkl_mo2
	, SUM(neo_fg*zf_fg*sub1.abs_op_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vkl_id) AS ist_vkl_mo
	, SUM(neo_fg*zf_fg*sub2.abs_op_plan) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vkl_id) AS plan_vkl_mo
	/* Setup Rang :vkl_2 gj */
	, SUM(bs_fg*neo_fg*zf_fg*stl_fg*sub0.ums_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.vkl_id) AS ist_vkl_gj2
	, SUM(bs_fg*neo_fg*zf_fg*stl_fg*sub2.ums_plan) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.vkl_id) AS plan_vkl_gj2
	, SUM(bs_fg*neo_fg*zf_fg*stl_fg*sub1.abs_op_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.vkl_id) AS ist_vkl_gj
	, SUM(bs_fg*neo_fg*zf_fg*stl_fg*sub2.abs_op_plan) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.vkl_id) AS plan_vkl_gj
	/* Rang absteigend: IST-Plan prozentpkt (Abschriften_2 operativ) */
	, NULLIFZERO(neo_fg)       * ((ist_fil_mo/NULLIFZERO(ist_fil_mo2))-(plan_fil_mo/NULLIFZERO(plan_fil_mo2))) AS fil_mo
	, NULLIFZERO(neo_fg*stl_fg)* ((ist_fil_gj/NULLIFZERO(ist_fil_gj2))-(plan_fil_gj/NULLIFZERO(plan_fil_gj2))) AS fil_gj
	, NULLIFZERO(zf_fg)        * ((ist_vkl_mo/NULLIFZERO(ist_vkl_mo2))-(plan_vkl_mo/NULLIFZERO(plan_vkl_mo2))) AS vkl_mo
	, NULLIFZERO(zf_fg*stl_fg) * ((ist_vkl_gj/NULLIFZERO(ist_vkl_gj2))-(plan_vkl_gj/NULLIFZERO(plan_vkl_gj2))) AS vkl_gj 
	FROM monat_fakt_wup sub
	LEFT OUTER JOIN monat_fakt_wg sub0 
	ON sub0.wup_id = sub.wup_id AND sub0.mandant_id = sub.mandant_id
	AND sub0.wrg_id = sub.wrg_id AND sub0.kjmo = sub.kjmo
	LEFT OUTER JOIN tag_abschriften_wg sub1
	ON sub1.wup_id = sub.wup_id AND sub1.mandant_id = sub.mandant_id
	AND sub1.wrg_id = sub.wrg_id AND sub1.kjmo = sub.kjmo
	LEFT OUTER JOIN ( /* SUB004 VIS_UMSATZ_ABSCHRIFTEN_PLAN (mv_view) */
		SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.kjmo
		, SUM(vis.abschriften_netto_operativ_plan) AS abs_op_plan
		, SUM(CASE WHEN hwg.abt_id=5 THEN vis.abschriften_netto_operativ_plan ELSE 0 END) AS abs_uf_plan
		, SUM(vis.umsatz_netto_plan) AS ums_plan
		, SUM(CASE WHEN hwg.abt_id=5 THEN vis.umsatz_netto_plan ELSE 0 END) AS ums_uf_plan
		FROM DBP_MSI_VIEW_VIS.MV_WUP_PLAN_KJMO_OWG_2 vis
		JOIN DBP_MSI_VIEW_VIS.MV_OWG_INT_2 owg
		ON owg.owg_id = vis.owg_id
		JOIN DBP_MSI_VIEW_VIS.MV_HWG_INT_2 hwg
		ON hwg.hwg_id = owg.hwg_id
		INNER JOIN DBP_DATA.MONAT_2 zeit_2
		ON zeit.kjmo = vis.kjmo AND zeit.akt_gj IN (-1, 0) AND zeit.akt_mo < 0
		INNER JOIN dbp_data.wup_2 wup_2 
		ON wup.wup_id = vis.wup_id AND wup.mandant_id = vis.mandant_id 
		/* Standard Filter VTC : Filiale + definierte NB. Datum Eröffnung fix + GJ Schließung dynamisch */
		AND (wup.nb_id=0 OR wup.wup_id IN (0,2,22,28,43,46,124,8980,8987,8991,100000,100002,100022,100028,100043,100046,100124))
		AND wup.dat_eroeffnung<'2090-12-31' 
		AND (EXTRACT(YEAR FROM wup.dat_bis) + CASE WHEN EXTRACT(MONTH FROM wup.dat_bis) < 3 THEN -1 ELSE 0 END) > (zeit.gj + 1) 
		GROUP BY vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.kjmo
	) sub2 
	ON sub2.wup_id = sub.wup_id AND sub2.mandant_id = sub.mandant_id
	AND sub2.wrg_id = sub.wrg_id AND sub2.kjmo = sub.kjmo
) vtr 
 
/* VTR320 Abschriften_2 Ultra-Frische (%) */ 
UNION ALL SELECT mandant_id, nb_id, vs_id, vkl_id, wup_id, wrg_id, gj, kjmo, 320::INTEGER AS VTR_ID 
, ist_fil  AS FILIST,  ist_fil2  AS FILIST2 
, kvj_fil  AS FILKVJ,  kvj_fil2  AS FILKVJ2 
, plan_fil AS FILPLAN, plan_fil2 AS FILPLAN2 
, ist_reg  AS REGIST,  ist_reg2  AS REGIST2 
, kvj_reg  AS REGKVJ,  kvj_reg2  AS REGKVJ2 
, ist_land AS LANDIST, ist_land2 AS LANDIST2 
, kvj_land AS LANDKVJ, kvj_land2 AS LANDKVJ2 
/* kein Rang (Abschriften_2 Ultra-Frische) */
, NULL AS FILMO_RANG, NULL AS FILGJ_RANG, NULL AS VKLMO_RANG, NULL AS VKLGJ_RANG 
, NULL AS FILMO_WERT, NULL AS FILGJ_WERT, NULL AS VKLMO_WERT, NULL AS VKLGJ_WERT 
FROM ( /* VTR310 Abschriften_2 operativ proz */
	SELECT sub.mandant_id, sub.nb_id, sub.wup_id, sub.wrg_id, sub.vs_id, sub.vkl_id, sub.gj, sub.kjmo
	, sub0.ums_uf_ist AS ist_fil2
	, sub0.ums_uf_kvj AS kvj_fil2
	, sub1.abs_uf_ist AS ist_fil
	, sub1.abs_uf_kvj AS kvj_fil
	, sub2.abs_uf_plan AS plan_fil
	, sub2.ums_uf_plan AS plan_fil2
	/* Referenz Region_2/Land_2 */
	, SUM(sub0.ums_uf_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vs_id) AS ist_reg2
	, SUM(sub0.ums_uf_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vs_id) AS kvj_reg2
	, SUM(sub0.ums_uf_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo) AS ist_land2
	, SUM(sub0.ums_uf_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo) AS kvj_land2
	, SUM(sub1.abs_uf_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vs_id) AS ist_reg
	, SUM(sub1.abs_uf_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vs_id) AS kvj_reg
	, SUM(sub1.abs_uf_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo) AS ist_land
	, SUM(sub1.abs_uf_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo) AS kvj_land
	FROM monat_fakt_wup sub
	LEFT OUTER JOIN monat_fakt_wg sub0 
	ON sub0.wup_id = sub.wup_id AND sub0.mandant_id = sub.mandant_id
	AND sub0.wrg_id = sub.wrg_id AND sub0.kjmo = sub.kjmo
	LEFT OUTER JOIN tag_abschriften_wg sub1
	ON sub1.wup_id = sub.wup_id AND sub1.mandant_id = sub.mandant_id
	AND sub1.wrg_id = sub.wrg_id AND sub1.kjmo = sub.kjmo
	LEFT OUTER JOIN ( /* SUB004 VIS_UMSATZ_ABSCHRIFTEN_PLAN (mv_view) */
		SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.kjmo
		, SUM(vis.abschriften_netto_operativ_plan) AS abs_op_plan
		, SUM(CASE WHEN hwg.abt_id=5 THEN vis.abschriften_netto_operativ_plan ELSE 0 END) AS abs_uf_plan
		, SUM(vis.umsatz_netto_plan) AS ums_plan
		, SUM(CASE WHEN hwg.abt_id=5 THEN vis.umsatz_netto_plan ELSE 0 END) AS ums_uf_plan
		FROM DBP_MSI_VIEW_VIS.MV_WUP_PLAN_KJMO_OWG_2 vis
		JOIN DBP_MSI_VIEW_VIS.MV_OWG_INT_2 owg
		ON owg.owg_id = vis.owg_id
		JOIN DBP_MSI_VIEW_VIS.MV_HWG_INT_2 hwg
		ON hwg.hwg_id = owg.hwg_id
		INNER JOIN DBP_DATA.MONAT_2 zeit_2
		ON zeit.kjmo = vis.kjmo AND zeit.akt_gj IN (-1, 0) AND zeit.akt_mo < 0
		INNER JOIN dbp_data.wup_2 wup_2 
		ON wup.wup_id = vis.wup_id AND wup.mandant_id = vis.mandant_id 
		/* Standard Filter VTC : Filiale + definierte NB. Datum Eröffnung fix + GJ Schließung dynamisch */
		AND (wup.nb_id=0 OR wup.wup_id IN (0,2,22,28,43,46,124,8980,8987,8991,100000,100002,100022,100028,100043,100046,100124))
		AND wup.dat_eroeffnung<'2090-12-31' 
		AND (EXTRACT(YEAR FROM wup.dat_bis) + CASE WHEN EXTRACT(MONTH FROM wup.dat_bis) < 3 THEN -1 ELSE 0 END) > (zeit.gj + 1) 
		GROUP BY vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.kjmo
	) sub2 
	ON sub2.wup_id = sub.wup_id AND sub2.mandant_id = sub.mandant_id
	AND sub2.wrg_id = sub.wrg_id AND sub2.kjmo = sub.kjmo
) vtr 
 
/* VTR340 Preisabschriften (%) */ 
UNION ALL SELECT mandant_id, nb_id, vs_id, vkl_id, wup_id, wrg_id, gj, kjmo, 340::INTEGER AS VTR_ID 
, ist_fil  AS FILIST,  ist_fil2  AS FILIST2 
, kvj_fil  AS FILKVJ,  kvj_fil2  AS FILKVJ2 
, NULL     AS FILPLAN, NULL      AS FILPLAN2 /* kein plan */ 
, ist_reg  AS REGIST,  ist_reg2  AS REGIST2 
, kvj_reg  AS REGKVJ,  kvj_reg2  AS REGKVJ2 
, ist_land AS LANDIST, ist_land2 AS LANDIST2 
, kvj_land AS LANDKVJ, kvj_land2 AS LANDKVJ2 
/* kein Rang (Preisabschriften proz) */
, NULL AS FILMO_RANG, NULL AS FILGJ_RANG, NULL AS VKLMO_RANG, NULL AS VKLGJ_RANG 
, NULL AS FILMO_WERT, NULL AS FILGJ_WERT, NULL AS VKLMO_WERT, NULL AS VKLGJ_WERT 
FROM ( /* VTR340 Preisabschriften proz */
	SELECT sub.mandant_id, sub.nb_id, sub.wup_id, sub.wrg_id, sub.vs_id, sub.vkl_id, sub.gj, sub.kjmo
	, sub0.ums_ist AS ist_fil2
	, sub0.ums_kvj AS kvj_fil2
	, sub1.abs_pa_ist AS ist_fil
	, sub1.abs_pa_kvj AS kvj_fil
	/* Referenz Region_2/Land_2 */
	, SUM(sub.ums_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vs_id) AS ist_reg2
	, SUM(sub.ums_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vs_id) AS kvj_reg2
	, SUM(sub.ums_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo) AS ist_land2
	, SUM(sub.ums_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo) AS kvj_land2
	, SUM(sub1.abs_pa_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vs_id) AS ist_reg
	, SUM(sub1.abs_pa_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vs_id) AS kvj_reg
	, SUM(sub1.abs_pa_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo) AS ist_land
	, SUM(sub1.abs_pa_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo) AS kvj_land
	FROM monat_fakt_wup sub
	LEFT OUTER JOIN monat_fakt_wg sub0 
	ON sub0.wup_id = sub.wup_id AND sub0.mandant_id = sub.mandant_id
	AND sub0.wrg_id = sub.wrg_id AND sub0.kjmo = sub.kjmo
	LEFT OUTER JOIN tag_abschriften_wg sub1
	ON sub1.wup_id = sub.wup_id AND sub1.mandant_id = sub.mandant_id
	AND sub1.wrg_id = sub.wrg_id AND sub1.kjmo = sub.kjmo
) vtr 
 
/* VTR345 Preisabschriften Anteil */ 
UNION ALL SELECT mandant_id, nb_id, vs_id, vkl_id, wup_id, wrg_id, gj, kjmo, 345::INTEGER AS VTR_ID 
, ist_fil  AS FILIST,  ist_fil2  AS FILIST2 
, kvj_fil  AS FILKVJ,  kvj_fil2  AS FILKVJ2 
, NULL     AS FILPLAN, NULL      AS FILPLAN2 /* kein plan */
, ist_reg  AS REGIST,  ist_reg2  AS REGIST2 
, kvj_reg  AS REGKVJ,  kvj_reg2  AS REGKVJ2 
, ist_land AS LANDIST, ist_land2 AS LANDIST2 
, kvj_land AS LANDKVJ, kvj_land2 AS LANDKVJ2 
/* Rang absteigend: IST% (Preisabschriften Anteil) */
, CASE WHEN neo_fg=1 THEN DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, kjmo, vs_id ORDER BY fil_mo DESC NULLS LAST) END AS FILMO_RANG
, CASE WHEN neo_fg*stl_fg=1 THEN DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, gj, vs_id ORDER BY fil_gj DESC NULLS LAST) END AS FILGJ_RANG
, CASE WHEN zf_fg=1 THEN DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, kjmo, vs_id ORDER BY vkl_mo DESC NULLS LAST) END AS VKLMO_RANG
, CASE WHEN zf_fg*stl_fg=1 THEN DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, gj, vs_id ORDER BY vkl_gj DESC NULLS LAST) END AS VKLGJ_RANG
, CASE WHEN neo_fg=1 THEN fil_mo END AS FILMO_WERT
, CASE WHEN neo_fg*stl_fg=1 THEN fil_gj END AS FILGJ_WERT
, CASE WHEN zf_fg=1 THEN vkl_mo END AS VKLMO_WERT
, CASE WHEN zf_fg*stl_fg=1 THEN vkl_gj END AS VKLGJ_WERT
FROM ( /* VTR345 Preisabschriften Anteil */
	SELECT sub.mandant_id, sub.nb_id, sub.wup_id, sub.wrg_id, sub.vs_id, sub.vkl_id, sub.gj, sub.kjmo
	, sub1.abs_pa_ist AS ist_fil
	, sub1.abs_pa_kvj AS kvj_fil
	, sub1.abs_op_ist AS ist_fil2
	, sub1.abs_op_kvj AS kvj_fil2
	/* Referenz Region_2/Land_2 */
	, SUM(sub1.abs_pa_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vs_id) AS ist_reg
	, SUM(sub1.abs_pa_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vs_id) AS kvj_reg
	, SUM(sub1.abs_pa_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo) AS ist_land
	, SUM(sub1.abs_pa_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo) AS kvj_land
	, SUM(sub1.abs_op_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vs_id) AS ist_reg2
	, SUM(sub1.abs_op_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vs_id) AS kvj_reg2
	, SUM(sub1.abs_op_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo) AS ist_land2
	, SUM(sub1.abs_op_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo) AS kvj_land2
	/* Rang : neo_fg = Filialen mind. 1 GJ offen, ohne Schließungmonat, ohne Ausschluss-Liste */
	, CASE WHEN sub.stl_dat > sub.max_dat 
		AND sub.gj > (EXTRACT(YEAR FROM sub.neo_dat)+CASE WHEN EXTRACT(MONTH FROM sub.neo_dat)<3 THEN -1 ELSE 0 END)+1 
		AND sub.nb_id=0 
		AND NOT ( /* Ausschluss Getränkemärkte, Zeltverkauf etc 2024-04-08 */
			(sub.mandant_id=1 AND sub.wup_id IN (1263,1273,2583,3166,6623,7220,8120,8563,8940,5876)) /* DE */ 
			OR (sub.mandant_id=7 AND sub.wup_id IN (1110,1410,6210,6310,6410)) /* RO */ 
			OR (sub.mandant_id=3 AND sub.wup_id IN (1010)) /* PL */
		) THEN 1 ELSE 0 END AS neo_fg
	/* Rang GJ : stl_fg = Filialen ohne Schließungen */
	, CASE WHEN sub.stl_dat BETWEEN TO_DATE(TO_CHAR(sub.gj)||'-03-01','YYYY-MM_2-DD') 
	  AND ADD_MONTHS(TO_DATE(TO_CHAR(sub.gj)||'-03-01','YYYY-MM_2-DD'),12)-1 
	  THEN 0 ELSE 1 END AS stl_fg 
	/* Rang VKL_2 : zf_fg = filialen ohne dummy_2 vkl_2 */
	, CASE WHEN sub.nb_id=0 AND sub.vkl_id>0 THEN 1 ELSE 0 END AS zf_fg
	/* Setup Rang :filiale monat_2 */
	, (neo_fg*sub1.abs_pa_ist) AS ist_fil_mo
	, (neo_fg*sub1.abs_pa_kvj) AS kvj_fil_mo
	, (neo_fg*sub1.abs_op_ist) AS ist_fil_mo2
	, (neo_fg*sub1.abs_op_kvj) AS kvj_fil_mo2
	/* Setup Rang :filiale gj */
	, SUM(neo_fg*stl_fg*sub1.abs_pa_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.wup_id) AS ist_fil_gj
	, SUM(neo_fg*stl_fg*sub1.abs_pa_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.wup_id) AS kvj_fil_gj
	, SUM(neo_fg*stl_fg*sub1.abs_op_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.wup_id) AS ist_fil_gj2
	, SUM(neo_fg*stl_fg*sub1.abs_op_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.wup_id) AS kvj_fil_gj2
	/* Setup Rang :vkl_2 monat_2 - werte mit neo_fg, rang ohne neo_fg */
	, SUM(neo_fg*zf_fg*sub1.abs_pa_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vkl_id) AS ist_vkl_mo
	, SUM(neo_fg*zf_fg*sub1.abs_pa_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vkl_id) AS kvj_vkl_mo
	, SUM(neo_fg*zf_fg*sub1.abs_op_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vkl_id) AS ist_vkl_mo2
	, SUM(neo_fg*zf_fg*sub1.abs_op_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vkl_id) AS kvj_vkl_mo2
	/* Setup Rang :vkl_2 gj */
	, SUM(neo_fg*zf_fg*stl_fg*sub1.abs_pa_ist)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.vkl_id) AS ist_vkl_gj
	, SUM(neo_fg*zf_fg*stl_fg*sub1.abs_pa_kvj)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.vkl_id) AS kvj_vkl_gj
	, SUM(neo_fg*zf_fg*stl_fg*sub1.abs_op_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.vkl_id) AS ist_vkl_gj2
	, SUM(neo_fg*zf_fg*stl_fg*sub1.abs_op_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.vkl_id) AS kvj_vkl_gj2
	/* Rang absteigend: IST% (Preisabschriften Anteil) */
	, NULLIFZERO(neo_fg)       * ((ist_fil_mo/NULLIFZERO(ist_fil_mo2))-(kvj_fil_mo/NULLIFZERO(kvj_fil_mo2))) AS fil_mo
	, NULLIFZERO(neo_fg*stl_fg)* ((ist_fil_gj/NULLIFZERO(ist_fil_gj2))-(kvj_fil_gj/NULLIFZERO(kvj_fil_gj2))) AS fil_gj
	, NULLIFZERO(zf_fg)        * ((ist_vkl_mo/NULLIFZERO(ist_vkl_mo2))-(kvj_vkl_mo/NULLIFZERO(kvj_vkl_mo2))) AS vkl_mo
	, NULLIFZERO(zf_fg*stl_fg) * ((ist_vkl_gj/NULLIFZERO(ist_vkl_gj2))-(kvj_vkl_gj/NULLIFZERO(kvj_vkl_gj2))) AS vkl_gj 
	FROM monat_fakt_wup sub
	LEFT OUTER JOIN tag_abschriften_wg sub1
	ON sub1.wup_id = sub.wup_id AND sub1.mandant_id = sub.mandant_id
	AND sub1.wrg_id = sub.wrg_id AND sub1.kjmo = sub.kjmo
) vtr 
 
/* VTR360 Totalabschriften proz */ 
UNION ALL SELECT mandant_id, nb_id, vs_id, vkl_id, wup_id, wrg_id, gj, kjmo, 360::INTEGER AS VTR_ID 
, ist_fil  AS FILIST,  ist_fil2  AS FILIST2 
, kvj_fil  AS FILKVJ,  kvj_fil2  AS FILKVJ2 
, NULL     AS FILPLAN, NULL      AS FILPLAN2 /* kein plan */ 
, ist_reg  AS REGIST,  ist_reg2  AS REGIST2 
, kvj_reg  AS REGKVJ,  kvj_reg2  AS REGKVJ2 
, ist_land AS LANDIST, ist_land2 AS LANDIST2 
, kvj_land AS LANDKVJ, kvj_land2 AS LANDKVJ2 
/* kein Rang (Totalabschriften proz) */
, NULL AS FILMO_RANG, NULL AS FILGJ_RANG, NULL AS VKLMO_RANG, NULL AS VKLGJ_RANG 
, NULL AS FILMO_WERT, NULL AS FILGJ_WERT, NULL AS VKLMO_WERT, NULL AS VKLGJ_WERT 
FROM ( /* VTR360 Totalabschriften proz */
	SELECT sub.mandant_id, sub.nb_id, sub.wup_id, sub.wrg_id, sub.vs_id, sub.vkl_id, sub.gj, sub.kjmo
	, sub0.ums_ist AS ist_fil2
	, sub0.ums_kvj AS kvj_fil2
	, sub1.abs_ta_ist AS ist_fil
	, sub1.abs_ta_kvj AS kvj_fil
	/* Referenz Region_2/Land_2 */
	, SUM(sub0.ums_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vs_id) AS ist_reg2
	, SUM(sub0.ums_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vs_id) AS kvj_reg2
	, SUM(sub0.ums_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo) AS ist_land2
	, SUM(sub0.ums_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo) AS kvj_land2
	, SUM(sub1.abs_ta_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vs_id) AS ist_reg
	, SUM(sub1.abs_ta_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vs_id) AS kvj_reg
	, SUM(sub1.abs_ta_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo) AS ist_land
	, SUM(sub1.abs_ta_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo) AS kvj_land
	FROM monat_fakt_wup sub
	LEFT OUTER JOIN monat_fakt_wg sub0 
	ON sub0.wup_id = sub.wup_id AND sub0.mandant_id = sub.mandant_id
	AND sub0.wrg_id = sub.wrg_id AND sub0.kjmo = sub.kjmo
	LEFT OUTER JOIN tag_abschriften_wg sub1
	ON sub1.wup_id = sub.wup_id AND sub1.mandant_id = sub.mandant_id
	AND sub1.wrg_id = sub.wrg_id AND sub1.kjmo = sub.kjmo
) vtr 
 
/* VTR365 Totalabschriften Anteil */ 
UNION ALL SELECT mandant_id, nb_id, vs_id, vkl_id, wup_id, wrg_id, gj, kjmo, 365::INTEGER AS VTR_ID 
, ist_fil  AS FILIST,  ist_fil2  AS FILIST2 
, kvj_fil  AS FILKVJ,  kvj_fil2  AS FILKVJ2 
, NULL     AS FILPLAN, NULL      AS FILPLAN2 /* kein plan */
, ist_reg  AS REGIST,  ist_reg2  AS REGIST2 
, kvj_reg  AS REGKVJ,  kvj_reg2  AS REGKVJ2 
, ist_land AS LANDIST, ist_land2 AS LANDIST2 
, kvj_land AS LANDKVJ, kvj_land2 AS LANDKVJ2 
/* kein Rang (Totalabschriften Anteil) */
, NULL AS FILMO_RANG, NULL AS FILGJ_RANG, NULL AS VKLMO_RANG, NULL AS VKLGJ_RANG 
, NULL AS FILMO_WERT, NULL AS FILGJ_WERT, NULL AS VKLMO_WERT, NULL AS VKLGJ_WERT 
FROM ( /* VTR365 Totalabschriften Anteil */
	SELECT sub.mandant_id, sub.nb_id, sub.wup_id, sub.wrg_id, sub.vs_id, sub.vkl_id, sub.gj, sub.kjmo
	, sub1.abs_ta_ist AS ist_fil
	, sub1.abs_ta_kvj AS kvj_fil
	, sub1.abs_op_ist AS ist_fil2
	, sub1.abs_op_kvj AS kvj_fil2
	/* Referenz Region_2/Land_2 */
	, SUM(sub1.abs_ta_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vs_id) AS ist_reg
	, SUM(sub1.abs_ta_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vs_id) AS kvj_reg
	, SUM(sub1.abs_ta_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo) AS ist_land
	, SUM(sub1.abs_ta_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo) AS kvj_land
	, SUM(sub1.abs_op_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vs_id) AS ist_reg2
	, SUM(sub1.abs_op_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vs_id) AS kvj_reg2
	, SUM(sub1.abs_op_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo) AS ist_land2
	, SUM(sub1.abs_op_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo) AS kvj_land2
	FROM monat_fakt_wup sub
	LEFT OUTER JOIN tag_abschriften_wg sub1
	ON sub1.wup_id = sub.wup_id AND sub1.mandant_id = sub.mandant_id
	AND sub1.wrg_id = sub.wrg_id AND sub1.kjmo = sub.kjmo
) vtr 
 
/* VTR410 Inventurdifferenz Ultra-Frische */ 
UNION ALL SELECT mandant_id, nb_id, vs_id, vkl_id, wup_id, wrg_id, gj, kjmo, 410::INTEGER  AS VTR_ID 
, ist_fil  AS FILIST,  ist_fil2  AS FILIST2 
, NULL     AS FILKVJ,  NULL      AS FILKVJ2  /* kein VJ */
, NULL     AS FILPLAN, NULL      AS FILPLAN2 /* kein PLAN */
, ist_reg  AS REGIST,  ist_reg2  AS REGIST2 
, NULL     AS REGKVJ,  NULL      AS REGKVJ2  /* kein VJ */
, ist_land AS LANDIST, ist_land2 AS LANDIST2 
, NULL     AS LANDKVJ, NULL      AS LANDKVJ2 /* kein VJ */
/* Rang absteigend = IST (Inventurdifferenz Ultra-Frische) */
, CASE WHEN bs_fg*neo_fg=1 THEN DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, kjmo, vs_id ORDER BY fil_mo DESC NULLS LAST) END AS FILMO_RANG
, CASE WHEN neo_fg*stl_fg=1 THEN DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, gj, vs_id ORDER BY fil_gj DESC NULLS LAST) END AS FILGJ_RANG
, CASE WHEN bs_fg*zf_fg=1 THEN DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, kjmo, vs_id ORDER BY vkl_mo DESC NULLS LAST) END AS VKLMO_RANG
, CASE WHEN zf_fg*stl_fg=1 THEN DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, gj, vs_id ORDER BY vkl_gj DESC NULLS LAST) END AS VKLGJ_RANG
, CASE WHEN bs_fg*neo_fg=1 THEN fil_mo END AS FILMO_WERT
, CASE WHEN neo_fg*stl_fg=1 THEN fil_gj END AS FILGJ_WERT
, CASE WHEN bs_fg*zf_fg=1 THEN vkl_mo END AS VKLMO_WERT
, CASE WHEN zf_fg*stl_fg=1 THEN vkl_gj END AS VKLGJ_WERT  
FROM ( /* VTR410 Inventurdifferenz Ultra-Frische */
	SELECT sub.mandant_id, sub.nb_id, sub.wup_id, sub.wrg_id, sub.vs_id, sub.vkl_id, sub.gj, sub.kjmo
	, sub1.inv_wert_ist AS ist_fil
	, sub1.inv_ums_ist  AS ist_fil2
	/* Referenz Region_2/Land_2 */
	, SUM(sub1.inv_wert_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vs_id) AS ist_reg
	, SUM(sub1.inv_ums_ist)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vs_id) AS ist_reg2
	, SUM(sub1.inv_wert_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo) AS ist_land
	, SUM(sub1.inv_ums_ist)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo) AS ist_land2
	/* Rang : neo_fg = Filialen mind. 1 GJ offen, ohne Schließungmonat, ohne Ausschluss-Liste */
	, CASE WHEN sub.stl_dat > sub.max_dat 
		AND sub.gj > (EXTRACT(YEAR FROM sub.neo_dat)+CASE WHEN EXTRACT(MONTH FROM sub.neo_dat)<3 THEN -1 ELSE 0 END)+1 
		AND sub.nb_id=0 
		AND NOT ( /* Ausschluss Getränkemärkte, Zeltverkauf etc 2024-04-08 */
			(sub.mandant_id=1 AND sub.wup_id IN (1263,1273,2583,3166,6623,7220,8120,8563,8940,5876)) /* DE */ 
			OR (sub.mandant_id=7 AND sub.wup_id IN (1110,1410,6210,6310,6410)) /* RO */ 
			OR (sub.mandant_id=3 AND sub.wup_id IN (1010)) /* PL */
		) THEN 1 ELSE 0 END AS neo_fg
	/* Rang GJ : stl_fg = Filialen ohne Schließungen */
	, CASE WHEN sub.stl_dat BETWEEN TO_DATE(TO_CHAR(sub.gj)||'-03-01','YYYY-MM_2-DD') 
	  AND ADD_MONTHS(TO_DATE(TO_CHAR(sub.gj)||'-03-01','YYYY-MM_2-DD'),12)-1 
	  THEN 0 ELSE 1 END AS stl_fg 
	/* Rang VKL_2 : zf_fg = filialen ohne dummy_2 vkl_2 */
	, CASE WHEN sub.nb_id=0 AND sub.vkl_id>0 THEN 1 ELSE 0 END AS zf_fg
	/* Rang BS : bs_fg = Nur Monate vor Buchungsschluss, wichtig am Monatsanfang*/
	, CASE WHEN sub.akt_bs <= 0 THEN 1 ELSE 0 END AS bs_fg
	/* Setup Rang : filiale monat_2 */
	, (neo_fg*sub1.inv_wert_ist) AS ist_fil_mo
	, (neo_fg*sub1.inv_ums_ist)  AS ist_fil_mo2
	/* Setup Rang : filiale gj */
	, SUM(bs_fg*neo_fg*stl_fg*sub1.inv_wert_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.wup_id) AS ist_fil_gj
	, SUM(bs_fg*neo_fg*stl_fg*sub1.inv_ums_ist)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.wup_id) AS ist_fil_gj2
	/* Setup Rang : vkl_2 monat_2 */
	, SUM(neo_fg*zf_fg*sub1.inv_wert_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vkl_id) AS ist_vkl_mo
	, SUM(neo_fg*zf_fg*sub1.inv_ums_ist)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vkl_id) AS ist_vkl_mo2
	/* Setup Rang : vkl_2 gj */
	, SUM(bs_fg*neo_fg*zf_fg*stl_fg*sub1.inv_wert_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.vkl_id) AS ist_vkl_gj
	, SUM(bs_fg*neo_fg*zf_fg*stl_fg*sub1.inv_ums_ist)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.vkl_id) AS ist_vkl_gj2
	/* Rang absteigend = IST (Inventurdifferenz Ultra-Frische) */
	, NULLIFZERO(neo_fg)       * (ist_fil_mo/NULLIFZERO(ist_fil_mo2)) AS fil_mo
	, NULLIFZERO(neo_fg*stl_fg)* (ist_fil_gj/NULLIFZERO(ist_fil_gj2)) AS fil_gj
	, NULLIFZERO(zf_fg)        * (ist_vkl_mo/NULLIFZERO(ist_vkl_mo2)) AS vkl_mo
	, NULLIFZERO(zf_fg*stl_fg) * (ist_vkl_gj/NULLIFZERO(ist_vkl_gj2)) AS vkl_gj 
	FROM monat_fakt_wup sub
	LEFT OUTER JOIN ( /* SUB0041 VIS_MONAT_HFM_INVENTUR_IST (aus mv_view) */
		SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id
		, zeit.kjmo
		, SUM(vis.inventur_wert_netto) AS inv_wert_ist
		, SUM(vis.inventur_ums_netto)  AS inv_ums_ist
		FROM DBP_MSI_VIEW_VIS.MV_VIS_MONAT_HFM_INVENTUR_2 vis
		INNER JOIN dbp_data.tag_2 zeit1
		ON zeit1.dat = vis.dat_plan_zaehlung /* Mapping, abweichendes Datum */
		INNER JOIN DBP_DATA.MONAT_2 zeit_2
		ON zeit.kjmo = zeit1.kjmo AND zeit.akt_gj IN (-1, 0) AND zeit.akt_mo < 0
		INNER JOIN dbp_data.wup_2 wup_2 
		ON wup.wup_id = vis.wup_id AND wup.mandant_id = vis.mandant_id 
		/* Standard Filter VTC : Filiale + definierte NB. Datum Eröffnung fix + GJ Schließung dynamisch */
		AND (wup.nb_id=0 OR wup.wup_id IN (0,2,22,28,43,46,124,8980,8987,8991,100000,100002,100022,100028,100043,100046,100124))
		AND wup.dat_eroeffnung<'2090-12-31' 
		AND (EXTRACT(YEAR FROM wup.dat_bis) + CASE WHEN EXTRACT(MONTH FROM wup.dat_bis) < 3 THEN -1 ELSE 0 END) > (zeit.gj + 1) 
		WHERE vis.abt_invart_id IN (50) /* nur Frische Inventur_2 */
		GROUP BY vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.kjmo
	) sub1
	ON sub1.mandant_id = sub.mandant_id AND sub1.wup_id = sub.wup_id
	AND sub1.wrg_id = sub.wrg_id AND sub1.kjmo = sub.kjmo
) vtr 
  
 /* OFFEN : 430 Bestandsentwicklung (zum Vormonat) */ 
 /* OFFEN : 450 Fehlerquote Mengenkorrektur */ 
 
UNION ALL SELECT mandant_id, nb_id, vs_id, vkl_id, wup_id, wrg_id, gj, kjmo
, 510::INTEGER  AS VTR_ID /* 510 Warten Kasse inkl. BS */ 
, ist_fil  AS FILIST,  NULL AS FILIST2 
, kvj_fil  AS FILKVJ,  NULL AS FILKVJ2 
, NULL     AS FILPLAN, NULL AS FILPLAN2 /* kein plan */
, ist_reg  AS REGIST,  NULL AS REGIST2 
, kvj_reg  AS REGKVJ,  NULL AS REGKVJ2 
, ist_land AS LANDIST, NULL AS LANDIST2 
, kvj_land AS LANDKVJ, NULL AS LANDKVJ2 
/* Rang aufsteigend = IST (Warten Kasse) */
, CASE WHEN bs_fg*neo_fg=1 THEN DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, kjmo, vs_id ORDER BY fil_mo ASC NULLS LAST) END AS FILMO_RANG
, CASE WHEN neo_fg*stl_fg=1 THEN DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, gj, vs_id ORDER BY fil_gj ASC NULLS LAST) END AS FILGJ_RANG
, CASE WHEN bs_fg*zf_fg=1 THEN DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, kjmo, vs_id ORDER BY vkl_mo ASC NULLS LAST) END AS VKLMO_RANG
, CASE WHEN zf_fg*stl_fg=1 THEN DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, gj, vs_id ORDER BY vkl_gj ASC NULLS LAST) END AS VKLGJ_RANG
, CASE WHEN bs_fg*neo_fg=1 THEN fil_mo END AS FILMO_WERT
, CASE WHEN neo_fg*stl_fg=1 THEN fil_gj END AS FILGJ_WERT
, CASE WHEN bs_fg*zf_fg=1 THEN vkl_mo END AS VKLMO_WERT
, CASE WHEN zf_fg*stl_fg=1 THEN vkl_gj END AS VKLGJ_WERT  
FROM ( /* VTR510 Warten Kasse */
	SELECT sub.mandant_id, sub.nb_id, sub.wup_id, sub.wrg_id, sub.vs_id, sub.vkl_id, sub.gj, sub.kjmo
	, sub1.w_kasse_ist AS ist_fil
	, sub2.w_kasse_kvj AS kvj_fil
	/* Referenz Region_2/Land_2 */
	, SUM(sub1.w_kasse_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vs_id) AS ist_reg
	, SUM(sub2.w_kasse_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vs_id) AS kvj_reg
	, SUM(sub1.w_kasse_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo) AS ist_land
	, SUM(sub2.w_kasse_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo) AS kvj_land
	/* Rang : neo_fg = Filialen mind. 1 GJ offen, ohne Schließungmonat, ohne Ausschluss-Liste */
	, CASE WHEN sub.stl_dat > sub.max_dat 
		AND sub.gj > (EXTRACT(YEAR FROM sub.neo_dat)+CASE WHEN EXTRACT(MONTH FROM sub.neo_dat)<3 THEN -1 ELSE 0 END)+1 
		AND sub.nb_id=0 
		AND NOT ( /* Ausschluss Getränkemärkte, Zeltverkauf etc 2024-04-08 */
			(sub.mandant_id=1 AND sub.wup_id IN (1263,1273,2583,3166,6623,7220,8120,8563,8940,5876)) /* DE */ 
			OR (sub.mandant_id=7 AND sub.wup_id IN (1110,1410,6210,6310,6410)) /* RO */ 
			OR (sub.mandant_id=3 AND sub.wup_id IN (1010)) /* PL */
		) THEN 1 ELSE 0 END AS neo_fg
	/* Rang GJ : stl_fg = Filialen ohne Schließungen */
	, CASE WHEN sub.stl_dat BETWEEN TO_DATE(TO_CHAR(sub.gj)||'-03-01','YYYY-MM_2-DD') 
	  AND ADD_MONTHS(TO_DATE(TO_CHAR(sub.gj)||'-03-01','YYYY-MM_2-DD'),12)-1 
	  THEN 0 ELSE 1 END AS stl_fg 
	/* Rang VKL_2 : zf_fg = filialen ohne dummy_2 vkl_2 */
	, CASE WHEN sub.nb_id=0 AND sub.vkl_id>0 THEN 1 ELSE 0 END AS zf_fg
	/* Rang BS : bs_fg = Nur Monate vor Buchungsschluss, wichtig am Monatsanfang*/
	, CASE WHEN sub.akt_bs <= 0 THEN 1 ELSE 0 END AS bs_fg
	/* Setup Rang : filiale monat_2 */
	, (neo_fg*sub1.w_kasse_ist)  AS ist_fil_mo
	, (neo_fg*sub2.w_kasse_kvj)  AS kvj_fil_mo
	/* Setup Rang : filiale gj */
	, SUM(bs_fg*neo_fg*stl_fg*sub1.w_kasse_ist)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.wup_id) AS ist_fil_gj
	, SUM(bs_fg*neo_fg*stl_fg*sub2.w_kasse_kvj)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.wup_id) AS kvj_fil_gj
	/* Setup Rang : vkl_2 monat_2 */
	, SUM(neo_fg*zf_fg*sub1.w_kasse_ist)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vkl_id) AS ist_vkl_mo
	, SUM(neo_fg*zf_fg*sub2.w_kasse_kvj)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vkl_id) AS kvj_vkl_mo
	/* Setup Rang : vkl_2 gj */
	, SUM(bs_fg*neo_fg*zf_fg*stl_fg*sub1.w_kasse_ist)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.vkl_id) AS ist_vkl_gj
	, SUM(bs_fg*neo_fg*zf_fg*stl_fg*sub2.w_kasse_kvj)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.vkl_id) AS kvj_vkl_gj
	/* Rang aufsteigend = IST (Warten Kasse) */
	, NULLIFZERO(neo_fg)        * ZEROIFNULL(ist_fil_mo) AS fil_mo
	, NULLIFZERO(neo_fg*stl_fg) * ZEROIFNULL(ist_fil_gj) AS fil_gj
	, NULLIFZERO(zf_fg)         * ZEROIFNULL(ist_vkl_mo) AS vkl_mo
	, NULLIFZERO(zf_fg*stl_fg)  * ZEROIFNULL(ist_vkl_gj) AS vkl_gj
	FROM monat_fakt_wup sub
	LEFT OUTER JOIN ( /* SUB0051 REKL_IST (aus mv_view) */
		SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id
		, zeit.kjmo
		, SUM(CASE WHEN reklamationsgrund_id IN(12,19) THEN 1 ELSE 0 END) AS f_preis_ist
		, SUM(CASE WHEN reklamationsgrund_id IN(13,14) THEN 1 ELSE 0 END) AS f_kasse_ist
		, SUM(CASE WHEN reklamationsgrund_id = 91 THEN vk_menge_kuga ELSE 0 END) AS w_theke_ist
		, SUM(CASE WHEN reklamationsgrund_id = 92 THEN vk_menge_kuga ELSE 0 END) AS w_kasse_ist
		, SUM(CASE WHEN reklamationsgrund_id = 93 THEN vk_menge_kuga ELSE 0 END) AS anz_mhd_ist
		FROM DBP_MSI_VIEW_VIS.MV_VIS_TAG_REKL_ART_2 vis
		INNER JOIN dbp_data.tag_2 zeit1
		ON zeit1.dat = vis.dat
		INNER JOIN DBP_DATA.MONAT_2 zeit_2
		ON zeit.kjmo = zeit1.kjmo AND zeit.akt_gj IN (-1, 0) AND zeit.akt_mo < 0
		INNER JOIN dbp_data.wup_2 wup_2 
		ON wup.wup_id = vis.wup_id AND wup.mandant_id = vis.mandant_id 
		/* Standard Filter VTC : Filiale + definierte NB. Datum Eröffnung fix + GJ Schließung dynamisch */
		AND (wup.nb_id=0 OR wup.wup_id IN (0,2,22,28,43,46,124,8980,8987,8991,100000,100002,100022,100028,100043,100046,100124))
		AND wup.dat_eroeffnung<'2090-12-31' 
		AND (EXTRACT(YEAR FROM wup.dat_bis) + CASE WHEN EXTRACT(MONTH FROM wup.dat_bis) < 3 THEN -1 ELSE 0 END) > (zeit.gj + 1) 
		/* Definierte Gründe, ohne Pfand */
		WHERE vis.reklamationsgrund_id IN (12,13,14,19,91,92,93)
		AND (vis.mandant_id, vis.art_id) IN ( 
			SELECT mandant_id, art_id FROM DBP_MSI_VIEW_VIS.MV_ART_WG_ZU_2
			WHERE wg_id NOT IN (980)
		) 
		GROUP BY vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.kjmo
	) sub1
	ON sub1.mandant_id = sub.mandant_id AND sub1.wup_id = sub.wup_id
	AND sub1.wrg_id = sub.wrg_id AND sub1.kjmo = sub.kjmo
	LEFT OUTER JOIN ( /* SUB0051 REKL_KVJ Transformation (aus mv_view) */
		SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id 
		, zeit.kjmo
		, SUM(CASE WHEN reklamationsgrund_id IN(12,19) THEN 1 ELSE 0 END) AS f_preis_kvj
		, SUM(CASE WHEN reklamationsgrund_id IN(13,14) THEN 1 ELSE 0 END) AS f_kasse_kvj
		, SUM(CASE WHEN reklamationsgrund_id = 91 THEN vk_menge_kuga ELSE 0 END) AS w_theke_kvj
		, SUM(CASE WHEN reklamationsgrund_id = 92 THEN vk_menge_kuga ELSE 0 END) AS w_kasse_kvj
		, SUM(CASE WHEN reklamationsgrund_id = 93 THEN vk_menge_kuga ELSE 0 END) AS anz_mhd_kvj
		FROM DBP_MSI_VIEW_VIS.MV_VIS_TAG_REKL_ART_2 vis
		INNER JOIN dbp_data.tag_2 zeit1
		ON zeit1.dat = vis.dat
		/* Transformation KVJ */
		INNER JOIN DBP_DATA.MONAT_2 zeit_2
		ON zeit.kjmo = zeit1.kjmo+100 AND zeit.akt_gj IN (-1, 0) AND zeit.akt_mo < 0
		INNER JOIN dbp_data.wup_2 wup_2 
		ON wup.wup_id = vis.wup_id AND wup.mandant_id = vis.mandant_id 
		/* Standard Filter VTC : Filiale + definierte NB. Datum Eröffnung fix + GJ Schließung dynamisch */
		AND (wup.nb_id=0 OR wup.wup_id IN (0,2,22,28,43,46,124,8980,8987,8991,100000,100002,100022,100028,100043,100046,100124))
		AND wup.dat_eroeffnung<'2090-12-31' 
		AND (EXTRACT(YEAR FROM wup.dat_bis) + CASE WHEN EXTRACT(MONTH FROM wup.dat_bis) < 3 THEN -1 ELSE 0 END) > (zeit.gj + 1) 
		/* Definierte Gründe, ohne Pfand */
		WHERE vis.reklamationsgrund_id IN (12,13,14,19,91,92,93)
		AND (vis.mandant_id, vis.art_id) IN ( 
			SELECT mandant_id, art_id FROM DBP_MSI_VIEW_VIS.MV_ART_WG_ZU_2
			WHERE wg_id NOT IN (980)
		) 
		GROUP BY vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.kjmo 
	) sub2
	ON sub2.mandant_id = sub.mandant_id AND sub2.wup_id = sub.wup_id
	AND sub2.wrg_id = sub.wrg_id AND sub2.kjmo = sub.kjmo
) vtr 
 
UNION ALL SELECT mandant_id, nb_id, vs_id, vkl_id, wup_id, wrg_id, gj, kjmo
, 515::INTEGER  AS VTR_ID /* 515 Warten Kasse pro 10T Kunden */ 
, ist_fil  AS FILIST,  ist_fil2 AS FILIST2 
, kvj_fil  AS FILKVJ,  kvj_fil2 AS FILKVJ2 
, NULL     AS FILPLAN, NULL AS FILPLAN2 /* kein plan */
, ist_reg  AS REGIST,  ist_reg2 AS REGIST2 
, kvj_reg  AS REGKVJ,  kvj_reg2 AS REGKVJ2 
, ist_land AS LANDIST, ist_land2 AS LANDIST2 
, kvj_land AS LANDKVJ, kvj_land2 AS LANDKVJ2 
/* Rang aufsteigend = IST Quote (Warten Kasse pro 10T Kunden) */
, CASE WHEN neo_fg=1 THEN DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, kjmo, vs_id ORDER BY fil_mo ASC NULLS LAST) END AS FILMO_RANG
, CASE WHEN neo_fg*stl_fg=1 THEN DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, gj, vs_id ORDER BY fil_gj ASC NULLS LAST) END AS FILGJ_RANG
, CASE WHEN zf_fg=1 THEN DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, kjmo, vs_id ORDER BY vkl_mo ASC NULLS LAST) END AS VKLMO_RANG
, CASE WHEN zf_fg*stl_fg=1 THEN DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, gj, vs_id ORDER BY vkl_gj ASC NULLS LAST) END AS VKLGJ_RANG
, CASE WHEN neo_fg=1 THEN fil_mo END AS FILMO_WERT
, CASE WHEN neo_fg*stl_fg=1 THEN fil_gj END AS FILGJ_WERT
, CASE WHEN zf_fg=1 THEN vkl_mo END AS VKLMO_WERT
, CASE WHEN zf_fg*stl_fg=1 THEN vkl_gj END AS VKLGJ_WERT  
FROM ( /* VTR515 Warten Kasse pro 10T Kunden */
	SELECT sub.mandant_id, sub.nb_id, sub.wup_id, sub.wrg_id, sub.vs_id, sub.vkl_id, sub.gj, sub.kjmo
	, sub.knd_10t_ist AS ist_fil2
	, sub.knd_10t_kvj AS kvj_fil2
	, sub1.w_kasse_ist AS ist_fil
	, sub2.w_kasse_kvj AS kvj_fil
	/* Referenz Region_2/Land_2 */
	, SUM(sub.knd_10t_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vs_id) AS ist_reg2
	, SUM(sub.knd_10t_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vs_id) AS kvj_reg2
	, SUM(sub1.w_kasse_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vs_id) AS ist_reg
	, SUM(sub2.w_kasse_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vs_id) AS kvj_reg
	, SUM(sub.knd_10t_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo) AS ist_land2
	, SUM(sub.knd_10t_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo) AS kvj_land2
	, SUM(sub1.w_kasse_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo) AS ist_land
	, SUM(sub2.w_kasse_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo) AS kvj_land
	/* Rang : neo_fg = Filialen mind. 1 GJ offen, ohne Schließungmonat, ohne Ausschluss-Liste */
	, CASE WHEN sub.stl_dat > sub.max_dat 
		AND sub.gj > (EXTRACT(YEAR FROM sub.neo_dat)+CASE WHEN EXTRACT(MONTH FROM sub.neo_dat)<3 THEN -1 ELSE 0 END)+1 
		AND sub.nb_id=0 
		AND NOT ( /* Ausschluss Getränkemärkte, Zeltverkauf etc 2024-04-08 */
			(sub.mandant_id=1 AND sub.wup_id IN (1263,1273,2583,3166,6623,7220,8120,8563,8940,5876)) /* DE */ 
			OR (sub.mandant_id=7 AND sub.wup_id IN (1110,1410,6210,6310,6410)) /* RO */ 
			OR (sub.mandant_id=3 AND sub.wup_id IN (1010)) /* PL */
		) THEN 1 ELSE 0 END AS neo_fg
	/* Rang GJ : stl_fg = Filialen ohne Schließungen */
	, CASE WHEN sub.stl_dat BETWEEN TO_DATE(TO_CHAR(sub.gj)||'-03-01','YYYY-MM_2-DD') 
	  AND ADD_MONTHS(TO_DATE(TO_CHAR(sub.gj)||'-03-01','YYYY-MM_2-DD'),12)-1 
	  THEN 0 ELSE 1 END AS stl_fg 
	/* Rang VKL_2 : zf_fg = filialen ohne dummy_2 vkl_2 */
	, CASE WHEN sub.nb_id=0 AND sub.vkl_id>0 THEN 1 ELSE 0 END AS zf_fg
	/* Setup Rang : filiale monat_2 */
	, (neo_fg*sub.knd_10t_ist) AS ist_fil_mo2
	, (neo_fg*sub.knd_10t_kvj) AS kvj_fil_mo2
	, (neo_fg*sub1.w_kasse_ist) AS ist_fil_mo
	, (neo_fg*sub2.w_kasse_kvj) AS kvj_fil_mo
	/* Setup Rang : filiale gj */
	, SUM(neo_fg*stl_fg*sub.knd_10t_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.wup_id) AS ist_fil_gj2
	, SUM(neo_fg*stl_fg*sub.knd_10t_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.wup_id) AS kvj_fil_gj2
	, SUM(neo_fg*stl_fg*sub1.w_kasse_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.wup_id) AS ist_fil_gj
	, SUM(neo_fg*stl_fg*sub2.w_kasse_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.wup_id) AS kvj_fil_gj
	/* Setup Rang : vkl_2 monat_2 */
	, SUM(neo_fg*zf_fg*sub.knd_10t_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vkl_id) AS ist_vkl_mo2
	, SUM(neo_fg*zf_fg*sub.knd_10t_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vkl_id) AS kvj_vkl_mo2
	, SUM(neo_fg*zf_fg*sub1.w_kasse_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vkl_id) AS ist_vkl_mo
	, SUM(neo_fg*zf_fg*sub2.w_kasse_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vkl_id) AS kvj_vkl_mo
	/* Setup Rang : vkl_2 gj */
	, SUM(neo_fg*zf_fg*stl_fg*sub.knd_10t_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.vkl_id) AS ist_vkl_gj2
	, SUM(neo_fg*zf_fg*stl_fg*sub.knd_10t_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.vkl_id) AS kvj_vkl_gj2
	, SUM(neo_fg*zf_fg*stl_fg*sub1.w_kasse_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.vkl_id) AS ist_vkl_gj
	, SUM(neo_fg*zf_fg*stl_fg*sub2.w_kasse_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.vkl_id) AS kvj_vkl_gj
	/* Rang aufsteigend = IST Quote (Warten Kasse pro 10T Kunden) */
	, NULLIFZERO(neo_fg)        * (ist_fil_mo/NULLIFZERO(ist_fil_mo2)) AS fil_mo
	, NULLIFZERO(neo_fg*stl_fg) * (ist_fil_gj/NULLIFZERO(ist_fil_gj2)) AS fil_gj
	, NULLIFZERO(zf_fg)         * (ist_vkl_mo/NULLIFZERO(ist_vkl_mo2)) AS vkl_mo
	, NULLIFZERO(zf_fg*stl_fg)  * (ist_vkl_gj/NULLIFZERO(ist_vkl_gj2)) AS vkl_gj
	FROM monat_fakt_wup sub
	LEFT OUTER JOIN ( /* SUB051 REKL_IST (aus mv_view) */
		SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id 
		, zeit.kjmo
		, SUM(CASE WHEN reklamationsgrund_id IN(12,19) THEN 1 ELSE 0 END) AS f_preis_ist
		, SUM(CASE WHEN reklamationsgrund_id IN(13,14) THEN 1 ELSE 0 END) AS f_kasse_ist
		, SUM(CASE WHEN reklamationsgrund_id = 91 THEN vk_menge_kuga ELSE 0 END) AS w_theke_ist
		, SUM(CASE WHEN reklamationsgrund_id = 92 THEN vk_menge_kuga ELSE 0 END) AS w_kasse_ist
		, SUM(CASE WHEN reklamationsgrund_id = 93 THEN vk_menge_kuga ELSE 0 END) AS anz_mhd_ist
		FROM DBP_MSI_VIEW_VIS.MV_VIS_TAG_REKL_ART_2 vis
		INNER JOIN dbp_data.tag_2 zeit1
		ON zeit1.dat = vis.dat
		INNER JOIN DBP_DATA.MONAT_2 zeit_2
		ON zeit.kjmo = zeit1.kjmo AND zeit.akt_gj IN (-1, 0) AND zeit.akt_mo < 0
		INNER JOIN dbp_data.wup_2 wup_2 
		ON wup.wup_id = vis.wup_id AND wup.mandant_id = vis.mandant_id 
		/* Standard Filter VTC : Filiale + definierte NB. Datum Eröffnung fix + GJ Schließung dynamisch */
		AND (wup.nb_id=0 OR wup.wup_id IN (0,2,22,28,43,46,124,8980,8987,8991,100000,100002,100022,100028,100043,100046,100124))
		AND wup.dat_eroeffnung<'2090-12-31' 
		AND (EXTRACT(YEAR FROM wup.dat_bis) + CASE WHEN EXTRACT(MONTH FROM wup.dat_bis) < 3 THEN -1 ELSE 0 END) > (zeit.gj + 1) 
		/* Definierte Gründe, ohne Pfand */
		WHERE vis.reklamationsgrund_id IN (12,13,14,19,91,92,93)
		AND (vis.mandant_id, vis.art_id) IN ( 
			SELECT mandant_id, art_id FROM DBP_MSI_VIEW_VIS.MV_ART_WG_ZU_2
			WHERE wg_id NOT IN (980)
		) 
		GROUP BY vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.kjmo 
	) sub1
	ON sub1.mandant_id = sub.mandant_id AND sub1.wup_id = sub.wup_id
	AND sub1.wrg_id = sub.wrg_id AND sub1.kjmo = sub.kjmo
	LEFT OUTER JOIN ( /* SUB052 REKL_KVJ Transformation (aus mv_view) */
		SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id 
		, zeit.kjmo
		, SUM(CASE WHEN reklamationsgrund_id IN(12,19) THEN 1 ELSE 0 END) AS f_preis_kvj
		, SUM(CASE WHEN reklamationsgrund_id IN(13,14) THEN 1 ELSE 0 END) AS f_kasse_kvj
		, SUM(CASE WHEN reklamationsgrund_id = 91 THEN vk_menge_kuga ELSE 0 END) AS w_theke_kvj
		, SUM(CASE WHEN reklamationsgrund_id = 92 THEN vk_menge_kuga ELSE 0 END) AS w_kasse_kvj
		, SUM(CASE WHEN reklamationsgrund_id = 93 THEN vk_menge_kuga ELSE 0 END) AS anz_mhd_kvj
		FROM DBP_MSI_VIEW_VIS.MV_VIS_TAG_REKL_ART_2 vis
		INNER JOIN dbp_data.tag_2 zeit1
		ON zeit1.dat = vis.dat
		/* Transformation KVJ */
		INNER JOIN DBP_DATA.MONAT_2 zeit_2
		ON zeit.kjmo = zeit1.kjmo+100 AND zeit.akt_gj IN (-1, 0) AND zeit.akt_mo < 0
		INNER JOIN dbp_data.wup_2 wup_2 
		ON wup.wup_id = vis.wup_id AND wup.mandant_id = vis.mandant_id 
		/* Standard Filter VTC : Filiale + definierte NB. Datum Eröffnung fix + GJ Schließung dynamisch */
		AND (wup.nb_id=0 OR wup.wup_id IN (0,2,22,28,43,46,124,8980,8987,8991,100000,100002,100022,100028,100043,100046,100124))
		AND wup.dat_eroeffnung<'2090-12-31' 
		AND (EXTRACT(YEAR FROM wup.dat_bis) + CASE WHEN EXTRACT(MONTH FROM wup.dat_bis) < 3 THEN -1 ELSE 0 END) > (zeit.gj + 1) 
		/* Definierte Gründe, ohne Pfand */
		WHERE vis.reklamationsgrund_id IN (12,13,14,19,91,92,93)
		AND (vis.mandant_id, vis.art_id) IN ( 
			SELECT mandant_id, art_id FROM DBP_MSI_VIEW_VIS.MV_ART_WG_ZU_2
			WHERE wg_id NOT IN (980)
		) 
		GROUP BY vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.kjmo 
	) sub2
	ON sub2.mandant_id = sub.mandant_id AND sub2.wup_id = sub.wup_id
	AND sub2.wrg_id = sub.wrg_id AND sub2.kjmo = sub.kjmo
) vtr 
 
UNION ALL SELECT mandant_id, nb_id, vs_id, vkl_id, wup_id, wrg_id, gj, kjmo
, 520::INTEGER  AS VTR_ID /* 520 Warten Theke */ 
, ist_fil  AS FILIST,  NULL AS FILIST2 
, kvj_fil  AS FILKVJ,  NULL AS FILKVJ2 
, NULL     AS FILPLAN, NULL AS FILPLAN2 /* kein plan */
, ist_reg  AS REGIST,  NULL AS REGIST2 
, kvj_reg  AS REGKVJ,  NULL AS REGKVJ2 
, ist_land AS LANDIST, NULL AS LANDIST2 
, kvj_land AS LANDKVJ, NULL AS LANDKVJ2 
/* Rang aufsteigend = IST (Warten Theke) */
, CASE WHEN bs_fg*neo_fg=1 THEN DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, kjmo, vs_id ORDER BY fil_mo ASC NULLS LAST) END AS FILMO_RANG
, CASE WHEN neo_fg*stl_fg=1 THEN DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, gj, vs_id ORDER BY fil_gj ASC NULLS LAST) END AS FILGJ_RANG
, CASE WHEN bs_fg*zf_fg=1 THEN DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, kjmo, vs_id ORDER BY vkl_mo ASC NULLS LAST) END AS VKLMO_RANG
, CASE WHEN zf_fg*stl_fg=1 THEN DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, gj, vs_id ORDER BY vkl_gj ASC NULLS LAST) END AS VKLGJ_RANG
, CASE WHEN bs_fg*neo_fg=1 THEN fil_mo END AS FILMO_WERT
, CASE WHEN neo_fg*stl_fg=1 THEN fil_gj END AS FILGJ_WERT
, CASE WHEN bs_fg*zf_fg=1 THEN vkl_mo END AS VKLMO_WERT
, CASE WHEN zf_fg*stl_fg=1 THEN vkl_gj END AS VKLGJ_WERT  
FROM ( /* VTR520 Warten Theke */
	SELECT sub.mandant_id, sub.nb_id, sub.wup_id, sub.wrg_id, sub.vs_id, sub.vkl_id, sub.gj, sub.kjmo
	, sub1.w_theke_ist AS ist_fil
	, sub2.w_theke_kvj AS kvj_fil
	/* Referenz Region_2/Land_2 */
	, SUM(sub1.w_theke_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vs_id) AS ist_reg
	, SUM(sub2.w_theke_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vs_id) AS kvj_reg
	, SUM(sub1.w_theke_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo) AS ist_land
	, SUM(sub2.w_theke_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo) AS kvj_land
	/* Rang : neo_fg = Filialen mind. 1 GJ offen, ohne Schließungmonat, ohne Ausschluss-Liste */
	, CASE WHEN sub.stl_dat > sub.max_dat 
		AND sub.gj > (EXTRACT(YEAR FROM sub.neo_dat)+CASE WHEN EXTRACT(MONTH FROM sub.neo_dat)<3 THEN -1 ELSE 0 END)+1 
		AND sub.nb_id=0 
		AND NOT ( /* Ausschluss Getränkemärkte, Zeltverkauf etc 2024-04-08 */
			(sub.mandant_id=1 AND sub.wup_id IN (1263,1273,2583,3166,6623,7220,8120,8563,8940,5876)) /* DE */ 
			OR (sub.mandant_id=7 AND sub.wup_id IN (1110,1410,6210,6310,6410)) /* RO */ 
			OR (sub.mandant_id=3 AND sub.wup_id IN (1010)) /* PL */
		) THEN 1 ELSE 0 END AS neo_fg
	/* Rang GJ : stl_fg = Filialen ohne Schließungen */
	, CASE WHEN sub.stl_dat BETWEEN TO_DATE(TO_CHAR(sub.gj)||'-03-01','YYYY-MM_2-DD') 
	  AND ADD_MONTHS(TO_DATE(TO_CHAR(sub.gj)||'-03-01','YYYY-MM_2-DD'),12)-1 
	  THEN 0 ELSE 1 END AS stl_fg 
	/* Rang VKL_2 : zf_fg = filialen ohne dummy_2 vkl_2 */
	, CASE WHEN sub.nb_id=0 AND sub.vkl_id>0 THEN 1 ELSE 0 END AS zf_fg
	/* Rang BS : bs_fg = Nur Monate vor Buchungsschluss, wichtig am Monatsanfang*/
	, CASE WHEN sub.akt_bs <= 0 THEN 1 ELSE 0 END AS bs_fg
	/* Setup Rang : filiale monat_2 */
	, (neo_fg*sub1.w_theke_ist)  AS ist_fil_mo
	, (neo_fg*sub2.w_theke_kvj)  AS kvj_fil_mo
	/* Setup Rang : filiale gj */
	, SUM(bs_fg*neo_fg*stl_fg*sub1.w_theke_ist)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.wup_id) AS ist_fil_gj
	, SUM(bs_fg*neo_fg*stl_fg*sub2.w_theke_kvj)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.wup_id) AS kvj_fil_gj
	/* Setup Rang : vkl_2 monat_2 */
	, SUM(neo_fg*zf_fg*sub1.w_theke_ist)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vkl_id) AS ist_vkl_mo
	, SUM(neo_fg*zf_fg*sub2.w_theke_kvj)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vkl_id) AS kvj_vkl_mo
	/* Setup Rang : vkl_2 gj */
	, SUM(bs_fg*neo_fg*zf_fg*stl_fg*sub1.w_theke_ist)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.vkl_id) AS ist_vkl_gj
	, SUM(bs_fg*neo_fg*zf_fg*stl_fg*sub2.w_theke_kvj)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.vkl_id) AS kvj_vkl_gj
	/* Rang aufsteigend = IST (Warten Theke) */
	, NULLIFZERO(neo_fg)        * ZEROIFNULL(ist_fil_mo) AS fil_mo
	, NULLIFZERO(neo_fg*stl_fg) * ZEROIFNULL(ist_fil_gj) AS fil_gj
	, NULLIFZERO(zf_fg)         * ZEROIFNULL(ist_vkl_mo) AS vkl_mo
	, NULLIFZERO(zf_fg*stl_fg)  * ZEROIFNULL(ist_vkl_gj) AS vkl_gj
	FROM monat_fakt_wup sub
	LEFT OUTER JOIN ( /* SUB0051 REKL_IST (aus mv_view) */
		SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id 
		, zeit.kjmo
		, SUM(CASE WHEN reklamationsgrund_id IN(12,19) THEN 1 ELSE 0 END) AS f_preis_ist
		, SUM(CASE WHEN reklamationsgrund_id IN(13,14) THEN 1 ELSE 0 END) AS f_kasse_ist
		, SUM(CASE WHEN reklamationsgrund_id = 91 THEN vk_menge_kuga ELSE 0 END) AS w_theke_ist
		, SUM(CASE WHEN reklamationsgrund_id = 92 THEN vk_menge_kuga ELSE 0 END) AS w_kasse_ist
		, SUM(CASE WHEN reklamationsgrund_id = 93 THEN vk_menge_kuga ELSE 0 END) AS anz_mhd_ist
		FROM DBP_MSI_VIEW_VIS.MV_VIS_TAG_REKL_ART_2 vis
		INNER JOIN dbp_data.tag_2 zeit1
		ON zeit1.dat = vis.dat
		INNER JOIN DBP_DATA.MONAT_2 zeit_2
		ON zeit.kjmo = zeit1.kjmo AND zeit.akt_gj IN (-1, 0) AND zeit.akt_mo < 0
		INNER JOIN dbp_data.wup_2 wup_2 
		ON wup.wup_id = vis.wup_id AND wup.mandant_id = vis.mandant_id 
		/* Standard Filter VTC : Filiale + definierte NB. Datum Eröffnung fix + GJ Schließung dynamisch */
		AND (wup.nb_id=0 OR wup.wup_id IN (0,2,22,28,43,46,124,8980,8987,8991,100000,100002,100022,100028,100043,100046,100124))
		AND wup.dat_eroeffnung<'2090-12-31' 
		AND (EXTRACT(YEAR FROM wup.dat_bis) + CASE WHEN EXTRACT(MONTH FROM wup.dat_bis) < 3 THEN -1 ELSE 0 END) > (zeit.gj + 1) 
		/* Definierte Gründe, ohne Pfand */
		WHERE vis.reklamationsgrund_id IN (12,13,14,19,91,92,93)
		AND (vis.mandant_id, vis.art_id) IN ( 
			SELECT mandant_id, art_id FROM DBP_MSI_VIEW_VIS.MV_ART_WG_ZU_2
			WHERE wg_id NOT IN (980)
		) 
		GROUP BY vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.kjmo 
	) sub1
	ON sub1.mandant_id = sub.mandant_id AND sub1.wup_id = sub.wup_id
	AND sub1.wrg_id = sub.wrg_id AND sub1.kjmo = sub.kjmo
	LEFT OUTER JOIN ( /* SUB0051 REKL_KVJ Transformation (aus mv_view) */
		SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id 
		, zeit.kjmo
		, SUM(CASE WHEN reklamationsgrund_id IN(12,19) THEN 1 ELSE 0 END) AS f_preis_kvj
		, SUM(CASE WHEN reklamationsgrund_id IN(13,14) THEN 1 ELSE 0 END) AS f_kasse_kvj
		, SUM(CASE WHEN reklamationsgrund_id = 91 THEN vk_menge_kuga ELSE 0 END) AS w_theke_kvj
		, SUM(CASE WHEN reklamationsgrund_id = 92 THEN vk_menge_kuga ELSE 0 END) AS w_kasse_kvj
		, SUM(CASE WHEN reklamationsgrund_id = 93 THEN vk_menge_kuga ELSE 0 END) AS anz_mhd_kvj
		FROM DBP_MSI_VIEW_VIS.MV_VIS_TAG_REKL_ART_2 vis
		INNER JOIN dbp_data.tag_2 zeit1
		ON zeit1.dat = vis.dat
		/* Transformation KVJ */
		INNER JOIN DBP_DATA.MONAT_2 zeit_2
		ON zeit.kjmo = zeit1.kjmo+100 AND zeit.akt_gj IN (-1, 0) AND zeit.akt_mo < 0
		INNER JOIN dbp_data.wup_2 wup_2 
		ON wup.wup_id = vis.wup_id AND wup.mandant_id = vis.mandant_id 
		/* Standard Filter VTC : Filiale + definierte NB. Datum Eröffnung fix + GJ Schließung dynamisch */
		AND (wup.nb_id=0 OR wup.wup_id IN (0,2,22,28,43,46,124,8980,8987,8991,100000,100002,100022,100028,100043,100046,100124))
		AND wup.dat_eroeffnung<'2090-12-31' 
		AND (EXTRACT(YEAR FROM wup.dat_bis) + CASE WHEN EXTRACT(MONTH FROM wup.dat_bis) < 3 THEN -1 ELSE 0 END) > (zeit.gj + 1) 
		/* Definierte Gründe, ohne Pfand */
		WHERE vis.reklamationsgrund_id IN (12,13,14,19,91,92,93)
		AND (vis.mandant_id, vis.art_id) IN ( 
			SELECT mandant_id, art_id FROM DBP_MSI_VIEW_VIS.MV_ART_WG_ZU_2
			WHERE wg_id NOT IN (980)
		) 
		GROUP BY vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.kjmo 
	) sub2
	ON sub2.mandant_id = sub.mandant_id AND sub2.wup_id = sub.wup_id
	AND sub2.wrg_id = sub.wrg_id AND sub2.kjmo = sub.kjmo
) vtr 
 
UNION ALL SELECT mandant_id, nb_id, vs_id, vkl_id, wup_id, wrg_id, gj, kjmo
, 525::INTEGER  AS VTR_ID /* 515 Warten Theke pro 10T Kunden */ 
, ist_fil  AS FILIST,  ist_fil2 AS FILIST2 
, kvj_fil  AS FILKVJ,  kvj_fil2 AS FILKVJ2 
, NULL     AS FILPLAN, NULL AS FILPLAN2 /* kein plan */
, ist_reg  AS REGIST,  ist_reg2 AS REGIST2 
, kvj_reg  AS REGKVJ,  kvj_reg2 AS REGKVJ2 
, ist_land AS LANDIST, ist_land2 AS LANDIST2 
, kvj_land AS LANDKVJ, kvj_land2 AS LANDKVJ2 
/* Rang aufsteigend = IST Quote (Warten Theke pro 10T Kunden) */
, CASE WHEN neo_fg=1 THEN DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, kjmo, vs_id ORDER BY fil_mo ASC NULLS LAST) END AS FILMO_RANG
, CASE WHEN neo_fg*stl_fg=1 THEN DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, gj, vs_id ORDER BY fil_gj ASC NULLS LAST) END AS FILGJ_RANG
, CASE WHEN zf_fg=1 THEN DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, kjmo, vs_id ORDER BY vkl_mo ASC NULLS LAST) END AS VKLMO_RANG
, CASE WHEN zf_fg*stl_fg=1 THEN DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, gj, vs_id ORDER BY vkl_gj ASC NULLS LAST) END AS VKLGJ_RANG
, CASE WHEN neo_fg=1 THEN fil_mo END AS FILMO_WERT
, CASE WHEN neo_fg*stl_fg=1 THEN fil_gj END AS FILGJ_WERT
, CASE WHEN zf_fg=1 THEN vkl_mo END AS VKLMO_WERT
, CASE WHEN zf_fg*stl_fg=1 THEN vkl_gj END AS VKLGJ_WERT  
FROM ( /* VTR515 Warten Theke pro 10T Kunden */
	SELECT sub.mandant_id, sub.nb_id, sub.wup_id, sub.wrg_id, sub.vs_id, sub.vkl_id, sub.gj, sub.kjmo
	, sub.knd_10t_ist AS ist_fil2
	, sub.knd_10t_kvj AS kvj_fil2
	, sub1.w_theke_ist AS ist_fil
	, sub2.w_theke_kvj AS kvj_fil
	/* Referenz Region_2/Land_2 */
	, SUM(sub.knd_10t_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vs_id) AS ist_reg2
	, SUM(sub.knd_10t_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vs_id) AS kvj_reg2
	, SUM(sub1.w_theke_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vs_id) AS ist_reg
	, SUM(sub2.w_theke_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vs_id) AS kvj_reg
	, SUM(sub.knd_10t_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo) AS ist_land2
	, SUM(sub.knd_10t_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo) AS kvj_land2
	, SUM(sub1.w_theke_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo) AS ist_land
	, SUM(sub2.w_theke_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo) AS kvj_land
	/* Rang : neo_fg = Filialen mind. 1 GJ offen, ohne Schließungmonat, ohne Ausschluss-Liste */
	, CASE WHEN sub.stl_dat > sub.max_dat 
		AND sub.gj > (EXTRACT(YEAR FROM sub.neo_dat)+CASE WHEN EXTRACT(MONTH FROM sub.neo_dat)<3 THEN -1 ELSE 0 END)+1 
		AND sub.nb_id=0 
		AND NOT ( /* Ausschluss Getränkemärkte, Zeltverkauf etc 2024-04-08 */
			(sub.mandant_id=1 AND sub.wup_id IN (1263,1273,2583,3166,6623,7220,8120,8563,8940,5876)) /* DE */ 
			OR (sub.mandant_id=7 AND sub.wup_id IN (1110,1410,6210,6310,6410)) /* RO */ 
			OR (sub.mandant_id=3 AND sub.wup_id IN (1010)) /* PL */
		) THEN 1 ELSE 0 END AS neo_fg
	/* Rang GJ : stl_fg = Filialen ohne Schließungen */
	, CASE WHEN sub.stl_dat BETWEEN TO_DATE(TO_CHAR(sub.gj)||'-03-01','YYYY-MM_2-DD') 
	  AND ADD_MONTHS(TO_DATE(TO_CHAR(sub.gj)||'-03-01','YYYY-MM_2-DD'),12)-1 
	  THEN 0 ELSE 1 END AS stl_fg 
	/* Rang VKL_2 : zf_fg = filialen ohne dummy_2 vkl_2 */
	, CASE WHEN sub.nb_id=0 AND sub.vkl_id>0 THEN 1 ELSE 0 END AS zf_fg
	/* Setup Rang : filiale monat_2 */
	, (neo_fg*sub.knd_10t_ist) AS ist_fil_mo2
	, (neo_fg*sub.knd_10t_kvj) AS kvj_fil_mo2
	, (neo_fg*sub1.w_theke_ist) AS ist_fil_mo
	, (neo_fg*sub2.w_theke_kvj) AS kvj_fil_mo
	/* Setup Rang : filiale gj */
	, SUM(neo_fg*stl_fg*sub.knd_10t_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.wup_id) AS ist_fil_gj2
	, SUM(neo_fg*stl_fg*sub.knd_10t_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.wup_id) AS kvj_fil_gj2
	, SUM(neo_fg*stl_fg*sub1.w_theke_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.wup_id) AS ist_fil_gj
	, SUM(neo_fg*stl_fg*sub2.w_theke_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.wup_id) AS kvj_fil_gj
	/* Setup Rang : vkl_2 monat_2 */
	, SUM(neo_fg*zf_fg*sub.knd_10t_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vkl_id) AS ist_vkl_mo2
	, SUM(neo_fg*zf_fg*sub.knd_10t_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vkl_id) AS kvj_vkl_mo2
	, SUM(neo_fg*zf_fg*sub1.w_theke_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vkl_id) AS ist_vkl_mo
	, SUM(neo_fg*zf_fg*sub2.w_theke_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vkl_id) AS kvj_vkl_mo
	/* Setup Rang : vkl_2 gj */
	, SUM(neo_fg*zf_fg*stl_fg*sub.knd_10t_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.vkl_id) AS ist_vkl_gj2
	, SUM(neo_fg*zf_fg*stl_fg*sub.knd_10t_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.vkl_id) AS kvj_vkl_gj2
	, SUM(neo_fg*zf_fg*stl_fg*sub1.w_theke_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.vkl_id) AS ist_vkl_gj
	, SUM(neo_fg*zf_fg*stl_fg*sub2.w_theke_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.vkl_id) AS kvj_vkl_gj
	/* Rang aufsteigend = IST Quote (Warten Theke pro 10T Kunden) */
	, NULLIFZERO(neo_fg)        * (ist_fil_mo/NULLIFZERO(ist_fil_mo2)) AS fil_mo
	, NULLIFZERO(neo_fg*stl_fg) * (ist_fil_gj/NULLIFZERO(ist_fil_gj2)) AS fil_gj
	, NULLIFZERO(zf_fg)         * (ist_vkl_mo/NULLIFZERO(ist_vkl_mo2)) AS vkl_mo
	, NULLIFZERO(zf_fg*stl_fg)  * (ist_vkl_gj/NULLIFZERO(ist_vkl_gj2)) AS vkl_gj
	FROM monat_fakt_wup sub
	LEFT OUTER JOIN ( /* SUB051 REKL_IST (aus mv_view) */
		SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id 
		, zeit.kjmo
		, SUM(CASE WHEN reklamationsgrund_id IN(12,19) THEN 1 ELSE 0 END) AS f_preis_ist
		, SUM(CASE WHEN reklamationsgrund_id IN(13,14) THEN 1 ELSE 0 END) AS f_kasse_ist
		, SUM(CASE WHEN reklamationsgrund_id = 91 THEN vk_menge_kuga ELSE 0 END) AS w_theke_ist
		, SUM(CASE WHEN reklamationsgrund_id = 92 THEN vk_menge_kuga ELSE 0 END) AS w_kasse_ist
		, SUM(CASE WHEN reklamationsgrund_id = 93 THEN vk_menge_kuga ELSE 0 END) AS anz_mhd_ist
		FROM DBP_MSI_VIEW_VIS.MV_VIS_TAG_REKL_ART_2 vis
		INNER JOIN dbp_data.tag_2 zeit1
		ON zeit1.dat = vis.dat
		INNER JOIN DBP_DATA.MONAT_2 zeit_2
		ON zeit.kjmo = zeit1.kjmo AND zeit.akt_gj IN (-1, 0) AND zeit.akt_mo < 0
		INNER JOIN dbp_data.wup_2 wup_2 
		ON wup.wup_id = vis.wup_id AND wup.mandant_id = vis.mandant_id 
		/* Standard Filter VTC : Filiale + definierte NB. Datum Eröffnung fix + GJ Schließung dynamisch */
		AND (wup.nb_id=0 OR wup.wup_id IN (0,2,22,28,43,46,124,8980,8987,8991,100000,100002,100022,100028,100043,100046,100124))
		AND wup.dat_eroeffnung<'2090-12-31' 
		AND (EXTRACT(YEAR FROM wup.dat_bis) + CASE WHEN EXTRACT(MONTH FROM wup.dat_bis) < 3 THEN -1 ELSE 0 END) > (zeit.gj + 1) 
		/* Definierte Gründe, ohne Pfand */
		WHERE vis.reklamationsgrund_id IN (12,13,14,19,91,92,93)
		AND (vis.mandant_id, vis.art_id) IN ( 
			SELECT mandant_id, art_id FROM DBP_MSI_VIEW_VIS.MV_ART_WG_ZU_2
			WHERE wg_id NOT IN (980)
		) 
		GROUP BY vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.kjmo 
	) sub1
	ON sub1.mandant_id = sub.mandant_id AND sub1.wup_id = sub.wup_id
	AND sub1.wrg_id = sub.wrg_id AND sub1.kjmo = sub.kjmo
	LEFT OUTER JOIN ( /* SUB052 REKL_KVJ Transformation (aus mv_view) */
		SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id 
		, zeit.kjmo
		, SUM(CASE WHEN reklamationsgrund_id IN(12,19) THEN 1 ELSE 0 END) AS f_preis_kvj
		, SUM(CASE WHEN reklamationsgrund_id IN(13,14) THEN 1 ELSE 0 END) AS f_kasse_kvj
		, SUM(CASE WHEN reklamationsgrund_id = 91 THEN vk_menge_kuga ELSE 0 END) AS w_theke_kvj
		, SUM(CASE WHEN reklamationsgrund_id = 92 THEN vk_menge_kuga ELSE 0 END) AS w_kasse_kvj
		, SUM(CASE WHEN reklamationsgrund_id = 93 THEN vk_menge_kuga ELSE 0 END) AS anz_mhd_kvj
		FROM DBP_MSI_VIEW_VIS.MV_VIS_TAG_REKL_ART_2 vis
		INNER JOIN dbp_data.tag_2 zeit1
		ON zeit1.dat = vis.dat
		/* Transformation KVJ */
		INNER JOIN DBP_DATA.MONAT_2 zeit_2
		ON zeit.kjmo = zeit1.kjmo+100 AND zeit.akt_gj IN (-1, 0) AND zeit.akt_mo < 0
		INNER JOIN dbp_data.wup_2 wup_2 
		ON wup.wup_id = vis.wup_id AND wup.mandant_id = vis.mandant_id 
		/* Standard Filter VTC : Filiale + definierte NB. Datum Eröffnung fix + GJ Schließung dynamisch */
		AND (wup.nb_id=0 OR wup.wup_id IN (0,2,22,28,43,46,124,8980,8987,8991,100000,100002,100022,100028,100043,100046,100124))
		AND wup.dat_eroeffnung<'2090-12-31' 
		AND (EXTRACT(YEAR FROM wup.dat_bis) + CASE WHEN EXTRACT(MONTH FROM wup.dat_bis) < 3 THEN -1 ELSE 0 END) > (zeit.gj + 1) 
		/* Definierte Gründe, ohne Pfand */
		WHERE vis.reklamationsgrund_id IN (12,13,14,19,91,92,93)
		AND (vis.mandant_id, vis.art_id) IN ( 
			SELECT mandant_id, art_id FROM DBP_MSI_VIEW_VIS.MV_ART_WG_ZU_2
			WHERE wg_id NOT IN (980)
		) 
		GROUP BY vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.kjmo 
	) sub2
	ON sub2.mandant_id = sub.mandant_id AND sub2.wup_id = sub.wup_id
	AND sub2.wrg_id = sub.wrg_id AND sub2.kjmo = sub.kjmo
) vtr  
 
UNION ALL SELECT mandant_id, nb_id, vs_id, vkl_id, wup_id, wrg_id, gj, kjmo
, 530::INTEGER  AS VTR_ID /* 530 Mangel MHD */ 
, ist_fil  AS FILIST,  NULL AS FILIST2 
, kvj_fil  AS FILKVJ,  NULL AS FILKVJ2 
, NULL     AS FILPLAN, NULL AS FILPLAN2 /* kein plan */
, ist_reg  AS REGIST,  NULL AS REGIST2 
, kvj_reg  AS REGKVJ,  NULL AS REGKVJ2 
, ist_land AS LANDIST, NULL AS LANDIST2 
, kvj_land AS LANDKVJ, NULL AS LANDKVJ2 
/* Rang aufsteigend = IST (Mangel MHD) */
, CASE WHEN neo_fg=1 THEN DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, kjmo, vs_id ORDER BY fil_mo ASC NULLS LAST) END AS FILMO_RANG
, CASE WHEN neo_fg*stl_fg=1 THEN DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, gj, vs_id ORDER BY fil_gj ASC NULLS LAST) END AS FILGJ_RANG
, CASE WHEN zf_fg=1 THEN DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, kjmo, vs_id ORDER BY vkl_mo ASC NULLS LAST) END AS VKLMO_RANG
, CASE WHEN zf_fg*stl_fg=1 THEN DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, gj, vs_id ORDER BY vkl_gj ASC NULLS LAST) END AS VKLGJ_RANG
, CASE WHEN neo_fg=1 THEN fil_mo END AS FILMO_WERT
, CASE WHEN neo_fg*stl_fg=1 THEN fil_gj END AS FILGJ_WERT
, CASE WHEN zf_fg=1 THEN vkl_mo END AS VKLMO_WERT
, CASE WHEN zf_fg*stl_fg=1 THEN vkl_gj END AS VKLGJ_WERT  
FROM ( /* VTR530 Mangel MHD */
	SELECT sub.mandant_id, sub.nb_id, sub.wup_id, sub.wrg_id, sub.vs_id, sub.vkl_id, sub.gj, sub.kjmo
	, sub1.anz_mhd_ist AS ist_fil
	, sub2.anz_mhd_kvj AS kvj_fil
	/* Referenz Region_2/Land_2 */
	, SUM(sub1.anz_mhd_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vs_id) AS ist_reg
	, SUM(sub2.anz_mhd_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vs_id) AS kvj_reg
	, SUM(sub1.anz_mhd_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo) AS ist_land
	, SUM(sub2.anz_mhd_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo) AS kvj_land
	/* Rang : neo_fg = Filialen mind. 1 GJ offen, ohne Schließungmonat, ohne Ausschluss-Liste */
	, CASE WHEN sub.stl_dat > sub.max_dat 
		AND sub.gj > (EXTRACT(YEAR FROM sub.neo_dat)+CASE WHEN EXTRACT(MONTH FROM sub.neo_dat)<3 THEN -1 ELSE 0 END)+1 
		AND sub.nb_id=0 
		AND NOT ( /* Ausschluss Getränkemärkte, Zeltverkauf etc 2024-04-08 */
			(sub.mandant_id=1 AND sub.wup_id IN (1263,1273,2583,3166,6623,7220,8120,8563,8940,5876)) /* DE */ 
			OR (sub.mandant_id=7 AND sub.wup_id IN (1110,1410,6210,6310,6410)) /* RO */ 
			OR (sub.mandant_id=3 AND sub.wup_id IN (1010)) /* PL */
		) THEN 1 ELSE 0 END AS neo_fg
	/* Rang GJ : stl_fg = Filialen ohne Schließungen */
	, CASE WHEN sub.stl_dat BETWEEN TO_DATE(TO_CHAR(sub.gj)||'-03-01','YYYY-MM_2-DD') 
	  AND ADD_MONTHS(TO_DATE(TO_CHAR(sub.gj)||'-03-01','YYYY-MM_2-DD'),12)-1 
	  THEN 0 ELSE 1 END AS stl_fg 
	/* Rang VKL_2 : zf_fg = filialen ohne dummy_2 vkl_2 */
	, CASE WHEN sub.nb_id=0 AND sub.vkl_id>0 THEN 1 ELSE 0 END AS zf_fg
	/* Setup Rang : filiale monat_2 */
	, (neo_fg*sub1.anz_mhd_ist)  AS ist_fil_mo
	, (neo_fg*sub2.anz_mhd_kvj)  AS kvj_fil_mo
	/* Setup Rang : filiale gj */
	, SUM(neo_fg*stl_fg*sub1.anz_mhd_ist)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.wup_id) AS ist_fil_gj
	, SUM(neo_fg*stl_fg*sub2.anz_mhd_kvj)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.wup_id) AS kvj_fil_gj
	/* Setup Rang : vkl_2 monat_2 */
	, SUM(neo_fg*zf_fg*sub1.anz_mhd_ist)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vkl_id) AS ist_vkl_mo
	, SUM(neo_fg*zf_fg*sub2.anz_mhd_kvj)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vkl_id) AS kvj_vkl_mo
	/* Setup Rang : vkl_2 gj */
	, SUM(neo_fg*zf_fg*stl_fg*sub1.anz_mhd_ist)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.vkl_id) AS ist_vkl_gj
	, SUM(neo_fg*zf_fg*stl_fg*sub2.anz_mhd_kvj)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.vkl_id) AS kvj_vkl_gj
	/* Rang aufsteigend = IST (Mangel MHD) */
	, NULLIFZERO(neo_fg)        * ZEROIFNULL(ist_fil_mo) AS fil_mo
	, NULLIFZERO(neo_fg*stl_fg) * ZEROIFNULL(ist_fil_gj) AS fil_gj
	, NULLIFZERO(zf_fg)         * ZEROIFNULL(ist_vkl_mo) AS vkl_mo
	, NULLIFZERO(zf_fg*stl_fg)  * ZEROIFNULL(ist_vkl_gj) AS vkl_gj
	FROM monat_fakt_wup sub
	LEFT OUTER JOIN ( /* SUB0051 REKL_IST (aus mv_view) */
		SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id
		, zeit.kjmo
		, SUM(CASE WHEN reklamationsgrund_id IN(12,19) THEN 1 ELSE 0 END) AS f_preis_ist
		, SUM(CASE WHEN reklamationsgrund_id IN(13,14) THEN 1 ELSE 0 END) AS f_kasse_ist
		, SUM(CASE WHEN reklamationsgrund_id = 91 THEN vk_menge_kuga ELSE 0 END) AS w_theke_ist
		, SUM(CASE WHEN reklamationsgrund_id = 92 THEN vk_menge_kuga ELSE 0 END) AS w_kasse_ist
		, SUM(CASE WHEN reklamationsgrund_id = 93 THEN vk_menge_kuga ELSE 0 END) AS anz_mhd_ist
		FROM DBP_MSI_VIEW_VIS.MV_VIS_TAG_REKL_ART_2 vis
		INNER JOIN dbp_data.tag_2 zeit1
		ON zeit1.dat = vis.dat
		INNER JOIN DBP_DATA.MONAT_2 zeit_2
		ON zeit.kjmo = zeit1.kjmo AND zeit.akt_gj IN (-1, 0) AND zeit.akt_mo < 0
		INNER JOIN dbp_data.wup_2 wup_2 
		ON wup.wup_id = vis.wup_id AND wup.mandant_id = vis.mandant_id 
		/* Standard Filter VTC : Filiale + definierte NB. Datum Eröffnung fix + GJ Schließung dynamisch */
		AND (wup.nb_id=0 OR wup.wup_id IN (0,2,22,28,43,46,124,8980,8987,8991,100000,100002,100022,100028,100043,100046,100124))
		AND wup.dat_eroeffnung<'2090-12-31' 
		AND (EXTRACT(YEAR FROM wup.dat_bis) + CASE WHEN EXTRACT(MONTH FROM wup.dat_bis) < 3 THEN -1 ELSE 0 END) > (zeit.gj + 1) 
		/* Definierte Gründe, ohne Pfand */
		WHERE vis.reklamationsgrund_id IN (12,13,14,19,91,92,93)
		AND (vis.mandant_id, vis.art_id) IN ( 
			SELECT mandant_id, art_id FROM DBP_MSI_VIEW_VIS.MV_ART_WG_ZU_2
			WHERE wg_id NOT IN (980)
		) 
		GROUP BY vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.kjmo
	) sub1
	ON sub1.mandant_id = sub.mandant_id AND sub1.wup_id = sub.wup_id
	AND sub1.wrg_id = sub.wrg_id AND sub1.kjmo = sub.kjmo
	LEFT OUTER JOIN ( /* SUB0051 REKL_KVJ Transformation (aus mv_view) */
		SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id
		, zeit.kjmo
		, SUM(CASE WHEN reklamationsgrund_id IN(12,19) THEN 1 ELSE 0 END) AS f_preis_kvj
		, SUM(CASE WHEN reklamationsgrund_id IN(13,14) THEN 1 ELSE 0 END) AS f_kasse_kvj
		, SUM(CASE WHEN reklamationsgrund_id = 91 THEN vk_menge_kuga ELSE 0 END) AS w_theke_kvj
		, SUM(CASE WHEN reklamationsgrund_id = 92 THEN vk_menge_kuga ELSE 0 END) AS w_kasse_kvj
		, SUM(CASE WHEN reklamationsgrund_id = 93 THEN vk_menge_kuga ELSE 0 END) AS anz_mhd_kvj
		FROM DBP_MSI_VIEW_VIS.MV_VIS_TAG_REKL_ART_2 vis
		INNER JOIN dbp_data.tag_2 zeit1
		ON zeit1.dat = vis.dat
		/* Transformation KVJ */
		INNER JOIN DBP_DATA.MONAT_2 zeit_2
		ON zeit.kjmo = zeit1.kjmo+100 AND zeit.akt_gj IN (-1, 0) AND zeit.akt_mo < 0
		INNER JOIN dbp_data.wup_2 wup_2 
		ON wup.wup_id = vis.wup_id AND wup.mandant_id = vis.mandant_id 
		/* Standard Filter VTC : Filiale + definierte NB. Datum Eröffnung fix + GJ Schließung dynamisch */
		AND (wup.nb_id=0 OR wup.wup_id IN (0,2,22,28,43,46,124,8980,8987,8991,100000,100002,100022,100028,100043,100046,100124))
		AND wup.dat_eroeffnung<'2090-12-31' 
		AND (EXTRACT(YEAR FROM wup.dat_bis) + CASE WHEN EXTRACT(MONTH FROM wup.dat_bis) < 3 THEN -1 ELSE 0 END) > (zeit.gj + 1) 
		/* Definierte Gründe, ohne Pfand */
		WHERE vis.reklamationsgrund_id IN (12,13,14,19,91,92,93)
		AND (vis.mandant_id, vis.art_id) IN ( 
			SELECT mandant_id, art_id FROM DBP_MSI_VIEW_VIS.MV_ART_WG_ZU_2
			WHERE wg_id NOT IN (980)
		) 
		GROUP BY vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.kjmo
	) sub2
	ON sub2.mandant_id = sub.mandant_id AND sub2.wup_id = sub.wup_id
	AND sub2.wrg_id = sub.wrg_id AND sub2.kjmo = sub.kjmo
) vtr 
 
UNION ALL SELECT mandant_id, nb_id, vs_id, vkl_id, wup_id, wrg_id, gj, kjmo
, 535::INTEGER  AS VTR_ID /* 535 Mangel MHD pro 10T Kunden */ 
, ist_fil  AS FILIST,  ist_fil2 AS FILIST2 
, kvj_fil  AS FILKVJ,  kvj_fil2 AS FILKVJ2 
, NULL     AS FILPLAN, NULL AS FILPLAN2 /* kein plan */
, ist_reg  AS REGIST,  ist_reg2 AS REGIST2 
, kvj_reg  AS REGKVJ,  kvj_reg2 AS REGKVJ2 
, ist_land AS LANDIST, ist_land2 AS LANDIST2 
, kvj_land AS LANDKVJ, kvj_land2 AS LANDKVJ2 
/* Rang aufsteigend = IST Quote (Mangel MHD pro 10T Kunden) */
, CASE WHEN neo_fg=1 THEN DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, kjmo, vs_id ORDER BY fil_mo ASC NULLS LAST) END AS FILMO_RANG
, CASE WHEN neo_fg*stl_fg=1 THEN DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, gj, vs_id ORDER BY fil_gj ASC NULLS LAST) END AS FILGJ_RANG
, CASE WHEN zf_fg=1 THEN DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, kjmo, vs_id ORDER BY vkl_mo ASC NULLS LAST) END AS VKLMO_RANG
, CASE WHEN zf_fg*stl_fg=1 THEN DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, gj, vs_id ORDER BY vkl_gj ASC NULLS LAST) END AS VKLGJ_RANG
, CASE WHEN neo_fg=1 THEN fil_mo END AS FILMO_WERT
, CASE WHEN neo_fg*stl_fg=1 THEN fil_gj END AS FILGJ_WERT
, CASE WHEN zf_fg=1 THEN vkl_mo END AS VKLMO_WERT
, CASE WHEN zf_fg*stl_fg=1 THEN vkl_gj END AS VKLGJ_WERT  
FROM ( /* VTR535 Mangel MHD pro 10T Kunden */
	SELECT sub.mandant_id, sub.nb_id, sub.wup_id, sub.wrg_id, sub.vs_id, sub.vkl_id, sub.gj, sub.kjmo
	, sub.knd_10t_ist AS ist_fil2
	, sub.knd_10t_kvj AS kvj_fil2
	, sub1.anz_mhd_ist AS ist_fil
	, sub2.anz_mhd_kvj AS kvj_fil
	/* Referenz Region_2/Land_2 */
	, SUM(sub.knd_10t_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vs_id) AS ist_reg2
	, SUM(sub.knd_10t_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vs_id) AS kvj_reg2
	, SUM(sub1.anz_mhd_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vs_id) AS ist_reg
	, SUM(sub2.anz_mhd_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vs_id) AS kvj_reg
	, SUM(sub.knd_10t_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo) AS ist_land2
	, SUM(sub.knd_10t_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo) AS kvj_land2
	, SUM(sub1.anz_mhd_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo) AS ist_land
	, SUM(sub2.anz_mhd_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo) AS kvj_land
	/* Rang : neo_fg = Filialen mind. 1 GJ offen, ohne Schließungmonat, ohne Ausschluss-Liste */
	, CASE WHEN sub.stl_dat > sub.max_dat 
		AND sub.gj > (EXTRACT(YEAR FROM sub.neo_dat)+CASE WHEN EXTRACT(MONTH FROM sub.neo_dat)<3 THEN -1 ELSE 0 END)+1 
		AND sub.nb_id=0 
		AND NOT ( /* Ausschluss Getränkemärkte, Zeltverkauf etc 2024-04-08 */
			(sub.mandant_id=1 AND sub.wup_id IN (1263,1273,2583,3166,6623,7220,8120,8563,8940,5876)) /* DE */ 
			OR (sub.mandant_id=7 AND sub.wup_id IN (1110,1410,6210,6310,6410)) /* RO */ 
			OR (sub.mandant_id=3 AND sub.wup_id IN (1010)) /* PL */
		) THEN 1 ELSE 0 END AS neo_fg
	/* Rang GJ : stl_fg = Filialen ohne Schließungen */
	, CASE WHEN sub.stl_dat BETWEEN TO_DATE(TO_CHAR(sub.gj)||'-03-01','YYYY-MM_2-DD') 
	  AND ADD_MONTHS(TO_DATE(TO_CHAR(sub.gj)||'-03-01','YYYY-MM_2-DD'),12)-1 
	  THEN 0 ELSE 1 END AS stl_fg 
	/* Rang VKL_2 : zf_fg = filialen ohne dummy_2 vkl_2 */
	, CASE WHEN sub.nb_id=0 AND sub.vkl_id>0 THEN 1 ELSE 0 END AS zf_fg
	/* Setup Rang : filiale monat_2 */
	, (neo_fg*sub.knd_10t_ist) AS ist_fil_mo2
	, (neo_fg*sub.knd_10t_kvj) AS kvj_fil_mo2
	, (neo_fg*sub1.anz_mhd_ist) AS ist_fil_mo
	, (neo_fg*sub2.anz_mhd_kvj) AS kvj_fil_mo
	/* Setup Rang : filiale gj */
	, SUM(neo_fg*stl_fg*sub.knd_10t_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.wup_id) AS ist_fil_gj2
	, SUM(neo_fg*stl_fg*sub.knd_10t_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.wup_id) AS kvj_fil_gj2
	, SUM(neo_fg*stl_fg*sub1.anz_mhd_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.wup_id) AS ist_fil_gj
	, SUM(neo_fg*stl_fg*sub2.anz_mhd_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.wup_id) AS kvj_fil_gj
	/* Setup Rang : vkl_2 monat_2 */
	, SUM(neo_fg*zf_fg*sub.knd_10t_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vkl_id) AS ist_vkl_mo2
	, SUM(neo_fg*zf_fg*sub.knd_10t_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vkl_id) AS kvj_vkl_mo2
	, SUM(neo_fg*zf_fg*sub1.anz_mhd_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vkl_id) AS ist_vkl_mo
	, SUM(neo_fg*zf_fg*sub2.anz_mhd_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vkl_id) AS kvj_vkl_mo
	/* Setup Rang : vkl_2 gj */
	, SUM(neo_fg*zf_fg*stl_fg*sub.knd_10t_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.vkl_id) AS ist_vkl_gj2
	, SUM(neo_fg*zf_fg*stl_fg*sub.knd_10t_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.vkl_id) AS kvj_vkl_gj2
	, SUM(neo_fg*zf_fg*stl_fg*sub1.anz_mhd_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.vkl_id) AS ist_vkl_gj
	, SUM(neo_fg*zf_fg*stl_fg*sub2.anz_mhd_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.vkl_id) AS kvj_vkl_gj
	/* Rang aufsteigend = IST Quote (Mangel MHD pro 10T Kunden) */
	, NULLIFZERO(neo_fg)        * (ist_fil_mo/NULLIFZERO(ist_fil_mo2)) AS fil_mo
	, NULLIFZERO(neo_fg*stl_fg) * (ist_fil_gj/NULLIFZERO(ist_fil_gj2)) AS fil_gj
	, NULLIFZERO(zf_fg)         * (ist_vkl_mo/NULLIFZERO(ist_vkl_mo2)) AS vkl_mo
	, NULLIFZERO(zf_fg*stl_fg)  * (ist_vkl_gj/NULLIFZERO(ist_vkl_gj2)) AS vkl_gj
	FROM monat_fakt_wup sub
	LEFT OUTER JOIN ( /* SUB051 REKL_IST (aus mv_view) */
		SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id
		, zeit.kjmo
		, SUM(CASE WHEN reklamationsgrund_id IN(12,19) THEN 1 ELSE 0 END) AS f_preis_ist
		, SUM(CASE WHEN reklamationsgrund_id IN(13,14) THEN 1 ELSE 0 END) AS f_kasse_ist
		, SUM(CASE WHEN reklamationsgrund_id = 91 THEN vk_menge_kuga ELSE 0 END) AS w_theke_ist
		, SUM(CASE WHEN reklamationsgrund_id = 92 THEN vk_menge_kuga ELSE 0 END) AS w_kasse_ist
		, SUM(CASE WHEN reklamationsgrund_id = 93 THEN vk_menge_kuga ELSE 0 END) AS anz_mhd_ist
		FROM DBP_MSI_VIEW_VIS.MV_VIS_TAG_REKL_ART_2 vis
		INNER JOIN dbp_data.tag_2 zeit1
		ON zeit1.dat = vis.dat
		INNER JOIN DBP_DATA.MONAT_2 zeit_2
		ON zeit.kjmo = zeit1.kjmo AND zeit.akt_gj IN (-1, 0) AND zeit.akt_mo < 0
		INNER JOIN dbp_data.wup_2 wup_2 
		ON wup.wup_id = vis.wup_id AND wup.mandant_id = vis.mandant_id 
		/* Standard Filter VTC : Filiale + definierte NB. Datum Eröffnung fix + GJ Schließung dynamisch */
		AND (wup.nb_id=0 OR wup.wup_id IN (0,2,22,28,43,46,124,8980,8987,8991,100000,100002,100022,100028,100043,100046,100124))
		AND wup.dat_eroeffnung<'2090-12-31' 
		AND (EXTRACT(YEAR FROM wup.dat_bis) + CASE WHEN EXTRACT(MONTH FROM wup.dat_bis) < 3 THEN -1 ELSE 0 END) > (zeit.gj + 1) 
		/* Definierte Gründe, ohne Pfand */
		WHERE vis.reklamationsgrund_id IN (12,13,14,19,91,92,93)
		AND (vis.mandant_id, vis.art_id) IN ( 
			SELECT mandant_id, art_id FROM DBP_MSI_VIEW_VIS.MV_ART_WG_ZU_2
			WHERE wg_id NOT IN (980)
		) 
		GROUP BY vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.kjmo
	) sub1
	ON sub1.mandant_id = sub.mandant_id AND sub1.wup_id = sub.wup_id
	AND sub1.wrg_id = sub.wrg_id AND sub1.kjmo = sub.kjmo
	LEFT OUTER JOIN ( /* SUB052 REKL_KVJ Transformation (aus mv_view) */
		SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id
		, zeit.kjmo
		, SUM(CASE WHEN reklamationsgrund_id IN(12,19) THEN 1 ELSE 0 END) AS f_preis_kvj
		, SUM(CASE WHEN reklamationsgrund_id IN(13,14) THEN 1 ELSE 0 END) AS f_kasse_kvj
		, SUM(CASE WHEN reklamationsgrund_id = 91 THEN vk_menge_kuga ELSE 0 END) AS w_theke_kvj
		, SUM(CASE WHEN reklamationsgrund_id = 92 THEN vk_menge_kuga ELSE 0 END) AS w_kasse_kvj
		, SUM(CASE WHEN reklamationsgrund_id = 93 THEN vk_menge_kuga ELSE 0 END) AS anz_mhd_kvj
		FROM DBP_MSI_VIEW_VIS.MV_VIS_TAG_REKL_ART_2 vis
		INNER JOIN dbp_data.tag_2 zeit1
		ON zeit1.dat = vis.dat
		/* Transformation KVJ */
		INNER JOIN DBP_DATA.MONAT_2 zeit_2
		ON zeit.kjmo = zeit1.kjmo+100 AND zeit.akt_gj IN (-1, 0) AND zeit.akt_mo < 0
		INNER JOIN dbp_data.wup_2 wup_2 
		ON wup.wup_id = vis.wup_id AND wup.mandant_id = vis.mandant_id 
		/* Standard Filter VTC : Filiale + definierte NB. Datum Eröffnung fix + GJ Schließung dynamisch */
		AND (wup.nb_id=0 OR wup.wup_id IN (0,2,22,28,43,46,124,8980,8987,8991,100000,100002,100022,100028,100043,100046,100124))
		AND wup.dat_eroeffnung<'2090-12-31' 
		AND (EXTRACT(YEAR FROM wup.dat_bis) + CASE WHEN EXTRACT(MONTH FROM wup.dat_bis) < 3 THEN -1 ELSE 0 END) > (zeit.gj + 1) 
		/* Definierte Gründe, ohne Pfand */
		WHERE vis.reklamationsgrund_id IN (12,13,14,19,91,92,93)
		AND (vis.mandant_id, vis.art_id) IN ( 
			SELECT mandant_id, art_id FROM DBP_MSI_VIEW_VIS.MV_ART_WG_ZU_2
			WHERE wg_id NOT IN (980)
		) 
		GROUP BY vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.kjmo
	) sub2
	ON sub2.mandant_id = sub.mandant_id AND sub2.wup_id = sub.wup_id
	AND sub2.wrg_id = sub.wrg_id AND sub2.kjmo = sub.kjmo
) vtr 
 
UNION ALL SELECT mandant_id, nb_id, vs_id, vkl_id, wup_id, wrg_id, gj, kjmo
, 540::INTEGER  AS VTR_ID /* 540 Preisfehler */ 
, ist_fil  AS FILIST,  NULL AS FILIST2 
, kvj_fil  AS FILKVJ,  NULL AS FILKVJ2 
, NULL     AS FILPLAN, NULL AS FILPLAN2 /* kein plan */
, ist_reg  AS REGIST,  NULL AS REGIST2 
, kvj_reg  AS REGKVJ,  NULL AS REGKVJ2 
, ist_land AS LANDIST, NULL AS LANDIST2 
, kvj_land AS LANDKVJ, NULL AS LANDKVJ2 
/* Rang aufsteigend = IST (Preisfehler) */
, CASE WHEN neo_fg=1 THEN DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, kjmo, vs_id ORDER BY fil_mo ASC NULLS LAST) END AS FILMO_RANG
, CASE WHEN neo_fg*stl_fg=1 THEN DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, gj, vs_id ORDER BY fil_gj ASC NULLS LAST) END AS FILGJ_RANG
, CASE WHEN zf_fg=1 THEN DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, kjmo, vs_id ORDER BY vkl_mo ASC NULLS LAST) END AS VKLMO_RANG
, CASE WHEN zf_fg*stl_fg=1 THEN DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, gj, vs_id ORDER BY vkl_gj ASC NULLS LAST) END AS VKLGJ_RANG
, CASE WHEN neo_fg=1 THEN fil_mo END AS FILMO_WERT
, CASE WHEN neo_fg*stl_fg=1 THEN fil_gj END AS FILGJ_WERT
, CASE WHEN zf_fg=1 THEN vkl_mo END AS VKLMO_WERT
, CASE WHEN zf_fg*stl_fg=1 THEN vkl_gj END AS VKLGJ_WERT  
FROM ( /* VTR540 Preisfehler */
	SELECT sub.mandant_id, sub.nb_id, sub.wup_id, sub.wrg_id, sub.vs_id, sub.vkl_id, sub.gj, sub.kjmo
	, sub1.f_preis_ist AS ist_fil
	, sub2.f_preis_kvj AS kvj_fil
	/* Referenz Region_2/Land_2 */
	, SUM(sub1.f_preis_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vs_id) AS ist_reg
	, SUM(sub2.f_preis_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vs_id) AS kvj_reg
	, SUM(sub1.f_preis_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo) AS ist_land
	, SUM(sub2.f_preis_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo) AS kvj_land
	/* Rang : neo_fg = Filialen mind. 1 GJ offen, ohne Schließungmonat, ohne Ausschluss-Liste */
	, CASE WHEN sub.stl_dat > sub.max_dat 
		AND sub.gj > (EXTRACT(YEAR FROM sub.neo_dat)+CASE WHEN EXTRACT(MONTH FROM sub.neo_dat)<3 THEN -1 ELSE 0 END)+1 
		AND sub.nb_id=0 
		AND NOT ( /* Ausschluss Getränkemärkte, Zeltverkauf etc 2024-04-08 */
			(sub.mandant_id=1 AND sub.wup_id IN (1263,1273,2583,3166,6623,7220,8120,8563,8940,5876)) /* DE */ 
			OR (sub.mandant_id=7 AND sub.wup_id IN (1110,1410,6210,6310,6410)) /* RO */ 
			OR (sub.mandant_id=3 AND sub.wup_id IN (1010)) /* PL */
		) THEN 1 ELSE 0 END AS neo_fg
	/* Rang GJ : stl_fg = Filialen ohne Schließungen */
	, CASE WHEN sub.stl_dat BETWEEN TO_DATE(TO_CHAR(sub.gj)||'-03-01','YYYY-MM_2-DD') 
	  AND ADD_MONTHS(TO_DATE(TO_CHAR(sub.gj)||'-03-01','YYYY-MM_2-DD'),12)-1 
	  THEN 0 ELSE 1 END AS stl_fg 
	/* Rang VKL_2 : zf_fg = filialen ohne dummy_2 vkl_2 */
	, CASE WHEN sub.nb_id=0 AND sub.vkl_id>0 THEN 1 ELSE 0 END AS zf_fg
	/* Setup Rang : filiale monat_2 */
	, (neo_fg*sub1.f_preis_ist)  AS ist_fil_mo
	, (neo_fg*sub2.f_preis_kvj)  AS kvj_fil_mo
	/* Setup Rang : filiale gj */
	, SUM(neo_fg*stl_fg*sub1.f_preis_ist)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.wup_id) AS ist_fil_gj
	, SUM(neo_fg*stl_fg*sub2.f_preis_kvj)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.wup_id) AS kvj_fil_gj
	/* Setup Rang : vkl_2 monat_2 */
	, SUM(neo_fg*zf_fg*sub1.f_preis_ist)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vkl_id) AS ist_vkl_mo
	, SUM(neo_fg*zf_fg*sub2.f_preis_kvj)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vkl_id) AS kvj_vkl_mo
	/* Setup Rang : vkl_2 gj */
	, SUM(neo_fg*zf_fg*stl_fg*sub1.f_preis_ist)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.vkl_id) AS ist_vkl_gj
	, SUM(neo_fg*zf_fg*stl_fg*sub2.f_preis_kvj)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.vkl_id) AS kvj_vkl_gj
	/* Rang aufsteigend = IST (Preisfehler) */
	, NULLIFZERO(neo_fg)        * ZEROIFNULL(ist_fil_mo) AS fil_mo
	, NULLIFZERO(neo_fg*stl_fg) * ZEROIFNULL(ist_fil_gj) AS fil_gj
	, NULLIFZERO(zf_fg)         * ZEROIFNULL(ist_vkl_mo) AS vkl_mo
	, NULLIFZERO(zf_fg*stl_fg)  * ZEROIFNULL(ist_vkl_gj) AS vkl_gj
	FROM monat_fakt_wup sub
	LEFT OUTER JOIN ( /* SUB0051 REKL_IST (aus mv_view) */
		SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id
		, zeit.kjmo
		, SUM(CASE WHEN reklamationsgrund_id IN(12,19) THEN 1 ELSE 0 END) AS f_preis_ist
		, SUM(CASE WHEN reklamationsgrund_id IN(13,14) THEN 1 ELSE 0 END) AS f_kasse_ist
		, SUM(CASE WHEN reklamationsgrund_id = 91 THEN vk_menge_kuga ELSE 0 END) AS w_theke_ist
		, SUM(CASE WHEN reklamationsgrund_id = 92 THEN vk_menge_kuga ELSE 0 END) AS w_kasse_ist
		, SUM(CASE WHEN reklamationsgrund_id = 93 THEN vk_menge_kuga ELSE 0 END) AS anz_mhd_ist
		FROM DBP_MSI_VIEW_VIS.MV_VIS_TAG_REKL_ART_2 vis
		INNER JOIN dbp_data.tag_2 zeit1
		ON zeit1.dat = vis.dat
		INNER JOIN DBP_DATA.MONAT_2 zeit_2
		ON zeit.kjmo = zeit1.kjmo AND zeit.akt_gj IN (-1, 0) AND zeit.akt_mo < 0
		INNER JOIN dbp_data.wup_2 wup_2 
		ON wup.wup_id = vis.wup_id AND wup.mandant_id = vis.mandant_id 
		/* Standard Filter VTC : Filiale + definierte NB. Datum Eröffnung fix + GJ Schließung dynamisch */
		AND (wup.nb_id=0 OR wup.wup_id IN (0,2,22,28,43,46,124,8980,8987,8991,100000,100002,100022,100028,100043,100046,100124))
		AND wup.dat_eroeffnung<'2090-12-31' 
		AND (EXTRACT(YEAR FROM wup.dat_bis) + CASE WHEN EXTRACT(MONTH FROM wup.dat_bis) < 3 THEN -1 ELSE 0 END) > (zeit.gj + 1) 
		/* Definierte Gründe, ohne Pfand */
		WHERE vis.reklamationsgrund_id IN (12,13,14,19,91,92,93)
		AND (vis.mandant_id, vis.art_id) IN ( 
			SELECT mandant_id, art_id FROM DBP_MSI_VIEW_VIS.MV_ART_WG_ZU_2
			WHERE wg_id NOT IN (980)
		) 
		GROUP BY vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.kjmo
	) sub1
	ON sub1.mandant_id = sub.mandant_id AND sub1.wup_id = sub.wup_id
	AND sub1.wrg_id = sub.wrg_id AND sub1.kjmo = sub.kjmo
	LEFT OUTER JOIN ( /* SUB0051 REKL_KVJ Transformation (aus mv_view) */
		SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id 
		, zeit.kjmo
		, SUM(CASE WHEN reklamationsgrund_id IN(12,19) THEN 1 ELSE 0 END) AS f_preis_kvj
		, SUM(CASE WHEN reklamationsgrund_id IN(13,14) THEN 1 ELSE 0 END) AS f_kasse_kvj
		, SUM(CASE WHEN reklamationsgrund_id = 91 THEN vk_menge_kuga ELSE 0 END) AS w_theke_kvj
		, SUM(CASE WHEN reklamationsgrund_id = 92 THEN vk_menge_kuga ELSE 0 END) AS w_kasse_kvj
		, SUM(CASE WHEN reklamationsgrund_id = 93 THEN vk_menge_kuga ELSE 0 END) AS anz_mhd_kvj
		FROM DBP_MSI_VIEW_VIS.MV_VIS_TAG_REKL_ART_2 vis
		INNER JOIN dbp_data.tag_2 zeit1
		ON zeit1.dat = vis.dat
		/* Transformation KVJ */
		INNER JOIN DBP_DATA.MONAT_2 zeit_2
		ON zeit.kjmo = zeit1.kjmo+100 AND zeit.akt_gj IN (-1, 0) AND zeit.akt_mo < 0
		INNER JOIN dbp_data.wup_2 wup_2 
		ON wup.wup_id = vis.wup_id AND wup.mandant_id = vis.mandant_id 
		/* Standard Filter VTC : Filiale + definierte NB. Datum Eröffnung fix + GJ Schließung dynamisch */
		AND (wup.nb_id=0 OR wup.wup_id IN (0,2,22,28,43,46,124,8980,8987,8991,100000,100002,100022,100028,100043,100046,100124))
		AND wup.dat_eroeffnung<'2090-12-31' 
		AND (EXTRACT(YEAR FROM wup.dat_bis) + CASE WHEN EXTRACT(MONTH FROM wup.dat_bis) < 3 THEN -1 ELSE 0 END) > (zeit.gj + 1) 
		/* Definierte Gründe, ohne Pfand */
		WHERE vis.reklamationsgrund_id IN (12,13,14,19,91,92,93)
		AND (vis.mandant_id, vis.art_id) IN ( 
			SELECT mandant_id, art_id FROM DBP_MSI_VIEW_VIS.MV_ART_WG_ZU_2
			WHERE wg_id NOT IN (980)
		) 
		GROUP BY vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.kjmo 
	) sub2
	ON sub2.mandant_id = sub.mandant_id AND sub2.wup_id = sub.wup_id
	AND sub2.wrg_id = sub.wrg_id AND sub2.kjmo = sub.kjmo
) vtr 
 
UNION ALL SELECT mandant_id, nb_id, vs_id, vkl_id, wup_id, wrg_id, gj, kjmo
, 545::INTEGER  AS VTR_ID /* 545 Preisfehler pro 10T Kunden */ 
, ist_fil  AS FILIST,  ist_fil2 AS FILIST2 
, kvj_fil  AS FILKVJ,  kvj_fil2 AS FILKVJ2 
, NULL     AS FILPLAN, NULL AS FILPLAN2 /* kein plan */
, ist_reg  AS REGIST,  ist_reg2 AS REGIST2 
, kvj_reg  AS REGKVJ,  kvj_reg2 AS REGKVJ2 
, ist_land AS LANDIST, ist_land2 AS LANDIST2 
, kvj_land AS LANDKVJ, kvj_land2 AS LANDKVJ2 
/* Rang aufsteigend = IST Quote (Preisfehler pro 10T Kunden) */
, CASE WHEN neo_fg=1 THEN DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, kjmo, vs_id ORDER BY fil_mo ASC NULLS LAST) END AS FILMO_RANG
, CASE WHEN neo_fg*stl_fg=1 THEN DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, gj, vs_id ORDER BY fil_gj ASC NULLS LAST) END AS FILGJ_RANG
, CASE WHEN zf_fg=1 THEN DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, kjmo, vs_id ORDER BY vkl_mo ASC NULLS LAST) END AS VKLMO_RANG
, CASE WHEN zf_fg*stl_fg=1 THEN DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, gj, vs_id ORDER BY vkl_gj ASC NULLS LAST) END AS VKLGJ_RANG
, CASE WHEN neo_fg=1 THEN fil_mo END AS FILMO_WERT
, CASE WHEN neo_fg*stl_fg=1 THEN fil_gj END AS FILGJ_WERT
, CASE WHEN zf_fg=1 THEN vkl_mo END AS VKLMO_WERT
, CASE WHEN zf_fg*stl_fg=1 THEN vkl_gj END AS VKLGJ_WERT  
FROM ( /* VTR545 Preisfehler pro 10T Kunden */
	SELECT sub.mandant_id, sub.nb_id, sub.wup_id, sub.wrg_id, sub.vs_id, sub.vkl_id, sub.gj, sub.kjmo
	, sub.knd_10t_ist AS ist_fil2
	, sub.knd_10t_kvj AS kvj_fil2
	, sub1.f_preis_ist AS ist_fil
	, sub2.f_preis_kvj AS kvj_fil
	/* Referenz Region_2/Land_2 */
	, SUM(sub.knd_10t_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vs_id) AS ist_reg2
	, SUM(sub.knd_10t_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vs_id) AS kvj_reg2
	, SUM(sub1.f_preis_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vs_id) AS ist_reg
	, SUM(sub2.f_preis_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vs_id) AS kvj_reg
	, SUM(sub.knd_10t_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo) AS ist_land2
	, SUM(sub.knd_10t_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo) AS kvj_land2
	, SUM(sub1.f_preis_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo) AS ist_land
	, SUM(sub2.f_preis_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo) AS kvj_land
	/* Rang : neo_fg = Filialen mind. 1 GJ offen, ohne Schließungmonat, ohne Ausschluss-Liste */
	, CASE WHEN sub.stl_dat > sub.max_dat 
		AND sub.gj > (EXTRACT(YEAR FROM sub.neo_dat)+CASE WHEN EXTRACT(MONTH FROM sub.neo_dat)<3 THEN -1 ELSE 0 END)+1 
		AND sub.nb_id=0 
		AND NOT ( /* Ausschluss Getränkemärkte, Zeltverkauf etc 2024-04-08 */
			(sub.mandant_id=1 AND sub.wup_id IN (1263,1273,2583,3166,6623,7220,8120,8563,8940,5876)) /* DE */ 
			OR (sub.mandant_id=7 AND sub.wup_id IN (1110,1410,6210,6310,6410)) /* RO */ 
			OR (sub.mandant_id=3 AND sub.wup_id IN (1010)) /* PL */
		) THEN 1 ELSE 0 END AS neo_fg
	/* Rang GJ : stl_fg = Filialen ohne Schließungen */
	, CASE WHEN sub.stl_dat BETWEEN TO_DATE(TO_CHAR(sub.gj)||'-03-01','YYYY-MM_2-DD') 
	  AND ADD_MONTHS(TO_DATE(TO_CHAR(sub.gj)||'-03-01','YYYY-MM_2-DD'),12)-1 
	  THEN 0 ELSE 1 END AS stl_fg 
	/* Rang VKL_2 : zf_fg = filialen ohne dummy_2 vkl_2 */
	, CASE WHEN sub.nb_id=0 AND sub.vkl_id>0 THEN 1 ELSE 0 END AS zf_fg
	/* Setup Rang : filiale monat_2 */
	, (neo_fg*sub.knd_10t_ist) AS ist_fil_mo2
	, (neo_fg*sub.knd_10t_kvj) AS kvj_fil_mo2
	, (neo_fg*sub1.f_preis_ist) AS ist_fil_mo
	, (neo_fg*sub2.f_preis_kvj) AS kvj_fil_mo
	/* Setup Rang : filiale gj */
	, SUM(neo_fg*stl_fg*sub.knd_10t_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.wup_id) AS ist_fil_gj2
	, SUM(neo_fg*stl_fg*sub.knd_10t_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.wup_id) AS kvj_fil_gj2
	, SUM(neo_fg*stl_fg*sub1.f_preis_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.wup_id) AS ist_fil_gj
	, SUM(neo_fg*stl_fg*sub2.f_preis_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.wup_id) AS kvj_fil_gj
	/* Setup Rang : vkl_2 monat_2 */
	, SUM(neo_fg*zf_fg*sub.knd_10t_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vkl_id) AS ist_vkl_mo2
	, SUM(neo_fg*zf_fg*sub.knd_10t_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vkl_id) AS kvj_vkl_mo2
	, SUM(neo_fg*zf_fg*sub1.f_preis_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vkl_id) AS ist_vkl_mo
	, SUM(neo_fg*zf_fg*sub2.f_preis_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vkl_id) AS kvj_vkl_mo
	/* Setup Rang : vkl_2 gj */
	, SUM(neo_fg*zf_fg*stl_fg*sub.knd_10t_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.vkl_id) AS ist_vkl_gj2
	, SUM(neo_fg*zf_fg*stl_fg*sub.knd_10t_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.vkl_id) AS kvj_vkl_gj2
	, SUM(neo_fg*zf_fg*stl_fg*sub1.f_preis_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.vkl_id) AS ist_vkl_gj
	, SUM(neo_fg*zf_fg*stl_fg*sub2.f_preis_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.vkl_id) AS kvj_vkl_gj
	/* Rang aufsteigend = IST Quote (Preisfehler pro 10T Kunden) */
	, NULLIFZERO(neo_fg)        * (ist_fil_mo/NULLIFZERO(ist_fil_mo2)) AS fil_mo
	, NULLIFZERO(neo_fg*stl_fg) * (ist_fil_gj/NULLIFZERO(ist_fil_gj2)) AS fil_gj
	, NULLIFZERO(zf_fg)         * (ist_vkl_mo/NULLIFZERO(ist_vkl_mo2)) AS vkl_mo
	, NULLIFZERO(zf_fg*stl_fg)  * (ist_vkl_gj/NULLIFZERO(ist_vkl_gj2)) AS vkl_gj
	FROM monat_fakt_wup sub
	LEFT OUTER JOIN ( /* SUB051 REKL_IST (aus mv_view) */
		SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id 
		, zeit.kjmo
		, SUM(CASE WHEN reklamationsgrund_id IN(12,19) THEN 1 ELSE 0 END) AS f_preis_ist
		, SUM(CASE WHEN reklamationsgrund_id IN(13,14) THEN 1 ELSE 0 END) AS f_kasse_ist
		, SUM(CASE WHEN reklamationsgrund_id = 91 THEN vk_menge_kuga ELSE 0 END) AS w_theke_ist
		, SUM(CASE WHEN reklamationsgrund_id = 92 THEN vk_menge_kuga ELSE 0 END) AS w_kasse_ist
		, SUM(CASE WHEN reklamationsgrund_id = 93 THEN vk_menge_kuga ELSE 0 END) AS anz_mhd_ist
		FROM DBP_MSI_VIEW_VIS.MV_VIS_TAG_REKL_ART_2 vis
		INNER JOIN dbp_data.tag_2 zeit1
		ON zeit1.dat = vis.dat
		INNER JOIN DBP_DATA.MONAT_2 zeit_2
		ON zeit.kjmo = zeit1.kjmo AND zeit.akt_gj IN (-1, 0) AND zeit.akt_mo < 0
		INNER JOIN dbp_data.wup_2 wup_2 
		ON wup.wup_id = vis.wup_id AND wup.mandant_id = vis.mandant_id 
		/* Standard Filter VTC : Filiale + definierte NB. Datum Eröffnung fix + GJ Schließung dynamisch */
		AND (wup.nb_id=0 OR wup.wup_id IN (0,2,22,28,43,46,124,8980,8987,8991,100000,100002,100022,100028,100043,100046,100124))
		AND wup.dat_eroeffnung<'2090-12-31' 
		AND (EXTRACT(YEAR FROM wup.dat_bis) + CASE WHEN EXTRACT(MONTH FROM wup.dat_bis) < 3 THEN -1 ELSE 0 END) > (zeit.gj + 1) 
		/* Definierte Gründe, ohne Pfand */
		WHERE vis.reklamationsgrund_id IN (12,13,14,19,91,92,93)
		AND (vis.mandant_id, vis.art_id) IN ( 
			SELECT mandant_id, art_id FROM DBP_MSI_VIEW_VIS.MV_ART_WG_ZU_2
			WHERE wg_id NOT IN (980)
		) 
		GROUP BY vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.kjmo 
	) sub1
	ON sub1.mandant_id = sub.mandant_id AND sub1.wup_id = sub.wup_id
	AND sub1.wrg_id = sub.wrg_id AND sub1.kjmo = sub.kjmo
	LEFT OUTER JOIN ( /* SUB052 REKL_KVJ Transformation (aus mv_view) */
		SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id 
		, zeit.kjmo
		, SUM(CASE WHEN reklamationsgrund_id IN(12,19) THEN 1 ELSE 0 END) AS f_preis_kvj
		, SUM(CASE WHEN reklamationsgrund_id IN(13,14) THEN 1 ELSE 0 END) AS f_kasse_kvj
		, SUM(CASE WHEN reklamationsgrund_id = 91 THEN vk_menge_kuga ELSE 0 END) AS w_theke_kvj
		, SUM(CASE WHEN reklamationsgrund_id = 92 THEN vk_menge_kuga ELSE 0 END) AS w_kasse_kvj
		, SUM(CASE WHEN reklamationsgrund_id = 93 THEN vk_menge_kuga ELSE 0 END) AS anz_mhd_kvj
		FROM DBP_MSI_VIEW_VIS.MV_VIS_TAG_REKL_ART_2 vis
		INNER JOIN dbp_data.tag_2 zeit1
		ON zeit1.dat = vis.dat
		/* Transformation KVJ */
		INNER JOIN DBP_DATA.MONAT_2 zeit_2
		ON zeit.kjmo = zeit1.kjmo+100 AND zeit.akt_gj IN (-1, 0) AND zeit.akt_mo < 0
		INNER JOIN dbp_data.wup_2 wup_2 
		ON wup.wup_id = vis.wup_id AND wup.mandant_id = vis.mandant_id 
		/* Standard Filter VTC : Filiale + definierte NB. Datum Eröffnung fix + GJ Schließung dynamisch */
		AND (wup.nb_id=0 OR wup.wup_id IN (0,2,22,28,43,46,124,8980,8987,8991,100000,100002,100022,100028,100043,100046,100124))
		AND wup.dat_eroeffnung<'2090-12-31' 
		AND (EXTRACT(YEAR FROM wup.dat_bis) + CASE WHEN EXTRACT(MONTH FROM wup.dat_bis) < 3 THEN -1 ELSE 0 END) > (zeit.gj + 1) 
		/* Definierte Gründe, ohne Pfand */
		WHERE vis.reklamationsgrund_id IN (12,13,14,19,91,92,93)
		AND (vis.mandant_id, vis.art_id) IN ( 
			SELECT mandant_id, art_id FROM DBP_MSI_VIEW_VIS.MV_ART_WG_ZU_2
			WHERE wg_id NOT IN (980)
		) 
		GROUP BY vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.kjmo 
	) sub2
	ON sub2.mandant_id = sub.mandant_id AND sub2.wup_id = sub.wup_id
	AND sub2.wrg_id = sub.wrg_id AND sub2.kjmo = sub.kjmo
) vtr 
 
UNION ALL SELECT mandant_id, nb_id, vs_id, vkl_id, wup_id, wrg_id, gj, kjmo
, 550::INTEGER  AS VTR_ID /* 550 Kassierfehler inkl. BS */ 
, ist_fil  AS FILIST,  NULL AS FILIST2 
, kvj_fil  AS FILKVJ,  NULL AS FILKVJ2 
, NULL     AS FILPLAN, NULL AS FILPLAN2 /* kein plan */
, ist_reg  AS REGIST,  NULL AS REGIST2 
, kvj_reg  AS REGKVJ,  NULL AS REGKVJ2 
, ist_land AS LANDIST, NULL AS LANDIST2 
, kvj_land AS LANDKVJ, NULL AS LANDKVJ2 
/* Rang aufsteigend = IST (Kassierfehler) */
, CASE WHEN bs_fg*neo_fg=1 THEN DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, kjmo, vs_id ORDER BY fil_mo ASC NULLS LAST) END AS FILMO_RANG
, CASE WHEN neo_fg*stl_fg=1 THEN DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, gj, vs_id ORDER BY fil_gj ASC NULLS LAST) END AS FILGJ_RANG
, CASE WHEN bs_fg*zf_fg=1 THEN DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, kjmo, vs_id ORDER BY vkl_mo ASC NULLS LAST) END AS VKLMO_RANG
, CASE WHEN zf_fg*stl_fg=1 THEN DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, gj, vs_id ORDER BY vkl_gj ASC NULLS LAST) END AS VKLGJ_RANG
, CASE WHEN bs_fg*neo_fg=1 THEN fil_mo END AS FILMO_WERT
, CASE WHEN neo_fg*stl_fg=1 THEN fil_gj END AS FILGJ_WERT
, CASE WHEN bs_fg*zf_fg=1 THEN vkl_mo END AS VKLMO_WERT
, CASE WHEN zf_fg*stl_fg=1 THEN vkl_gj END AS VKLGJ_WERT  
FROM ( /* VTR550 Kassierfehler */
	SELECT sub.mandant_id, sub.nb_id, sub.wup_id, sub.wrg_id, sub.vs_id, sub.vkl_id, sub.gj, sub.kjmo
	, sub1.f_kasse_ist AS ist_fil
	, sub2.f_kasse_kvj AS kvj_fil
	/* Referenz Region_2/Land_2 */
	, SUM(sub1.f_kasse_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vs_id) AS ist_reg
	, SUM(sub2.f_kasse_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vs_id) AS kvj_reg
	, SUM(sub1.f_kasse_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo) AS ist_land
	, SUM(sub2.f_kasse_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo) AS kvj_land
	/* Rang : neo_fg = Filialen mind. 1 GJ offen, ohne Schließungmonat, ohne Ausschluss-Liste */
	, CASE WHEN sub.stl_dat > sub.max_dat 
		AND sub.gj > (EXTRACT(YEAR FROM sub.neo_dat)+CASE WHEN EXTRACT(MONTH FROM sub.neo_dat)<3 THEN -1 ELSE 0 END)+1 
		AND sub.nb_id=0 
		AND NOT ( /* Ausschluss Getränkemärkte, Zeltverkauf etc 2024-04-08 */
			(sub.mandant_id=1 AND sub.wup_id IN (1263,1273,2583,3166,6623,7220,8120,8563,8940,5876)) /* DE */ 
			OR (sub.mandant_id=7 AND sub.wup_id IN (1110,1410,6210,6310,6410)) /* RO */ 
			OR (sub.mandant_id=3 AND sub.wup_id IN (1010)) /* PL */
		) THEN 1 ELSE 0 END AS neo_fg
	/* Rang GJ : stl_fg = Filialen ohne Schließungen */
	, CASE WHEN sub.stl_dat BETWEEN TO_DATE(TO_CHAR(sub.gj)||'-03-01','YYYY-MM_2-DD') 
	  AND ADD_MONTHS(TO_DATE(TO_CHAR(sub.gj)||'-03-01','YYYY-MM_2-DD'),12)-1 
	  THEN 0 ELSE 1 END AS stl_fg 
	/* Rang VKL_2 : zf_fg = filialen ohne dummy_2 vkl_2 */
	, CASE WHEN sub.nb_id=0 AND sub.vkl_id>0 THEN 1 ELSE 0 END AS zf_fg
	/* Rang BS : bs_fg = Nur Monate vor Buchungsschluss, wichtig am Monatsanfang*/
	, CASE WHEN sub.akt_bs <= 0 THEN 1 ELSE 0 END AS bs_fg
	/* Setup Rang : filiale monat_2 */
	, (neo_fg*sub1.f_kasse_ist)  AS ist_fil_mo
	, (neo_fg*sub2.f_kasse_kvj)  AS kvj_fil_mo
	/* Setup Rang : filiale gj */
	, SUM(bs_fg*neo_fg*stl_fg*sub1.f_kasse_ist)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.wup_id) AS ist_fil_gj
	, SUM(bs_fg*neo_fg*stl_fg*sub2.f_kasse_kvj)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.wup_id) AS kvj_fil_gj
	/* Setup Rang : vkl_2 monat_2 */
	, SUM(neo_fg*zf_fg*sub1.f_kasse_ist)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vkl_id) AS ist_vkl_mo
	, SUM(neo_fg*zf_fg*sub2.f_kasse_kvj)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vkl_id) AS kvj_vkl_mo
	/* Setup Rang : vkl_2 gj */
	, SUM(bs_fg*neo_fg*zf_fg*stl_fg*sub1.f_kasse_ist)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.vkl_id) AS ist_vkl_gj
	, SUM(bs_fg*neo_fg*zf_fg*stl_fg*sub2.f_kasse_kvj)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.vkl_id) AS kvj_vkl_gj
	/* Rang aufsteigend = IST (Kassierfehler) */
	, NULLIFZERO(neo_fg)        * ZEROIFNULL(ist_fil_mo) AS fil_mo
	, NULLIFZERO(neo_fg*stl_fg) * ZEROIFNULL(ist_fil_gj) AS fil_gj
	, NULLIFZERO(zf_fg)         * ZEROIFNULL(ist_vkl_mo) AS vkl_mo
	, NULLIFZERO(zf_fg*stl_fg)  * ZEROIFNULL(ist_vkl_gj) AS vkl_gj
	FROM monat_fakt_wup sub
	LEFT OUTER JOIN ( /* SUB0051 REKL_IST (aus mv_view) */
		SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id
		, zeit.kjmo
		, SUM(CASE WHEN reklamationsgrund_id IN(12,19) THEN 1 ELSE 0 END) AS f_preis_ist
		, SUM(CASE WHEN reklamationsgrund_id IN(13,14) THEN 1 ELSE 0 END) AS f_kasse_ist
		, SUM(CASE WHEN reklamationsgrund_id = 91 THEN vk_menge_kuga ELSE 0 END) AS w_theke_ist
		, SUM(CASE WHEN reklamationsgrund_id = 92 THEN vk_menge_kuga ELSE 0 END) AS w_kasse_ist
		, SUM(CASE WHEN reklamationsgrund_id = 93 THEN vk_menge_kuga ELSE 0 END) AS anz_mhd_ist
		FROM DBP_MSI_VIEW_VIS.MV_VIS_TAG_REKL_ART_2 vis
		INNER JOIN dbp_data.tag_2 zeit1
		ON zeit1.dat = vis.dat
		INNER JOIN DBP_DATA.MONAT_2 zeit_2
		ON zeit.kjmo = zeit1.kjmo AND zeit.akt_gj IN (-1, 0) AND zeit.akt_mo < 0
		INNER JOIN dbp_data.wup_2 wup_2 
		ON wup.wup_id = vis.wup_id AND wup.mandant_id = vis.mandant_id 
		/* Standard Filter VTC : Filiale + definierte NB. Datum Eröffnung fix + GJ Schließung dynamisch */
		AND (wup.nb_id=0 OR wup.wup_id IN (0,2,22,28,43,46,124,8980,8987,8991,100000,100002,100022,100028,100043,100046,100124))
		AND wup.dat_eroeffnung<'2090-12-31' 
		AND (EXTRACT(YEAR FROM wup.dat_bis) + CASE WHEN EXTRACT(MONTH FROM wup.dat_bis) < 3 THEN -1 ELSE 0 END) > (zeit.gj + 1) 
		/* Definierte Gründe, ohne Pfand */
		WHERE vis.reklamationsgrund_id IN (12,13,14,19,91,92,93)
		AND (vis.mandant_id, vis.art_id) IN ( 
			SELECT mandant_id, art_id FROM DBP_MSI_VIEW_VIS.MV_ART_WG_ZU_2
			WHERE wg_id NOT IN (980)
		) 
		GROUP BY vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.kjmo
	) sub1
	ON sub1.mandant_id = sub.mandant_id AND sub1.wup_id = sub.wup_id
	AND sub1.wrg_id = sub.wrg_id AND sub1.kjmo = sub.kjmo
	LEFT OUTER JOIN ( /* SUB0051 REKL_KVJ Transformation (aus mv_view) */
		SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id 
		, zeit.kjmo
		, SUM(CASE WHEN reklamationsgrund_id IN(12,19) THEN 1 ELSE 0 END) AS f_preis_kvj
		, SUM(CASE WHEN reklamationsgrund_id IN(13,14) THEN 1 ELSE 0 END) AS f_kasse_kvj
		, SUM(CASE WHEN reklamationsgrund_id = 91 THEN vk_menge_kuga ELSE 0 END) AS w_theke_kvj
		, SUM(CASE WHEN reklamationsgrund_id = 92 THEN vk_menge_kuga ELSE 0 END) AS w_kasse_kvj
		, SUM(CASE WHEN reklamationsgrund_id = 93 THEN vk_menge_kuga ELSE 0 END) AS anz_mhd_kvj
		FROM DBP_MSI_VIEW_VIS.MV_VIS_TAG_REKL_ART_2 vis
		INNER JOIN dbp_data.tag_2 zeit1
		ON zeit1.dat = vis.dat
		/* Transformation KVJ */
		INNER JOIN DBP_DATA.MONAT_2 zeit_2
		ON zeit.kjmo = zeit1.kjmo+100 AND zeit.akt_gj IN (-1, 0) AND zeit.akt_mo < 0
		INNER JOIN dbp_data.wup_2 wup_2 
		ON wup.wup_id = vis.wup_id AND wup.mandant_id = vis.mandant_id 
		/* Standard Filter VTC : Filiale + definierte NB. Datum Eröffnung fix + GJ Schließung dynamisch */
		AND (wup.nb_id=0 OR wup.wup_id IN (0,2,22,28,43,46,124,8980,8987,8991,100000,100002,100022,100028,100043,100046,100124))
		AND wup.dat_eroeffnung<'2090-12-31' 
		AND (EXTRACT(YEAR FROM wup.dat_bis) + CASE WHEN EXTRACT(MONTH FROM wup.dat_bis) < 3 THEN -1 ELSE 0 END) > (zeit.gj + 1) 
		/* Definierte Gründe, ohne Pfand */
		WHERE vis.reklamationsgrund_id IN (12,13,14,19,91,92,93)
		AND (vis.mandant_id, vis.art_id) IN ( 
			SELECT mandant_id, art_id FROM DBP_MSI_VIEW_VIS.MV_ART_WG_ZU_2
			WHERE wg_id NOT IN (980)
		) 
		GROUP BY vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.kjmo 
	) sub2
	ON sub2.mandant_id = sub.mandant_id AND sub2.wup_id = sub.wup_id
	AND sub2.wrg_id = sub.wrg_id AND sub2.kjmo = sub.kjmo
) vtr 
 
UNION ALL SELECT mandant_id, nb_id, vs_id, vkl_id, wup_id, wrg_id, gj, kjmo
, 555::INTEGER  AS VTR_ID /* 555 Kassierfehler pro 100T Scans */ 
, ist_fil  AS FILIST,  ist_fil2 AS FILIST2 
, kvj_fil  AS FILKVJ,  kvj_fil2 AS FILKVJ2 
, NULL     AS FILPLAN, NULL AS FILPLAN2 /* kein plan */
, ist_reg  AS REGIST,  ist_reg2 AS REGIST2 
, kvj_reg  AS REGKVJ,  kvj_reg2 AS REGKVJ2 
, ist_land AS LANDIST, ist_land2 AS LANDIST2 
, kvj_land AS LANDKVJ, kvj_land2 AS LANDKVJ2 
/* Rang aufsteigend = IST Quote (Kassierfehler pro 100T Scans) */
, CASE WHEN neo_fg=1 THEN DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, kjmo, vs_id ORDER BY fil_mo ASC NULLS LAST) END AS FILMO_RANG
, CASE WHEN neo_fg*stl_fg=1 THEN DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, gj, vs_id ORDER BY fil_gj ASC NULLS LAST) END AS FILGJ_RANG
, CASE WHEN zf_fg=1 THEN DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, kjmo, vs_id ORDER BY vkl_mo ASC NULLS LAST) END AS VKLMO_RANG
, CASE WHEN zf_fg*stl_fg=1 THEN DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, gj, vs_id ORDER BY vkl_gj ASC NULLS LAST) END AS VKLGJ_RANG
, CASE WHEN neo_fg=1 THEN fil_mo END AS FILMO_WERT
, CASE WHEN neo_fg*stl_fg=1 THEN fil_gj END AS FILGJ_WERT
, CASE WHEN zf_fg=1 THEN vkl_mo END AS VKLMO_WERT
, CASE WHEN zf_fg*stl_fg=1 THEN vkl_gj END AS VKLGJ_WERT  
FROM ( /* VTR555 Kassierfehler Kassierfehler pro 100T Scans */
	SELECT sub.mandant_id, sub.nb_id, sub.wup_id, sub.wrg_id, sub.vs_id, sub.vkl_id, sub.gj, sub.kjmo
	, sub3.art_100t_ist AS ist_fil2
	, sub4.art_100t_kvj AS kvj_fil2
	, sub1.f_kasse_ist AS ist_fil
	, sub2.f_kasse_kvj AS kvj_fil
	/* Referenz Region_2/Land_2 */
	, SUM(sub3.art_100t_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vs_id) AS ist_reg2
	, SUM(sub4.art_100t_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vs_id) AS kvj_reg2
	, SUM(sub1.f_kasse_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vs_id) AS ist_reg
	, SUM(sub2.f_kasse_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vs_id) AS kvj_reg
	, SUM(sub3.art_100t_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo) AS ist_land2
	, SUM(sub4.art_100t_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo) AS kvj_land2
	, SUM(sub1.f_kasse_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo) AS ist_land
	, SUM(sub2.f_kasse_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo) AS kvj_land
	/* Rang : neo_fg = Filialen mind. 1 GJ offen, ohne Schließungmonat, ohne Ausschluss-Liste */
	, CASE WHEN sub.stl_dat > sub.max_dat 
		AND sub.gj > (EXTRACT(YEAR FROM sub.neo_dat)+CASE WHEN EXTRACT(MONTH FROM sub.neo_dat)<3 THEN -1 ELSE 0 END)+1 
		AND sub.nb_id=0 
		AND NOT ( /* Ausschluss Getränkemärkte, Zeltverkauf etc 2024-04-08 */
			(sub.mandant_id=1 AND sub.wup_id IN (1263,1273,2583,3166,6623,7220,8120,8563,8940,5876)) /* DE */ 
			OR (sub.mandant_id=7 AND sub.wup_id IN (1110,1410,6210,6310,6410)) /* RO */ 
			OR (sub.mandant_id=3 AND sub.wup_id IN (1010)) /* PL */
		) THEN 1 ELSE 0 END AS neo_fg
	/* Rang GJ : stl_fg = Filialen ohne Schließungen */
	, CASE WHEN sub.stl_dat BETWEEN TO_DATE(TO_CHAR(sub.gj)||'-03-01','YYYY-MM_2-DD') 
	  AND ADD_MONTHS(TO_DATE(TO_CHAR(sub.gj)||'-03-01','YYYY-MM_2-DD'),12)-1 
	  THEN 0 ELSE 1 END AS stl_fg 
	/* Rang VKL_2 : zf_fg = filialen ohne dummy_2 vkl_2 */
	, CASE WHEN sub.nb_id=0 AND sub.vkl_id>0 THEN 1 ELSE 0 END AS zf_fg
	/* Setup Rang : filiale monat_2 */
	, (neo_fg*sub1.f_kasse_ist) AS ist_fil_mo
	, (neo_fg*sub2.f_kasse_kvj) AS kvj_fil_mo
	, (neo_fg*sub3.art_100t_ist) AS ist_fil_mo2
	, (neo_fg*sub4.art_100t_kvj) AS kvj_fil_mo2
	/* Setup Rang : filiale gj */
	, SUM(neo_fg*stl_fg*sub1.f_kasse_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.wup_id) AS ist_fil_gj
	, SUM(neo_fg*stl_fg*sub2.f_kasse_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.wup_id) AS kvj_fil_gj
	, SUM(neo_fg*stl_fg*sub3.art_100t_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.wup_id) AS ist_fil_gj2
	, SUM(neo_fg*stl_fg*sub4.art_100t_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.wup_id) AS kvj_fil_gj2
	/* Setup Rang : vkl_2 monat_2 */
	, SUM(neo_fg*zf_fg*sub1.f_kasse_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vkl_id) AS ist_vkl_mo
	, SUM(neo_fg*zf_fg*sub2.f_kasse_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vkl_id) AS kvj_vkl_mo
	, SUM(neo_fg*zf_fg*sub3.art_100t_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vkl_id) AS ist_vkl_mo2
	, SUM(neo_fg*zf_fg*sub4.art_100t_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vkl_id) AS kvj_vkl_mo2
	/* Setup Rang : vkl_2 gj */
	, SUM(neo_fg*zf_fg*stl_fg*sub1.f_kasse_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.vkl_id) AS ist_vkl_gj
	, SUM(neo_fg*zf_fg*stl_fg*sub2.f_kasse_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.vkl_id) AS kvj_vkl_gj
	, SUM(neo_fg*zf_fg*stl_fg*sub3.art_100t_ist) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.vkl_id) AS ist_vkl_gj2
	, SUM(neo_fg*zf_fg*stl_fg*sub4.art_100t_kvj) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.vkl_id) AS kvj_vkl_gj2
	/* Rang aufsteigend = IST Quote (Kassierfehler pro 100T Scans) */
	, NULLIFZERO(neo_fg)        * (ist_fil_mo/NULLIFZERO(ist_fil_mo2)) AS fil_mo
	, NULLIFZERO(neo_fg*stl_fg) * (ist_fil_gj/NULLIFZERO(ist_fil_gj2)) AS fil_gj
	, NULLIFZERO(zf_fg)         * (ist_vkl_mo/NULLIFZERO(ist_vkl_mo2)) AS vkl_mo
	, NULLIFZERO(zf_fg*stl_fg)  * (ist_vkl_gj/NULLIFZERO(ist_vkl_gj2)) AS vkl_gj
	FROM monat_fakt_wup sub
	LEFT OUTER JOIN ( /* SUB051 REKL_IST (aus mv_view) */
		SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id 
		, zeit.kjmo
		, SUM(CASE WHEN reklamationsgrund_id IN(12,19) THEN 1 ELSE 0 END) AS f_preis_ist
		, SUM(CASE WHEN reklamationsgrund_id IN(13,14) THEN 1 ELSE 0 END) AS f_kasse_ist
		, SUM(CASE WHEN reklamationsgrund_id = 91 THEN vk_menge_kuga ELSE 0 END) AS w_theke_ist
		, SUM(CASE WHEN reklamationsgrund_id = 92 THEN vk_menge_kuga ELSE 0 END) AS w_kasse_ist
		, SUM(CASE WHEN reklamationsgrund_id = 93 THEN vk_menge_kuga ELSE 0 END) AS anz_mhd_ist
		FROM DBP_MSI_VIEW_VIS.MV_VIS_TAG_REKL_ART_2 vis
		INNER JOIN dbp_data.tag_2 zeit1
		ON zeit1.dat = vis.dat
		INNER JOIN DBP_DATA.MONAT_2 zeit_2
		ON zeit.kjmo = zeit1.kjmo AND zeit.akt_gj IN (-1, 0) AND zeit.akt_mo < 0
		INNER JOIN dbp_data.wup_2 wup_2 
		ON wup.wup_id = vis.wup_id AND wup.mandant_id = vis.mandant_id 
		/* Standard Filter VTC : Filiale + definierte NB. Datum Eröffnung fix + GJ Schließung dynamisch */
		AND (wup.nb_id=0 OR wup.wup_id IN (0,2,22,28,43,46,124,8980,8987,8991,100000,100002,100022,100028,100043,100046,100124))
		AND wup.dat_eroeffnung<'2090-12-31' 
		AND (EXTRACT(YEAR FROM wup.dat_bis) + CASE WHEN EXTRACT(MONTH FROM wup.dat_bis) < 3 THEN -1 ELSE 0 END) > (zeit.gj + 1) 
		/* Definierte Gründe, ohne Pfand */
		WHERE vis.reklamationsgrund_id IN (12,13,14,19,91,92,93)
		AND (vis.mandant_id, vis.art_id) IN ( 
			SELECT mandant_id, art_id FROM DBP_MSI_VIEW_VIS.MV_ART_WG_ZU_2
			WHERE wg_id NOT IN (980)
		) 
		GROUP BY vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.kjmo 
	) sub1
	ON sub1.mandant_id = sub.mandant_id AND sub1.wup_id = sub.wup_id
	AND sub1.wrg_id = sub.wrg_id AND sub1.kjmo = sub.kjmo
	LEFT OUTER JOIN ( /* SUB052 REKL_KVJ Transformation (aus mv_view) */
		SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id 
		, zeit.kjmo
		, SUM(CASE WHEN reklamationsgrund_id IN(12,19) THEN 1 ELSE 0 END) AS f_preis_kvj
		, SUM(CASE WHEN reklamationsgrund_id IN(13,14) THEN 1 ELSE 0 END) AS f_kasse_kvj
		, SUM(CASE WHEN reklamationsgrund_id = 91 THEN vk_menge_kuga ELSE 0 END) AS w_theke_kvj
		, SUM(CASE WHEN reklamationsgrund_id = 92 THEN vk_menge_kuga ELSE 0 END) AS w_kasse_kvj
		, SUM(CASE WHEN reklamationsgrund_id = 93 THEN vk_menge_kuga ELSE 0 END) AS anz_mhd_kvj
		FROM DBP_MSI_VIEW_VIS.MV_VIS_TAG_REKL_ART_2 vis
		INNER JOIN dbp_data.tag_2 zeit1
		ON zeit1.dat = vis.dat
		/* Transformation KVJ */
		INNER JOIN DBP_DATA.MONAT_2 zeit_2
		ON zeit.kjmo = zeit1.kjmo+100 AND zeit.akt_gj IN (-1, 0) AND zeit.akt_mo < 0
		INNER JOIN dbp_data.wup_2 wup_2 
		ON wup.wup_id = vis.wup_id AND wup.mandant_id = vis.mandant_id 
		/* Standard Filter VTC : Filiale + definierte NB. Datum Eröffnung fix + GJ Schließung dynamisch */
		AND (wup.nb_id=0 OR wup.wup_id IN (0,2,22,28,43,46,124,8980,8987,8991,100000,100002,100022,100028,100043,100046,100124))
		AND wup.dat_eroeffnung<'2090-12-31' 
		AND (EXTRACT(YEAR FROM wup.dat_bis) + CASE WHEN EXTRACT(MONTH FROM wup.dat_bis) < 3 THEN -1 ELSE 0 END) > (zeit.gj + 1) 
		/* Definierte Gründe, ohne Pfand */
		WHERE vis.reklamationsgrund_id IN (12,13,14,19,91,92,93)
		AND (vis.mandant_id, vis.art_id) IN ( 
			SELECT mandant_id, art_id FROM DBP_MSI_VIEW_VIS.MV_ART_WG_ZU_2
			WHERE wg_id NOT IN (980)
		) 
		GROUP BY vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.kjmo 
	) sub2
	ON sub2.mandant_id = sub.mandant_id AND sub2.wup_id = sub.wup_id
	AND sub2.wrg_id = sub.wrg_id AND sub2.kjmo = sub.kjmo
	LEFT OUTER JOIN ( /* SUB021 VIS_TAG_KASSE_IST (aus mv_view) */
		SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id 
		, zeit.kjmo
		, SUM(vis.umsatz_netto) AS ums_kass_ist
		, SUM(vis.anz_kunden) AS knd_kass_ist
		, SUM(CASE WHEN ktp.kasse_typ_id IN (1) THEN vis.umsatz_netto END) AS ums_pos_ist
		, SUM(CASE WHEN ktp.kasse_typ_id IN (1) THEN vis.anz_kunden END) AS knd_pos_ist
		, SUM(CASE WHEN ktp.kasse_typ_id IN (8,9,10,11) THEN vis.umsatz_netto ELSE 0 END) AS ums_sco_ist
		, SUM(CASE WHEN ktp.kasse_typ_id IN (8,9,10,11) THEN vis.anz_kunden ELSE 0 END) AS knd_sco_ist
		, SUM(CASE WHEN ktp.kasse_typ_id IN (1) THEN vis.anz_artikel END) AS art_anz_ist
		, SUM(CASE WHEN ktp.kasse_typ_id IN (1) THEN vis.anz_artikel END)/100000.00 AS art_100t_ist
		, SUM(CASE WHEN ktp.kasse_typ_id IN (1) THEN vis.registrierzeit/60.0000 END) AS scan_min_ist
		, SUM(CASE WHEN ktp.kasse_typ_id IN (1) THEN vis.kassierzeit/3600.0000 END) AS kass_std_ist
		FROM DBP_MSI_VIEW_VIS.MV_VIS_TAG_KASSE_2 vis
		JOIN DBP_MSI_VIEW_VIS.MV_KASSE_TYP_PER_2 ktp
		ON ktp.mandant_id = vis.mandant_id AND ktp.wup_id = vis.wup_id 
		AND ktp.dat = vis.dat AND ktp.kasse_nr = vis.kasse_nr
		INNER JOIN dbp_data.tag_2 zeit1
		ON zeit1.dat = vis.dat
		INNER JOIN DBP_DATA.MONAT_2 zeit_2
		ON zeit.kjmo = zeit1.kjmo AND zeit.akt_gj IN (-1, 0) AND zeit.akt_mo < 0
		INNER JOIN dbp_data.wup_2 wup_2 
		ON wup.wup_id = vis.wup_id AND wup.mandant_id = vis.mandant_id 
		/* Standard Filter VTC : Filiale + definierte NB. Datum Eröffnung fix + GJ Schließung dynamisch */
		AND (wup.nb_id=0 OR wup.wup_id IN (0,2,22,28,43,46,124,8980,8987,8991,100000,100002,100022,100028,100043,100046,100124))
		AND wup.dat_eroeffnung<'2090-12-31' 
		AND (EXTRACT(YEAR FROM wup.dat_bis) + CASE WHEN EXTRACT(MONTH FROM wup.dat_bis) < 3 THEN -1 ELSE 0 END) > (zeit.gj + 1) 
		/* Kassentyp 1 = POS (Checkout) + 8,9,10,11 = SCO (Express + Paystation) */
		WHERE ktp.kasse_typ_id IN (1,8,9,10,11) 
		GROUP BY vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.kjmo
	) sub3
	ON sub3.mandant_id = sub.mandant_id AND sub3.wup_id = sub.wup_id
	AND sub3.wrg_id = sub.wrg_id AND sub3.kjmo = sub.kjmo
	LEFT OUTER JOIN ( /* SUB022 VIS_TAG_KASSE_KVJ (aus mv_view) */
		SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id 
		, zeit.kjmo
		, SUM(vis.umsatz_netto) AS ums_kass_kvj
		, SUM(vis.anz_kunden) AS knd_kass_kvj
		, SUM(CASE WHEN ktp.kasse_typ_id IN (1) THEN vis.umsatz_netto END) AS ums_pos_kvj
		, SUM(CASE WHEN ktp.kasse_typ_id IN (1) THEN vis.anz_kunden END) AS knd_pos_kvj
		, SUM(CASE WHEN ktp.kasse_typ_id IN (8,9,10,11) THEN vis.umsatz_netto ELSE 0 END) AS ums_sco_kvj
		, SUM(CASE WHEN ktp.kasse_typ_id IN (8,9,10,11) THEN vis.anz_kunden ELSE 0 END) AS knd_sco_kvj
		, SUM(CASE WHEN ktp.kasse_typ_id IN (1) THEN vis.anz_artikel END) AS art_anz_kvj
		, SUM(CASE WHEN ktp.kasse_typ_id IN (1) THEN vis.anz_artikel END)/100000.00 AS art_100t_kvj
		, SUM(CASE WHEN ktp.kasse_typ_id IN (1) THEN vis.registrierzeit/60.0000 END) AS scan_min_kvj
		, SUM(CASE WHEN ktp.kasse_typ_id IN (1) THEN vis.kassierzeit/3600.0000 END) AS kass_std_kvj
		FROM DBP_MSI_VIEW_VIS.MV_VIS_TAG_KASSE_2 vis
		JOIN DBP_MSI_VIEW_VIS.MV_KASSE_TYP_PER_2 ktp
		ON ktp.mandant_id = vis.mandant_id AND ktp.wup_id = vis.wup_id 
		AND ktp.dat = vis.dat AND ktp.kasse_nr = vis.kasse_nr
		INNER JOIN dbp_data.tag_2 zeit1
		ON zeit1.dat = vis.dat
		/* Transformation KVJ */
		INNER JOIN DBP_DATA.MONAT_2 zeit_2
		ON zeit.kjmo = zeit1.kjmo+100 AND zeit.akt_gj IN (-1, 0) AND zeit.akt_mo < 0
		INNER JOIN dbp_data.wup_2 wup_2 
		ON wup.wup_id = vis.wup_id AND wup.mandant_id = vis.mandant_id 
		/* Standard Filter VTC : Filiale + definierte NB. Datum Eröffnung fix + GJ Schließung dynamisch */
		AND (wup.nb_id=0 OR wup.wup_id IN (0,2,22,28,43,46,124,8980,8987,8991,100000,100002,100022,100028,100043,100046,100124))
		AND wup.dat_eroeffnung<'2090-12-31' 
		AND (EXTRACT(YEAR FROM wup.dat_bis) + CASE WHEN EXTRACT(MONTH FROM wup.dat_bis) < 3 THEN -1 ELSE 0 END) > (zeit.gj + 1) 
		/* Kassentyp 1 = POS (Checkout) + 8,9,10,11 = SCO (Express + Paystation) */
		WHERE ktp.kasse_typ_id IN (1,8,9,10,11) 
		GROUP BY vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.kjmo
	) sub4
	ON sub4.mandant_id = sub.mandant_id AND sub4.wup_id = sub.wup_id
	AND sub4.wrg_id = sub.wrg_id AND sub4.kjmo = sub.kjmo
) vtr 
 
/* OFFEN  : 610 Google Bewertung */
/* OFFEN : 620 Kurzcheck Gesamt */
/* OFFEN : 630 K-Card Anteil */
 
UNION ALL SELECT mandant_id, nb_id, vs_id, vkl_id, wup_id, wrg_id, gj, kjmo
, 710::INTEGER AS VTR_ID /* 710 Übernahmequote Autodispo inkl. BS */
, ist_fil  AS FILIST,  ist_fil2  AS FILIST2 
, NULL     AS FILKVJ,  NULL      AS FILKVJ2  /* kein vj */
, NULL     AS FILPLAN, NULL      AS FILPLAN2 /* kein plan */
, ist_reg  AS REGIST,  ist_reg2  AS REGIST2 
, NULL     AS REGKVJ,  NULL      AS REGKVJ2  /* kein vj */
, ist_land AS LANDIST, ist_land2 AS LANDIST2 
, NULL     AS LANDKVJ, NULL      AS LANDKVJ2 /* kein vj */
/* Rang absteigend = IST% (Übernahmequote Autodispo) */
, CASE WHEN bs_fg*neo_fg=1 THEN DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, kjmo, vs_id ORDER BY fil_mo DESC NULLS LAST) END AS FILMO_RANG
, CASE WHEN neo_fg*stl_fg=1 THEN DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, gj, vs_id ORDER BY fil_gj DESC NULLS LAST) END AS FILGJ_RANG
, CASE WHEN bs_fg*zf_fg=1 THEN DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, kjmo, vs_id ORDER BY vkl_mo DESC NULLS LAST) END AS VKLMO_RANG
, CASE WHEN zf_fg*stl_fg=1 THEN DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, gj, vs_id ORDER BY vkl_gj DESC NULLS LAST) END AS VKLGJ_RANG
, CASE WHEN bs_fg*neo_fg=1 THEN fil_mo END AS FILMO_WERT
, CASE WHEN neo_fg*stl_fg=1 THEN fil_gj END AS FILGJ_WERT
, CASE WHEN bs_fg*zf_fg=1 THEN vkl_mo END AS VKLMO_WERT
, CASE WHEN zf_fg*stl_fg=1 THEN vkl_gj END AS VKLGJ_WERT  
FROM ( /* VTR710 Übernahmequote Autodispo */
	SELECT sub.mandant_id, sub.nb_id, sub.wup_id, sub.wrg_id, sub.vs_id, sub.vkl_id, sub.gj, sub.kjmo
	-- Übernahmequote Autodispo = (best_vor - best_kor) / best_vor + best_man
	, (sub1.best_vor-sub1.best_kor) AS ist_fil
	, (sub1.best_vor+sub1.best_man) AS ist_fil2
	/* Referenz Region_2/Land_2 */
	, SUM(sub1.best_vor-sub1.best_kor) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vs_id) AS ist_reg
	, SUM(sub1.best_vor+sub1.best_man) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vs_id) AS ist_reg2
	, SUM(sub1.best_vor-sub1.best_kor) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo) AS ist_land
	, SUM(sub1.best_vor+sub1.best_man) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo) AS ist_land2
	/* Rang : neo_fg = Filialen mind. 1 GJ offen, ohne Schließungmonat, ohne Ausschluss-Liste */
	, CASE WHEN sub.stl_dat > sub.max_dat 
		AND sub.gj > (EXTRACT(YEAR FROM sub.neo_dat)+CASE WHEN EXTRACT(MONTH FROM sub.neo_dat)<3 THEN -1 ELSE 0 END)+1 
		AND sub.nb_id=0 
		AND NOT ( /* Ausschluss Getränkemärkte, Zeltverkauf etc 2024-04-08 */
			(sub.mandant_id=1 AND sub.wup_id IN (1263,1273,2583,3166,6623,7220,8120,8563,8940,5876)) /* DE */ 
			OR (sub.mandant_id=7 AND sub.wup_id IN (1110,1410,6210,6310,6410)) /* RO */ 
			OR (sub.mandant_id=3 AND sub.wup_id IN (1010)) /* PL */
		) THEN 1 ELSE 0 END AS neo_fg
	/* Rang GJ : stl_fg = Filialen ohne Schließungen */
	, CASE WHEN sub.stl_dat BETWEEN TO_DATE(TO_CHAR(sub.gj)||'-03-01','YYYY-MM_2-DD') 
	  AND ADD_MONTHS(TO_DATE(TO_CHAR(sub.gj)||'-03-01','YYYY-MM_2-DD'),12)-1 
	  THEN 0 ELSE 1 END AS stl_fg 
	/* Rang VKL_2 : zf_fg = filialen ohne dummy_2 vkl_2 */
	, CASE WHEN sub.nb_id=0 AND sub.vkl_id>0 THEN 1 ELSE 0 END AS zf_fg
	/* Rang BS : bs_fg = Nur Monate vor Buchungsschluss, wichtig am Monatsanfang*/
	, CASE WHEN sub.akt_bs <= 0 THEN 1 ELSE 0 END AS bs_fg
	/* Setup Rang : filiale monat_2 */
	, (neo_fg*(sub1.best_vor-sub1.best_kor)) AS ist_fil_mo
	, (neo_fg*(sub1.best_vor+sub1.best_man)) AS ist_fil_mo2
	/* Setup Rang : filiale gj */
	, SUM(bs_fg*neo_fg*stl_fg*(sub1.best_vor-sub1.best_kor)) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.wup_id) AS ist_fil_gj
	, SUM(bs_fg*neo_fg*stl_fg*(sub1.best_vor+sub1.best_man)) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.wup_id) AS ist_fil_gj2
	/* Setup Rang : vkl_2 monat_2 */
	, SUM(neo_fg*zf_fg*(sub1.best_vor-sub1.best_kor)) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vkl_id) AS ist_vkl_mo
	, SUM(neo_fg*zf_fg*(sub1.best_vor+sub1.best_man)) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vkl_id) AS ist_vkl_mo2
	/* Setup Rang : vkl_2 gj */
	, SUM(bs_fg*neo_fg*zf_fg*stl_fg*(sub1.best_vor-sub1.best_kor)) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.vkl_id) AS ist_vkl_gj
	, SUM(bs_fg*neo_fg*zf_fg*stl_fg*(sub1.best_vor+sub1.best_man)) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.vkl_id) AS ist_vkl_gj2
	/* Rang absteigend = IST% (Übernahmequote Autodispo) */
	, NULLIFZERO(neo_fg)        * (ist_fil_mo/NULLIFZERO(ist_fil_mo2)) AS fil_mo
	, NULLIFZERO(neo_fg*stl_fg) * (ist_fil_gj/NULLIFZERO(ist_fil_gj2)) AS fil_gj
	, NULLIFZERO(zf_fg)         * (ist_vkl_mo/NULLIFZERO(ist_vkl_mo2)) AS vkl_mo
	, NULLIFZERO(zf_fg*stl_fg)  * (ist_vkl_gj/NULLIFZERO(ist_vkl_gj2)) AS vkl_gj
	FROM monat_fakt_wup sub
	LEFT OUTER JOIN ( /* SUB071 VIS_BSCH_BESTVOR_DET (mv_view, keine wrg_2) */
		SELECT vis.mandant_id, vis.nb_id, vis.wup_id
		, zeit.kjmo
		-- Übernahmequote Autodispo = (best_vor - best_kor) / best_vor + best_man
		, SUM(CASE WHEN vis.status_2 NOT IN ('0B','0N')  THEN 1 ELSE 0 END) AS best_vor /* Bestellvorschläge */
		, SUM(CASE WHEN vis.status_2 IN ('0B')           THEN 1 ELSE 0 END) AS best_man /* manuelle Bestellungen*/
		, SUM(CASE WHEN vis.status_2 IN ('V0','V-','V+') THEN 1 ELSE 0 END) AS best_kor /* korrigierte Bestellungen*/
		FROM DBP_MSI_VIEW_VIS.MV_BSCH_BESTVOR_DET_2 vis
		INNER JOIN DBP_DATA.TAG_2 zeit1
		ON zeit1.dat = vis.dat_plan
		INNER JOIN DBP_DATA.MONAT_2 zeit_2
		ON zeit.kjmo = zeit1.kjmo AND zeit.akt_gj IN (-1, 0) AND zeit.akt_mo < 0
		INNER JOIN DBP_MSI_VIEW_VIS.MV_ART_WG_ZU_2 art_2
		ON art.art_id = vis.art_id AND art.mandant_id = vis.mandant_id
		INNER JOIN DBP_MSI_VIEW_VIS.MV_WG_INT_2 wg
		ON wg.wg_id = art.wg_id
		INNER JOIN DBP_MSI_VIEW_VIS.MV_OWG_INT_2 owg
		ON owg.owg_id = wg.owg_id
		INNER JOIN DBP_MSI_VIEW_VIS.MV_HWG_INT_2 hwg
		ON hwg.hwg_id = owg.hwg_id
		INNER JOIN dbp_data.wup_2 wup_2 
		ON wup.wup_id = vis.wup_id AND wup.mandant_id = vis.mandant_id 
		/* Standard Filter VTC : Filiale + definierte NB. Datum Eröffnung fix + GJ Schließung dynamisch */
		AND (wup.nb_id=0 OR wup.wup_id IN (0,2,22,28,43,46,124,8980,8987,8991,100000,100002,100022,100028,100043,100046,100124))
		AND wup.dat_eroeffnung<'2090-12-31' 
		AND (EXTRACT(YEAR FROM wup.dat_bis) + CASE WHEN EXTRACT(MONTH FROM wup.dat_bis) < 3 THEN -1 ELSE 0 END) > (zeit.gj + 1) 
		WHERE vis.status_2 NOT IN ('0N') /* weitere Filter/Logik siehe mv_view! */
		AND hwg.abt_id IN (5,6,7,8) /* Abteilung ohne Nebengeschäft */
		GROUP BY vis.mandant_id, vis.nb_id, vis.wup_id, zeit.kjmo
	) sub1 
	ON sub1.wup_id = sub.wup_id AND sub1.mandant_id = sub.mandant_id
	AND sub1.kjmo = sub.kjmo
) vtr 
 
UNION ALL SELECT mandant_id, nb_id, vs_id, vkl_id, wup_id, wrg_id, gj, kjmo
, 730::INTEGER AS VTR_ID /* 730 Zählaufträge Anzahl */
, ist_fil  AS FILIST,  NULL AS FILIST2 
, NULL     AS FILKVJ,  NULL AS FILKVJ2  /* kein vj */
, NULL     AS FILPLAN, NULL AS FILPLAN2 /* kein plan */
, ist_reg  AS REGIST,  NULL AS REGIST2 
, NULL     AS REGKVJ,  NULL AS REGKVJ2  /* kein vj */
, ist_land AS LANDIST, NULL AS LANDIST2 
, NULL     AS LANDKVJ, NULL AS LANDKVJ2 /* kein vj */
/* kein Rang (Zählaufträge Anzahl) */
, NULL AS FILMO_RANG, NULL AS FILGJ_RANG
, NULL AS VKLMO_RANG, NULL AS VKLGJ_RANG 
, NULL AS FILMO_WERT, NULL AS FILGJ_WERT
, NULL AS VKLMO_WERT, NULL AS VKLGJ_WERT 
FROM ( /* VTR730 Zählaufträge Anzahl */
	SELECT sub.mandant_id, sub.nb_id, sub.wup_id, sub.wrg_id, sub.vs_id, sub.vkl_id, sub.gj, sub.kjmo
	, sub1.auftrag AS ist_fil
	/* Referenz Region_2/Land_2 */
	, SUM(sub1.auftrag) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vs_id) AS ist_reg
	, SUM(sub1.auftrag) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo) AS ist_land
	/* kein Rang (Zählaufträge Anzahl) */
	FROM monat_fakt_wup sub
	LEFT OUTER JOIN zaehl_auftrag sub1 
	ON sub1.wup_id = sub.wup_id AND sub1.mandant_id = sub.mandant_id
	AND sub1.kjmo = sub.kjmo
) vtr 
 
UNION ALL SELECT mandant_id, nb_id, vs_id, vkl_id, wup_id, wrg_id, gj, kjmo
, 732::INTEGER AS VTR_ID /* 732 Zählungen durchgeführt */
, ist_fil  AS FILIST,  NULL AS FILIST2 
, NULL     AS FILKVJ,  NULL AS FILKVJ2  /* kein vj */
, NULL     AS FILPLAN, NULL AS FILPLAN2 /* kein plan */
, ist_reg  AS REGIST,  NULL AS REGIST2 
, NULL     AS REGKVJ,  NULL AS REGKVJ2  /* kein vj */
, ist_land AS LANDIST, NULL AS LANDIST2 
, NULL     AS LANDKVJ, NULL AS LANDKVJ2 /* kein vj */
/* kein Rang (Zählungen durchgeführt) */
, NULL AS FILMO_RANG, NULL AS FILGJ_RANG
, NULL AS VKLMO_RANG, NULL AS VKLGJ_RANG 
, NULL AS FILMO_WERT, NULL AS FILGJ_WERT
, NULL AS VKLMO_WERT, NULL AS VKLGJ_WERT 
FROM ( /* VTR732 Zählungen durchgeführt */
	SELECT sub.mandant_id, sub.nb_id, sub.wup_id, sub.wrg_id, sub.vs_id, sub.vkl_id, sub.gj, sub.kjmo
	, sub1.gezaehlt AS ist_fil
	/* Referenz Region_2/Land_2 */
	, SUM(sub1.gezaehlt) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vs_id) AS ist_reg
	, SUM(sub1.gezaehlt) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo) AS ist_land
	/* kein Rang (Zählungen durchgeführt) */
	FROM monat_fakt_wup sub
	LEFT OUTER JOIN zaehl_auftrag sub1 
	ON sub1.wup_id = sub.wup_id AND sub1.mandant_id = sub.mandant_id
	AND sub1.kjmo = sub.kjmo
) vtr 
 
UNION ALL SELECT mandant_id, nb_id, vs_id, vkl_id, wup_id, wrg_id, gj, kjmo
, 735::INTEGER AS VTR_ID /* 735 Zählaufträge bearbeitet (%) */
, ist_fil  AS FILIST,  ist_fil2  AS FILIST2 
, NULL     AS FILKVJ,  NULL      AS FILKVJ2  /* kein vj */
, NULL     AS FILPLAN, NULL      AS FILPLAN2 /* kein plan */
, ist_reg  AS REGIST,  ist_reg2  AS REGIST2 
, NULL     AS REGKVJ,  NULL      AS REGKVJ2  /* kein vj */
, ist_land AS LANDIST, ist_land2 AS LANDIST2 
, NULL     AS LANDKVJ, NULL      AS LANDKVJ2 /* kein vj */
/* kein Rang (Zählaufträge bearbeitet (%)) */
, NULL AS FILMO_RANG, NULL AS FILGJ_RANG
, NULL AS VKLMO_RANG, NULL AS VKLGJ_RANG 
, NULL AS FILMO_WERT, NULL AS FILGJ_WERT
, NULL AS VKLMO_WERT, NULL AS VKLGJ_WERT 
FROM ( /* VTR735 Zählaufträge bearbeitet (%) */
	SELECT sub.mandant_id, sub.nb_id, sub.wup_id, sub.wrg_id, sub.vs_id, sub.vkl_id, sub.gj, sub.kjmo
	, sub1.gezaehlt AS ist_fil
	, sub1.auftrag AS ist_fil2
	/* Referenz Region_2/Land_2 */
	, SUM(sub1.gezaehlt) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vs_id) AS ist_reg
	, SUM(sub1.auftrag) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vs_id) AS ist_reg2
	, SUM(sub1.gezaehlt) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo) AS ist_land
	, SUM(sub1.auftrag) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo) AS ist_land2
	/* kein Rang (Zählaufträge bearbeitet (%)) */
	FROM monat_fakt_wup sub
	LEFT OUTER JOIN zaehl_auftrag sub1 
	ON sub1.wup_id = sub.wup_id AND sub1.mandant_id = sub.mandant_id
	AND sub1.kjmo = sub.kjmo
) vtr 
 
UNION ALL SELECT mandant_id, nb_id, vs_id, vkl_id, wup_id, wrg_id, gj, kjmo
, 750::INTEGER AS VTR_ID /* 750 Nullbestandsquote */
, ist_fil  AS FILIST,  ist_fil2  AS FILIST2 
, NULL     AS FILKVJ,  NULL      AS FILKVJ2  /* kein vj */
, NULL     AS FILPLAN, NULL      AS FILPLAN2 /* kein plan */
, ist_reg  AS REGIST,  ist_reg2  AS REGIST2 
, NULL     AS REGKVJ,  NULL      AS REGKVJ2  /* kein vj */
, ist_land AS LANDIST, ist_land2 AS LANDIST2 
, NULL     AS LANDKVJ, NULL      AS LANDKVJ2 /* kein vj */
/* kein Rang (Nullbestandsquote) */
, NULL AS FILMO_RANG, NULL AS FILGJ_RANG
, NULL AS VKLMO_RANG, NULL AS VKLGJ_RANG 
, NULL AS FILMO_WERT, NULL AS FILGJ_WERT
, NULL AS VKLMO_WERT, NULL AS VKLGJ_WERT 
FROM ( /* VTR750 Nullbestandsquote */
	SELECT sub.mandant_id, sub.nb_id, sub.wup_id, sub.wrg_id, sub.vs_id, sub.vkl_id, sub.gj, sub.kjmo
	, sub1.null_best AS ist_fil
	, sub1.auto_dispo AS ist_fil2
	/* Referenz Region_2/Land_2 */
	, SUM(sub1.null_best) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vs_id) AS ist_reg
	, SUM(sub1.auto_dispo) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vs_id) AS ist_reg2
	, SUM(sub1.null_best) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo) AS ist_land
	, SUM(sub1.auto_dispo) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo) AS ist_land2
	/* kein Rang (Nullbestandsquote) */
	FROM monat_fakt_wup sub
	LEFT OUTER JOIN tag_fwws_wg sub1 
	ON sub1.wup_id = sub.wup_id AND sub1.mandant_id = sub.mandant_id
	AND sub1.kjmo = sub.kjmo
) vtr 
 
UNION ALL SELECT mandant_id, nb_id, vs_id, vkl_id, wup_id, wrg_id, gj, kjmo
, 752::INTEGER AS VTR_ID /* 752 Minusbestandsquote */
, ist_fil  AS FILIST,  ist_fil2  AS FILIST2 
, NULL     AS FILKVJ,  NULL      AS FILKVJ2  /* kein vj */
, NULL     AS FILPLAN, NULL      AS FILPLAN2 /* kein plan */
, ist_reg  AS REGIST,  ist_reg2  AS REGIST2 
, NULL     AS REGKVJ,  NULL      AS REGKVJ2  /* kein vj */
, ist_land AS LANDIST, ist_land2 AS LANDIST2 
, NULL     AS LANDKVJ, NULL      AS LANDKVJ2 /* kein vj */
/* kein Rang (Minusbestandsquote) */
, NULL AS FILMO_RANG, NULL AS FILGJ_RANG
, NULL AS VKLMO_RANG, NULL AS VKLGJ_RANG 
, NULL AS FILMO_WERT, NULL AS FILGJ_WERT
, NULL AS VKLMO_WERT, NULL AS VKLGJ_WERT 
FROM ( /* VTR752 Minusbestandsquote */
	SELECT sub.mandant_id, sub.nb_id, sub.wup_id, sub.wrg_id, sub.vs_id, sub.vkl_id, sub.gj, sub.kjmo
	, sub1.minus_best AS ist_fil
	, sub1.auto_dispo AS ist_fil2
	/* Referenz Region_2/Land_2 */
	, SUM(sub1.minus_best) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vs_id) AS ist_reg
	, SUM(sub1.auto_dispo) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vs_id) AS ist_reg2
	, SUM(sub1.minus_best) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo) AS ist_land
	, SUM(sub1.auto_dispo) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo) AS ist_land2
	/* kein Rang (Minusbestandsquote) */
	FROM monat_fakt_wup sub
	LEFT OUTER JOIN tag_fwws_wg sub1 
	ON sub1.wup_id = sub.wup_id AND sub1.mandant_id = sub.mandant_id
	AND sub1.kjmo = sub.kjmo
) vtr 
 
UNION ALL SELECT mandant_id, nb_id, vs_id, vkl_id, wup_id, wrg_id, gj, kjmo
, 755::INTEGER AS VTR_ID /* 755 Null-/Minusquote inkl. BS */
, ist_fil  AS FILIST,  ist_fil2  AS FILIST2 
, NULL     AS FILKVJ,  NULL      AS FILKVJ2  /* kein vj */
, NULL     AS FILPLAN, NULL      AS FILPLAN2 /* kein plan */
, ist_reg  AS REGIST,  ist_reg2  AS REGIST2 
, NULL     AS REGKVJ,  NULL      AS REGKVJ2  /* kein vj */
, ist_land AS LANDIST, ist_land2 AS LANDIST2 
, NULL     AS LANDKVJ, NULL      AS LANDKVJ2 /* kein vj */
/* Rang aufsteigend = IST% (Null-/Minusquote) */
, CASE WHEN bs_fg*neo_fg=1 THEN DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, kjmo, vs_id ORDER BY fil_mo ASC NULLS LAST) END AS FILMO_RANG
, CASE WHEN neo_fg*stl_fg=1 THEN DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, gj, vs_id ORDER BY fil_gj ASC NULLS LAST) END AS FILGJ_RANG
, CASE WHEN bs_fg*zf_fg=1 THEN DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, kjmo, vs_id ORDER BY vkl_mo ASC NULLS LAST) END AS VKLMO_RANG
, CASE WHEN zf_fg*stl_fg=1 THEN DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, gj, vs_id ORDER BY vkl_gj ASC NULLS LAST) END AS VKLGJ_RANG
, CASE WHEN bs_fg*neo_fg=1 THEN fil_mo END AS FILMO_WERT
, CASE WHEN neo_fg*stl_fg=1 THEN fil_gj END AS FILGJ_WERT
, CASE WHEN bs_fg*zf_fg=1 THEN vkl_mo END AS VKLMO_WERT
, CASE WHEN zf_fg*stl_fg=1 THEN vkl_gj END AS VKLGJ_WERT  
FROM ( /* VTR755 Null-/Minusquote */
	SELECT sub.mandant_id, sub.nb_id, sub.wup_id, sub.wrg_id, sub.vs_id, sub.vkl_id, sub.gj, sub.kjmo
	, (sub1.null_best+sub1.minus_best) AS ist_fil
	, sub1.auto_dispo AS ist_fil2
	/* Referenz Region_2/Land_2 */
	, SUM(sub1.null_best+sub1.minus_best) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vs_id) AS ist_reg
	, SUM(sub1.auto_dispo) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vs_id) AS ist_reg2
	, SUM(sub1.null_best+sub1.minus_best) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo) AS ist_land
	, SUM(sub1.auto_dispo) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo) AS ist_land2
	/* Rang : neo_fg = Filialen mind. 1 GJ offen, ohne Schließungmonat, ohne Ausschluss-Liste */
	, CASE WHEN sub.stl_dat > sub.max_dat 
		AND sub.gj > (EXTRACT(YEAR FROM sub.neo_dat)+CASE WHEN EXTRACT(MONTH FROM sub.neo_dat)<3 THEN -1 ELSE 0 END)+1 
		AND sub.nb_id=0 
		AND NOT ( /* Ausschluss Getränkemärkte, Zeltverkauf etc 2024-04-08 */
			(sub.mandant_id=1 AND sub.wup_id IN (1263,1273,2583,3166,6623,7220,8120,8563,8940,5876)) /* DE */ 
			OR (sub.mandant_id=7 AND sub.wup_id IN (1110,1410,6210,6310,6410)) /* RO */ 
			OR (sub.mandant_id=3 AND sub.wup_id IN (1010)) /* PL */
		) THEN 1 ELSE 0 END AS neo_fg
	/* Rang GJ : stl_fg = Filialen ohne Schließungen */
	, CASE WHEN sub.stl_dat BETWEEN TO_DATE(TO_CHAR(sub.gj)||'-03-01','YYYY-MM_2-DD') 
	  AND ADD_MONTHS(TO_DATE(TO_CHAR(sub.gj)||'-03-01','YYYY-MM_2-DD'),12)-1 
	  THEN 0 ELSE 1 END AS stl_fg 
	/* Rang VKL_2 : zf_fg = filialen ohne dummy_2 vkl_2 */
	, CASE WHEN sub.nb_id=0 AND sub.vkl_id>0 THEN 1 ELSE 0 END AS zf_fg
	/* Rang BS : bs_fg = Nur Monate vor Buchungsschluss, wichtig am Monatsanfang*/
	, CASE WHEN sub.akt_bs <= 0 THEN 1 ELSE 0 END AS bs_fg
	/* Setup Rang : filiale monat_2 */
	, (neo_fg*(sub1.null_best+sub1.minus_best)) AS ist_fil_mo
	, (neo_fg*sub1.auto_dispo) AS ist_fil_mo2
	/* Setup Rang : filiale gj */
	, SUM(bs_fg*neo_fg*stl_fg*(sub1.null_best+sub1.minus_best)) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.wup_id) AS ist_fil_gj
	, SUM(bs_fg*neo_fg*stl_fg*sub1.auto_dispo) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.wup_id) AS ist_fil_gj2
	/* Setup Rang : vkl_2 monat_2 */
	, SUM(neo_fg*zf_fg*(sub1.null_best+sub1.minus_best)) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vkl_id) AS ist_vkl_mo
	, SUM(neo_fg*zf_fg*sub1.auto_dispo) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vkl_id) AS ist_vkl_mo2
	/* Setup Rang : vkl_2 gj */
	, SUM(bs_fg*neo_fg*zf_fg*stl_fg*(sub1.null_best+sub1.minus_best)) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.vkl_id) AS ist_vkl_gj
	, SUM(bs_fg*neo_fg*zf_fg*stl_fg*sub1.auto_dispo) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.gj, sub.vkl_id) AS ist_vkl_gj2
	/* Rang aufsteigend = IST% (Null-/Minusquote) */
	, NULLIFZERO(neo_fg)        * (ist_fil_mo/NULLIFZERO(ist_fil_mo2)) AS fil_mo
	, NULLIFZERO(neo_fg*stl_fg) * (ist_fil_gj/NULLIFZERO(ist_fil_gj2)) AS fil_gj
	, NULLIFZERO(zf_fg)         * (ist_vkl_mo/NULLIFZERO(ist_vkl_mo2)) AS vkl_mo
	, NULLIFZERO(zf_fg*stl_fg)  * (ist_vkl_gj/NULLIFZERO(ist_vkl_gj2)) AS vkl_gj
	FROM monat_fakt_wup sub
	LEFT OUTER JOIN tag_fwws_wg sub1 
	ON sub1.wup_id = sub.wup_id AND sub1.mandant_id = sub.mandant_id
	AND sub1.kjmo = sub.kjmo
) vtr 
;