CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_VIS_MONAT_FILIALWETTBEWERB_WUP_2(
	MANDANT_ID,
	NB_ID,
	VS_ID,
	WUP_ID,
	WRG_ID,
	GJ,
	KJMO,
	MDM_OFFEN,
	MDM_UMS_NETTO_IST,
	MDM_UMS_NETTO_PLAN,
	MDM_UMS_NETTO,
	MDM_UMS_NETTO_RANK,
	MDM_UMS_NETTO_DENSE,
	MDM_UMS_TAG_IST,
	MDM_UMS_TAG_KVJ,
	MDM_UMS_OG_IST,
	MDM_UMS_OG_KVJ,
	MDM_UMS_ANTEIL_OG_IST,
	MDM_UMS_ANTEIL_OG_KVJ,
	MDM_UMS_ANTEIL_OG,
	MDM_UMS_ANTEIL_OG_RANK,
	MDM_UMS_ANTEIL_OG_DENSE,
	MDM_UMS_BS_IST,
	MDM_UMS_BS_KVJ,
	MDM_UMS_ANTEIL_BS_IST,
	MDM_UMS_ANTEIL_BS_KVJ,
	MDM_UMS_ANTEIL_BS,
	MDM_UMS_ANTEIL_BS_RANK,
	MDM_UMS_ANTEIL_BS_DENSE,
	MDM_ABS_OP_IST,
	MDM_ABS_OWG_PLAN,
	MDM_UMS_OWG_PLAN,
	MDM_ABSCHRIFT_OP_IST,
	MDM_ABSCHRIFT_OP_PLAN,
	MDM_ABSCHRIFT_OP,
	MDM_ABSCHRIFT_OP_RANK,
	MDM_ABSCHRIFT_OP_DENSE,
	MDM_NETTOSTD_IST,
	MDM_NETTOSTD_PLAN,
	MDM_NETTOLEIST_IST,
	MDM_NETTOLEIST_PLAN,
	MDM_NETTOLEIST,
	MDM_NETTOLEIST_RANK,
	MDM_NETTOLEIST_DENSE,
	MDM_WARTEN_KASSE,
	MDM_WARTEN_KASSE_RANK,
	MDM_WARTEN_KASSE_DENSE,
	MDM_WARTEN_THEKE,
	MDM_WARTEN_THEKE_RANK,
	MDM_WARTEN_THEKE_DENSE,
	MDM_BONANZAHL,
	MDM_BON_KCARD,
	MDM_KCARD,
	MDM_KCARD_RANK,
	MDM_KCARD_DENSE,
	MDM_BONANZAHL_IST,
	MDM_BON_KCARD_IST,
	MDM_BONANZAHL_KVJ,
	MDM_BON_KCARD_KVJ,
	MDM_KCARD_IST,
	MDM_KCARD_KVJ,
	MDM_KCARD_DELTA,
	MDM_KCARD_DELTA_RANK,
	MDM_KCARD_DELTA_DENSE,
	MDM_GOOGLE_SUM,
	MDM_GOOGLE_ANZ,
	MDM_GOOGLE,
	MDM_GOOGLE_RANK,
	MDM_GOOGLE_DENSE,
	MDM_KCG_ANZ,
	MDM_KCG_NOK_ANZ,
	MDM_KCG_NOK,
	MDM_KCG_NOK_RANK,
	MDM_KCG_NOK_DENSE,
	MDM_KC_FESTSTELL,
	MDM_KC_GESAMT,
	MDM_KC_NOK,
	MDM_KC_NOK_RANK,
	MDM_KC_NOK_DENSE,
	MDM_KFB_FESTSTELL,
	MDM_KFB_GESAMT,
	MDM_KFB_NOK,
	MDM_KFB_NOK_RANK,
	MDM_KFB_NOK_DENSE
) AS 

/*
	FAKT DENORM : Filialwettbewerb Markt des Monats 
	2023-03-08 ssch0611 : Updated. Dense ranking with filter. AP0154666 
	2023-04-14 ssch0611 : Update. Filter GJ2023 (CZ) + Definition K-Card (PL)
	2024-03-11 ssch0611 : Update GJ2024. Umsatzanteil O&G/Backshop, K-Card Delta , Google [AP0195212]
	2024-03-21 ssch0611 : Ausschluss SK1420 (202402)
	2024-04-08 ssch0611 : Filialfilter GJ2024
	2024-06-20 muellerpatri : Filialumgliederung [P1760-DWH]
	2024-08-15 muellerpatri: Ausschluss D1430 - Anfrage Fachbereich
	2024-11-14 muellerpatri : Filialausschluss mandant_id = 2 AND wup.wup_id IN (1700, 6800) AND vis0.kjmo > 202409
	2025-01-30 muellerpatri : Erweiterung um neuen Kurzcheck Gesamt (KCG)
	2025-04-10 ssch0611 : Anpassung Filter GJ2025. Basis CTE. Deaktivierung/NULL von KFB/KC (alt) [NSR5150325][AP0263138]
	2025-04-23 ssch0611 : Fix Zeit_2 Filter NEO
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
		/* Ausschluss Markt des Monats -- 2025-04 */
		/* Ausschluss CZ (temporär) 2 Filialen von 202409 bis 202602 */
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
	, vis.kjmo
	, vis.offen_ist AS MDM_offen
	/* 01 Umsatz netto - Delta Plan DESC */
	, vis.ums_netto_ist  AS MDM_ums_netto_ist
	, vis.ums_netto_plan AS MDM_ums_netto_plan
	, (MDM_ums_netto_ist - MDM_ums_netto_plan) / NULLIFZERO(MDM_ums_netto_plan) AS MDM_ums_netto
	, RANK ()       OVER (PARTITION BY vis.mandant_id, vis.vs_id, vis.wrg_id, vis.kjmo ORDER BY MDM_ums_netto DESC NULLS LAST) AS MDM_ums_netto_rank
	, DENSE_RANK () OVER (PARTITION BY vis.mandant_id, vis.vs_id, vis.wrg_id, vis.kjmo ORDER BY MDM_ums_netto DESC NULLS LAST) AS MDM_ums_netto_dense
	/* 02 Umsatzanteil Obst und Gemüse - Delta VJ DESC */
	, vistag.ums_tag_ist AS MDM_ums_tag_ist
	, vistag.ums_tag_kvj AS MDM_ums_tag_kvj
	, vishwg.ums_og_ist  AS MDM_ums_og_ist
	, vishwg.ums_og_kvj  AS MDM_ums_og_kvj
	, MDM_ums_og_ist / NULLIFZERO(MDM_ums_tag_ist) AS MDM_ums_anteil_og_ist
	, MDM_ums_og_kvj / NULLIFZERO(MDM_ums_tag_kvj) AS MDM_ums_anteil_og_kvj
	, MDM_ums_anteil_og_ist - NULLIFZERO(MDM_ums_anteil_og_kvj) AS MDM_ums_anteil_og
	, RANK () OVER (PARTITION BY vis.mandant_id, vis.vs_id, vis.wrg_id, vis.kjmo ORDER BY MDM_ums_anteil_og DESC NULLS LAST) AS MDM_ums_anteil_og_rank
	, DENSE_RANK () OVER (PARTITION BY vis.mandant_id, vis.vs_id, vis.wrg_id, vis.kjmo ORDER BY MDM_ums_anteil_og DESC NULLS LAST) AS MDM_ums_anteil_og_dense
	/* 03 Umsatzanteil Backshop - Delta VJ DESC */
	, vishwg.ums_bs_ist  AS MDM_ums_bs_ist
	, vishwg.ums_bs_kvj  AS MDM_ums_bs_kvj
	, MDM_ums_bs_ist / NULLIFZERO(MDM_ums_tag_ist) AS MDM_ums_anteil_bs_ist
	, MDM_ums_bs_kvj / NULLIFZERO(MDM_ums_tag_kvj) AS MDM_ums_anteil_bs_kvj
	, MDM_ums_anteil_bs_ist - NULLIFZERO(MDM_ums_anteil_bs_kvj) AS MDM_ums_anteil_bs
	, RANK () OVER (PARTITION BY vis.mandant_id, vis.vs_id, vis.wrg_id, vis.kjmo ORDER BY MDM_ums_anteil_bs DESC NULLS LAST) AS MDM_ums_anteil_bs_rank
	, DENSE_RANK () OVER (PARTITION BY vis.mandant_id, vis.vs_id, vis.wrg_id, vis.kjmo ORDER BY MDM_ums_anteil_bs DESC NULLS LAST) AS MDM_ums_anteil_bs_dense
	/* 04 Abschriften_2 operativ - Delta Plan DESC */
	, visabs.abs_op_ist    AS MDM_abs_op_ist
	, planowg.abs_owg_plan AS MDM_abs_owg_plan
	, planowg.ums_owg_plan AS MDM_ums_owg_plan
	, MDM_abs_op_ist / NULLIFZERO(MDM_ums_tag_ist)    AS MDM_abschrift_op_ist
	, MDM_abs_owg_plan / NULLIFZERO(MDM_ums_owg_plan) AS MDM_abschrift_op_plan
	, MDM_abschrift_op_ist - NULLIFZERO(MDM_abschrift_op_plan) AS MDM_abschrift_op
	, RANK () OVER (PARTITION BY vis.mandant_id, vis.vs_id, vis.wrg_id, vis.kjmo ORDER BY MDM_abschrift_op DESC NULLS LAST) AS MDM_abschrift_op_rank
	, DENSE_RANK () OVER (PARTITION BY vis.mandant_id, vis.vs_id, vis.wrg_id, vis.kjmo ORDER BY MDM_abschrift_op DESC NULLS LAST) AS MDM_abschrift_op_dense
	/* 05 Nettoleistung - Delta Plan DESC */
	, vis.nettostd_ist  AS MDM_nettostd_ist
	, vis.nettostd_plan AS MDM_nettostd_plan
	, vis.ums_netto_ist  / NULLIFZERO(vis.nettostd_ist)    AS MDM_nettoleist_ist
	, vis.ums_netto_plan / NULLIFZERO(vis.nettostd_plan)   AS MDM_nettoleist_plan
	, MDM_nettoleist_ist - NULLIFZERO(MDM_nettoleist_plan) AS MDM_nettoleist
	, RANK () OVER (PARTITION BY vis.mandant_id, vis.vs_id, vis.wrg_id, vis.kjmo ORDER BY MDM_nettoleist DESC NULLS LAST) AS MDM_nettoleist_rank
	, DENSE_RANK () OVER (PARTITION BY vis.mandant_id, vis.vs_id, vis.wrg_id, vis.kjmo ORDER BY MDM_nettoleist   DESC NULLS LAST) AS MDM_nettoleist_dense
	/* 06 Kundgarantie Anzahl Warten Kasse - Wert ASC DENSE */
	, rekl.wkasse AS MDM_warten_kasse
	, RANK () OVER (PARTITION BY vis.mandant_id, vis.vs_id, vis.wrg_id, vis.kjmo ORDER BY MDM_warten_kasse ASC NULLS LAST) AS MDM_warten_kasse_rank
	, DENSE_RANK () OVER (PARTITION BY vis.mandant_id, vis.vs_id, vis.wrg_id, vis.kjmo ORDER BY MDM_warten_kasse ASC  NULLS LAST) AS MDM_warten_kasse_dense
	/* 07 Kundgarantie Anzahl Warten Theke - Wert ASC DENSE */
	, rekl.wtheke AS MDM_warten_theke
	, RANK () OVER (PARTITION BY vis.mandant_id, vis.vs_id, vis.wrg_id, vis.kjmo ORDER BY MDM_warten_theke ASC  NULLS LAST) AS MDM_warten_theke_rank
	, DENSE_RANK () OVER (PARTITION BY vis.mandant_id, vis.vs_id, vis.wrg_id, vis.kjmo ORDER BY MDM_warten_theke ASC  NULLS LAST) AS MDM_warten_theke_dense
	/* 08 Kundenanteil K-Card - Wert DESC */
	, wcal.bonanz    AS MDM_bonanzahl
	, wcal.bonkcard  AS MDM_bon_kcard
	, MDM_bon_kcard / NULLIFZERO(MDM_bonanzahl) AS MDM_kcard
	, RANK () OVER (PARTITION BY vis.mandant_id, vis.vs_id, vis.wrg_id, vis.kjmo ORDER BY MDM_kcard DESC NULLS LAST) AS MDM_kcard_rank
	, DENSE_RANK () OVER (PARTITION BY vis.mandant_id, vis.vs_id, vis.wrg_id, vis.kjmo ORDER BY MDM_kcard DESC NULLS LAST) AS MDM_kcard_dense
	/* 09 Kundenanteil K-Card - Delta VJ DESC */
	, wcal.bonanz       AS MDM_bonanzahl_ist
	, wcal.bonkcard     AS MDM_bon_kcard_ist
	, wcal_kvj.bonanz   AS MDM_bonanzahl_kvj
	, wcal_kvj.bonkcard AS MDM_bon_kcard_kvj
	, MDM_bon_kcard_ist / NULLIFZERO(MDM_bonanzahl_ist) AS MDM_kcard_ist
	, MDM_bon_kcard_kvj / NULLIFZERO(MDM_bonanzahl_kvj) AS MDM_kcard_kvj
	, MDM_kcard_ist - MDM_kcard_kvj AS MDM_kcard_delta
	, RANK () OVER (PARTITION BY vis.mandant_id, vis.vs_id, vis.wrg_id, vis.kjmo ORDER BY MDM_kcard_delta DESC NULLS LAST) AS MDM_kcard_delta_rank
	, DENSE_RANK () OVER (PARTITION BY vis.mandant_id, vis.vs_id, vis.wrg_id, vis.kjmo ORDER BY MDM_kcard_delta DESC NULLS LAST) AS MDM_kcard_delta_dense  
	/* 10 Google Reviews Kaufland - Sterne DESC DENSE - ab Jan 2024 */
	, ggl.sum_review_rating AS MDM_google_sum
	, ggl.anz_review_rating AS MDM_google_anz
	, MDM_google_sum / NULLIFZERO(MDM_google_anz) AS MDM_google
	, RANK () OVER (PARTITION BY vis.mandant_id, vis.vs_id, vis.wrg_id, vis.kjmo ORDER BY MDM_google DESC NULLS LAST) AS MDM_google_rank
	, DENSE_RANK () OVER (PARTITION BY vis.mandant_id, vis.vs_id, vis.wrg_id, vis.kjmo ORDER BY MDM_google DESC NULLS LAST) AS MDM_google_dense
	/* 11 Kurzcheck Gesamt NEU - NOK% ASC DENSE -- Daten ab August 2024 >> Monatswerte aktuell nicht verwendet! */
	, kcg.kcg_anz     AS MDM_kcg_anz
	, kcg.kcg_nok_anz AS MDM_kcg_nok_anz
	, MDM_kcg_nok_anz / NULLIFZERO(MDM_kcg_anz) AS MDM_kcg_nok
	, RANK ()       OVER (PARTITION BY vis.mandant_id, vis.vs_id, vis.wrg_id, vis.kjmo ORDER BY MDM_kcg_nok ASC  NULLS LAST) AS MDM_kcg_nok_rank
	, DENSE_RANK () OVER (PARTITION BY vis.mandant_id, vis.vs_id, vis.wrg_id, vis.kjmo ORDER BY MDM_kcg_nok ASC  NULLS LAST) AS MDM_kcg_nok_dense
	/* 1x Kurzcheck KC_ALT - NOK% ASC DENSE -- Daten bis Juli 2024 */
	, NULL AS MDM_kc_feststell
	, NULL AS MDM_kc_gesamt
	, NULL AS MDM_kc_nok
	, NULL AS MDM_kc_nok_rank
	, NULL AS MDM_kc_nok_dense
	/* 1x Kundenfeedback KFB - NOK% ASC DENSE -- Daten bis Juli 2023 */
	, NULL MDM_kfb_feststell
	, NULL AS MDM_kfb_gesamt
	, NULL AS MDM_kfb_nok
	, NULL AS MDM_kfb_nok_rank
	, NULL AS MDM_kfb_nok_dense

/* vis_monat : Monatsumsatz und Nettostunden (Referenz) */
FROM (
	SELECT vis0.mandant_id, vis0.nb_id, wup.vs_id, vis0.wrg_id
		, wup.aktuell_wup_id AS wup_id
		, vis0.gj, vis0.kjmo
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
		AND wup.aus_fg <> 1            /* ohne Ausschluss */
		AND NOT (wup.aus_fg = 2 AND zeit.kjmo BETWEEN 202409 AND 202602) /* ohne temp. Ausschluss CZ */
	GROUP BY ALL
) vis 

/* vis_tag : Tagesumsatz für Abschriften_2 und Anteile */
INNER JOIN (
	SELECT vis0.mandant_id, vis0.wrg_id
		, wup.aktuell_wup_id AS wup_id
		, zeit.kjmo
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
		AND wup.aus_fg <> 1            /* ohne Ausschluss */
		AND NOT (wup.aus_fg = 2 AND zeit.kjmo BETWEEN 202409 AND 202602) /* ohne temp. Ausschluss CZ */
	GROUP BY ALL
) vistag
	ON vistag.wup_id = vis.wup_id AND vistag.mandant_id = vis.mandant_id AND vistag.wrg_id = vis.wrg_id 
	AND vistag.kjmo = vis.kjmo

/* vis_wg : HWG Umsatz für Backshop und Obst & Gemüse */
LEFT OUTER JOIN (
	SELECT vis0.mandant_id, vis0.wrg_id
		, wup.aktuell_wup_id AS wup_id
		, vis0.kjmo
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
		AND wup.aus_fg <> 1            /* ohne Ausschluss */
		AND NOT (wup.aus_fg = 2 AND zeit.kjmo BETWEEN 202409 AND 202602) /* ohne temp. Ausschluss CZ */
		AND owg.hwg_id IN (62, 64) /* 62 Backshop + 64 Obst & Gemüse */ 
	GROUP BY ALL
) vishwg
	ON vishwg.wup_id = vis.wup_id AND vishwg.mandant_id = vis.mandant_id AND vishwg.wrg_id = vis.wrg_id 
	AND vishwg.kjmo = vis.kjmo

/* vis_abs : Abschriften_2 */
LEFT OUTER JOIN (
	SELECT vis0.mandant_id, wup.aktuell_wup_id AS wup_id, vis0.wrg_id, vis0.kjmo
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
		AND wup.aus_fg <> 1            /* ohne Ausschluss */
		AND NOT (wup.aus_fg = 2 AND zeit.kjmo BETWEEN 202409 AND 202602) /* ohne temp. Ausschluss CZ */
		AND abs_thema.abschriftart_thema_int_id IN (1, 4) /* 1 Totalabschriften + 4 Preisänderungen */ 
	GROUP BY ALL
) visabs
	ON visabs.wup_id = vis.wup_id AND visabs.mandant_id = vis.mandant_id AND visabs.wrg_id = vis.wrg_id 
	AND visabs.kjmo = vis.kjmo

/* plan_owg : Plan Abschriften_2 (Währung in mv_view) */
LEFT OUTER JOIN (
	SELECT vis0.mandant_id, vis0.wrg_id 
		, wup.aktuell_wup_id AS wup_id
		, vis0.kjmo
		, SUM(vis0.abschriften_netto_operativ_plan) AS abs_owg_plan
		, SUM(vis0.umsatz_netto_plan) AS ums_owg_plan
	FROM dbp_msi_view_vis.mv_wup_plan_kjmo_owg_2 vis0
	INNER JOIN zeit_2 
		ON zeit.kjmo = vis0.kjmo 
	INNER JOIN wup_2 
		ON wup.wup_id = vis0.wup_id AND wup.mandant_id = vis0.mandant_id 
	WHERE wup.neo_gj < (zeit.gj -1)    /* Filiale muss 1 komplettes GJ geöffnet sein */
		AND wup.stl_dat > zeit.max_dat /* ohne Schließungsmonat */
		AND wup.aus_fg <> 1            /* ohne Ausschluss */
		AND NOT (wup.aus_fg = 2 AND zeit.kjmo BETWEEN 202409 AND 202602) /* ohne temp. Ausschluss CZ */
	GROUP BY ALL
) planowg
	ON planowg.wup_id = vis.wup_id AND planowg.mandant_id = vis.mandant_id AND planowg.wrg_id = vis.wrg_id 
	AND planowg.kjmo = vis.kjmo

/* vis_rekl : Kundengarantie Warten Kasse/Theke (Logik in mv_view) */
LEFT OUTER JOIN ( 
	SELECT vis0.mandant_id, vis0.wrg_id
		, wup.aktuell_wup_id AS wup_id
		, zeit.kjmo
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
		AND wup.aus_fg <> 1            /* ohne Ausschluss */
		AND NOT (wup.aus_fg = 2 AND zeit.kjmo BETWEEN 202409 AND 202602) /* ohne temp. Ausschluss CZ */
	GROUP BY ALL
) rekl_2
	ON rekl.mandant_id = vis.mandant_id AND rekl.wup_id = vis.wup_id AND rekl.wrg_id = vis.wrg_id 
	AND rekl.kjmo = vis.kjmo

/* wupcal_2 : Kunden/Kundenkarte IST (ohne WRG_2) */
LEFT OUTER JOIN (
	SELECT vis0.mandant_id
		, wup.aktuell_wup_id AS wup_id
		, zeit.kjmo
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
		AND wup.aus_fg <> 1            /* ohne Ausschluss */
		AND NOT (wup.aus_fg = 2 AND zeit.kjmo BETWEEN 202409 AND 202602) /* ohne temp. Ausschluss CZ */
	GROUP BY ALL
) wcal
	ON wcal.mandant_id = vis.mandant_id AND wcal.wup_id = vis.wup_id
	AND wcal.kjmo = vis.kjmo

/* wupcal_2 : Kunden/Kundenkarte KVJ (ohne WRG_2) */
LEFT OUTER JOIN ( 
SELECT vis0.mandant_id
	, wup.aktuell_wup_id AS wup_id
	, zeit.kjmo /* Transformation Projektion IST */
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
		AND wup.aus_fg <> 1            /* ohne Ausschluss */
		AND NOT (wup.aus_fg = 2 AND zeit.kjmo BETWEEN 202409 AND 202602) /* ohne temp. Ausschluss CZ */
	GROUP BY ALL
) wcal_kvj
	ON wcal_kvj.mandant_id = vis.mandant_id AND wcal_kvj.wup_id = vis.wup_id
	AND wcal_kvj.kjmo = vis.kjmo

/* kfl_retail_store_mo_sum_2 - Google Reviews historisiert > Daten ab Jan 2024 (ohne WRG_2) */
LEFT OUTER JOIN (
	SELECT vis0.mandant_id
		, wup.aktuell_wup_id AS wup_id
		, vis0.kjmo
		, SUM(vis0.sum_review_rating) AS sum_review_rating
		, SUM(vis0.anz_review_rating) AS anz_review_rating
	FROM DBP_MSI_DATA.KFL_RETAIL_STORE_MO_SUM_2 vis0
	INNER JOIN zeit_2 
		ON zeit.kjmo = vis0.kjmo 
	INNER JOIN wup_2 
		ON wup.wup_id = vis0.wup_id AND wup.mandant_id = vis0.mandant_id 
	WHERE wup.neo_gj < (zeit.gj -1)    /* Filiale muss 1 komplettes GJ geöffnet sein */
		AND wup.stl_dat > zeit.max_dat /* ohne Schließungsmonat */
		AND wup.aus_fg <> 1            /* ohne Ausschluss */
		AND NOT (wup.aus_fg = 2 AND zeit.kjmo BETWEEN 202409 AND 202602) /* ohne temp. Ausschluss CZ */
	GROUP BY ALL
) ggl 
	ON ggl.wup_id = vis.wup_id AND ggl.mandant_id = vis.mandant_id
	AND ggl.kjmo = vis.kjmo 

/* kmr_kurzcheck NEU : Filialbewertung Gesamt (alt/NEU) kcg (mv_view / ohne WRG_2)*/
LEFT OUTER JOIN (  
	SELECT vis0.mandant_id
	, vis0.wup_id
	, vis0.kjmo
	, SUM(vis0.kmr_gesamt_nok) AS kcg_nok_anz
	, SUM(vis0.kmr_gesamt_ges) AS kcg_anz
	FROM dbp_msi_view_vis.mv_kmr_filialbewertung_gesamt_2 vis0
	INNER JOIN zeit_2 
		ON zeit.kjmo = vis0.kjmo 
	INNER JOIN wup_2 
		ON wup.wup_id = vis0.wup_id AND wup.mandant_id = vis0.mandant_id 
	WHERE wup.neo_gj < (zeit.gj -1)    /* Filiale muss 1 komplettes GJ geöffnet sein */
		AND wup.stl_dat > zeit.max_dat /* ohne Schließungsmonat */
		AND wup.aus_fg <> 1            /* ohne Ausschluss */
		AND NOT (wup.aus_fg = 2 AND zeit.kjmo BETWEEN 202409 AND 202602) /* ohne temp. Ausschluss CZ */
	GROUP BY ALL
) kcg
	ON kcg.mandant_id = vis.mandant_id AND kcg.wup_id = vis.wup_id 
	AND kcg.kjmo = vis.kjmo
;