CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_VIS_JZG_FAKT_ZIELWERT_1(
	METRIK_ID,
	TYP_ID,
	LEVEL_ID,
	MANDANT_ID,
	NB_ID,
	WUP_ID,
	WRG_ID,
	GJ,
	EINGABE_GJ,
	KOMMENTAR_GJ,
	ZIELERREICHUNG,
	CHECK_GJ,
	ZIEL_GJ1,
	ZIEL_GJ2,
	ZIEL_GJ
) AS
/*
	JZG FAKT DENORM JZG : Jahreszielgespräch. Zielwerte + Kommentare
	2025-01-22 ssch0611 : Review 2025. Neue Metriken. VJ Ziel/Kommentare [AP0244672]
	2025-02-05 ssch0611 : Ergänzung Zentralfilialen. Check Personal [AP0244672]
	2025-03-31 ssch0611 : Final GJ2025. Umstellung Scans/min (KPOS) [AP0264011]
*/ 

/* CTE */

WITH monat_gj AS (
	/* Monatsebene GJ */
	SELECT gj
		, akt_gj
		, mo_kj
		, kjmo
	FROM DBP_VIEW.V_MONAT_1
	WHERE akt_gj = 0
	)
, tag_gj AS (
	/* Tagesebene GJ */
	SELECT gj
		, mo_kj
		, kjmo
		, dat
	FROM DBP_VIEW.V_TAG_1
	WHERE akt_gj = 0
	)
, wup_1 AS ( /* Filiale */
	SELECT wup.mandant_id, wup.nb_id, wup.wup_id
		, wup.aktuell_wup_id
		, wup.dat_eroeffnung
		, wup.dat_bis
		, COALESCE(wup.dat_eroeffnung_alt, wup.dat_eroeffnung) AS neo_dat
		, wup.dat_bis AS stl_dat
		, EXTRACT(YEAR FROM neo_dat) - IFF(EXTRACT(MONTH FROM neo_dat) < 3, 1, 0) AS neo_gj
		, EXTRACT(YEAR FROM stl_dat) - IFF(EXTRACT(MONTH FROM stl_dat) < 3, 1, 0) AS stl_gj
	FROM DBP_VIEW.V_WUP_1 wup_1
	WHERE (wup.nb_id = 0 OR wup.wup_id IN (0, 2, 22, 28, 43, 46, 124, 8980, 8987, 8991, 100000, 100002, 100022, 100028, 100043, 100046, 100124)) /* Filialen + definierte ZF */
	AND wup.dat_eroeffnung < '2090-12-31' /* fix */
	)

, ware AS (
	/* Mapping Ware + Level */
	SELECT abt.abt_id
		, hwg.hwg_id
		, owg.owg_id
		, CASE WHEN abt.abt_id = 4 THEN 9999999 /* Nebengeschäft ABT_1 */
			WHEN abt.abt_id = 5 THEN (abt.abt_id * 1000000 + ABS(hwg.hwg_id) * 10000 + ABS(owg.owg_id)) /* Ultra Frische OWG */
			WHEN abt.abt_id = 6 THEN (abt.abt_id * 1000000 + ABS(hwg.hwg_id) * 10000) /* Food Frische HWG */
			ELSE abt.abt_id * 1000000 /* Food + Nonfood ABT_1 */
			END::INTEGER AS level_owg
		, CASE WHEN abt.abt_id = 4 THEN 9999999 /* Nebengeschäft ABT_1 */
			WHEN abt.abt_id IN (5, 6) THEN (abt.abt_id * 1000000 + ABS(hwg.hwg_id) * 10000) /* Ultra Frische OWG */
			ELSE abt.abt_id * 1000000 /* Food + Nonfood ABT_1 */
			END::INTEGER AS level_hwg
		, CASE abt.abt_id WHEN 4 THEN 9999999 /* Nebengeschäft ABT_1 */
			ELSE abt.abt_id * 1000000 /* Food + Nonfood ABT_1 */
			END::INTEGER AS level_abt
	FROM dbp_msi_view_vis.mv_owg_int_1 owg
	INNER JOIN DBP_MSI_VIEW_VIS.MV_HWG_INT_1 hwg
		ON hwg.hwg_id = owg.hwg_id
	INNER JOIN DBP_MSI_VIEW_VIS.MV_ABT_INT_1 abt_1
		ON abt.abt_id = hwg.abt_id
	WHERE abt.abt_id IN (4, 5, 6, 7, 8) /* relevante Abteilungen */
	)
, ziel AS (
	/* MV_VIS_JZG_ZIEL_WERT_1 -- GJ */
	SELECT jzg.mandant_id
		, jzg.nb_id
		, jzg.wup_id
		, jzg.wrg_id
		, jzg.metrik_id AS metrik_id
		, jzg.typ_id AS typ_id
		, jzg.level_id AS level_id
		, jzg.zielerreich_eingabe AS zielerreich 
		, jzg.zielwert_eingabe AS zielwert_gj
		, jzg.kommentar_eingabe AS kommentar_gj
	FROM DBP_MSI_VIEW_VIS.MV_VIS_JZG_FAKT_EINGABE_1 jzg
	INNER JOIN wup_1
		ON wup.wup_id = jzg.wup_id AND wup.mandant_id = jzg.mandant_id
	INNER JOIN DBP_VIEW.V_JAHR_GJ_1 jahr
		ON jahr.gj = jzg.gj AND jahr.akt_gj = 0
	)
, vis_main AS (
	/* MV_VIS_MONAT_FAKT_WUP_1 aggregiert -- Filiale Referenz GJ */
	SELECT vis.mandant_id
		, vis.nb_id
		, vis.wup_id
		, vis.wrg_id
		, 0::INTEGER AS zero
		, zeit.gj 
		, SUM(vis.ums_netto_plan) AS ums_plan_gj
		, SUM(vis.pers_std_plan)  AS std_plan_gj
		, MAX(ziel.zielwert_gj)   AS ums_ziel_gj
		, MAX(ziel.kommentar_gj)  AS ums_komm_gj
		, MAX(ziel.zielerreich)   AS ums_ziel_er
		, ums_ziel_gj / NULLIFZERO(ums_plan_gj) AS faktor_gj
	FROM DBP_MSI_VIEW_VIS.MV_VIS_MONAT_FAKT_WUP_1 vis
	INNER JOIN monat_gj zeit_1
		ON zeit.kjmo = vis.kjmo
	INNER JOIN wup_1
		ON wup.wup_id = vis.wup_id AND wup.mandant_id = vis.mandant_id
	LEFT JOIN ziel 
		ON ziel.mandant_id = vis.mandant_id AND ziel.wup_id = vis.wup_id AND ziel.wrg_id = vis.wrg_id /* Umsatz Zielwert + Kommentar VJ */
		AND ziel.metrik_id = 10 AND ziel.typ_id = 0 AND ziel.level_id = 0 
	WHERE wup.stl_gj > zeit.gj /* ohne (künftige) Schließungen im akt. GJ */
		AND wup.neo_gj <= zeit.gj /* inkl (künftige) NEÖ im akt. GJ */
	GROUP BY ALL
	)
, vis_plan AS (
	/* MV_WUP_PLAN_KJMO_OWG_1 -- Basisabfrage gruppiert */
	SELECT vis.mandant_id
		, vis.nb_id
		, vis.wup_id
		, vis.wrg_id
		, zeit.gj /* Anzeige akt. GJ */
		, ware.abt_id
		, ware.hwg_id
		, ware.owg_id
		, ware.level_abt
		, ware.level_hwg
		, ware.level_owg
		, SUM(vis.umsatz_netto_plan) AS ums_plan_gj /* Umsatz Plan Ware GJ */
		, MAX(ziel.zielerreich)      AS abs_ziel_er /* Zielereichung Abschrift VJ */
		, MAX(ziel.kommentar_gj)     AS abs_komm_gj /* Kommentar Abschrift GJ */
		, MAX(ziel.zielwert_gj)      AS abs_eing_gj /* Eingabe Abschrift Ziel% GJ */
		, ums_plan_gj * abs_eing_gj  AS abs_kalk_gj /* kalkulierte Abschrift Ziel (absolut) GJ */
	FROM DBP_MSI_VIEW_VIS.MV_WUP_PLAN_KJMO_OWG_1 vis
	INNER JOIN ware
		ON ware.owg_id = vis.owg_id
	INNER JOIN monat_gj zeit_1
		ON zeit.kjmo = vis.kjmo
	INNER JOIN wup_1
		ON wup.wup_id = vis.wup_id AND wup.mandant_id = vis.mandant_id
	LEFT JOIN ziel
		ON ziel.mandant_id = vis.mandant_id AND ziel.wup_id = vis.wup_id AND ziel.wrg_id = vis.wrg_id /* Abschriften_1 Eingabe/Zielwert Helper VJ */
		AND ziel.metrik_id = 40 AND ziel.level_id = ware.level_owg 
	WHERE wup.stl_gj > zeit.gj /* ohne (künftige) Schließungen im GJ */
		AND wup.neo_gj <= zeit.gj /* inkl (künftige) NEÖ im GJ */
	GROUP BY ALL
	)
, vis_owg_plan AS (
	/* MV_WUP_PLAN_KJMO_OWG_1 gefiltert - OWG GJ + VJ */
	SELECT vis.mandant_id
		, vis.nb_id
		, vis.wup_id
		, vis.wrg_id
		, vis.gj
		, vis.owg_id
		, vis.level_owg AS level_id
		, SUM(vis.ums_plan_gj) AS ums_plan_gj
		, SUM(vis.abs_kalk_gj) AS abs_kalk_gj
		, MAX(vis.abs_eing_gj) AS abs_eing_gj
		, MAX(vis.abs_komm_gj) AS abs_komm_gj
		, MAX(vis.abs_ziel_er) AS abs_ziel_er
	FROM vis_plan vis
	WHERE vis.abt_id = 5 /* OWG Ultra Frische */
	GROUP BY ALL
	)
, vis_hwg_plan AS (
	/* MV_WUP_PLAN_KJMO_OWG_1 aggregiert -- HWG Frische Plan GJ/VJ */
	SELECT vis.mandant_id
		, vis.nb_id
		, vis.wup_id
		, vis.wrg_id
		, vis.gj
		, vis.hwg_id
		, vis.level_hwg AS level_id
		, SUM(vis.ums_plan_gj) AS ums_plan_gj
		, SUM(vis.abs_kalk_gj) AS abs_kalk_gj
		, MAX(IFF(vis.abt_id IN (6), vis.abs_eing_gj, NULL)) AS abs_eing_gj
		, MAX(IFF(vis.abt_id IN (6), vis.abs_komm_gj, NULL)) AS abs_komm_gj
		, MAX(IFF(vis.abt_id IN (6), vis.abs_ziel_er, NULL)) AS abs_ziel_er
	FROM vis_plan vis
	WHERE vis.abt_id IN (5, 6) /* HWG Frische */
	GROUP BY ALL
	)
, vis_abt_plan AS (
	/* MV_WUP_PLAN_KJMO_OWG_1 aggregiert -- Abteilung Plan GJ */
	SELECT vis.mandant_id
		, vis.nb_id
		, vis.wup_id
		, vis.wrg_id
		, vis.gj
		, vis.abt_id
		, vis.level_abt AS level_id
		, SUM(vis.ums_plan_gj) AS ums_plan_gj
		, SUM(vis.abs_kalk_gj) AS abs_kalk_gj
		, MAX(IFF(vis.abt_id IN (4, 7, 8), vis.abs_eing_gj, NULL)) AS abs_eing_gj
		, MAX(IFF(vis.abt_id IN (4, 7, 8), vis.abs_komm_gj, NULL)) AS abs_komm_gj
		, MAX(IFF(vis.abt_id IN (4, 7, 8), vis.abs_ziel_er, NULL)) AS abs_ziel_er
	FROM vis_plan vis
	GROUP BY ALL
	)
, vis_fil_plan AS (
	/* MV_WUP_PLAN_KJMO_OWG_1 aggregiert -- Filiale Plan GJ */
	SELECT vis.mandant_id
		, vis.nb_id
		, vis.wup_id
		, vis.wrg_id
		, vis.gj
		, SUM(vis.ums_plan_gj) AS ums_plan_gj
		, SUM(vis.abs_kalk_gj) AS abs_kalk_gj
		, NULL AS abs_eing_gj /* keine Eigabe auf Ebene Filiale */
	FROM vis_plan vis
	GROUP BY ALL
	)
	
, vis_abt_inv AS (
	/* MV_WUP_PLAN_KJMO_OWG_1 gruppiert -- Ziel Inventur_1 Abteilung */
	SELECT vis.mandant_id
		, vis.nb_id
		, vis.wup_id
		, vis.wrg_id
		, vis.gj 
		, vis.abt_id
		, vis.level_abt AS level_id
		, SUM(vis.ums_plan_gj)   AS ums_plan_gj
		, MAX(ziel.zielwert_gj)  AS inv_eing_gj /* ursprüngliche Eingabe Inventur_1 Ziel%*/
		, MAX(ziel.kommentar_gj) AS inv_komm_gj
		, MAX(ziel.zielerreich)  AS inv_ziel_er
		, SUM(vis.ums_plan_gj) * MAX(ziel.zielwert_gj) AS inv_kalk_gj /* kalkulierter Zielwert Inventur_1 (absolut) */
	FROM vis_plan vis
	LEFT JOIN ziel
		ON ziel.mandant_id = vis.mandant_id AND ziel.wup_id = vis.wup_id AND ziel.wrg_id = vis.wrg_id  /* Inventur_1 Eingabe/Zielwert Helper VJ */
		AND ziel.metrik_id = 46 AND ziel.level_id = vis.level_abt
	GROUP BY ALL
	)
, vis_fil_inv AS (
	/* MV_WUP_PLAN_KJMO_OWG_1 gruppiert -- Ziel Inventur_1 Filiale */
	SELECT vis.mandant_id
		, vis.nb_id
		, vis.wup_id
		, vis.wrg_id
		, vis.gj 
		, SUM(vis.ums_plan_gj) AS ums_plan_gj
		, SUM(vis.inv_kalk_gj) AS inv_kalk_gj /* kalkulierter Zielwert Inventur_1 (absolut) */
	FROM vis_abt_inv vis
	GROUP BY ALL
	)

/* CTE <-->  MAIN */

/* JZG 10-0-0 Umsatz Filiale */
SELECT 10::INTEGER AS METRIK_ID
	, vis0.zero AS TYP_ID
	, vis0.zero AS LEVEL_ID
	, vis0.mandant_id
	, vis0.nb_id
	, vis0.wup_id
	, vis0.wrg_id
	, vis0.gj
	, IFNULL(vis0.ums_ziel_gj, 0)  AS EINGABE_GJ /* Eingabe Zielwert GJ */
	, IFNULL(vis0.ums_komm_gj, '') AS KOMMENTAR_GJ /* Eingabe Kommentar GJ */
	, IFNULL(vis0.ums_ziel_er, '') AS ZIELERREICHUNG /* Eingabe Zielerreichung VJ */
	, vis0.faktor_gj AS CHECK_GJ /* Faktor Umsatz Ziel/Plan */
	, EINGABE_GJ AS ZIEL_GJ1
	, NULL AS ZIEL_GJ2
	, ZIEL_GJ1 AS ZIEL_GJ
FROM vis_main vis0

UNION ALL
/* JZG 10-1-x Umsatz Abteilung */
SELECT 10::INTEGER AS METRIK_ID
	, 1::INTEGER AS TYP_ID
	, sub1.level_id AS LEVEL_ID
	, vis0.mandant_id
	, vis0.nb_id
	, vis0.wup_id
	, vis0.wrg_id
	, vis0.gj
	, NULL AS EINGABE_GJ
	, ''   AS KOMMENTAR_GJ
	, ''   AS ZIELERREICHUNG
	, vis0.faktor_gj AS CHECK_GJ /* Faktor Umsatz Ziel/Plan */
	, sub1.ums_plan_gj * vis0.faktor_gj AS ZIEL_GJ1
	, NULL AS ZIEL_GJ2
	, ZIEL_GJ1 AS ZIEL_GJ
FROM vis_main vis0
INNER JOIN vis_abt_plan sub1
	ON sub1.mandant_id = vis0.mandant_id AND sub1.wup_id = vis0.wup_id AND sub1.wrg_id = vis0.wrg_id

UNION ALL
/* JZG 10-2-x Umsatz HWG Frische */
SELECT 10::INTEGER AS METRIK_ID
	, 2::INTEGER AS TYP_ID
	, sub1.level_id AS LEVEL_ID
	, vis0.mandant_id
	, vis0.nb_id
	, vis0.wup_id
	, vis0.wrg_id
	, vis0.gj
	, NULL AS EINGABE_GJ
	, ''   AS KOMMENTAR_GJ
	, ''   AS ZIELERREICHUNG
	, vis0.faktor_gj AS CHECK_GJ /* Faktor Umsatz Ziel/Plan */
	, sub1.ums_plan_gj * vis0.faktor_gj AS ZIEL_GJ1
	, NULL AS ZIEL_GJ2
	, ZIEL_GJ1 AS ZIEL_GJ
FROM vis_main vis0
INNER JOIN vis_hwg_plan sub1
	ON sub1.mandant_id = vis0.mandant_id AND sub1.wup_id = vis0.wup_id AND sub1.wrg_id = vis0.wrg_id

UNION ALL
/* JZG 10-3-x Umsatz OWG Ultra Frische */
SELECT 10::INTEGER AS METRIK_ID
	, 3::INTEGER AS TYP_ID
	, sub1.level_id AS LEVEL_ID
	, vis0.mandant_id
	, vis0.nb_id
	, vis0.wup_id
	, vis0.wrg_id
	, vis0.gj
	, NULL AS EINGABE_GJ
	, ''   AS KOMMENTAR_GJ
	, ''   AS ZIELERREICHUNG
	, vis0.faktor_gj AS CHECK_GJ /* Faktor Umsatz Ziel/Plan */
	, sub1.ums_plan_gj * vis0.faktor_gj AS ZIEL_GJ1
	, NULL AS ZIEL_GJ2
	, ZIEL_GJ1 AS ZIEL_GJ
FROM vis_main vis0
INNER JOIN vis_owg_plan sub1
	ON sub1.mandant_id = vis0.mandant_id AND sub1.wup_id = vis0.wup_id AND sub1.wrg_id = vis0.wrg_id

UNION ALL
/* JZG 16-0-0 Kunden */
SELECT 16::INTEGER AS METRIK_ID
	, vis0.zero AS TYP_ID
	, vis0.zero AS LEVEL_ID
	, vis0.mandant_id
	, vis0.nb_id
	, vis0.wup_id
	, vis0.wrg_id
	, vis0.gj
	, IFNULL(ziel.zielwert_gj, 0)   AS EINGABE_GJ /* Eingabe Zielwert Kunden GJ */
	, IFNULL(ziel.kommentar_gj, '') AS KOMMENTAR_GJ /* Eingabe Kommentar Kunden GJ */
	, IFNULL(ziel.zielerreich, '')  AS ZIELERREICHUNG /* Eingabe Zielerreichung Kunden VJ */
	, NULL AS CHECK_GJ 
	, ziel.zielwert_gj AS ZIEL_GJ1
	, NULL AS ZIEL_GJ2
	, ZIEL_GJ1 AS ZIEL_GJ
FROM vis_main vis0
LEFT JOIN ziel 
	ON ziel.mandant_id = vis0.mandant_id AND ziel.wup_id = vis0.wup_id AND ziel.wrg_id = vis0.wrg_id /* Kunde Zielwert + Kommentar GJ */
	AND ziel.metrik_id = 16 AND ziel.typ_id = 0 AND ziel.level_id = 0

UNION ALL
/* JZG 18-0-0 Ø-Bon */
SELECT 18::INTEGER AS METRIK_ID
	, vis0.zero AS TYP_ID
	, vis0.zero AS LEVEL_ID
	, vis0.mandant_id
	, vis0.nb_id
	, vis0.wup_id
	, vis0.wrg_id
	, vis0.gj
	, NULL AS EINGABE_GJ
	, ''   AS KOMMENTAR_GJ
	, ''   AS ZIELERREICHUNG
	, NULL AS CHECK_GJ 
	, IFNULL(vis0.ums_ziel_gj, 0) AS ZIEL_GJ1 /* Eingabe Umsatz */
	, IFNULL(ziel.zielwert_gj, 0) AS ZIEL_GJ2 /* Eingabe Kunden */
	, ZIEL_GJ1 / NULLIFZERO(ZIEL_GJ2) AS ZIEL_GJ
FROM vis_main vis0
LEFT JOIN ziel 
	ON ziel.mandant_id = vis0.mandant_id AND ziel.wup_id = vis0.wup_id AND ziel.wrg_id = vis0.wrg_id /* Kunde Zielwert GJ */
	AND ziel.metrik_id = 16 AND ziel.typ_id = 0 AND ziel.level_id = 0

UNION ALL
/* JZG 20-0-0 Nettoleistung */
SELECT 20::INTEGER AS METRIK_ID
	, vis0.zero AS TYP_ID
	, vis0.zero AS LEVEL_ID
	, vis0.mandant_id
	, vis0.nb_id
	, vis0.wup_id
	, vis0.wrg_id
	, vis0.gj
	, NULL AS EINGABE_GJ
	, ''   AS KOMMENTAR_GJ
	, ''   AS ZIELERREICHUNG
	, NULL AS CHECK_GJ 
	, IFNULL(vis0.ums_ziel_gj, 0) AS ZIEL_GJ1 /* Eingabe Umsatz */
	, IFNULL(ziel.zielwert_gj, 0) AS ZIEL_GJ2 /* Eingabe Nettostunden */
	, ZIEL_GJ1 / NULLIFZERO(ZIEL_GJ2) AS ZIEL_GJ
FROM vis_main vis0
LEFT JOIN ziel
	ON ziel.mandant_id = vis0.mandant_id AND ziel.wup_id = vis0.wup_id AND ziel.wrg_id = vis0.wrg_id /* Nettostunden Zielwert GJ */
	AND ziel.metrik_id = 24 AND ziel.typ_id = 0 AND ziel.level_id = 0

UNION ALL
/* JZG 24-0-0 Nettostunden */
SELECT 24::INTEGER AS METRIK_ID
	, vis0.zero AS TYP_ID
	, vis0.zero AS LEVEL_ID
	, vis0.mandant_id
	, vis0.nb_id
	, vis0.wup_id
	, vis0.wrg_id
	, vis0.gj
	, IFNULL(ziel.zielwert_gj, 0)   AS EINGABE_GJ /* Eingabe Zielwert Nettostunden GJ */
	, IFNULL(ziel.kommentar_gj, '') AS KOMMENTAR_GJ /* Eingabe Kommentar Nettostunden GJ */
	, IFNULL(ziel.zielerreich, '')  AS ZIELERREICHUNG /* Eingabe Zielerreichung Nettostunden VJ */
	, NULL AS CHECK_GJ 
	, IFNULL(ziel.zielwert_gj, 0) AS ZIEL_GJ1 /*  Zielwert Nettostunden GJ */
	, NULL AS ZIEL_GJ2 
	, ZIEL_GJ1 AS ZIEL_GJ
FROM vis_main vis0
LEFT JOIN ziel
	ON ziel.mandant_id = vis0.mandant_id AND ziel.wup_id = vis0.wup_id AND ziel.wrg_id = vis0.wrg_id /* Nettostunden Zielwert + Kommentar GJ */
	AND ziel.metrik_id = 24 AND ziel.typ_id = 0 AND ziel.level_id = 0

UNION ALL
/* JZG 40-0-0 Abschriften_1 operativ Filiale */
SELECT 40::INTEGER AS METRIK_ID
	, vis0.zero AS TYP_ID
	, vis0.zero AS LEVEL_ID
	, vis0.mandant_id
	, vis0.nb_id
	, vis0.wup_id
	, vis0.wrg_id
	, vis0.gj
	, NULL AS EINGABE_GJ
	, ''   AS KOMMENTAR_GJ
	, ''   AS ZIELERREICHUNG
	, vis0.faktor_gj AS CHECK_GJ /* Faktor Umsatz Ziel/Plan */
	, IFNULL(sub1.abs_kalk_gj * vis0.faktor_gj, 0) AS ZIEL_GJ1
	, IFNULL(sub1.ums_plan_gj * vis0.faktor_gj, 0) AS ZIEL_GJ2
	, ZIEL_GJ1 / NULLIFZERO(ZIEL_GJ2) AS ZIEL_GJ
FROM vis_main vis0
INNER JOIN vis_fil_plan sub1
	ON sub1.mandant_id = vis0.mandant_id AND sub1.wup_id = vis0.wup_id AND sub1.wrg_id = vis0.wrg_id

UNION ALL
/* JZG 40-1-0 Abschriften_1 operativ Abteilung */
SELECT 40::INTEGER AS METRIK_ID
	, 1 AS TYP_ID
	, sub1.level_id AS LEVEL_ID
	, vis0.mandant_id
	, vis0.nb_id
	, vis0.wup_id
	, vis0.wrg_id
	, vis0.gj
	, IFNULL(sub1.abs_eing_gj, 0) AS EINGABE_GJ /* Eingabe Zielwert Abschriften_1 GJ */
	, IFNULL(sub1.abs_komm_gj, '') AS KOMMENTAR_GJ
	, IFNULL(sub1.abs_ziel_er, '') AS ZIELERREICHUNG
	, vis0.faktor_gj AS CHECK_GJ /* Faktor Umsatz Ziel/Plan */
	, IFNULL(sub1.abs_kalk_gj * vis0.faktor_gj, 0) AS ZIEL_GJ1
	, IFNULL(sub1.ums_plan_gj * vis0.faktor_gj, 0) AS ZIEL_GJ2
	, ZIEL_GJ1 / NULLIFZERO(ZIEL_GJ2) AS ZIEL_GJ
FROM vis_main vis0
INNER JOIN vis_abt_plan sub1
	ON sub1.mandant_id = vis0.mandant_id AND sub1.wup_id = vis0.wup_id AND sub1.wrg_id = vis0.wrg_id

UNION ALL
/* JZG 40-2-x Abschriften_1 operativ HWG Frische */
SELECT 40::INTEGER AS METRIK_ID
	, 2 AS TYP_ID
	, sub1.level_id AS LEVEL_ID
	, vis0.mandant_id
	, vis0.nb_id
	, vis0.wup_id
	, vis0.wrg_id
	, vis0.gj
	, IFNULL(sub1.abs_eing_gj, 0) AS EINGABE_GJ /* Eingabe Zielwert Abschriften_1 GJ */
	, IFNULL(sub1.abs_komm_gj, '') AS KOMMENTAR_GJ
	, IFNULL(sub1.abs_ziel_er, '') AS ZIELERREICHUNG
	, vis0.faktor_gj AS CHECK_GJ /* Faktor Umsatz Ziel/Plan */
	, IFNULL(sub1.abs_kalk_gj * vis0.faktor_gj, 0) AS ZIEL_GJ1
	, IFNULL(sub1.ums_plan_gj * vis0.faktor_gj, 0) AS ZIEL_GJ2
	, ZIEL_GJ1 / NULLIFZERO(ZIEL_GJ2) AS ZIEL_GJ
FROM vis_main vis0
INNER JOIN vis_hwg_plan sub1
	ON sub1.mandant_id = vis0.mandant_id AND sub1.wup_id = vis0.wup_id AND sub1.wrg_id = vis0.wrg_id

UNION ALL
/* JZG 40-3-x Abschriften_1 operativ OWG Ultra Frische */
SELECT 40::INTEGER AS METRIK_ID
	, 3 AS TYP_ID
	, sub1.level_id AS LEVEL_ID
	, vis0.mandant_id
	, vis0.nb_id
	, vis0.wup_id
	, vis0.wrg_id
	, vis0.gj
	, IFNULL(sub1.abs_eing_gj, 0) AS EINGABE_GJ /* Eingabe Zielwert Abschriften_1 GJ */
	, IFNULL(sub1.abs_komm_gj, '') AS KOMMENTAR_GJ
	, IFNULL(sub1.abs_ziel_er, '') AS ZIELERREICHUNG
	, vis0.faktor_gj AS CHECK_GJ /* Faktor Umsatz Ziel/Plan */
	, IFNULL(sub1.abs_kalk_gj * vis0.faktor_gj, 0) AS ZIEL_GJ1
	, IFNULL(sub1.ums_plan_gj * vis0.faktor_gj, 0) AS ZIEL_GJ2
	, ZIEL_GJ1 / NULLIFZERO(ZIEL_GJ2) AS ZIEL_GJ
FROM vis_main vis0
INNER JOIN vis_owg_plan sub1
	ON sub1.mandant_id = vis0.mandant_id AND sub1.wup_id = vis0.wup_id AND sub1.wrg_id = vis0.wrg_id

UNION ALL
/* JZG 46-0-0 Inventur_1 Filiale */
SELECT 46::INTEGER AS METRIK_ID
	, vis0.zero AS TYP_ID
	, vis0.zero AS LEVEL_ID
	, vis0.mandant_id
	, vis0.nb_id
	, vis0.wup_id
	, vis0.wrg_id
	, vis0.gj
	, NULL AS EINGABE_GJ 
	, ''   AS KOMMENTAR_GJ
	, ''   AS ZIELERREICHUNG
	, vis0.faktor_gj AS CHECK_GJ /* Faktor Umsatz Ziel/Plan */
	, IFNULL(sub1.inv_kalk_gj * vis0.faktor_gj, 0) AS ZIEL_GJ1 /* kalkuliert Inventur_1 (absolut) GJ */
	, IFNULL(sub1.ums_plan_gj * vis0.faktor_gj, 0) AS ZIEL_GJ2 /* Eingabe Zielwert Umsatz GJ */
	, ZIEL_GJ1 / NULLIFZERO(ZIEL_GJ2) AS ZIEL_GJ
FROM vis_main vis0
INNER JOIN vis_fil_inv sub1
	ON sub1.mandant_id = vis0.mandant_id AND sub1.wup_id = vis0.wup_id AND sub1.wrg_id = vis0.wrg_id

UNION ALL
/* JZG 46-1-0 Inventur_1 Abteilung */
SELECT 46::INTEGER AS METRIK_ID
	, 1 AS TYP_ID
	, sub1.level_id AS LEVEL_ID
	, vis0.mandant_id
	, vis0.nb_id
	, vis0.wup_id
	, vis0.wrg_id
	, vis0.gj
	, IFNULL(sub1.inv_eing_gj, 0)  AS EINGABE_GJ /* Eingabe Zielwert Inventur_1 % */
	, IFNULL(sub1.inv_komm_gj, '') AS KOMMENTAR_GJ
	, IFNULL(sub1.inv_ziel_er, '') AS ZIELERREICHUNG
	, vis0.faktor_gj AS CHECK_GJ /* Faktor Umsatz Ziel/Plan */
	, IFNULL(sub1.inv_kalk_gj * vis0.faktor_gj, 0) AS ZIEL_GJ1 /* kalkuliert Inventur_1 (absolut) GJ */
	, IFNULL(sub1.ums_plan_gj * vis0.faktor_gj, 0) AS ZIEL_GJ2 /* Eingabe Zielwert Umsatz GJ */
	, ZIEL_GJ1 / NULLIFZERO(ZIEL_GJ2) AS ZIEL_GJ
FROM vis_main vis0
INNER JOIN vis_abt_inv sub1
	ON sub1.mandant_id = vis0.mandant_id AND sub1.wup_id = vis0.wup_id AND sub1.wrg_id = vis0.wrg_id

UNION ALL 
/* JZG 70-0-0 Personalkosten_1 (%) */
SELECT 70::INTEGER AS METRIK_ID
	, vis0.zero AS TYP_ID
	, vis0.zero AS LEVEL_ID
	, vis0.mandant_id
	, vis0.nb_id
	, vis0.wup_id
	, vis0.wrg_id
	, vis0.gj
	, IFNULL(ziel.zielwert_gj, 0) AS EINGABE_GJ /* Eingabe Zielwert Personalkosten_1 % */
	, '' AS KOMMENTAR_GJ
	, '' AS ZIELERREICHUNG
	, NULL AS CHECK_GJ 
	, IFNULL(ziel.zielwert_gj * vis0.ums_ziel_gj, 0) AS ZIEL_GJ1 /* Kalkuliert Personalkosten_1 GJ */
	, IFNULL(vis0.ums_ziel_gj, 0) AS ZIEL_GJ2 /* Eingabe Zielwert Umsatz GJ */
	, ZIEL_GJ1 / NULLIFZERO(ZIEL_GJ2) AS ZIEL_GJ
FROM vis_main vis0
LEFT JOIN ziel 
	ON ziel.mandant_id = vis0.mandant_id AND ziel.wup_id = vis0.wup_id AND ziel.wrg_id = vis0.wrg_id /* PK% Zielwert GJ */
	AND ziel.metrik_id = 70 AND ziel.typ_id = 0 AND ziel.level_id = 0

UNION ALL 
/* JZG 91-0-0 TOP1 Kommentar */
SELECT 91::INTEGER METRIK_ID
	, vis0.zero AS TYP_ID
	, vis0.zero AS LEVEL_ID
	, vis0.mandant_id
	, vis0.nb_id
	, vis0.wup_id
	, vis0.wrg_id
	, vis0.gj
	, NULL AS EINGABE_GJ 
	, IFNULL(ziel.kommentar_gj, '') AS KOMMENTAR_GJ /* Eingabe Kommentar TOP GJ */
	, IFNULL(ziel.zielerreich, '')  AS ZIELERREICHUNG /* Eingabe Zielerreichung TOP VJ */
	, NULL AS CHECK_GJ 
	, NULL AS ZIEL_GJ1 
	, NULL AS ZIEL_GJ2 
	, NULL AS ZIEL_GJ
FROM vis_main vis0
LEFT JOIN ziel
	ON ziel.mandant_id = vis0.mandant_id AND ziel.wup_id = vis0.wup_id AND ziel.wrg_id = vis0.wrg_id /* TOP Kommentar VJ */
	AND ziel.metrik_id = 91 AND ziel.typ_id = 0 AND ziel.level_id = 0

UNION ALL 
/* JZG 92-0-0 TOP1 Kommentar */
SELECT 92::INTEGER METRIK_ID
	, vis0.zero AS TYP_ID
	, vis0.zero AS LEVEL_ID
	, vis0.mandant_id
	, vis0.nb_id
	, vis0.wup_id
	, vis0.wrg_id
	, vis0.gj
	, NULL AS EINGABE_GJ 
	, IFNULL(ziel.kommentar_gj, '') AS KOMMENTAR_GJ /* Eingabe Kommentar TOP GJ */
	, IFNULL(ziel.zielerreich, '')  AS ZIELERREICHUNG /* Eingabe Zielerreichung TOP VJ */
	, NULL AS CHECK_GJ 
	, NULL AS ZIEL_GJ1 
	, NULL AS ZIEL_GJ2 
	, NULL AS ZIEL_GJ
FROM vis_main vis0
LEFT JOIN ziel
	ON ziel.mandant_id = vis0.mandant_id AND ziel.wup_id = vis0.wup_id AND ziel.wrg_id = vis0.wrg_id /* TOP Kommentar VJ */
	AND ziel.metrik_id = 92 AND ziel.typ_id = 0 AND ziel.level_id = 0

UNION ALL
/* JZG 93-0-0 TOP1 Kommentar */
SELECT 93::INTEGER METRIK_ID
	, vis0.zero AS TYP_ID
	, vis0.zero AS LEVEL_ID
	, vis0.mandant_id
	, vis0.nb_id
	, vis0.wup_id
	, vis0.wrg_id
	, vis0.gj
	, NULL AS EINGABE_GJ 
	, IFNULL(ziel.kommentar_gj, '') AS KOMMENTAR_GJ /* Eingabe Kommentar TOP GJ */
	, IFNULL(ziel.zielerreich, '')  AS ZIELERREICHUNG /* Eingabe Zielerreichung TOP VJ */
	, NULL AS CHECK_GJ 
	, NULL AS ZIEL_GJ1 
	, NULL AS ZIEL_GJ2 
	, NULL AS ZIEL_GJ
FROM vis_main vis0
LEFT JOIN ziel
	ON ziel.mandant_id = vis0.mandant_id AND ziel.wup_id = vis0.wup_id AND ziel.wrg_id = vis0.wrg_id /* TOP Kommentar VJ */
	AND ziel.metrik_id = 93 AND ziel.typ_id = 0 AND ziel.level_id = 0

UNION ALL
/* JZG 94-0-0 TOP1 Kommentar */
SELECT 94::INTEGER METRIK_ID
	, vis0.zero AS TYP_ID
	, vis0.zero AS LEVEL_ID
	, vis0.mandant_id
	, vis0.nb_id
	, vis0.wup_id
	, vis0.wrg_id
	, vis0.gj
	, NULL AS EINGABE_GJ 
	, IFNULL(ziel.kommentar_gj, '') AS KOMMENTAR_GJ /* Eingabe Kommentar TOP GJ */
	, IFNULL(ziel.zielerreich, '')  AS ZIELERREICHUNG /* Eingabe Zielerreichung TOP VJ */
	, NULL AS CHECK_GJ 
	, NULL AS ZIEL_GJ1 
	, NULL AS ZIEL_GJ2 
	, NULL AS ZIEL_GJ
FROM vis_main vis0
LEFT JOIN ziel
	ON ziel.mandant_id = vis0.mandant_id AND ziel.wup_id = vis0.wup_id AND ziel.wrg_id = vis0.wrg_id /* TOP Kommentar VJ */
	AND ziel.metrik_id = 94 AND ziel.typ_id = 0 AND ziel.level_id = 0

UNION ALL
/* JZG 95-0-0 TOP1 Kommentar */
SELECT 95::INTEGER METRIK_ID
	, vis0.zero AS TYP_ID
	, vis0.zero AS LEVEL_ID
	, vis0.mandant_id
	, vis0.nb_id
	, vis0.wup_id
	, vis0.wrg_id
	, vis0.gj
	, NULL AS EINGABE_GJ 
	, IFNULL(ziel.kommentar_gj, '') AS KOMMENTAR_GJ /* Eingabe Kommentar TOP GJ */
	, IFNULL(ziel.zielerreich, '')  AS ZIELERREICHUNG /* Eingabe Zielerreichung TOP VJ */
	, NULL AS CHECK_GJ 
	, NULL AS ZIEL_GJ1 
	, NULL AS ZIEL_GJ2 
	, NULL AS ZIEL_GJ
FROM vis_main vis0
LEFT JOIN ziel
	ON ziel.mandant_id = vis0.mandant_id AND ziel.wup_id = vis0.wup_id AND ziel.wrg_id = vis0.wrg_id /* TOP Kommentar VJ */
	AND ziel.metrik_id = 95 AND ziel.typ_id = 0 AND ziel.level_id = 0

UNION ALL
/* JZG xx-0-0 übrige Kennzahlen  */
SELECT jzg.metrik_id AS METRIK_ID
	, vis0.zero AS TYP_ID
	, vis0.zero AS LEVEL_ID
	, vis0.mandant_id
	, vis0.nb_id
	, vis0.wup_id
	, vis0.wrg_id
	, vis0.gj
	, IFNULL(ziel.zielwert_gj, 0)   AS EINGABE_GJ /* Eingabe Zielwert GJ */
	, IFNULL(ziel.kommentar_gj, '') AS KOMMENTAR_GJ /* Eingabe Kommentar GJ */
	, IFNULL(ziel.zielerreich, '')  AS ZIELERREICHUNG /* Eingabe Zielerreichung VJ */
	, NULL AS CHECK_GJ 
	, ziel.zielwert_gj AS ZIEL_GJ1 
	, NULL AS ZIEL_GJ2 
	, ZIEL_GJ1 AS ZIEL_GJ
FROM vis_main vis0
CROSS JOIN (
	SELECT metrik_id, metrik_fg
	FROM DBP_MSI_VIEW_VIS.MV_VIS_JZG_L_METRIK_1
	WHERE metrik_fg IN (10, 30) /* 10 Metriken (ohne Ziel/Kommentar) + 30 Metriken mit Ziel/Kommentar (nicht agg) */
	) jzg
LEFT JOIN ziel
	ON ziel.mandant_id = vis0.mandant_id AND ziel.wup_id = vis0.wup_id AND ziel.wrg_id = vis0.wrg_id /* übrige Zielwerte + Kommentar VJ */
	AND ziel.metrik_id = jzg.metrik_id AND ziel.typ_id = 0 AND ziel.level_id = 0
;