create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_VIS.MV_EXPORT_TAGESUMSATZ_KW_TAG(
	MANDANT_ID,
	BB_FG,
	LAND_ID,
	LAND_SORT,
	WRG_ID,
	DAT,
	DAT_WVJ,
	UMSATZ_NETTO_IST,
	UMSATZ_NETTO_BEREINIGT_IST,
	UMSATZ_NETTO_PLAN,
	ANZAHL_KUNDEN_IST,
	ANZAHL_KUNDEN_BEREINIGT_IST,
	ABSATZ_OHNE_PFAND_IST,
	ABSATZ_OHNE_PFAND_BEREINIGT_IST,
	UMSATZ_NETTO_WVJ,
	UMSATZ_NETTO_BEREINIGT_WVJ,
	ANZAHL_KUNDEN_WVJ,
	ANZAHL_KUNDEN_BEREINIGT_WVJ,
	ABSATZ_OHNE_PFAND_WVJ,
	ABSATZ_OHNE_PFAND_BEREINIGT_WVJ
) as

/*
	FAKT : Export des KL_VIS Tagesumsatz KW (BB-Bericht) 
	Version Tag : Tageswerte (komplettes GJ + Vorwoche/Folgewoche)
	2026-02-03 ssch0611 Initial AP0298917 
*/


/* CTE */

WITH 
  wup AS ( 
	/* Standard Filter Filialen , definierte ZF, ohne Ausschluss */
	SELECT wup.mandant_id
		, wup.land_id
		, man.mandant_sort_id AS land_sort
		, wup.nb_id
		, wup.vs_id
		, wup.wup_id
		, wup.dat_eroeffnung AS neo_dat
		, wup.dat_bis        AS stl_dat
		, IFF(CURRENT_DATE() - 1 BETWEEN neo_dat AND stl_dat, 1, 0) AS offen_fg /* geöffnete Filialen */
		, IFF((wup.mandant_id = 1 AND wup.wup_id IN (1263,3166,5876,6623,8308,8563,8940)) OR (wup.mandant_id = 7 AND wup.wup_id IN (1410,6210,6310,6410)), 0, 1) AS aus_fg /* Ausschluss Getränkemärkte + Zeltverkauf */
		, IFF(wup.nb_id = 0, offen_fg * aus_fg, 0) AS zaehl_fg /* Zählung geöffnete Filialen (ohne Auschluss, ohne ZF) */
	FROM DBP_MSI_VIEW_VIS.MV_WUP wup
	JOIN DBP_MSI_VIEW_VIS.MV_MANDANT man
	ON man.mandant_id = wup.mandant_id
	WHERE wup.dat_eroeffnung < '2090-12-31' AND wup.dat_bis > CURRENT_DATE() - 731 /* ohne Dummies, inkl Schließungen im VGJ */
	AND (wup.nb_id = 0 OR wup.wup_id IN (0,2,22,28,43,46,124, 8980,8987,8991, 100000,100002,100022,100028,100043,100046,100124)) /* Filialen  + definierte ZF */
) 
, zeit AS (
	/* Zeitfilter Aktuelles GJ (bis gestern) */
	SELECT zeit.dat
		, zeit.akt_tag
		, zeit.kjwo
		, zeit.akt_wo
		, zeit.akt_wo_komplett
		, zeit.wo_dat_von
		, zeit.wo_dat_bis
		, zeit.akt_gj
	FROM DBP_MSI_VIEW_VIS.MV_TAG zeit
	WHERE zeit.akt_gj = 0 OR zeit.akt_wo BETWEEN -1 AND 1
) 
, check_bb AS (
	/* Blackberry Prüfung */
	SELECT zeit.dat
		, cbb.mandant_id
		, cbb.bb_fg
		, cbb.check_fg
	FROM zeit 
	INNER JOIN DBP_MSI_DATA.CHECK_BLACKBERRY cbb
	ON cbb.dat = zeit.dat
) 
, vis AS (
	/* Umsatz IST, Plan, WVJ (Tageswerte) */
	SELECT vis.mandant_id
		, wup.land_id
		, wup.land_sort
		, vis.wrg_id
		, vis.dat
		, vis.dat-364 AS dat_wvj
		, COALESCE(check_bb.bb_fg, 1) AS bb_plan
		, COALESCE(check_bb.bb_fg, 0) AS bb_ist
		, SUM(vis.ums_netto)      AS umsatz_netto_ist
		, SUM(vis.ums_netto_plan) AS umsatz_netto_plan
		, SUM(vis.ums_netto_wvj)  AS umsatz_netto_wvj
		, SUM(vis.anz_kunde)      AS anzahl_kunden_ist
		, SUM(vis.anz_kunde_wvj)  AS anzahl_kunden_wvj
		, SUM(vis.ums_netto     * IFF(zeit.wo_dat_von > wup.neo_dat + 364 AND zeit.wo_dat_bis < wup.stl_dat, 1.00, 0)) AS umsatz_netto_bereinigt_ist
		, SUM(vis.ums_netto_wvj * IFF(zeit.wo_dat_von > wup.neo_dat + 364 AND zeit.wo_dat_bis < wup.stl_dat, 1.00, 0)) AS umsatz_netto_bereinigt_wvj
		, SUM(vis.anz_kunde     * IFF(zeit.wo_dat_von > wup.neo_dat + 364 AND zeit.wo_dat_bis < wup.stl_dat, 1.00, 0)) AS anzahl_kunden_bereinigt_ist
		, SUM(vis.anz_kunde_wvj * IFF(zeit.wo_dat_von > wup.neo_dat + 364 AND zeit.wo_dat_bis < wup.stl_dat, 1.00, 0)) AS anzahl_kunden_bereinigt_wvj
	FROM DBP_MSI_VIEW_VIS.MV_VIS_TAG_FAKT_WUP vis
	INNER JOIN wup
	ON wup.mandant_id = vis.mandant_id AND wup.wup_id = vis.wup_id
	INNER JOIN zeit
	ON zeit.dat = vis.dat
	LEFT JOIN check_bb
	ON check_bb.mandant_id = vis.mandant_id AND check_bb.dat = vis.dat
	GROUP BY ALL
) 
, vis_wg AS (
	/* Absatz Umsatz IST, Plan, WVJ (Tageswerte) */
	SELECT vis.mandant_id
		, vis.wrg_id
		, vis.dat
		, SUM(vis.menge)     AS absatz_ohne_pfand_ist
		, SUM(vis.menge_wvj) AS absatz_ohne_pfand_wvj
		, SUM(vis.menge     * IFF(zeit.wo_dat_von > wup.neo_dat + 364 AND zeit.wo_dat_bis < wup.stl_dat, 1.00, 0)) AS absatz_ohne_pfand_bereinigt_ist
		, SUM(vis.menge_wvj * IFF(zeit.wo_dat_von > wup.neo_dat + 364 AND zeit.wo_dat_bis < wup.stl_dat, 1.00, 0)) AS absatz_ohne_pfand_bereinigt_wvj
	FROM DBP_MSI_VIEW_VIS.MV_VIS_TAG_FAKT_WG vis
	INNER JOIN wup
	ON wup.mandant_id = vis.mandant_id AND wup.wup_id = vis.wup_id
	INNER JOIN zeit
	ON zeit.dat = vis.dat
	WHERE vis.wg_id NOT IN (980,981,982,983,984,985,986,987,988,989)
	GROUP BY ALL
) 


/* MAIN */

SELECT vis.mandant_id /* KFL mandant_id */
	, check_bb.bb_fg  /* 1 = Daten sind freigegeben*/
	, vis.land_id     /* Land (ISO) */
	, vis.land_sort   /* Sortierung der K Länder */
	, vis.wrg_id      /*  EUR (Berichtskurs) + Landeswährung */
	, vis.dat         /* Datum (aktuell) */
	, vis.dat_wvj     /* Datum im Vorjahr (Wochentagsvergleich, IST-364 Tage) */
	, vis.umsatz_netto_ist
	, vis.umsatz_netto_bereinigt_ist
	, vis.umsatz_netto_plan
	, vis.anzahl_kunden_ist
	, vis.anzahl_kunden_bereinigt_ist
	, vis_wg.absatz_ohne_pfand_ist
	, vis_wg.absatz_ohne_pfand_bereinigt_ist
	, vis.umsatz_netto_wvj
	, vis.umsatz_netto_bereinigt_wvj
	, vis.anzahl_kunden_wvj
	, vis.anzahl_kunden_bereinigt_wvj
	, vis_wg.absatz_ohne_pfand_wvj
	, vis_wg.absatz_ohne_pfand_bereinigt_wvj
FROM vis
INNER JOIN vis_wg
ON vis_wg.mandant_id = vis.mandant_id AND vis_wg.wrg_id = vis.wrg_id AND vis_wg.dat = vis.dat
INNER JOIN check_bb
ON check_bb.mandant_id = vis.mandant_id AND check_bb.dat = vis.dat
;
