create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_VIS.MV_EXPORT_TAGESUMSATZ_KW_ZEITRAUM(
	MANDANT_ID,
	BB_FG,
	LAND_ID,
	LAND_SORT,
	WRG_ID,
	ZEIT_ID,
	ZEIT_SORT,
	ZEIT_BEZ,
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
	Version Zeitraum : Analog Berichtslayout (verdichtet auf einzelne Zeiträum)
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
, zeitraum AS (
	/* Zeitfilter Zeitraum (analog Bericht) */
	SELECT ztag.zeit_id
		, zspr.zeit_tag_sort
		, zspr.zeit_bez
		, ttt.dat
		, ttt.akt_tag
		, ttt.kjwo
		, ttt.akt_wo
		, ttt.wo_dat_von
		, ttt.wo_dat_bis
		, ttt.akt_gj
	FROM DBP_MSI_VIEW_VIS.MV_ZEIT_TAG_ZU ztag
	INNER JOIN DBP_MSI_VIEW_VIS.MV_TAG ttt
	ON ttt.dat = ztag.dat
	INNER JOIN  DBP_MSI_VIEW_VIS.MV_ZEIT_SPR_ZU zspr
	ON zspr.zeit_id = ztag.zeit_id
	WHERE ztag.zeit_id NOT IN (-120, -200, -190, -180, -170, -160, -150, -140, -130, 100, 110, 120, 130) 
	AND zspr.zeit_tag_sort <> 9999
) 
, check_bb AS (
	/* Blackberry Prüfung */
	SELECT cbb.dat
		, cbb.mandant_id
		, cbb.bb_fg
		, cbb.check_fg
	FROM DBP_MSI_DATA.CHECK_BLACKBERRY cbb
	INNER JOIN DBP_MSI_VIEW_VIS.MV_TAG ttt
	ON ttt.dat = cbb.dat
	WHERE ttt.akt_tag = 0
) 
, vis AS (
	/* Umsatz IST, Plan, WVJ (Tageswerte) */
	SELECT vis.mandant_id
		, wup.land_id
		, wup.land_sort
		, vis.wrg_id
		, zeitraum.zeit_id
		, zeitraum.zeit_tag_sort AS zeit_sort
		, zeitraum.zeit_bez
		, SUM(vis.ums_netto)      AS umsatz_netto_ist
		, SUM(vis.ums_netto_plan) AS umsatz_netto_plan
		, SUM(vis.ums_netto_wvj)  AS umsatz_netto_wvj
		, SUM(vis.anz_kunde)      AS anzahl_kunden_ist
		, SUM(vis.anz_kunde_wvj)  AS anzahl_kunden_wvj
		, SUM(vis.ums_netto     * IFF(zeitraum.wo_dat_von > wup.neo_dat + 364 AND zeitraum.wo_dat_bis < wup.stl_dat, 1.00, 0)) AS umsatz_netto_bereinigt_ist
		, SUM(vis.ums_netto_wvj * IFF(zeitraum.wo_dat_von > wup.neo_dat + 364 AND zeitraum.wo_dat_bis < wup.stl_dat, 1.00, 0)) AS umsatz_netto_bereinigt_wvj
		, SUM(vis.anz_kunde     * IFF(zeitraum.wo_dat_von > wup.neo_dat + 364 AND zeitraum.wo_dat_bis < wup.stl_dat, 1.00, 0)) AS anzahl_kunden_bereinigt_ist
		, SUM(vis.anz_kunde_wvj * IFF(zeitraum.wo_dat_von > wup.neo_dat + 364 AND zeitraum.wo_dat_bis < wup.stl_dat, 1.00, 0)) AS anzahl_kunden_bereinigt_wvj
	FROM DBP_MSI_VIEW_VIS.MV_VIS_TAG_FAKT_WUP vis
	INNER JOIN wup
	ON wup.mandant_id = vis.mandant_id AND wup.wup_id = vis.wup_id
	INNER JOIN zeitraum
	ON zeitraum.dat = vis.dat
	GROUP BY ALL
) 
, vis_wg AS (
	/* Absatz Umsatz IST, Plan, WVJ (Tageswerte) */
	SELECT vis.mandant_id
		, wup.land_id
		, vis.wrg_id
		, zeitraum.zeit_id
		, SUM(vis.menge)     AS absatz_ohne_pfand_ist
		, SUM(vis.menge_wvj) AS absatz_ohne_pfand_wvj
		, SUM(vis.menge     * IFF(zeitraum.wo_dat_von > wup.neo_dat + 364 AND zeitraum.wo_dat_bis < wup.stl_dat, 1.00, 0)) AS absatz_ohne_pfand_bereinigt_ist
		, SUM(vis.menge_wvj * IFF(zeitraum.wo_dat_von > wup.neo_dat + 364 AND zeitraum.wo_dat_bis < wup.stl_dat, 1.00, 0)) AS absatz_ohne_pfand_bereinigt_wvj
	FROM DBP_MSI_VIEW_VIS.MV_VIS_TAG_FAKT_WG vis
	INNER JOIN wup
	ON wup.mandant_id = vis.mandant_id AND wup.wup_id = vis.wup_id
	INNER JOIN zeitraum
	ON zeitraum.dat = vis.dat
	WHERE vis.wg_id NOT IN (980,981,982,983,984,985,986,987,988,989) /* ohne Pfand */
	GROUP BY ALL
) 


/* MAIN */

SELECT vis.mandant_id /* KFL mandant_id */
	, check_bb.bb_fg  /* 1 = Daten sind freigegeben*/
	, vis.land_id     /* Land (ISO) */
	, vis.land_sort   /* Sortierung der K Länder */
	, vis.wrg_id      /* EUR (Berichtskurs) + Landeswährung */
	, vis.zeit_id     /* Zeitraum: Tag, Woche (aufg.), Monat (aufg.), GJ (aufg.)*/
	, vis.zeit_sort   /* Zeitraum: Berichtssortierung */
	, vis.zeit_bez    /* Zeitraum: Bezeichnung */
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
ON vis_wg.mandant_id = vis.mandant_id AND vis_wg.wrg_id = vis.wrg_id AND vis_wg.zeit_id = vis.zeit_id
INNER JOIN check_bb
ON check_bb.mandant_id = vis.mandant_id
;
