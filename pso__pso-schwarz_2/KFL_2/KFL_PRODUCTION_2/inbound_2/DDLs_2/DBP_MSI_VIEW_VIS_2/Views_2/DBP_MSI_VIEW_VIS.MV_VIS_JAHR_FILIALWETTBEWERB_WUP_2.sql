CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_VIS_JAHR_FILIALWETTBEWERB_WUP_2(
	MANDANT_ID,
	NB_ID,
	VS_ID,
	WUP_ID,
	WRG_ID,
	GJ,
	MDJ_KJMO,
	MDJ_OFFEN,
	MDJ_UMS_NETTO_IST,
	MDJ_UMS_NETTO_PLAN,
	MDJ_UMS_NETTO,
	MDJ_UMS_NETTO_RANK,
	MDJ_UMS_NETTO_DENSE,
	MDJ_UMS_TAG_IST,
	MDJ_UMS_TAG_KVJ,
	MDJ_UMS_OG_IST,
	MDJ_UMS_OG_KVJ,
	MDJ_UMS_ANTEIL_OG_IST,
	MDJ_UMS_ANTEIL_OG_KVJ,
	MDJ_UMS_ANTEIL_OG,
	MDJ_UMS_ANTEIL_OG_RANK,
	MDJ_UMS_ANTEIL_OG_DENSE,
	MDJ_UMS_BS_IST,
	MDJ_UMS_BS_KVJ,
	MDJ_UMS_ANTEIL_BS_IST,
	MDJ_UMS_ANTEIL_BS_KVJ,
	MDJ_UMS_ANTEIL_BS,
	MDJ_UMS_ANTEIL_BS_RANK,
	MDJ_UMS_ANTEIL_BS_DENSE,
	MDJ_ABS_OP_IST,
	MDJ_ABS_OWG_PLAN,
	MDJ_UMS_OWG_PLAN,
	MDJ_ABSCHRIFT_OP_IST,
	MDJ_ABSCHRIFT_OP_PLAN,
	MDJ_ABSCHRIFT_OP,
	MDJ_ABSCHRIFT_OP_RANK,
	MDJ_ABSCHRIFT_OP_DENSE,
	MDJ_NETTOSTD_IST,
	MDJ_NETTOSTD_PLAN,
	MDJ_NETTOLEIST_IST,
	MDJ_NETTOLEIST_PLAN,
	MDJ_NETTOLEIST,
	MDJ_NETTOLEIST_RANK,
	MDJ_NETTOLEIST_DENSE,
	MDJ_WARTEN_KASSE,
	MDJ_WARTEN_KASSE_RANK,
	MDJ_WARTEN_KASSE_DENSE,
	MDJ_WARTEN_THEKE,
	MDJ_WARTEN_THEKE_RANK,
	MDJ_WARTEN_THEKE_DENSE,
	MDJ_BONANZAHL,
	MDJ_BON_KCARD,
	MDJ_KCARD,
	MDJ_KCARD_RANK,
	MDJ_KCARD_DENSE,
	MDJ_BONANZAHL_IST,
	MDJ_BON_KCARD_IST,
	MDJ_BONANZAHL_KVJ,
	MDJ_BON_KCARD_KVJ,
	MDJ_KCARD_IST,
	MDJ_KCARD_KVJ,
	MDJ_KCARD_DELTA,
	MDJ_KCARD_DELTA_RANK,
	MDJ_KCARD_DELTA_DENSE,
	MDJ_GOOGLE_SUM,
	MDJ_GOOGLE_ANZ,
	MDJ_GOOGLE,
	MDJ_GOOGLE_RANK,
	MDJ_GOOGLE_DENSE,
	MDJ_KCG_NOK_ANZ,
	MDJ_KCG_ANZ,
	MDJ_KCG_NOK,
	MDJ_KCG_NOK_RANK,
	MDJ_KCG_NOK_DENSE,
	MDJ_KC_FESTSTELL,
	MDJ_KC_GESAMT,
	MDJ_KC_NOK,
	MDJ_KC_NOK_RANK,
	MDJ_KC_NOK_DENSE
) AS 

/*
	FAKT DENORM : Filialwettbewerb Markt des Jahres  
	2023-03-10 ssch0611 : Updated/Fixed. Dense ranking with filter. AP0154666  
	2023-04-14 ssch0611 : Update. Filter GJ2023 (CZ) + Definition K-Card (PL)
	2023-07-17 ssch0611 : Bugfix. Filter Abschriften_2 operativ.
	2024-04-08 ssch0611 : Filialfilter GJ2024. Umsatzanteil O&G/Backshop, K-Card Delta , Google ergänzt. MDL/Kundenfeedback entfernt [AP0195212]
	2024-04-25 ssch0611 : Ergänzung Zeitfilter in allen Sub-Selects + Fix Wupcal_2
	2024-06-20 muellerpatri : Filialumgliederung [P1760-DWH]
	2024-08-15 muellerpatri: Ausschluss D1430 - Anfrage Fachbereich
	2024-11-14 muellerpatri : Filialausschluss mandant_id = 2 AND wup.wup_id IN (1700, 6800) 
	2025-01-30 muellerpatri : Erweiterung um neuen Kurzcheck Gesamt
	2025-06-03 ssch0611 : Review auf Basis Monat_2 inkl Filter GJ 2025 [AP0263138]
	2025-11-17 ssch0611 : Fix Filter Umgliederungen (dat_bis Altfiliale)
*/ 

WITH 
/* Filialen inkl Mapping Umgliederungen, ohne ZF, ohne Ausschluss */
 wup_2 AS ( 
	SELECT wup.mandant_id
		, wup.nb_id
		, wup.vs_id
		, wup.aktuell_wup_id
		, wup.wup_id
		, COALESCE(wup.dat_eroeffnung_alt, wup.dat_eroeffnung) AS neo_dat  /* Eröffnungsdatum - EÖ der ursprünglichen Filiale ist gemappt */
		, IFF(wup_aenderung_grund_id = 3, '9999-12-31', NULL)  AS dat_umgl /* Umgliederung : Dummy_2 (keine Schließung) */
		, COALESCE(dat_umgl, wup.dat_bis)                      AS stl_dat  /* Schließungsdatum - keine Schließung bei Altfilialen/Umgliederung */
		, EXTRACT(YEAR FROM neo_dat) - IFF(EXTRACT(MONTH FROM neo_dat) < 3, 1, 0) AS neo_gj /* GJ der Eröffnung */
		, EXTRACT(YEAR FROM stl_dat) - IFF(EXTRACT(MONTH FROM stl_dat) < 3, 1, 0) AS stl_gj /* GJ der Schließung */
		/* Ausschluss Filialwettbewerb -- 2025-04 */
		, CASE 
			WHEN wup.mandant_id = 1 AND wup.wup_id IN (1263, 1273, 3166, 6623, 8120, 8563, 8940, 5876) THEN 1 /* DE Sonderverkauf/Getränkemärkte*/
			WHEN wup.mandant_id = 3 AND wup.wup_id IN (1010)                                           THEN 1 /* PL Sonderverkauf */
			WHEN wup.mandant_id = 7 AND wup.wup_id IN (1110, 1410, 6210, 6310, 6410)                   THEN 1 /* RO Sonderverkauf/Zeltverkauf */
		/* Ausschluss Markt des Jahres -- 2025-04 */
		/* Ausschluss CZ (temporär) bis 202602 */
			WHEN wup.mandant_id = 2 AND wup.wup_id IN (1700, 6800)                                     THEN 2 
			ELSE 0 END AS aus_fg
	FROM DBP_DATA.WUP_2 wup_2
	WHERE wup.nb_id = 0 AND wup.dat_eroeffnung < '2090-12-31' /* Filialen ohne Dummy_2 NEÖ */
	)

/* Zeit_2 akt. GJ (Monatsreporting) bis Vormonat / Wechsel am 02. April */
, zeit_2 AS(
	SELECT zeit.gj 
		, zeit.akt_gj /* GJ Wechsel am 02. März - hier nicht verwendet */
		, zeit.akt_gj + IFF(EXTRACT(MONTH FROM CURRENT_DATE - 1) = 3, 1, 0) AS akt_gj_mo /* GJ Wechsel am 02. April */
		, zeit.kjmo 
		, zeit.kjmo_vj /* Kalendermonat im VJ */
		, zeit.akt_mo 
		, zeit.min_dat /* Datum Monatsanfang */
		, zeit.max_dat /* Datum Monatsende */
	FROM DBP_DATA.MONAT_2 zeit_2
	WHERE akt_gj_mo = 0 AND zeit.akt_mo < 0 
	)


/* MAIN */

SELECT vis.mandant_id
	, vis.nb_id
	, vis.vs_id
	, vis.wup_id
	, vis.wrg_id
	, vis.gj
	, vis.kjmo_max  AS MDJ_kjmo
	, vis.offen_ist AS MDJ_offen
	/* 01 Umsatz netto - Delta Plan DESC */
	, vis.ums_netto_ist  AS MDJ_ums_netto_ist
	, vis.ums_netto_plan AS MDJ_ums_netto_plan
	, (MDJ_ums_netto_ist - MDJ_ums_netto_plan) / NULLIFZERO(MDJ_ums_netto_plan) AS MDJ_ums_netto
	, RANK ()       OVER (PARTITION BY vis.mandant_id, vis.vs_id, vis.wrg_id, vis.gj ORDER BY MDJ_ums_netto DESC NULLS LAST) AS MDJ_ums_netto_rank
	, DENSE_RANK () OVER (PARTITION BY vis.mandant_id, vis.vs_id, vis.wrg_id, vis.gj ORDER BY MDJ_ums_netto DESC NULLS LAST) AS MDJ_ums_netto_dense
	/* 02 Umsatzanteil Obst und Gemüse - Delta VJ DESC */
	, vistag.ums_tag_ist AS MDJ_ums_tag_ist
	, vistag.ums_tag_kvj AS MDJ_ums_tag_kvj
	, vishwg.ums_og_ist  AS MDJ_ums_og_ist
	, vishwg.ums_og_kvj  AS MDJ_ums_og_kvj
	, MDJ_ums_og_ist / NULLIFZERO(MDJ_ums_tag_ist) AS MDJ_ums_anteil_og_ist
	, MDJ_ums_og_kvj / NULLIFZERO(MDJ_ums_tag_kvj) AS MDJ_ums_anteil_og_kvj
	, MDJ_ums_anteil_og_ist - NULLIFZERO(MDJ_ums_anteil_og_kvj) AS MDJ_ums_anteil_og
	, RANK ()       OVER (PARTITION BY vis.mandant_id, vis.vs_id, vis.wrg_id, vis.gj ORDER BY MDJ_ums_anteil_og DESC NULLS LAST) AS MDJ_ums_anteil_og_rank
	, DENSE_RANK () OVER (PARTITION BY vis.mandant_id, vis.vs_id, vis.wrg_id, vis.gj ORDER BY MDJ_ums_anteil_og DESC NULLS LAST) AS MDJ_ums_anteil_og_dense
	/* 03 Umsatzanteil Backshop - Delta VJ DESC */
	, vishwg.ums_bs_ist  AS MDJ_ums_bs_ist
	, vishwg.ums_bs_kvj  AS MDJ_ums_bs_kvj
	, MDJ_ums_bs_ist / NULLIFZERO(MDJ_ums_tag_ist) AS MDJ_ums_anteil_bs_ist
	, MDJ_ums_bs_kvj / NULLIFZERO(MDJ_ums_tag_kvj) AS MDJ_ums_anteil_bs_kvj
	, MDJ_ums_anteil_bs_ist - NULLIFZERO(MDJ_ums_anteil_bs_kvj) AS MDJ_ums_anteil_bs
	, RANK ()       OVER (PARTITION BY vis.mandant_id, vis.vs_id, vis.wrg_id, vis.gj ORDER BY MDJ_ums_anteil_bs DESC NULLS LAST) AS MDJ_ums_anteil_bs_rank
	, DENSE_RANK () OVER (PARTITION BY vis.mandant_id, vis.vs_id, vis.wrg_id, vis.gj ORDER BY MDJ_ums_anteil_bs DESC NULLS LAST) AS MDJ_ums_anteil_bs_dense
	/* 04 Abschriften_2 operativ - Delta Plan DESC */
	, visabs.abs_op_ist    AS MDJ_abs_op_ist
	, planowg.abs_owg_plan AS MDJ_abs_owg_plan
	, planowg.ums_owg_plan AS MDJ_ums_owg_plan
	, MDJ_abs_op_ist / NULLIFZERO(MDJ_ums_tag_ist)    AS MDJ_abschrift_op_ist
	, MDJ_abs_owg_plan / NULLIFZERO(MDJ_ums_owg_plan) AS MDJ_abschrift_op_plan
	, MDJ_abschrift_op_ist - NULLIFZERO(MDJ_abschrift_op_plan) AS MDJ_abschrift_op
	, RANK ()       OVER (PARTITION BY vis.mandant_id, vis.vs_id, vis.wrg_id, vis.gj ORDER BY MDJ_abschrift_op DESC NULLS LAST) AS MDJ_abschrift_op_rank
	, DENSE_RANK () OVER (PARTITION BY vis.mandant_id, vis.vs_id, vis.wrg_id, vis.gj ORDER BY MDJ_abschrift_op DESC NULLS LAST) AS MDJ_abschrift_op_dense
	/* 05 Nettoleistung - Delta Plan DESC */
	, vis.nettostd_ist  AS MDJ_nettostd_ist
	, vis.nettostd_plan AS MDJ_nettostd_plan
	, vis.ums_netto_ist  / NULLIFZERO(vis.nettostd_ist)    AS MDJ_nettoleist_ist
	, vis.ums_netto_plan / NULLIFZERO(vis.nettostd_plan)   AS MDJ_nettoleist_plan
	, MDJ_nettoleist_ist - NULLIFZERO(MDJ_nettoleist_plan) AS MDJ_nettoleist
	, RANK ()       OVER (PARTITION BY vis.mandant_id, vis.vs_id, vis.wrg_id, vis.gj ORDER BY MDJ_nettoleist DESC NULLS LAST) AS MDJ_nettoleist_rank
	, DENSE_RANK () OVER (PARTITION BY vis.mandant_id, vis.vs_id, vis.wrg_id, vis.gj ORDER BY MDJ_nettoleist   DESC NULLS LAST) AS MDJ_nettoleist_dense
	/* 06 Kundgarantie Anzahl Warten Kasse - Wert ASC DENSE */
	, rekl.wkasse AS MDJ_warten_kasse
	, RANK ()       OVER (PARTITION BY vis.mandant_id, vis.vs_id, vis.wrg_id, vis.gj ORDER BY MDJ_warten_kasse ASC NULLS LAST) AS MDJ_warten_kasse_rank
	, DENSE_RANK () OVER (PARTITION BY vis.mandant_id, vis.vs_id, vis.wrg_id, vis.gj ORDER BY MDJ_warten_kasse ASC  NULLS LAST) AS MDJ_warten_kasse_dense
	/* 07 Kundgarantie Anzahl Warten Theke - Wert ASC DENSE */
	, rekl.wtheke AS MDJ_warten_theke
	, RANK ()       OVER (PARTITION BY vis.mandant_id, vis.vs_id, vis.wrg_id, vis.gj ORDER BY MDJ_warten_theke ASC  NULLS LAST) AS MDJ_warten_theke_rank
	, DENSE_RANK () OVER (PARTITION BY vis.mandant_id, vis.vs_id, vis.wrg_id, vis.gj ORDER BY MDJ_warten_theke ASC  NULLS LAST) AS MDJ_warten_theke_dense
	/* 08 Kundenanteil K-Card - Wert DESC */
	, wcal.bonanz    AS MDJ_bonanzahl
	, wcal.bonkcard  AS MDJ_bon_kcard
	, MDJ_bon_kcard / NULLIFZERO(MDJ_bonanzahl) AS MDJ_kcard
	, RANK ()       OVER (PARTITION BY vis.mandant_id, vis.vs_id, vis.wrg_id, vis.gj ORDER BY MDJ_kcard DESC NULLS LAST) AS MDJ_kcard_rank
	, DENSE_RANK () OVER (PARTITION BY vis.mandant_id, vis.vs_id, vis.wrg_id, vis.gj ORDER BY MDJ_kcard DESC NULLS LAST) AS MDJ_kcard_dense
	/* 09 Kundenanteil K-Card - Delta VJ DESC */
	, wcal.bonanz       AS MDJ_bonanzahl_ist
	, wcal.bonkcard     AS MDJ_bon_kcard_ist
	, wcal_kvj.bonanz   AS MDJ_bonanzahl_kvj
	, wcal_kvj.bonkcard AS MDJ_bon_kcard_kvj
	, MDJ_bon_kcard_ist / NULLIFZERO(MDJ_bonanzahl_ist) AS MDJ_kcard_ist
	, MDJ_bon_kcard_kvj / NULLIFZERO(MDJ_bonanzahl_kvj) AS MDJ_kcard_kvj
	, MDJ_kcard_ist - MDJ_kcard_kvj AS MDJ_kcard_delta
	, RANK ()       OVER (PARTITION BY vis.mandant_id, vis.vs_id, vis.wrg_id, vis.gj ORDER BY MDJ_kcard_delta DESC NULLS LAST) AS MDJ_kcard_delta_rank
	, DENSE_RANK () OVER (PARTITION BY vis.mandant_id, vis.vs_id, vis.wrg_id, vis.gj ORDER BY MDJ_kcard_delta DESC NULLS LAST) AS MDJ_kcard_delta_dense  
	/* 10 Google Reviews Kaufland - Sterne DESC DENSE - ab Jan 2024 */
	, ggl.sum_review_rating AS MDJ_google_sum
	, ggl.anz_review_rating AS MDJ_google_anz
	, MDJ_google_sum / NULLIFZERO(MDJ_google_anz) AS MDJ_google
	, RANK ()       OVER (PARTITION BY vis.mandant_id, vis.vs_id, vis.wrg_id, vis.gj ORDER BY MDJ_google DESC NULLS LAST) AS MDJ_google_rank
	, DENSE_RANK () OVER (PARTITION BY vis.mandant_id, vis.vs_id, vis.wrg_id, vis.gj ORDER BY MDJ_google DESC NULLS LAST) AS MDJ_google_dense
	/* 11 Kurzcheck Gesamt NEU - NOK% ASC DENSE -- Daten ab August 2024 */
	, kcg.kcg_anz     AS MDJ_kcg_anz
	, kcg.kcg_nok_anz AS MDJ_kcg_nok_anz
	, MDJ_kcg_nok_anz / NULLIFZERO(MDJ_kcg_anz) AS MDJ_kcg_nok
	, RANK ()       OVER (PARTITION BY vis.mandant_id, vis.vs_id, vis.wrg_id, vis.gj ORDER BY MDJ_kcg_nok ASC  NULLS LAST) AS MDJ_kcg_nok_rank
	, DENSE_RANK () OVER (PARTITION BY vis.mandant_id, vis.vs_id, vis.wrg_id, vis.gj ORDER BY MDJ_kcg_nok ASC  NULLS LAST) AS MDJ_kcg_nok_dense
	/* 1x Kurzcheck (ALT) -- Daten bis Juli 2024 */
	, NULL AS MDJ_kc_feststell
	, NULL AS MDJ_kc_gesamt
	, NULL AS MDJ_kc_nok
	, NULL AS MDJ_kc_nok_rank
	, NULL AS MDJ_kc_nok_dense

/* vis_monat : Monatsumsatz und Nettostunden (Referenz) */
FROM (
	SELECT vis0.mandant_id
		, vis0.nb_id
		, wup.vs_id
		, wup.aktuell_wup_id AS wup_id
		, vis0.wrg_id
		, zeit.gj
		, MAX(vis0.kjmo)           AS kjmo_max
		, SUM(vis0.anz_offen)      AS offen_ist
		, SUM(vis0.ums_netto)      AS ums_netto_ist
		, SUM(vis0.ums_netto_plan) AS ums_netto_plan
		, SUM(vis0.pers_std)       AS nettostd_ist
		, SUM(vis0.pers_std_plan)  AS nettostd_plan
	FROM dbp_msi_data.vis_monat_ums_kunde_pers_wup_2 vis0
	INNER JOIN zeit_2 
		ON zeit.kjmo = vis0.kjmo 
	INNER JOIN wup_2 
		ON wup.wup_id = vis0.wup_id AND wup.mandant_id = vis0.mandant_id
	WHERE wup.neo_gj < (zeit.gj -1)    /* Filiale muss 1 komplettes GJ geöffnet sein */
		AND wup.stl_dat > zeit.max_dat /* ohne Schließungsmonat */
		AND wup.aus_fg = 0             /* ohne Ausschluss (komplett) */
	GROUP BY ALL
) vis 

/* vis_tag : Tagesumsatz für Abschriften_2 und Anteile */
INNER JOIN (
	SELECT vis0.mandant_id, vis0.wrg_id
		, wup.aktuell_wup_id AS wup_id
		, zeit.gj
		, SUM(vis0.ums_netto)     AS ums_tag_ist
		, SUM(vis0.ums_netto_kvj) AS ums_tag_kvj
	FROM dbp_msi_data.vis_tag_umsatz_kunde_wup_2 vis0
	JOIN dbp_data.tag_2 zeit0
		ON zeit0.dat = vis0.dat
	INNER JOIN zeit_2 
		ON zeit.kjmo = zeit0.kjmo 
	INNER JOIN wup_2 
		ON wup.wup_id = vis0.wup_id AND wup.mandant_id = vis0.mandant_id 
	WHERE wup.neo_gj < (zeit.gj -1)    /* Filiale muss 1 komplettes GJ geöffnet sein */
		AND wup.stl_dat > zeit.max_dat /* ohne Schließungsmonat */
		AND wup.aus_fg = 0             /* ohne Ausschluss (komplett) */
	GROUP BY ALL
) vistag
	ON vistag.wup_id = vis.wup_id AND vistag.mandant_id = vis.mandant_id AND vistag.gj = vis.gj
	AND vistag.wrg_id = vis.wrg_id 

/* vis_wg : HWG Umsatz für Backshop und Obst & Gemüse */
LEFT OUTER JOIN (
	SELECT vis0.mandant_id, vis0.wrg_id
		, wup.aktuell_wup_id AS wup_id
		, zeit.gj
		, SUM(CASE WHEN owg.hwg_id = 62 THEN vis0.ums_netto     ELSE 0 END) AS ums_bs_ist
		, SUM(CASE WHEN owg.hwg_id = 64 THEN vis0.ums_netto     ELSE 0 END) AS ums_og_ist
		, SUM(CASE WHEN owg.hwg_id = 62 THEN vis0.ums_netto_kvj ELSE 0 END) AS ums_bs_kvj
		, SUM(CASE WHEN owg.hwg_id = 64 THEN vis0.ums_netto_kvj ELSE 0 END) AS ums_og_kvj
	FROM dbp_msi_view_vis.MV_VIS_MONAT_FAKT_WG_2 vis0
	JOIN dbp_msi_view_vis.MV_WG_INT_2	wg
		ON vis0.wg_id = wg.wg_id
	JOIN dbp_msi_view_vis.MV_OWG_INT_2 owg
		ON wg.owg_id = owg.owg_id
	INNER JOIN zeit_2 
		ON zeit.kjmo = vis0.kjmo 
	INNER JOIN wup_2 
		ON wup.wup_id = vis0.wup_id AND wup.mandant_id = vis0.mandant_id 
	WHERE wup.neo_gj < (zeit.gj -1)    /* Filiale muss 1 komplettes GJ geöffnet sein */
		AND wup.stl_dat > zeit.max_dat /* ohne Schließungsmonat */
		AND wup.aus_fg = 0             /* ohne Ausschluss (komplett) */
		AND owg.hwg_id IN (62, 64) /* 62 Backshop + 64 Obst & Gemüse */ 
	GROUP BY ALL
) vishwg
	ON vishwg.wup_id = vis.wup_id AND vishwg.mandant_id = vis.mandant_id AND vishwg.gj = vis.gj
	AND vishwg.wrg_id = vis.wrg_id 

/* vis_abs : Abschriften_2 */
LEFT OUTER JOIN (
	SELECT vis0.mandant_id
		, wup.aktuell_wup_id AS wup_id
		, vis0.wrg_id
		, zeit.gj
		, SUM(CASE 
			WHEN vis0.mandant_id IN (6)         AND vis0.abschriftart_id = 2  THEN 1 
			WHEN vis0.mandant_id IN (3)         AND vis0.abschriftart_id = 11 THEN 1 
			WHEN vis0.mandant_id IN (2,4,5,7,8) AND vis0.abschriftart_id = 7  THEN 1 
			WHEN vis0.mandant_id IN (2,5)       AND vis0.abschriftart_id = 10 THEN 1 
			WHEN vis0.mandant_id NOT IN (1)     AND vis0.abschriftart_id = 20 THEN 1 
			ELSE -1 END * vis0.abschrift_netto) AS abs_op_ist
	FROM dbp_msi_view_vis.MV_VIS_TAG_ABSCHRIFTEN_WG_2 vis0
	JOIN dbp_msi_view_vis.MV_ABSCHRIFTART_INT_ZU_2 abs_art
		ON abs_art.abschriftart_id = vis0.abschriftart_id AND abs_art.mandant_id = vis0.mandant_id 
	JOIN dbp_msi_view_vis.MV_ABSCHRIFTART_INT_THEMA_ZU_2 abs_thema
		ON abs_thema.abschriftart_int_id = abs_art.abschriftart_int_id
	INNER JOIN zeit_2 
		ON zeit.kjmo = vis0.kjmo 
	INNER JOIN wup_2 
		ON wup.wup_id = vis0.wup_id AND wup.mandant_id = vis0.mandant_id 
	WHERE wup.neo_gj < (zeit.gj -1)    /* Filiale muss 1 komplettes GJ geöffnet sein */
		AND wup.stl_dat > zeit.max_dat /* ohne Schließungsmonat */
		AND wup.aus_fg = 0             /* ohne Ausschluss (komplett) */
		AND abs_thema.abschriftart_thema_int_id IN (1, 4) /* 1 Totalabschriften + 4 Preisänderungen */ 
	GROUP BY ALL
) visabs
	ON visabs.wup_id = vis.wup_id AND visabs.mandant_id = vis.mandant_id AND visabs.gj = vis.gj
	AND visabs.wrg_id = vis.wrg_id 

/* plan_owg : Plan Abschriften_2 (Währung in mv_view) */
LEFT OUTER JOIN (
	SELECT vis0.mandant_id
		, wup.aktuell_wup_id AS wup_id
		, vis0.wrg_id 
		, zeit.gj
		, SUM(vis0.abschriften_netto_operativ_plan) AS abs_owg_plan
		, SUM(vis0.umsatz_netto_plan) AS ums_owg_plan
	FROM dbp_msi_view_vis.mv_wup_plan_kjmo_owg_2 vis0
	INNER JOIN zeit_2 
		ON zeit.kjmo = vis0.kjmo 
	INNER JOIN wup_2 
		ON wup.wup_id = vis0.wup_id AND wup.mandant_id = vis0.mandant_id 
	WHERE wup.neo_gj < (zeit.gj -1)    /* Filiale muss 1 komplettes GJ geöffnet sein */
		AND wup.stl_dat > zeit.max_dat /* ohne Schließungsmonat */
		AND wup.aus_fg = 0             /* ohne Ausschluss (komplett) */
	GROUP BY ALL
) planowg
	ON planowg.wup_id = vis.wup_id AND planowg.mandant_id = vis.mandant_id AND planowg.gj = vis.gj
	AND planowg.wrg_id = vis.wrg_id 

/* vis_rekl : Kundengarantie Warten Kasse/Theke (Logik in mv_view) */
LEFT OUTER JOIN ( 
	SELECT vis0.mandant_id
		, wup.aktuell_wup_id AS wup_id
		, vis0.wrg_id
		, zeit.gj
		, SUM(CASE WHEN reklamationsgrund_id = 91 THEN vk_menge_kuga ELSE 0 END) wtheke
		, SUM(CASE WHEN reklamationsgrund_id = 92 THEN vk_menge_kuga ELSE 0 END) wkasse
	FROM dbp_msi_view_vis.MV_VIS_TAG_REKL_ART_2 vis0
	JOIN dbp_data.tag_2 zeit0
		ON zeit0.dat = vis0.dat
	INNER JOIN zeit_2 
		ON zeit.kjmo = zeit0.kjmo 
	INNER JOIN wup_2 
		ON wup.wup_id = vis0.wup_id AND wup.mandant_id = vis0.mandant_id 
	WHERE wup.neo_gj < (zeit.gj -1)    /* Filiale muss 1 komplettes GJ geöffnet sein */
		AND wup.stl_dat > zeit.max_dat /* ohne Schließungsmonat */
		AND wup.aus_fg = 0             /* ohne Ausschluss (komplett) */
	GROUP BY ALL
) rekl_2
	ON rekl.mandant_id = vis.mandant_id AND rekl.wup_id = vis.wup_id AND rekl.gj = vis.gj
	AND rekl.wrg_id = vis.wrg_id 

/* wupcal_2 : Kunden/Kundenkarte IST (ohne WRG_2) */
LEFT OUTER JOIN (
	SELECT vis0.mandant_id
		, wup.aktuell_wup_id AS wup_id
		, zeit.gj
		, SUM(bonanzahl_sug)                 AS bonanz
		, SUM(bonanzahl_kundenkarte)         AS kundenkarte
		, SUM(bonanzahl_kundenkarte_payback) AS payback
		, kundenkarte - ZEROIFNULL(payback)  AS bonkcard 
	FROM dbp_data.wupcal_2 vis0
	JOIN dbp_data.tag_2 zeit0
		ON zeit0.dat = vis0.dat
	INNER JOIN zeit_2 
		ON zeit.kjmo = zeit0.kjmo 
	INNER JOIN wup_2 
		ON wup.wup_id = vis0.wup_id AND wup.mandant_id = vis0.mandant_id 
	WHERE wup.neo_gj < (zeit.gj -1)    /* Filiale muss 1 komplettes GJ geöffnet sein */
		AND wup.stl_dat > zeit.max_dat /* ohne Schließungsmonat */
		AND wup.aus_fg = 0             /* ohne Ausschluss (komplett) */
	GROUP BY ALL
) wcal
	ON wcal.mandant_id = vis.mandant_id AND wcal.wup_id = vis.wup_id AND wcal.gj = vis.gj

/* wupcal_2 : Kunden/Kundenkarte KVJ (ohne WRG_2) */
LEFT OUTER JOIN ( 
SELECT vis0.mandant_id
	, wup.aktuell_wup_id AS wup_id
	, zeit.gj /* Transformation Projektion IST */
	, SUM(bonanzahl_sug)                 AS bonanz
	, SUM(bonanzahl_kundenkarte)         AS kundenkarte
	, SUM(bonanzahl_kundenkarte_payback) AS payback
	, kundenkarte - ZEROIFNULL(payback)  AS bonkcard 
	FROM dbp_data.wupcal_2 vis0
	JOIN dbp_data.tag_2 zeit0
		ON zeit0.dat = vis0.dat
	INNER JOIN zeit_2 
		ON zeit.kjmo_vj = zeit0.kjmo /* Transformation Mapping KVJ */
	INNER JOIN wup_2 
		ON wup.wup_id = vis0.wup_id AND wup.mandant_id = vis0.mandant_id 
	WHERE wup.neo_gj < (zeit.gj -1)    /* Filiale muss 1 komplettes GJ geöffnet sein */
		AND wup.stl_dat > zeit.max_dat /* ohne Schließungsmonat */
		AND wup.aus_fg = 0             /* ohne Ausschluss (komplett) */
	GROUP BY ALL
) wcal_kvj
	ON wcal_kvj.mandant_id = vis.mandant_id AND wcal_kvj.wup_id = vis.wup_id AND wcal_kvj.gj = vis.gj

/* kfl_retail_store_mo_sum_2 - Google Reviews historisiert > Daten ab Jan 2024 (ohne WRG_2) */
LEFT OUTER JOIN (
	SELECT vis0.mandant_id
		, wup.aktuell_wup_id AS wup_id
		, zeit.gj
		, SUM(vis0.sum_review_rating) AS sum_review_rating
		, SUM(vis0.anz_review_rating) AS anz_review_rating
	FROM DBP_MSI_DATA.KFL_RETAIL_STORE_MO_SUM_2 vis0
	INNER JOIN zeit_2 
		ON zeit.kjmo = vis0.kjmo 
	INNER JOIN wup_2 
		ON wup.wup_id = vis0.wup_id AND wup.mandant_id = vis0.mandant_id 
	WHERE wup.neo_gj < (zeit.gj -1)    /* Filiale muss 1 komplettes GJ geöffnet sein */
		AND wup.stl_dat > zeit.max_dat /* ohne Schließungsmonat */
		AND wup.aus_fg = 0             /* ohne Ausschluss (komplett) */
	GROUP BY ALL
) ggl 
	ON ggl.wup_id = vis.wup_id AND ggl.mandant_id = vis.mandant_id AND ggl.gj = vis.gj 

/* kmr_kurzcheck NEU : Filialbewertung Gesamt (alt/NEU) kcg (mv_view / ohne WRG_2)*/
LEFT OUTER JOIN (  
	SELECT vis0.mandant_id
	, vis0.wup_id
	, zeit.gj
	, SUM(vis0.kmr_gesamt_nok) AS kcg_nok_anz
	, SUM(vis0.kmr_gesamt_ges) AS kcg_anz
	FROM dbp_msi_view_vis.mv_kmr_filialbewertung_gesamt_2 vis0
	INNER JOIN zeit_2 
		ON zeit.kjmo = vis0.kjmo 
	INNER JOIN wup_2 
		ON wup.wup_id = vis0.wup_id AND wup.mandant_id = vis0.mandant_id 
	WHERE wup.neo_gj < (zeit.gj -1)    /* Filiale muss 1 komplettes GJ geöffnet sein */
		AND wup.stl_dat > zeit.max_dat /* ohne Schließungsmonat */
		AND wup.aus_fg = 0             /* ohne Ausschluss (komplett) */
	GROUP BY ALL
) kcg
	ON kcg.mandant_id = vis.mandant_id AND kcg.wup_id = vis.wup_id AND kcg.gj = vis.gj
;