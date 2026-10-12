CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_VIS_JZG_DATA_PLAN_2(
	MANDANT_ID,
	NB_ID,
	WUP_ID,
	WRG_ID,
	GJ,
	METRIK_ID,
	TYP_ID,
	LEVEL_ID,
	PLAN_GJ1,
	PLAN_GJ2,
	PLAN_GJ,
	EINGABE,
	ANTEIL,
	ZIEL1,
	ZIEL2,
	ZIEL,
	KOMMENTAR
) AS 
/*
   FAKT DENORM JZG - Jahreszielgespräch Plan / Eingabe / Ziel
   2023-02-15 ssch0611 : Setup inkl. Dummies. AP0144461
   2023-02-24 ssch0611 : Finetuning & Bugfix. 
   2023-03-01 ssch0611 : Inventur_2 Berechnung.
*/ 
 
/* JZG 100-0 - Umsatz Filiale */
SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id
, vis.gj      AS GJ
, 10::INTEGER AS METRIK_ID
, 0::INTEGER  AS TYP_ID
, 0::INTEGER  AS LEVEL_ID
, vis.ums_netto_plan AS PLAN_GJ1
, 1.00 AS PLAN_GJ2
, vis.ums_netto_plan AS PLAN_GJ
, jzg10.wert_eingabe AS EINGABE
, 1 AS ANTEIL
, jzg10.wert_eingabe AS ZIEL1 /* ZIEL = Eingabe */
, 1.00 AS ZIEL2 
, COALESCE(jzg10.wert_eingabe, 0)       AS ZIEL 
, COALESCE(jzg10.kommentar_eingabe, '') AS KOMMENTAR 
FROM ( /* JZG Filiale - MAIN */
	SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.gj
	, SUM(vis.ums_netto_plan) AS ums_netto_plan
	, SUM(vis.pers_std_plan)  AS pers_std_plan
	FROM DBP_MSI_DATA.VIS_MONAT_UMS_KUNDE_PERS_WUP_2   vis
	JOIN DBP_DATA.MONAT_2 zeit_2
	ON   zeit.kjmo = vis.kjmo AND zeit.akt_gj = 0
	GROUP BY vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.gj
) vis
LEFT JOIN DBP_MSI_VIEW_VIS.MV_VIS_JZG_ZIEL_WERT_2  jzg10 /* 10 Umsatz */
ON  jzg10.mandant_id = vis.mandant_id AND jzg10.wup_id = vis.wup_id
AND jzg10.wrg_id = vis.wrg_id AND jzg10.gj = vis.gj
AND jzg10.metrik_id = 10 AND jzg10.typ_id = 0 AND jzg10.level_id = 0 
 
/* JZG 101-x000000 - Umsatz Abteilung */
UNION ALL
SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id
, vis.gj      AS GJ
, 10::INTEGER AS METRIK_ID
, 1::INTEGER  AS TYP_ID
, (CASE vis.abt_id WHEN 4 THEN 9999999 ELSE vis.abt_id * 1000000 END)::INTEGER AS LEVEL_ID
, plan.ums_netto_plan AS PLAN_GJ1 /* Plan Ware */
, 1.00 AS PLAN_GJ2
, plan.ums_netto_plan AS PLAN_GJ
, NULL AS EINGABE /* Eingabe = Ebene Filiale*/
, plan.ums_netto_plan / NULLIFZERO(fil.ums_netto_plan) AS ANTEIL /* Basis = Plan Filiale */
, jzg10.wert_eingabe * ANTEIL AS ZIEL1  /*Ziel berechnet*/
, 1.00 AS ZIEL2 
, COALESCE(jzg10.wert_eingabe * ANTEIL, 0) AS ZIEL
, '' AS KOMMENTAR /* nur auf Ebene Eingabe */
FROM ( /* JZG Abteilung - Umsatz Ware */
	SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.gj, abt.abt_id
	, SUM(vis.ums_netto) AS ums_netto
	FROM DBP_MSI_DATA.VIS_MONAT_UMSATZ_WG_2  vis
	JOIN DBP_MSI_VIEW_VIS.MV_WG_INT_2 wg 
	ON   wg.wg_id = vis.wg_id
	JOIN DBP_MSI_VIEW_VIS.MV_OWG_INT_2 owg
	ON   owg.owg_id = wg.owg_id
	JOIN DBP_MSI_VIEW_VIS.MV_HWG_INT_2 hwg
	ON   hwg.hwg_id = owg.hwg_id
	JOIN DBP_MSI_VIEW_VIS.MV_ABT_INT_2 abt_2
	ON   abt.abt_id = hwg.abt_id
	JOIN DBP_DATA.MONAT_2  zeit_2
	ON   zeit.kjmo = vis.kjmo AND zeit.akt_gj = 0
	GROUP BY vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.gj, abt.abt_id
) vis
JOIN ( /* JZG Abteilung - Plan Filiale */
	SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.gj
	, SUM(vis.ums_netto_plan) AS ums_netto_plan
	FROM DBP_MSI_DATA.VIS_MONAT_UMS_KUNDE_PERS_WUP_2   vis
	JOIN DBP_DATA.MONAT_2 zeit_2
	ON   zeit.kjmo = vis.kjmo AND zeit.akt_gj = 0
	GROUP BY vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.gj
) fil
ON fil.mandant_id = vis.mandant_id AND fil.wup_id = vis.wup_id
AND fil.wrg_id = vis.wrg_id AND fil.gj = vis.gj 
LEFT JOIN ( /* JZG Abteilung - Plan VJ */
	SELECT plan.mandant_id, plan.nb_id, plan.wup_id, plan.wrg_id, zeit.gj, abt.abt_id
	, SUM(plan.umsatz_netto_plan)               AS ums_netto_plan
	FROM dbp_msi_view_vis.mv_wup_plan_kjmo_owg_2 plan
	JOIN DBP_MSI_VIEW_VIS.MV_OWG_INT_2 owg
	ON   owg.owg_id = plan.owg_id  
	JOIN DBP_MSI_VIEW_VIS.MV_HWG_INT_2 hwg
	ON   hwg.hwg_id = owg.hwg_id
	JOIN DBP_MSI_VIEW_VIS.MV_ABT_INT_2 abt_2
	ON   abt.abt_id = hwg.abt_id
	JOIN DBP_DATA.MONAT_2  zeit_2
	ON   zeit.kjmo = plan.kjmo AND zeit.akt_gj = 0
	GROUP BY plan.mandant_id, plan.nb_id, plan.wup_id, plan.wrg_id, zeit.gj, abt.abt_id
) plan
ON plan.mandant_id = vis.mandant_id AND plan.wup_id = vis.wup_id
AND plan.wrg_id = vis.wrg_id AND plan.gj = vis.gj 
AND plan.abt_id = vis.abt_id 
LEFT JOIN DBP_MSI_VIEW_VIS.MV_VIS_JZG_ZIEL_WERT_2  jzg10 /* 10 Umsatz */
ON  jzg10.mandant_id = vis.mandant_id AND jzg10.wup_id = vis.wup_id
AND jzg10.wrg_id = vis.wrg_id AND jzg10.gj = vis.gj
AND jzg10.metrik_id = 10 AND jzg10.typ_id = 0 AND jzg10.level_id = 0 

/* JZG 102-x000000 - Umsatz HWG */
UNION ALL
SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id
, vis.gj      AS GJ
, 10::INTEGER AS METRIK_ID
, 2::INTEGER  AS TYP_ID
, (vis.abt_id * 1000000 + ABS(vis.hwg_id) * 10000)::INTEGER AS LEVEL_ID
, plan.ums_netto_plan AS PLAN_GJ1 /* Plan Ware */
, 1.00 AS PLAN_GJ2
, plan.ums_netto_plan AS PLAN_GJ
, NULL AS EINGABE /* Eingabe = Ebene Filiale*/
, plan.ums_netto_plan / NULLIFZERO(fil.ums_netto_plan) AS ANTEIL /* Basis = Plan Filiale */
, jzg10.wert_eingabe * ANTEIL AS ZIEL1  /*Ziel berechnet*/
, 1.00 AS ZIEL2 
, COALESCE(jzg10.wert_eingabe * ANTEIL, 0) AS ZIEL
, '' AS KOMMENTAR /* nur auf Ebene Eingabe */
FROM ( /* JZG HWG - Umsatz Ware */
	SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.gj, abt.abt_id, hwg.hwg_id
	, SUM(vis.ums_netto) AS ums_netto
	FROM DBP_MSI_DATA.VIS_MONAT_UMSATZ_WG_2  vis
	JOIN DBP_MSI_VIEW_VIS.MV_WG_INT_2 wg 
	ON   wg.wg_id = vis.wg_id
	JOIN DBP_MSI_VIEW_VIS.MV_OWG_INT_2 owg
	ON   owg.owg_id = wg.owg_id
	JOIN DBP_MSI_VIEW_VIS.MV_HWG_INT_2 hwg
	ON   hwg.hwg_id = owg.hwg_id
	JOIN DBP_MSI_VIEW_VIS.MV_ABT_INT_2 abt_2
	ON   abt.abt_id = hwg.abt_id
	JOIN DBP_DATA.MONAT_2  zeit_2
	ON   zeit.kjmo = vis.kjmo AND zeit.akt_gj = 0
    WHERE abt.abt_id IN (5,6)
	GROUP BY vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.gj, abt.abt_id, hwg.hwg_id
) vis
JOIN ( /* JZG HWG - Plan Filiale */
	SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.gj
	, SUM(vis.ums_netto_plan) AS ums_netto_plan
	FROM DBP_MSI_DATA.VIS_MONAT_UMS_KUNDE_PERS_WUP_2   vis
	JOIN DBP_DATA.MONAT_2 zeit_2
	ON   zeit.kjmo = vis.kjmo AND zeit.akt_gj = 0
	GROUP BY vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.gj
) fil
ON fil.mandant_id = vis.mandant_id AND fil.wup_id = vis.wup_id
AND fil.wrg_id = vis.wrg_id AND fil.gj = vis.gj 
LEFT JOIN ( /* JZG HWG - Plan VJ */
	SELECT plan.mandant_id, plan.nb_id, plan.wup_id, plan.wrg_id, zeit.gj, abt.abt_id, hwg.hwg_id
	, SUM(plan.umsatz_netto_plan)               AS ums_netto_plan
	FROM dbp_msi_view_vis.mv_wup_plan_kjmo_owg_2 plan
	JOIN DBP_MSI_VIEW_VIS.MV_OWG_INT_2 owg
	ON   owg.owg_id = plan.owg_id  
	JOIN DBP_MSI_VIEW_VIS.MV_HWG_INT_2 hwg
	ON   hwg.hwg_id = owg.hwg_id
	JOIN DBP_MSI_VIEW_VIS.MV_ABT_INT_2 abt_2
	ON   abt.abt_id = hwg.abt_id
	JOIN DBP_DATA.MONAT_2  zeit_2
	ON   zeit.kjmo = plan.kjmo AND zeit.akt_gj = 0
    WHERE abt.abt_id IN (5,6)
	GROUP BY plan.mandant_id, plan.nb_id, plan.wup_id, plan.wrg_id, zeit.gj, abt.abt_id, hwg.hwg_id
) plan
ON plan.mandant_id = vis.mandant_id AND plan.wup_id = vis.wup_id
AND plan.wrg_id = vis.wrg_id AND plan.gj = vis.gj 
AND plan.hwg_id = vis.hwg_id 
LEFT JOIN DBP_MSI_VIEW_VIS.MV_VIS_JZG_ZIEL_WERT_2  jzg10 /* 10 Umsatz */
ON  jzg10.mandant_id = vis.mandant_id AND jzg10.wup_id = vis.wup_id
AND jzg10.wrg_id = vis.wrg_id AND jzg10.gj = vis.gj
AND jzg10.metrik_id = 10 AND jzg10.typ_id = 0 AND jzg10.level_id = 0 
 
/* JZG 103-5xxxxxx - Umsatz OWG */
UNION ALL
SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id
, vis.gj      AS GJ
, 10::INTEGER AS METRIK_ID
, 2::INTEGER  AS TYP_ID
, (vis.abt_id * 1000000 + ABS(vis.hwg_id) * 10000)::INTEGER AS LEVEL_ID
, plan.ums_netto_plan AS PLAN_GJ1 /* Plan Ware */
, 1.00 AS PLAN_GJ2
, plan.ums_netto_plan AS PLAN_GJ
, NULL AS EINGABE /* Eingabe = Ebene Filiale*/
, plan.ums_netto_plan / NULLIFZERO(fil.ums_netto_plan) AS ANTEIL /* Basis = Plan Filiale */
, jzg10.wert_eingabe * ANTEIL AS ZIEL1  /*Ziel berechnet*/
, 1.00 AS ZIEL2 
, COALESCE(jzg10.wert_eingabe * ANTEIL, 0) AS ZIEL
, '' AS KOMMENTAR /* nur auf Ebene Eingabe */
FROM ( /* JZG OWG - Umsatz Ware */
	SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.gj, abt.abt_id, hwg.hwg_id, owg.owg_id
	, SUM(vis.ums_netto) AS ums_netto
	FROM DBP_MSI_DATA.VIS_MONAT_UMSATZ_WG_2  vis
	JOIN DBP_MSI_VIEW_VIS.MV_WG_INT_2 wg 
	ON   wg.wg_id = vis.wg_id
	JOIN DBP_MSI_VIEW_VIS.MV_OWG_INT_2 owg
	ON   owg.owg_id = wg.owg_id
	JOIN DBP_MSI_VIEW_VIS.MV_HWG_INT_2 hwg
	ON   hwg.hwg_id = owg.hwg_id
	JOIN DBP_MSI_VIEW_VIS.MV_ABT_INT_2 abt_2
	ON   abt.abt_id = hwg.abt_id
	JOIN DBP_DATA.MONAT_2  zeit_2
	ON   zeit.kjmo = vis.kjmo AND zeit.akt_gj = 0
	WHERE abt.abt_id IN (5)
	GROUP BY vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.gj, abt.abt_id, hwg.hwg_id, owg.owg_id
) vis
JOIN ( /* JZG OWG - Plan Filiale */
	SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.gj
	, SUM(vis.ums_netto_plan) AS ums_netto_plan
	FROM DBP_MSI_DATA.VIS_MONAT_UMS_KUNDE_PERS_WUP_2   vis
	JOIN DBP_DATA.MONAT_2 zeit_2
	ON   zeit.kjmo = vis.kjmo AND zeit.akt_gj = 0
	GROUP BY vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.gj
) fil
ON fil.mandant_id = vis.mandant_id AND fil.wup_id = vis.wup_id
AND fil.wrg_id = vis.wrg_id AND fil.gj = vis.gj 
LEFT JOIN ( /* JZG OWG - Plan VJ */
	SELECT plan.mandant_id, plan.nb_id, plan.wup_id, plan.wrg_id, zeit.gj, abt.abt_id, hwg.hwg_id, owg.owg_id
	, SUM(plan.umsatz_netto_plan)               AS ums_netto_plan
	FROM dbp_msi_view_vis.mv_wup_plan_kjmo_owg_2 plan
	JOIN DBP_MSI_VIEW_VIS.MV_OWG_INT_2 owg
	ON   owg.owg_id = plan.owg_id  
	JOIN DBP_MSI_VIEW_VIS.MV_HWG_INT_2 hwg
	ON   hwg.hwg_id = owg.hwg_id
	JOIN DBP_MSI_VIEW_VIS.MV_ABT_INT_2 abt_2
	ON   abt.abt_id = hwg.abt_id
	JOIN DBP_DATA.MONAT_2  zeit_2
	ON   zeit.kjmo = plan.kjmo AND zeit.akt_gj = 0
    WHERE abt.abt_id IN (5)
	GROUP BY plan.mandant_id, plan.nb_id, plan.wup_id, plan.wrg_id, zeit.gj, abt.abt_id, hwg.hwg_id, owg.owg_id
) plan
ON plan.mandant_id = vis.mandant_id AND plan.wup_id = vis.wup_id
AND plan.wrg_id = vis.wrg_id AND plan.gj = vis.gj 
AND plan.owg_id = vis.owg_id 
LEFT JOIN DBP_MSI_VIEW_VIS.MV_VIS_JZG_ZIEL_WERT_2  jzg10 /* 10 Umsatz */
ON  jzg10.mandant_id = vis.mandant_id AND jzg10.wup_id = vis.wup_id
AND jzg10.wrg_id = vis.wrg_id AND jzg10.gj = vis.gj
AND jzg10.metrik_id = 10 AND jzg10.typ_id = 0 AND jzg10.level_id = 0 
 
/* JZG 130-0 - Kunden Filiale */
UNION ALL
SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id
, vis.gj      AS GJ
, 13::INTEGER AS METRIK_ID
, 0::INTEGER  AS TYP_ID
, 0::INTEGER  AS LEVEL_ID
, NULL AS PLAN_GJ1 /* kein Plan */
, NULL AS PLAN_GJ2
, NULL PLAN_GJ
, jzg13.wert_eingabe AS EINGABE /* Kunden */
, NULL AS ANTEIL
, jzg13.wert_eingabe AS ZIEL1 /* ZIEL = Eingabe */
, 1.00 AS ZIEL2 
, COALESCE(jzg13.wert_eingabe, 0)       AS ZIEL 
, COALESCE(jzg13.kommentar_eingabe, '') AS KOMMENTAR 
FROM ( /* JZG Filiale - MAIN */
	SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.gj
	FROM DBP_MSI_DATA.VIS_MONAT_UMS_KUNDE_PERS_WUP_2   vis
	JOIN DBP_DATA.MONAT_2 zeit_2
	ON   zeit.kjmo = vis.kjmo AND zeit.akt_gj = 0 AND zeit.mo_kj=2
) vis
LEFT JOIN DBP_MSI_VIEW_VIS.MV_VIS_JZG_ZIEL_WERT_2  jzg13 /* 10 Kunde */
ON  jzg13.mandant_id = vis.mandant_id AND jzg13.wup_id = vis.wup_id
AND jzg13.wrg_id = vis.wrg_id AND jzg13.gj = vis.gj
AND jzg13.metrik_id = 13 AND jzg13.typ_id = 0 AND jzg13.level_id = 0 
 
/* JZG 160-0 - Ø Bon Filiale */
UNION ALL 
SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id
, vis.gj      AS GJ
, 16::INTEGER AS METRIK_ID
, 0::INTEGER  AS TYP_ID
, 0::INTEGER  AS LEVEL_ID
, NULL AS PLAN_GJ1 /* kein Plan */
, NULL AS PLAN_GJ2
, NULL PLAN_GJ
, NULL AS EINGABE
, NULL AS ANTEIL
, jzg10.wert_eingabe AS ZIEL1 /* Eingabe Umsatz Filiale */
, jzg13.wert_eingabe AS ZIEL2 /* Eingabe Kunden Filiale */
, COALESCE(ZIEL1 / NULLIFZERO(ZIEL2), 0) AS ZIEL 
, '' AS KOMMENTAR /* nur auf Ebene Eingabe */
FROM ( /* JZG Filiale - MAIN */
	SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.gj
	FROM DBP_MSI_DATA.VIS_MONAT_UMS_KUNDE_PERS_WUP_2   vis
	JOIN DBP_DATA.MONAT_2 zeit_2
	ON   zeit.kjmo = vis.kjmo AND zeit.akt_gj = 0 AND zeit.mo_kj=2
) vis
LEFT JOIN DBP_MSI_VIEW_VIS.MV_VIS_JZG_ZIEL_WERT_2  jzg10 /* 10 Umsatz */
ON  jzg10.mandant_id = vis.mandant_id AND jzg10.wup_id = vis.wup_id
AND jzg10.wrg_id = vis.wrg_id AND jzg10.gj = vis.gj
AND jzg10.metrik_id = 10 AND jzg10.typ_id = 0 AND jzg10.level_id = 0 
LEFT JOIN DBP_MSI_VIEW_VIS.MV_VIS_JZG_ZIEL_WERT_2  jzg13 /* 13 Kunde */
ON  jzg13.mandant_id = vis.mandant_id AND jzg13.wup_id = vis.wup_id
AND jzg13.wrg_id = vis.wrg_id AND jzg13.gj = vis.gj
AND jzg13.metrik_id = 13 AND jzg13.typ_id = 0 AND jzg13.level_id = 0 
 
/* JZG 200-0 - Nettoleistung Filiale */
UNION ALL 
SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id
, vis.gj      AS GJ
, 20::INTEGER AS METRIK_ID
, 0::INTEGER  AS TYP_ID
, 0::INTEGER  AS LEVEL_ID
, vis.ums_netto_plan AS PLAN_GJ1 
, vis.pers_std_plan  AS PLAN_GJ2
, vis.ums_netto_plan / NULLIFZERO(vis.pers_std_plan) AS PLAN_GJ
, NULL AS EINGABE
, NULL AS ANTEIL
, jzg10.wert_eingabe AS ZIEL1 /* Eingabe Umsatz Filiale */
, jzg23.wert_eingabe AS ZIEL2 /* Eingabe Stunden_2 Filiale */
, COALESCE(ZIEL1 / NULLIFZERO(ZIEL2), 0) AS ZIEL 
, '' AS KOMMENTAR /* nur auf Ebene Eingabe */
FROM ( /* JZG Filiale - MAIN */
	SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.gj
	, SUM(vis.ums_netto_plan) AS ums_netto_plan
	, SUM(vis.pers_std_plan)  AS pers_std_plan
	FROM DBP_MSI_DATA.VIS_MONAT_UMS_KUNDE_PERS_WUP_2   vis
	JOIN DBP_DATA.MONAT_2 zeit_2
	ON   zeit.kjmo = vis.kjmo AND zeit.akt_gj = 0
	GROUP BY vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.gj
) vis
LEFT JOIN DBP_MSI_VIEW_VIS.MV_VIS_JZG_ZIEL_WERT_2  jzg10 /* 10 Umsatz */
ON  jzg10.mandant_id = vis.mandant_id AND jzg10.wup_id = vis.wup_id
AND jzg10.wrg_id = vis.wrg_id AND jzg10.gj = vis.gj
AND jzg10.metrik_id = 10 AND jzg10.typ_id = 0 AND jzg10.level_id = 0 
LEFT JOIN DBP_MSI_VIEW_VIS.MV_VIS_JZG_ZIEL_WERT_2 jzg23 /* 23 Stunden_2 */
ON jzg23.mandant_id = vis.mandant_id AND jzg23.wup_id = vis.wup_id
AND jzg23.wrg_id = vis.wrg_id AND jzg23.gj = vis.gj
AND jzg23.metrik_id = 23 AND jzg23.typ_id = 0 AND jzg23.level_id = 0 

/* JZG 230-0 - Nettostunden Filiale */
UNION ALL 
SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id
, vis.gj      AS GJ
, 23::INTEGER AS METRIK_ID
, 0::INTEGER  AS TYP_ID
, 0::INTEGER  AS LEVEL_ID
, vis.pers_std_plan AS PLAN_GJ1
, 1.00 AS PLAN_GJ2
, vis.pers_std_plan AS PLAN_GJ
, jzg23.wert_eingabe AS EINGABE /* Ziel = Eingabe Stunden_2 Filiale */
, NULL AS ANTEIL
, jzg23.wert_eingabe AS ZIEL1 
, 1.00 AS ZIEL2 
, COALESCE(jzg23.wert_eingabe, 0)      AS ZIEL 
, COALESCE(jzg23.kommentar_eingabe, '') AS KOMMENTAR
FROM ( /* JZG Filiale - MAIN */
	SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.gj
	, SUM(vis.ums_netto_plan) AS ums_netto_plan
	, SUM(vis.pers_std_plan)  AS pers_std_plan
	FROM DBP_MSI_DATA.VIS_MONAT_UMS_KUNDE_PERS_WUP_2   vis
	JOIN DBP_DATA.MONAT_2 zeit_2
	ON   zeit.kjmo = vis.kjmo AND zeit.akt_gj = 0
	GROUP BY vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.gj
) vis
LEFT JOIN DBP_MSI_VIEW_VIS.MV_VIS_JZG_ZIEL_WERT_2 jzg23 /* 23 Stunden_2 */
ON jzg23.mandant_id = vis.mandant_id AND jzg23.wup_id = vis.wup_id
AND jzg23.wrg_id = vis.wrg_id AND jzg23.gj = vis.gj
AND jzg23.metrik_id = 23 AND jzg23.typ_id = 0 AND jzg23.level_id = 0 
 
/* JZG 400-0 - Abschriften_2 Filiale v2 */
UNION ALL 
SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id
, vis.gj      AS GJ
, 40::INTEGER AS METRIK_ID
, 0::INTEGER  AS TYP_ID
, 0::INTEGER  AS LEVEL_ID
, vis_agg.abs_plan AS PLAN_GJ1 
, vis_agg.ums_plan AS PLAN_GJ2
, vis_agg.abs_plan / NULLIFZERO(vis_agg.ums_plan) AS PLAN_GJ
, NULL AS EINGABE /* keine Eingabe Filiale */
, vis_agg.anteil   AS ANTEIL
, vis_agg.abs_ziel AS ZIEL1 /* berechnet Abschriften_2 */
, vis_agg.ums_ziel AS ZIEL2 /* berechnet Umsatz */
, COALESCE(ZIEL1 / NULLIFZERO(ZIEL2), 0) AS ZIEL 
, COALESCE(vis_agg.kommentar, '') AS KOMMENTAR /* nur auf Ebene Eingabe */
FROM ( /* JZG Filiale - MAIN */
	SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.gj
	, SUM(vis.ums_netto_plan) AS ums_netto_plan
	, SUM(vis.pers_std_plan)  AS pers_std_plan
	FROM DBP_MSI_DATA.VIS_MONAT_UMS_KUNDE_PERS_WUP_2   vis
	JOIN DBP_DATA.MONAT_2 zeit_2
	ON   zeit.kjmo = vis.kjmo AND zeit.akt_gj = 0
	GROUP BY vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.gj
) vis
LEFT JOIN ( /* JZG Filiale - Plan/Eingabe */ 
	SELECT vis_plan_fil.mandant_id, vis_plan_fil.nb_id, vis_plan_fil.wup_id, vis_plan_fil.wrg_id, vis_plan_fil.gj
	, SUM(vis_plan_fil.abs_plan) AS abs_plan
	, SUM(vis_plan_fil.ums_plan) AS ums_plan
	, SUM(vis_plan_fil.anteil)   AS anteil
    , NULL AS kommentar 
	, SUM(vis_plan_fil.ums_ziel) AS ums_ziel
	, SUM(vis_plan_fil.abs_ziel) AS abs_ziel
	FROM ( /*Berechnung auf 3 Leveln - OWG, HWG, Abteilung */
    	/* Filiale - Abteilung 5 > Join Level OWG */
        SELECT vis_plan.mandant_id, vis_plan.nb_id, vis_plan.wup_id, vis_plan.wrg_id, vis_plan.gj, vis_plan.abt_id, vis_plan.hwg_id, vis_plan.owg_id
        , vis_plan.abschriften_netto_operativ_plan AS abs_plan
        , vis_plan.umsatz_netto_plan AS ums_plan 
        , abs_plan / NULLIFZERO(ums_plan) AS co_plan
        , ums_plan / NULLIFZERO(vis_tag.ums_netto_plan) AS anteil
        , anteil * jzg10.wert_eingabe AS ums_ziel
        , ums_ziel * COALESCE(jzg40.wert_eingabe, co_plan) AS abs_ziel
        FROM ( /* Abteilung 5 OWG */
            SELECT plan.mandant_id, plan.nb_id, plan.wup_id, plan.wrg_id, zeit.gj, abt.abt_id, hwg.hwg_id, owg.owg_id
            , (abt.abt_id * 1000000 + ABS(hwg.hwg_id) * 10000 + ABS(owg.owg_id))::INTEGER AS LEVEL_ID
            , SUM(plan.umsatz_netto_plan) AS umsatz_netto_plan
            , SUM(plan.abschriften_netto_operativ_plan) AS abschriften_netto_operativ_plan
            FROM dbp_msi_view_vis.mv_wup_plan_kjmo_owg_2 plan
            JOIN DBP_MSI_VIEW_VIS.MV_OWG_INT_2 owg
            ON owg.owg_id = plan.owg_id  
            JOIN DBP_MSI_VIEW_VIS.MV_HWG_INT_2 hwg
            ON hwg.hwg_id = owg.hwg_id
            JOIN DBP_MSI_VIEW_VIS.MV_ABT_INT_2 abt_2
            ON abt.abt_id = hwg.abt_id
            JOIN DBP_DATA.MONAT_2 zeit_2
            ON zeit.kjmo = plan.kjmo AND zeit.akt_gj = 0 
            WHERE abt.abt_id = 5
            GROUP BY plan.mandant_id, plan.nb_id, plan.wup_id, zeit.gj, plan.wrg_id, abt.abt_id, hwg.hwg_id, owg.owg_id, LEVEL_ID
        ) vis_plan
        LEFT JOIN DBP_MSI_VIEW_VIS.MV_VIS_JZG_ZIEL_WERT_2 jzg40 /* 40 Abschriften_2 OWG */
        ON jzg40.mandant_id = vis_plan.mandant_id AND jzg40.wup_id = vis_plan.wup_id
        AND jzg40.wrg_id = vis_plan.wrg_id AND jzg40.gj = vis_plan.gj
        AND jzg40.metrik_id = 40 AND jzg40.level_id = vis_plan.level_id
        LEFT JOIN DBP_MSI_VIEW_VIS.MV_VIS_JZG_ZIEL_WERT_2 jzg10 /* 10 Umsatz Filiale */
        ON jzg10.mandant_id = vis_plan.mandant_id AND jzg10.wup_id = vis_plan.wup_id
        AND jzg10.wrg_id = vis_plan.wrg_id AND jzg10.gj = vis_plan.gj
        AND jzg10.metrik_id = 10 AND jzg10.typ_id = 0 AND jzg10.level_id = 0 
        JOIN ( /* Umsatz Plan Filiale Gesamt */
            SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.gj
            , SUM(vis.ums_netto_plan) AS ums_netto_plan
            FROM dbp_msi_data.vis_tag_umsatz_kunde_wup_2 vis
            JOIN DBP_DATA.MONAT_2 zeit_2
            ON zeit.kjmo = vis.kjmo AND zeit.akt_gj = 0
            GROUP BY vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.gj
        ) vis_tag
        ON vis_tag.mandant_id = vis_plan.mandant_id AND vis_tag.wup_id = vis_plan.wup_id
        AND vis_tag.wrg_id = vis_plan.wrg_id AND vis_tag.gj = vis_plan.gj
        /* Filiale - Abteilung 6 > Join Level HWG */
        UNION ALL 
        SELECT vis_plan.mandant_id, vis_plan.nb_id, vis_plan.wup_id, vis_plan.wrg_id, vis_plan.gj, vis_plan.abt_id, vis_plan.hwg_id, 0 AS owg_id
        , vis_plan.abschriften_netto_operativ_plan AS abs_plan
        , vis_plan.umsatz_netto_plan AS ums_plan 
        , abs_plan / NULLIFZERO(ums_plan) AS co_plan
        , ums_plan / NULLIFZERO(vis_tag.ums_netto_plan) AS anteil
        , anteil * jzg10.wert_eingabe AS ums_ziel
        , ums_ziel * COALESCE(jzg40.wert_eingabe, co_plan) AS abs_ziel
        FROM ( /* Abteilung 6 HWG */
            SELECT plan.mandant_id, plan.nb_id, plan.wup_id, plan.wrg_id, zeit.gj, abt.abt_id, hwg.hwg_id
            , (abt.abt_id * 1000000 + ABS(hwg.hwg_id) * 10000)::INTEGER AS LEVEL_ID
            , SUM(plan.umsatz_netto_plan) AS umsatz_netto_plan
            , SUM(plan.abschriften_netto_operativ_plan) AS abschriften_netto_operativ_plan
            FROM dbp_msi_view_vis.mv_wup_plan_kjmo_owg_2 plan
            JOIN DBP_MSI_VIEW_VIS.MV_OWG_INT_2 owg
            ON owg.owg_id = plan.owg_id  
            JOIN DBP_MSI_VIEW_VIS.MV_HWG_INT_2 hwg
            ON hwg.hwg_id = owg.hwg_id
            JOIN DBP_MSI_VIEW_VIS.MV_ABT_INT_2 abt_2
            ON abt.abt_id = hwg.abt_id
            JOIN DBP_DATA.MONAT_2 zeit_2
            ON zeit.kjmo = plan.kjmo AND zeit.akt_gj = 0 
            WHERE abt.abt_id = 6
            GROUP BY plan.mandant_id, plan.nb_id, plan.wup_id, plan.wrg_id, zeit.gj, abt.abt_id, hwg.hwg_id, LEVEL_ID
        ) vis_plan
        LEFT JOIN DBP_MSI_VIEW_VIS.MV_VIS_JZG_ZIEL_WERT_2 jzg40 /* 40 Abschriften_2 HWG */
        ON jzg40.mandant_id = vis_plan.mandant_id AND jzg40.wup_id = vis_plan.wup_id
        AND jzg40.wrg_id = vis_plan.wrg_id AND jzg40.gj = vis_plan.gj
        AND jzg40.metrik_id = 40 AND jzg40.level_id = vis_plan.level_id
        LEFT JOIN DBP_MSI_VIEW_VIS.MV_VIS_JZG_ZIEL_WERT_2 jzg10 /* 10 Umsatz Filiale */
        ON jzg10.mandant_id = vis_plan.mandant_id AND jzg10.wup_id = vis_plan.wup_id
        AND jzg10.wrg_id = vis_plan.wrg_id AND jzg10.gj = vis_plan.gj
        AND jzg10.metrik_id = 10 AND jzg10.typ_id = 0 AND jzg10.level_id = 0 
        JOIN ( /* Umsatz Plan Filiale */
            SELECT vis.mandant_id, vis.nb_id, vis.wup_id, zeit.gj, vis.wrg_id
            , SUM(vis.ums_netto_plan) AS ums_netto_plan
            FROM dbp_msi_data.vis_tag_umsatz_kunde_wup_2 vis
            JOIN DBP_DATA.MONAT_2 zeit_2
            ON zeit.kjmo = vis.kjmo AND zeit.akt_gj = 0
            GROUP BY vis.mandant_id, vis.nb_id, vis.wup_id, zeit.gj, vis.wrg_id
        ) vis_tag
        ON vis_tag.mandant_id = vis_plan.mandant_id AND vis_tag.wup_id = vis_plan.wup_id
        AND vis_tag.wrg_id = vis_plan.wrg_id AND vis_tag.gj = vis_plan.gj 
        /* ABTEILUNG - Abteilung 7,8,4 > Join Level Abteilung */
        UNION ALL 
        SELECT vis_plan.mandant_id, vis_plan.nb_id, vis_plan.wup_id, vis_plan.wrg_id, vis_plan.gj, vis_plan.abt_id,  0 AS hwg_id, 0 AS owg_id
        , vis_plan.abschriften_netto_operativ_plan AS abs_plan
        , vis_plan.umsatz_netto_plan AS ums_plan 
        , abs_plan / NULLIFZERO(ums_plan) AS co_plan
        , ums_plan / NULLIFZERO(vis_tag.ums_netto_plan) AS anteil
        , anteil * jzg10.wert_eingabe AS ums_ziel
        , ums_ziel * COALESCE(jzg40.wert_eingabe, co_plan) AS abs_ziel
        FROM ( /* Abteilung 7,8,4 */
            SELECT plan.mandant_id, plan.nb_id, plan.wup_id, plan.wrg_id, zeit.gj, abt.abt_id
            , (CASE abt.abt_id WHEN 4 THEN 9999999 ELSE abt.abt_id * 1000000 END)::INTEGER AS LEVEL_ID
            , SUM(plan.umsatz_netto_plan) AS umsatz_netto_plan
            , SUM(plan.abschriften_netto_operativ_plan) AS abschriften_netto_operativ_plan
            FROM dbp_msi_view_vis.mv_wup_plan_kjmo_owg_2 plan
            JOIN DBP_MSI_VIEW_VIS.MV_OWG_INT_2 owg
            ON owg.owg_id = plan.owg_id  
            JOIN DBP_MSI_VIEW_VIS.MV_HWG_INT_2 hwg
            ON hwg.hwg_id = owg.hwg_id
            JOIN DBP_MSI_VIEW_VIS.MV_ABT_INT_2 abt_2
            ON abt.abt_id = hwg.abt_id 
            JOIN DBP_DATA.MONAT_2 zeit_2
            ON zeit.kjmo = plan.kjmo AND zeit.akt_gj = 0  
            WHERE abt.abt_id IN (4,7,8)
            GROUP BY plan.mandant_id, plan.nb_id, plan.wup_id, plan.wrg_id, zeit.gj, abt.abt_id, LEVEL_ID
        ) vis_plan
        LEFT JOIN DBP_MSI_VIEW_VIS.MV_VIS_JZG_ZIEL_WERT_2 jzg40 /* 40 Abschriften_2 Abteilung */
        ON jzg40.mandant_id = vis_plan.mandant_id AND jzg40.wup_id = vis_plan.wup_id
        AND jzg40.wrg_id = vis_plan.wrg_id AND jzg40.gj = vis_plan.gj
        AND jzg40.metrik_id = 40 AND jzg40.level_id = vis_plan.level_id
        LEFT JOIN DBP_MSI_VIEW_VIS.MV_VIS_JZG_ZIEL_WERT_2 jzg10 /* 10 Umsatz Filiale */
        ON jzg10.mandant_id = vis_plan.mandant_id AND jzg10.wup_id = vis_plan.wup_id
        AND jzg10.wrg_id = vis_plan.wrg_id AND jzg10.gj = vis_plan.gj
        AND jzg10.metrik_id = 10 AND jzg10.typ_id = 0 AND jzg10.level_id = 0 
        JOIN ( /* Umsatz Plan Filiale */
            SELECT vis.mandant_id, vis.nb_id, vis.wup_id, zeit.gj, vis.wrg_id
            , SUM(vis.ums_netto_plan) AS ums_netto_plan
            FROM dbp_msi_data.vis_tag_umsatz_kunde_wup_2 vis
            JOIN DBP_DATA.MONAT_2 zeit_2
            ON zeit.kjmo = vis.kjmo AND zeit.akt_gj = 0
            GROUP BY vis.mandant_id, vis.nb_id, vis.wup_id, zeit.gj, vis.wrg_id
        ) vis_tag
        ON vis_tag.mandant_id = vis_plan.mandant_id AND vis_tag.wup_id = vis_plan.wup_id
        AND vis_tag.wrg_id = vis_plan.wrg_id AND vis_tag.gj = vis_plan.gj         
	) vis_plan_fil
	GROUP BY vis_plan_fil.mandant_id, vis_plan_fil.nb_id, vis_plan_fil.wup_id, vis_plan_fil.wrg_id ,vis_plan_fil.gj
) vis_agg
ON vis_agg.mandant_id = vis.mandant_id AND vis_agg.wup_id = vis.wup_id
AND vis_agg.wrg_id = vis.wrg_id AND vis_agg.gj = vis.gj  
 
/* JZG 401-x000000 - Abschriften_2 Abteilung v2*/
UNION ALL 
SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id
, vis.gj      AS GJ
, 40::INTEGER AS METRIK_ID
, 1::INTEGER  AS TYP_ID
, (CASE vis.abt_id WHEN 4 THEN 9999999 ELSE vis.abt_id * 1000000 END)::INTEGER AS LEVEL_ID
, vis_agg.abs_plan AS PLAN_GJ1 
, vis_agg.ums_plan AS PLAN_GJ2
, vis_agg.abs_plan / NULLIFZERO(vis_agg.ums_plan) AS PLAN_GJ
, vis_agg.eingabe  AS EINGABE
, vis_agg.anteil   AS ANTEIL
, vis_agg.abs_ziel AS ZIEL1 /* berechnet Abschriften_2 */
, vis_agg.ums_ziel AS ZIEL2 /* berechnet Umsatz */
, COALESCE(ZIEL1 / NULLIFZERO(ZIEL2), 0) AS ZIEL 
, COALESCE(vis_agg.kommentar, '') AS KOMMENTAR /* nur auf Ebene Eingabe */
FROM ( /* JZG Abteilung - Ware */
	SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.gj, abt.abt_id
	, SUM(vis.ums_netto) AS ums_netto
	FROM DBP_MSI_DATA.VIS_MONAT_UMSATZ_WG_2  vis
	JOIN DBP_MSI_VIEW_VIS.MV_WG_INT_2 wg 
	ON   wg.wg_id = vis.wg_id
	JOIN DBP_MSI_VIEW_VIS.MV_OWG_INT_2 owg
	ON   owg.owg_id = wg.owg_id
	JOIN DBP_MSI_VIEW_VIS.MV_HWG_INT_2 hwg
	ON   hwg.hwg_id = owg.hwg_id
	JOIN DBP_MSI_VIEW_VIS.MV_ABT_INT_2 abt_2
	ON   abt.abt_id = hwg.abt_id
	JOIN DBP_DATA.MONAT_2  zeit_2
	ON   zeit.kjmo = vis.kjmo AND zeit.akt_gj = 0
	WHERE abt.abt_id > 0
	GROUP BY vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.gj, abt.abt_id
) vis
LEFT JOIN ( /* JZG Abteilung - Plan/Eingabe */ 
    /* ABTEILUNG - Abteilung 5 Grouping */
    SELECT vis_plan_owg.mandant_id, vis_plan_owg.nb_id, vis_plan_owg.wup_id, vis_plan_owg.gj, vis_plan_owg.wrg_id, vis_plan_owg.abt_id
    , SUM(vis_plan_owg.abs_plan) AS abs_plan
    , SUM(vis_plan_owg.ums_plan) AS ums_plan
    , SUM(vis_plan_owg.anteil)   AS anteil
    , NULL AS eingabe
    , NULL AS kommentar
    , SUM(vis_plan_owg.ums_ziel) AS ums_ziel
    , SUM(vis_plan_owg.abs_ziel) AS abs_ziel
    FROM ( /* ABTEILUNG - Abteilung 5 Join Level OWG */
        SELECT vis_plan.mandant_id, vis_plan.nb_id, vis_plan.wup_id, vis_plan.gj, vis_plan.wrg_id, vis_plan.abt_id, vis_plan.hwg_id, vis_plan.owg_id
        , vis_plan.abschriften_netto_operativ_plan AS abs_plan
        , vis_plan.umsatz_netto_plan AS ums_plan /* Plan Ware */
        , ums_plan / NULLIFZERO(vis_tag.ums_netto_plan) AS anteil /* Plan Filiale */
        , jzg40.kommentar_eingabe AS kommentar
        , anteil * jzg10.wert_eingabe AS ums_ziel
        , ums_ziel * COALESCE(jzg40.wert_eingabe, abs_plan / NULLIFZERO(ums_plan)) AS abs_ziel
        FROM ( 
            SELECT plan.mandant_id, plan.nb_id, plan.wup_id, zeit.gj, plan.wrg_id, abt.abt_id, hwg.hwg_id, owg.owg_id
            , (abt.abt_id * 1000000 + ABS(hwg.hwg_id) * 10000 + ABS(owg.owg_id))::INTEGER AS LEVEL_ID
            , SUM(plan.umsatz_netto_plan) AS umsatz_netto_plan
            , SUM(plan.abschriften_netto_operativ_plan) AS abschriften_netto_operativ_plan
            FROM dbp_msi_view_vis.mv_wup_plan_kjmo_owg_2 plan
            JOIN DBP_MSI_VIEW_VIS.MV_OWG_INT_2 owg
            ON owg.owg_id = plan.owg_id  
            JOIN DBP_MSI_VIEW_VIS.MV_HWG_INT_2 hwg
            ON hwg.hwg_id = owg.hwg_id
            JOIN DBP_MSI_VIEW_VIS.MV_ABT_INT_2 abt_2
            ON abt.abt_id = hwg.abt_id
            JOIN DBP_DATA.MONAT_2 zeit_2
            ON zeit.kjmo = plan.kjmo AND zeit.akt_gj = 0
            WHERE abt.abt_id = 5 
            GROUP BY plan.mandant_id, plan.nb_id, plan.wup_id, zeit.gj, plan.wrg_id, abt.abt_id, hwg.hwg_id, owg.owg_id, LEVEL_ID
        ) vis_plan
        LEFT JOIN DBP_MSI_VIEW_VIS.MV_VIS_JZG_ZIEL_WERT_2 jzg40 /* Eingabe Abschriften_2 OWG */
        ON jzg40.mandant_id = vis_plan.mandant_id AND jzg40.wup_id = vis_plan.wup_id
        AND jzg40.wrg_id = vis_plan.wrg_id AND jzg40.gj = vis_plan.gj
        AND jzg40.metrik_id = 40 AND jzg40.level_id = vis_plan.level_id
        LEFT JOIN DBP_MSI_VIEW_VIS.MV_VIS_JZG_ZIEL_WERT_2 jzg10 /* Eingabe Umsatz Filiale */
        ON jzg10.mandant_id = vis_plan.mandant_id AND jzg10.wup_id = vis_plan.wup_id
        AND jzg10.wrg_id = vis_plan.wrg_id AND jzg10.gj = vis_plan.gj
        AND jzg10.metrik_id = 10 AND jzg10.typ_id = 0 AND jzg10.level_id = 0 
        JOIN ( /* Umsatz Plan Filiale */
            SELECT vis.mandant_id, vis.nb_id, vis.wup_id, zeit.gj, vis.wrg_id
            , SUM(vis.ums_netto_plan) AS ums_netto_plan
            FROM dbp_msi_data.vis_tag_umsatz_kunde_wup_2 vis
            JOIN DBP_DATA.MONAT_2 zeit_2
            ON zeit.kjmo = vis.kjmo AND zeit.akt_gj = 0
            GROUP BY vis.mandant_id, vis.nb_id, vis.wup_id, zeit.gj, vis.wrg_id
        ) vis_tag
        ON vis_tag.mandant_id = vis_plan.mandant_id AND vis_tag.wup_id = vis_plan.wup_id
        AND vis_tag.wrg_id = vis_plan.wrg_id AND vis_tag.gj = vis_plan.gj
    ) vis_plan_owg
    GROUP BY vis_plan_owg.mandant_id, vis_plan_owg.nb_id, vis_plan_owg.wup_id, vis_plan_owg.gj, vis_plan_owg.wrg_id, vis_plan_owg.abt_id
    /* ABTEILUNG - Abteilung 6 Grouping */
    UNION ALL
    SELECT vis_plan_hwg.mandant_id, vis_plan_hwg.nb_id, vis_plan_hwg.wup_id, vis_plan_hwg.gj, vis_plan_hwg.wrg_id, vis_plan_hwg.abt_id
    , SUM(vis_plan_hwg.abs_plan) AS abs_plan
    , SUM(vis_plan_hwg.ums_plan) AS ums_plan
    , SUM(vis_plan_hwg.anteil)   AS anteil
    , NULL AS eingabe
    , NULL AS kommentar 
    , SUM(vis_plan_hwg.ums_ziel) AS ums_ziel
    , SUM(vis_plan_hwg.abs_ziel) AS abs_ziel
    FROM ( /* ABTEILUNG - Abteilung 6 Join Level HWG */
        SELECT vis_plan.mandant_id, vis_plan.nb_id, vis_plan.wup_id, vis_plan.gj, vis_plan.wrg_id, vis_plan.abt_id, vis_plan.hwg_id
        , vis_plan.abschriften_netto_operativ_plan AS abs_plan
        , vis_plan.umsatz_netto_plan AS ums_plan /* Plan Ware */
        , abs_plan / NULLIFZERO(ums_plan) AS co_plan 
        , ums_plan / NULLIFZERO(vis_tag.ums_netto_plan) AS anteil /* Plan Filiale */
        , jzg40.kommentar_eingabe AS kommentar
        , anteil * jzg10.wert_eingabe AS ums_ziel
        , ums_ziel * COALESCE(jzg40.wert_eingabe, co_plan) AS abs_ziel
        FROM (
        	SELECT plan.mandant_id, plan.nb_id, plan.wup_id, zeit.gj, plan.wrg_id, abt.abt_id, hwg.hwg_id
            , (abt.abt_id * 1000000 + ABS(hwg.hwg_id) * 10000)::INTEGER AS LEVEL_ID
            , SUM(plan.umsatz_netto_plan) AS umsatz_netto_plan
            , SUM(plan.abschriften_netto_operativ_plan) AS abschriften_netto_operativ_plan
            FROM dbp_msi_view_vis.mv_wup_plan_kjmo_owg_2 plan
            JOIN DBP_MSI_VIEW_VIS.MV_OWG_INT_2 owg
            ON owg.owg_id = plan.owg_id  
            JOIN DBP_MSI_VIEW_VIS.MV_HWG_INT_2 hwg
            ON hwg.hwg_id = owg.hwg_id
            JOIN DBP_MSI_VIEW_VIS.MV_ABT_INT_2 abt_2
            ON abt.abt_id = hwg.abt_id
            JOIN DBP_DATA.MONAT_2 zeit_2
            ON zeit.kjmo = plan.kjmo AND zeit.akt_gj = 0
            WHERE abt.abt_id = 6
            GROUP BY plan.mandant_id, plan.nb_id, plan.wup_id, zeit.gj, plan.wrg_id, abt.abt_id, hwg.hwg_id, LEVEL_ID
        ) vis_plan
        LEFT JOIN DBP_MSI_VIEW_VIS.MV_VIS_JZG_ZIEL_WERT_2 jzg40 /* Eingabe Abschriften_2 HWG */
        ON jzg40.mandant_id = vis_plan.mandant_id AND jzg40.wup_id = vis_plan.wup_id
        AND jzg40.wrg_id = vis_plan.wrg_id AND jzg40.gj = vis_plan.gj
        AND jzg40.metrik_id = 40 AND jzg40.level_id = vis_plan.level_id
        LEFT JOIN DBP_MSI_VIEW_VIS.MV_VIS_JZG_ZIEL_WERT_2 jzg10 /* Eingabe Umsatz Filiale */
        ON jzg10.mandant_id = vis_plan.mandant_id AND jzg10.wup_id = vis_plan.wup_id
        AND jzg10.wrg_id = vis_plan.wrg_id AND jzg10.gj = vis_plan.gj
        AND jzg10.metrik_id = 10 AND jzg10.typ_id = 0 AND jzg10.level_id = 0 
        JOIN ( /* Umsatz Plan Filiale */
            SELECT vis.mandant_id, vis.nb_id, vis.wup_id, zeit.gj, vis.wrg_id
            , SUM(vis.ums_netto_plan) AS ums_netto_plan
            FROM dbp_msi_data.vis_tag_umsatz_kunde_wup_2 vis
            JOIN DBP_DATA.MONAT_2 zeit_2
            ON zeit.kjmo = vis.kjmo AND zeit.akt_gj = 0
            GROUP BY vis.mandant_id, vis.nb_id, vis.wup_id, zeit.gj, vis.wrg_id
        ) vis_tag
        ON vis_tag.mandant_id = vis_plan.mandant_id AND vis_tag.wup_id = vis_plan.wup_id
        AND vis_tag.wrg_id = vis_plan.wrg_id AND vis_tag.gj = vis_plan.gj 
    ) vis_plan_hwg
    GROUP BY vis_plan_hwg.mandant_id, vis_plan_hwg.nb_id, vis_plan_hwg.wup_id, vis_plan_hwg.gj, vis_plan_hwg.wrg_id, vis_plan_hwg.abt_id
    /* ABTEILUNG - Abteilung 7,8,4 inkl Eingabe */
    UNION ALL 
    SELECT vis_plan.mandant_id, vis_plan.nb_id, vis_plan.wup_id, vis_plan.gj, vis_plan.wrg_id, vis_plan.abt_id
    , vis_plan.abs_netto_plan AS abs_plan
    , vis_plan.ums_netto_plan AS ums_plan
    , ums_plan / NULLIFZERO(vis_tag.ums_netto_plan) AS anteil
    , jzg40.wert_eingabe AS eingabe
    , jzg40.kommentar_eingabe AS kommentar
    , anteil * jzg10.wert_eingabe AS ums_ziel
    , ums_ziel * COALESCE (jzg40.wert_eingabe, abs_plan / NULLIFZERO(ums_plan)) AS abs_ziel
    FROM (  
        SELECT plan.mandant_id, plan.nb_id, plan.wup_id, zeit.gj, plan.wrg_id, abt.abt_id
        , (CASE abt.abt_id WHEN 4 THEN 9999999 ELSE abt.abt_id * 1000000 END)::INTEGER AS LEVEL_ID
        , SUM(plan.umsatz_netto_plan) AS ums_netto_plan
        , SUM(plan.abschriften_netto_operativ_plan) AS abs_netto_plan
        FROM dbp_msi_view_vis.mv_wup_plan_kjmo_owg_2 plan
        JOIN DBP_MSI_VIEW_VIS.MV_OWG_INT_2 owg
        ON owg.owg_id = plan.owg_id  
        JOIN DBP_MSI_VIEW_VIS.MV_HWG_INT_2 hwg
        ON hwg.hwg_id = owg.hwg_id
        JOIN DBP_MSI_VIEW_VIS.MV_ABT_INT_2 abt_2
        ON abt.abt_id = hwg.abt_id
        JOIN DBP_DATA.MONAT_2 zeit_2
        ON zeit.kjmo = plan.kjmo AND zeit.akt_gj = 0
        WHERE abt.abt_id IN (4,7,8)
        GROUP BY plan.mandant_id, plan.nb_id, plan.wup_id, zeit.gj, plan.wrg_id, abt.abt_id, LEVEL_ID
    ) vis_plan
    LEFT JOIN DBP_MSI_VIEW_VIS.MV_VIS_JZG_ZIEL_WERT_2 jzg40 /* Eingabe Abschriften_2 ABT_2 */
    ON jzg40.mandant_id = vis_plan.mandant_id AND jzg40.wup_id = vis_plan.wup_id
    AND jzg40.wrg_id = vis_plan.wrg_id AND jzg40.gj = vis_plan.gj
    AND jzg40.metrik_id = 40 AND jzg40.level_id = vis_plan.level_id
    LEFT JOIN DBP_MSI_VIEW_VIS.MV_VIS_JZG_ZIEL_WERT_2 jzg10 /* Eingabe Umsatz Filiale */
    ON jzg10.mandant_id = vis_plan.mandant_id AND jzg10.wup_id = vis_plan.wup_id
    AND jzg10.wrg_id = vis_plan.wrg_id AND jzg10.gj = vis_plan.gj
    AND jzg10.metrik_id = 10 AND jzg10.typ_id = 0 AND jzg10.level_id = 0 
	JOIN ( /* Umsatz Plan Filiale */
		SELECT vis.mandant_id, vis.nb_id, vis.wup_id, zeit.gj, vis.wrg_id
		, SUM(vis.ums_netto_plan) AS ums_netto_plan
		FROM dbp_msi_data.vis_tag_umsatz_kunde_wup_2 vis
		JOIN DBP_DATA.MONAT_2 zeit_2
		ON zeit.kjmo = vis.kjmo AND zeit.akt_gj = 0
		GROUP BY vis.mandant_id, vis.nb_id, vis.wup_id, zeit.gj, vis.wrg_id
	) vis_tag
	ON vis_tag.mandant_id = vis_plan.mandant_id AND vis_tag.wup_id = vis_plan.wup_id
	AND vis_tag.wrg_id = vis_plan.wrg_id AND vis_tag.gj = vis_plan.gj 
) vis_agg
ON vis_agg.mandant_id = vis.mandant_id AND vis_agg.wup_id = vis.wup_id
AND vis_agg.wrg_id = vis.wrg_id AND vis_agg.gj = vis.gj 
AND vis_agg.abt_id = vis.abt_id 
 
/* JZG 402-xxx0000 - Abschriften_2 HWG v2 */    
UNION ALL 
SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id
, vis.gj      AS GJ
, 40::INTEGER AS METRIK_ID
, 2::INTEGER  AS TYP_ID
, (vis.abt_id * 1000000 + ABS(vis.hwg_id) * 10000)::INTEGER AS LEVEL_ID
, vis_agg.abs_plan AS PLAN_GJ1 
, vis_agg.ums_plan AS PLAN_GJ2
, vis_agg.abs_plan / NULLIFZERO(vis_agg.ums_plan) AS PLAN_GJ
, vis_agg.eingabe  AS EINGABE
, vis_agg.anteil   AS ANTEIL
, vis_agg.abs_ziel AS ZIEL1 /* berechnet Abschriften_2 */
, vis_agg.ums_ziel AS ZIEL2 /* berechnet Umsatz */
, COALESCE(ZIEL1 / NULLIFZERO(ZIEL2), 0) AS ZIEL 
, COALESCE(vis_agg.kommentar, '') AS KOMMENTAR /* nur auf Ebene Eingabe */
FROM ( /* JZG HWG - Ware */
	SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.gj, abt.abt_id, hwg.hwg_id
	, SUM(vis.ums_netto) AS ums_netto
	FROM DBP_MSI_DATA.VIS_MONAT_UMSATZ_WG_2  vis
	JOIN DBP_MSI_VIEW_VIS.MV_WG_INT_2 wg 
	ON   wg.wg_id = vis.wg_id
	JOIN DBP_MSI_VIEW_VIS.MV_OWG_INT_2 owg
	ON   owg.owg_id = wg.owg_id
	JOIN DBP_MSI_VIEW_VIS.MV_HWG_INT_2 hwg
	ON   hwg.hwg_id = owg.hwg_id
	JOIN DBP_MSI_VIEW_VIS.MV_ABT_INT_2 abt_2
	ON   abt.abt_id = hwg.abt_id
	JOIN DBP_DATA.MONAT_2  zeit_2
	ON   zeit.kjmo = vis.kjmo AND zeit.akt_gj = 0
	WHERE abt.abt_id IN (5,6)
	GROUP BY vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.gj, abt.abt_id, hwg.hwg_id
) vis
LEFT JOIN ( /* JZG HWG - Plan inkl. Eingabe */ 
    /* HWG - Abteilung 5 Grouping */
    SELECT vis_plan_owg.mandant_id, vis_plan_owg.nb_id, vis_plan_owg.wup_id, vis_plan_owg.gj, vis_plan_owg.wrg_id, vis_plan_owg.abt_id, vis_plan_owg.hwg_id
    , SUM(vis_plan_owg.abs_plan) AS abs_plan
    , SUM(vis_plan_owg.ums_plan) AS ums_plan
    , SUM(vis_plan_owg.anteil)   AS anteil
    , NULL AS eingabe
    , NULL AS kommentar
    , SUM(vis_plan_owg.ums_ziel) AS ums_ziel
    , SUM(vis_plan_owg.abs_ziel) AS abs_ziel
    FROM ( /* HWG - Abteilung 5 Join Level OWG */
        SELECT vis_plan.mandant_id, vis_plan.nb_id, vis_plan.wup_id, vis_plan.gj, vis_plan.wrg_id, vis_plan.abt_id, vis_plan.hwg_id, vis_plan.owg_id
        , vis_plan.abschriften_netto_operativ_plan AS abs_plan
        , vis_plan.umsatz_netto_plan AS ums_plan /* Plan Ware */
        , ums_plan / NULLIFZERO(vis_tag.ums_netto_plan) AS anteil /* Plan Filiale */
        , jzg40.kommentar_eingabe AS kommentar
        , anteil * jzg10.wert_eingabe AS ums_ziel
        , ums_ziel * COALESCE(jzg40.wert_eingabe, abs_plan / NULLIFZERO(ums_plan)) AS abs_ziel
        FROM ( 
            SELECT plan.mandant_id, plan.nb_id, plan.wup_id, zeit.gj, plan.wrg_id, abt.abt_id, hwg.hwg_id, owg.owg_id
            , (abt.abt_id * 1000000 + ABS(hwg.hwg_id) * 10000 + ABS(owg.owg_id))::INTEGER AS LEVEL_ID
            , SUM(plan.umsatz_netto_plan) AS umsatz_netto_plan
            , SUM(plan.abschriften_netto_operativ_plan) AS abschriften_netto_operativ_plan
            FROM dbp_msi_view_vis.mv_wup_plan_kjmo_owg_2 plan
            JOIN DBP_MSI_VIEW_VIS.MV_OWG_INT_2 owg
            ON owg.owg_id = plan.owg_id  
            JOIN DBP_MSI_VIEW_VIS.MV_HWG_INT_2 hwg
            ON hwg.hwg_id = owg.hwg_id
            JOIN DBP_MSI_VIEW_VIS.MV_ABT_INT_2 abt_2
            ON abt.abt_id = hwg.abt_id
            JOIN DBP_DATA.MONAT_2 zeit_2
            ON zeit.kjmo = plan.kjmo AND zeit.akt_gj = 0
            WHERE abt.abt_id = 5
            GROUP BY plan.mandant_id, plan.nb_id, plan.wup_id, zeit.gj, plan.wrg_id, abt.abt_id, hwg.hwg_id, owg.owg_id, LEVEL_ID
        ) vis_plan
        LEFT JOIN DBP_MSI_VIEW_VIS.MV_VIS_JZG_ZIEL_WERT_2 jzg40 /* 40 Abschriften_2 HWG */
        ON jzg40.mandant_id = vis_plan.mandant_id AND jzg40.wup_id = vis_plan.wup_id
        AND jzg40.wrg_id = vis_plan.wrg_id AND jzg40.gj = vis_plan.gj
        AND jzg40.metrik_id = 40 AND jzg40.level_id = vis_plan.level_id
        LEFT JOIN DBP_MSI_VIEW_VIS.MV_VIS_JZG_ZIEL_WERT_2 jzg10 /* 10 Umsatz Filiale */
        ON jzg10.mandant_id = vis_plan.mandant_id AND jzg10.wup_id = vis_plan.wup_id
        AND jzg10.wrg_id = vis_plan.wrg_id AND jzg10.gj = vis_plan.gj
        AND jzg10.metrik_id = 10 AND jzg10.typ_id = 0 AND jzg10.level_id = 0 
		JOIN ( /* Umsatz Plan Filiale */
			SELECT vis.mandant_id, vis.nb_id, vis.wup_id, zeit.gj, vis.wrg_id
			, SUM(vis.ums_netto_plan) AS ums_netto_plan
			FROM dbp_msi_data.vis_tag_umsatz_kunde_wup_2 vis
			JOIN DBP_DATA.MONAT_2 zeit_2
			ON zeit.kjmo = vis.kjmo AND zeit.akt_gj = 0
			GROUP BY vis.mandant_id, vis.nb_id, vis.wup_id, zeit.gj, vis.wrg_id
		) vis_tag
		ON vis_tag.mandant_id = vis_plan.mandant_id AND vis_tag.wup_id = vis_plan.wup_id
		AND vis_tag.wrg_id = vis_plan.wrg_id AND vis_tag.gj = vis_plan.gj 
    ) vis_plan_owg
    GROUP BY vis_plan_owg.mandant_id, vis_plan_owg.nb_id, vis_plan_owg.wup_id, vis_plan_owg.gj, vis_plan_owg.wrg_id, vis_plan_owg.abt_id, vis_plan_owg.hwg_id
    /* HWG - Abteilung 6 Join Level HWG = Eingabe */
    UNION ALL
    SELECT vis_plan.mandant_id, vis_plan.nb_id, vis_plan.wup_id, vis_plan.gj, vis_plan.wrg_id, vis_plan.abt_id, vis_plan.hwg_id
    , vis_plan.abschriften_netto_operativ_plan AS abs_plan
    , vis_plan.umsatz_netto_plan AS ums_plan /* Plan Ware */
    , ums_plan / NULLIFZERO(vis_tag.ums_netto_plan) AS anteil /* Plan Filiale */
    , jzg40.wert_eingabe      AS eingabe
    , jzg40.kommentar_eingabe AS kommentar
    , anteil * jzg10.wert_eingabe AS ums_ziel
    , ums_ziel * COALESCE(jzg40.wert_eingabe, abs_plan / NULLIFZERO(ums_plan)) AS abs_ziel
    FROM (  
        SELECT plan.mandant_id, plan.nb_id, plan.wup_id, zeit.gj, plan.wrg_id, abt.abt_id, hwg.hwg_id
        , (abt.abt_id * 1000000 + ABS(hwg.hwg_id) * 10000)::INTEGER AS LEVEL_ID
        , SUM(plan.umsatz_netto_plan) AS umsatz_netto_plan
        , SUM(plan.abschriften_netto_operativ_plan) AS abschriften_netto_operativ_plan
        FROM dbp_msi_view_vis.mv_wup_plan_kjmo_owg_2 plan
        JOIN DBP_DATA.MONAT_2 zeit_2
        ON zeit.kjmo = plan.kjmo
        JOIN DBP_MSI_VIEW_VIS.MV_OWG_INT_2 owg
        ON owg.owg_id = plan.owg_id  
        JOIN DBP_MSI_VIEW_VIS.MV_HWG_INT_2 hwg
        ON hwg.hwg_id = owg.hwg_id
        JOIN DBP_MSI_VIEW_VIS.MV_ABT_INT_2 abt_2
        ON abt.abt_id = hwg.abt_id
        WHERE zeit.akt_gj = 0 AND plan.nb_id = 0 AND abt.abt_id IN (6)
        GROUP BY plan.mandant_id, plan.nb_id, plan.wup_id, zeit.gj, plan.wrg_id, abt.abt_id, hwg.hwg_id, LEVEL_ID
    ) vis_plan
    LEFT JOIN DBP_MSI_VIEW_VIS.MV_VIS_JZG_ZIEL_WERT_2 jzg40 /* Eingabe Abschriften_2 HWG */
    ON jzg40.mandant_id = vis_plan.mandant_id AND jzg40.wup_id = vis_plan.wup_id
    AND jzg40.wrg_id = vis_plan.wrg_id AND jzg40.gj = vis_plan.gj
    AND jzg40.metrik_id = 40 AND jzg40.level_id = vis_plan.level_id
    LEFT JOIN DBP_MSI_VIEW_VIS.MV_VIS_JZG_ZIEL_WERT_2 jzg10 /* Eingabe Umsatz Filiale */
    ON jzg10.mandant_id = vis_plan.mandant_id AND jzg10.wup_id = vis_plan.wup_id
    AND jzg10.wrg_id = vis_plan.wrg_id AND jzg10.gj = vis_plan.gj
    AND jzg10.metrik_id = 10 AND jzg10.typ_id = 0 AND jzg10.level_id = 0 
	JOIN ( /* Umsatz Plan Filiale */
		SELECT vis.mandant_id, vis.nb_id, vis.wup_id, zeit.gj, vis.wrg_id
		, SUM(vis.ums_netto_plan) AS ums_netto_plan
		FROM dbp_msi_data.vis_tag_umsatz_kunde_wup_2 vis
		JOIN DBP_DATA.MONAT_2 zeit_2
		ON zeit.kjmo = vis.kjmo AND zeit.akt_gj = 0
		GROUP BY vis.mandant_id, vis.nb_id, vis.wup_id, zeit.gj, vis.wrg_id
	) vis_tag
	ON vis_tag.mandant_id = vis_plan.mandant_id AND vis_tag.wup_id = vis_plan.wup_id
	AND vis_tag.wrg_id = vis_plan.wrg_id AND vis_tag.gj = vis_plan.gj 
) vis_agg
ON vis_agg.mandant_id = vis.mandant_id AND vis_agg.wup_id = vis.wup_id
AND vis_agg.wrg_id = vis.wrg_id AND vis_agg.gj = vis.gj 
AND vis_agg.hwg_id = vis.hwg_id  
 
/* JZG 403-5xxxxxx - Abschriften_2 OWG v2 */    
UNION ALL 
SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id
, vis.gj      AS GJ
, 40::INTEGER AS METRIK_ID
, 3::INTEGER  AS TYP_ID
, (vis.abt_id * 1000000 + ABS(vis.hwg_id) * 10000 + ABS(vis.owg_id))::INTEGER AS LEVEL_ID
, vis_agg.abs_plan AS PLAN_GJ1 
, vis_agg.ums_plan AS PLAN_GJ2
, vis_agg.abs_plan / NULLIFZERO(vis_agg.ums_plan) AS PLAN_GJ
, vis_agg.eingabe  AS EINGABE
, vis_agg.anteil   AS ANTEIL
, vis_agg.abs_ziel AS ZIEL1 /* berechnet Abschriften_2 */
, vis_agg.ums_ziel AS ZIEL2 /* berechnet Umsatz */
, COALESCE(ZIEL1 / NULLIFZERO(ZIEL2), 0) AS ZIEL 
, COALESCE(vis_agg.kommentar, '') AS KOMMENTAR /* nur auf Ebene Eingabe */
FROM ( /* JZG OWG - Ware */
	SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.gj, abt.abt_id, hwg.hwg_id, owg.owg_id
	, SUM(vis.ums_netto) AS ums_netto
	FROM DBP_MSI_DATA.VIS_MONAT_UMSATZ_WG_2  vis
	JOIN DBP_MSI_VIEW_VIS.MV_WG_INT_2 wg 
	ON   wg.wg_id = vis.wg_id
	JOIN DBP_MSI_VIEW_VIS.MV_OWG_INT_2 owg
	ON   owg.owg_id = wg.owg_id
	JOIN DBP_MSI_VIEW_VIS.MV_HWG_INT_2 hwg
	ON   hwg.hwg_id = owg.hwg_id
	JOIN DBP_MSI_VIEW_VIS.MV_ABT_INT_2 abt_2
	ON   abt.abt_id = hwg.abt_id
	JOIN DBP_DATA.MONAT_2  zeit_2
	ON   zeit.kjmo = vis.kjmo AND zeit.akt_gj = 0
	WHERE abt.abt_id = 5
	GROUP BY vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.gj, abt.abt_id, hwg.hwg_id, owg.owg_id
) vis
LEFT JOIN ( /* JZG OWG - Abschriften_2 Plan inkl. Eingabe */
    SELECT vis_plan.mandant_id, vis_plan.nb_id, vis_plan.wup_id, vis_plan.gj, vis_plan.wrg_id, vis_plan.abt_id, vis_plan.hwg_id, vis_plan.owg_id
    , vis_plan.abschriften_netto_operativ_plan AS abs_plan
    , vis_plan.umsatz_netto_plan AS ums_plan /* Plan Ware */
    , ums_plan / NULLIFZERO(vis_tag.ums_netto_plan) AS anteil /* Plan Filiale */
    , jzg40.wert_eingabe AS eingabe
    , jzg40.kommentar_eingabe AS kommentar
    , anteil * jzg10.wert_eingabe AS ums_ziel
    , ums_ziel * COALESCE(jzg40.wert_eingabe, abs_plan / NULLIFZERO(ums_plan)) AS abs_ziel
    FROM ( /* Abteilung 5 Join Level OWG */
        SELECT plan.mandant_id, plan.nb_id, plan.wup_id, zeit.gj, plan.wrg_id, abt.abt_id, hwg.hwg_id, owg.owg_id
        , (abt.abt_id * 1000000 + ABS(hwg.hwg_id) * 10000 + ABS(owg.owg_id))::INTEGER AS LEVEL_ID
        , SUM(plan.umsatz_netto_plan) AS umsatz_netto_plan
        , SUM(plan.abschriften_netto_operativ_plan) AS abschriften_netto_operativ_plan
        FROM dbp_msi_view_vis.mv_wup_plan_kjmo_owg_2 plan
        JOIN DBP_MSI_VIEW_VIS.MV_OWG_INT_2 owg
        ON owg.owg_id = plan.owg_id  
        JOIN DBP_MSI_VIEW_VIS.MV_HWG_INT_2 hwg
        ON hwg.hwg_id = owg.hwg_id
        JOIN DBP_MSI_VIEW_VIS.MV_ABT_INT_2 abt_2
        ON abt.abt_id = hwg.abt_id
        JOIN DBP_DATA.MONAT_2 zeit_2
        ON zeit.kjmo = plan.kjmo AND zeit.akt_gj = 0
        WHERE abt.abt_id = 5
        GROUP BY plan.mandant_id, plan.nb_id, plan.wup_id, zeit.gj, plan.wrg_id, abt.abt_id, hwg.hwg_id, owg.owg_id, LEVEL_ID
    ) vis_plan
    LEFT JOIN DBP_MSI_VIEW_VIS.MV_VIS_JZG_ZIEL_WERT_2 jzg40 /* 40 Abschriften_2 OWG */
    ON jzg40.mandant_id = vis_plan.mandant_id AND jzg40.wup_id = vis_plan.wup_id
    AND jzg40.wrg_id = vis_plan.wrg_id AND jzg40.gj = vis_plan.gj
    AND jzg40.metrik_id = 40 AND jzg40.level_id = vis_plan.level_id
    LEFT JOIN DBP_MSI_VIEW_VIS.MV_VIS_JZG_ZIEL_WERT_2 jzg10 /* 10 Umsatz Filiale */
    ON jzg10.mandant_id = vis_plan.mandant_id AND jzg10.wup_id = vis_plan.wup_id
    AND jzg10.wrg_id = vis_plan.wrg_id AND jzg10.gj = vis_plan.gj
    AND jzg10.metrik_id = 10 AND jzg10.typ_id = 0 AND jzg10.level_id = 0 
	JOIN ( /* Umsatz Plan Filiale */
		SELECT vis.mandant_id, vis.nb_id, vis.wup_id, zeit.gj, vis.wrg_id
		, SUM(vis.ums_netto_plan) AS ums_netto_plan
		FROM dbp_msi_data.vis_tag_umsatz_kunde_wup_2 vis
		JOIN DBP_DATA.MONAT_2 zeit_2
		ON zeit.kjmo = vis.kjmo AND zeit.akt_gj = 0
		GROUP BY vis.mandant_id, vis.nb_id, vis.wup_id, zeit.gj, vis.wrg_id
	) vis_tag
	ON vis_tag.mandant_id = vis_plan.mandant_id AND vis_tag.wup_id = vis_plan.wup_id
	AND vis_tag.wrg_id = vis_plan.wrg_id AND vis_tag.gj = vis_plan.gj 
) vis_agg
ON vis_agg.mandant_id = vis.mandant_id AND vis_agg.wup_id = vis.wup_id
AND vis_agg.wrg_id = vis.wrg_id AND vis_agg.gj = vis.gj 
AND vis_agg.owg_id = vis.owg_id  
 
/* JZG 50x - Inventur_2 all levels v2 */
UNION ALL
SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id
, vis.gj
, 50::INTEGER AS METRIK_ID
, vis_pln.TYP_ID
, vis_pln.LEVEL_ID AS LEVEL_ID
, NULL AS PLAN_GJ1 /* kein Plan */
, NULL AS PLAN_GJ2
, NULL AS PLAN_GJ
, vis_pln.inv_eingabe AS EINGABE /* Eingabe Inventur_2 Prozent */
, vis_pln.ums_owg_plan / NULLIFZERO(vis.ums_fil_plan) AS ANTEIL
, vis_pln.inv_wert * vis.ums_faktor     AS ZIEL1 /* ZIEL Inventur_2 berechnet */
, vis_pln.ums_owg_plan * vis.ums_faktor AS ZIEL2 /* ZIEL Umsatz berechnet */ 
, COALESCE(ZIEL1 / NULLIFZERO(ZIEL2), 0) AS ZIEL
, COALESCE(vis_pln.inv_kommentar, '') AS KOMMENTAR 
FROM ( /* JZG Filiale - MAIN */
	SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.gj
	, SUM(vis.ums_netto_plan) AS ums_fil_plan
    , SUM(jzg10.wert_eingabe) AS ums_eingabe
    , ZEROIFNULL(ums_eingabe) / NULLIFZERO(ums_fil_plan) ums_faktor /* */
	FROM DBP_MSI_DATA.VIS_MONAT_UMS_KUNDE_PERS_WUP_2 vis
	JOIN DBP_DATA.MONAT_2 zeit_2
	ON   zeit.kjmo = vis.kjmo AND zeit.akt_gj = 0
    LEFT JOIN DBP_MSI_VIEW_VIS.MV_VIS_JZG_ZIEL_WERT_2 jzg10 /* 100 Umsatz Filiale */
	ON jzg10.mandant_id = vis.mandant_id AND jzg10.wup_id = vis.wup_id
	AND jzg10.wrg_id = vis.wrg_id AND jzg10.gj = zeit.gj
	AND jzg10.metrik_id = 10 AND jzg10.typ_id = 0 AND jzg10.level_id = 0
	GROUP BY vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.gj
) vis
LEFT JOIN ( 
	/* JZG Inventur_2 - Eingabe Filiale */
	SELECT pln.mandant_id, pln.nb_id, pln.wup_id, zeit.gj, pln.wrg_id, 0 AS abt_id, 0 AS hwg_id, 0 AS owg_id
    , 0::INTEGER AS TYP_ID
    , 0::INTEGER AS LEVEL_ID
    , SUM(pln.umsatz_netto_plan) AS ums_owg_plan
    , MAX(jzg50.wert_eingabe)    AS inv_eingabe
    , MAX(jzg50.kommentar_eingabe) AS inv_kommentar
    , ums_owg_plan * inv_eingabe AS inv_wert
    FROM dbp_msi_view_vis.mv_wup_plan_kjmo_owg_2 pln
    JOIN DBP_DATA.MONAT_2 zeit_2
    ON zeit.kjmo = pln.kjmo AND zeit.akt_gj = 0
    LEFT JOIN DBP_MSI_VIEW_VIS.MV_VIS_JZG_ZIEL_WERT_2 jzg50 /* 503 Inventur_2 Filiale */
	ON jzg50.mandant_id = pln.mandant_id AND jzg50.wup_id = pln.wup_id
	AND jzg50.wrg_id = pln.wrg_id AND jzg50.gj = zeit.gj
	AND jzg50.metrik_id = 50 AND jzg50.typ_id = 0
    AND jzg50.level_id = 0
    GROUP BY pln.mandant_id, pln.nb_id, pln.wup_id, zeit.gj, pln.wrg_id
    /* JZG Inventur_2 - Eingabe Abteilung Food Frische */
    UNION ALL 
	SELECT pln.mandant_id, pln.nb_id, pln.wup_id, zeit.gj, pln.wrg_id, abt.abt_id, 0 AS hwg_id, 0 AS owg_id
    , 1::INTEGER AS TYP_ID
    , (abt.abt_id * 1000000)::INTEGER AS LEVEL_ID
    , SUM(pln.umsatz_netto_plan) AS ums_owg_plan
    , MAX(jzg50.wert_eingabe)    AS inv_eingabe
    , MAX(jzg50.kommentar_eingabe) AS inv_kommentar
    , ums_owg_plan * inv_eingabe AS inv_wert
    FROM dbp_msi_view_vis.mv_wup_plan_kjmo_owg_2 pln
    JOIN DBP_MSI_VIEW_VIS.MV_OWG_INT_2 owg
    ON owg.owg_id = pln.owg_id  
    JOIN DBP_MSI_VIEW_VIS.MV_HWG_INT_2 hwg
    ON hwg.hwg_id = owg.hwg_id
    JOIN DBP_MSI_VIEW_VIS.MV_ABT_INT_2 abt_2
    ON abt.abt_id = hwg.abt_id
    JOIN DBP_DATA.MONAT_2 zeit_2
    ON zeit.kjmo = pln.kjmo AND zeit.akt_gj = 0
    LEFT JOIN DBP_MSI_VIEW_VIS.MV_VIS_JZG_ZIEL_WERT_2 jzg50 /* 503 Inventur_2 Abt_2 */
	ON jzg50.mandant_id = pln.mandant_id AND jzg50.wup_id = pln.wup_id
	AND jzg50.wrg_id = pln.wrg_id AND jzg50.gj = zeit.gj
	AND jzg50.metrik_id = 50 AND jzg50.typ_id = 1 
    AND jzg50.level_id = (abt.abt_id * 1000000)
    WHERE abt.abt_id IN (6) /* Food Frische */
    GROUP BY pln.mandant_id, pln.nb_id, pln.wup_id, zeit.gj, pln.wrg_id, abt.abt_id
	/* JZG Inventur_2 - Berechnung Abteilung Ultra Frische*/
    UNION ALL 
	SELECT plnsub.mandant_id, plnsub.nb_id, plnsub.wup_id, plnsub.gj, plnsub.wrg_id, plnsub.abt_id, 0 AS hwg_id, 0 AS owg_id
    , 1::INTEGER AS TYP_ID
   	, (plnsub.abt_id * 1000000)::INTEGER AS LEVEL_ID
   	, SUM(plnsub.ums_owg_plan) AS ums_owg_plan
   	, NULL AS inv_eingabe   /* BERECHNET */
   	, NULL AS inv_kommentar /* INAKTIV */
   	, SUM(plnsub.inv_wert) AS inv_wert
    FROM ( /* Eingabe OWG Level */
		SELECT pln.mandant_id, pln.nb_id, pln.wup_id, zeit.gj, pln.wrg_id, abt.abt_id, hwg.hwg_id, owg.owg_id
    	, (abt.abt_id * 1000000 + ABS(hwg.hwg_id) * 10000 + ABS(owg.owg_id))::INTEGER AS LEVEL_ID
	    , SUM(pln.umsatz_netto_plan) AS ums_owg_plan
    	, MAX(jzg50.wert_eingabe)    AS inv_eingabe
    	, MAX(jzg50.kommentar_eingabe) AS inv_kommentar
    	, ums_owg_plan * inv_eingabe AS inv_wert
    	FROM dbp_msi_view_vis.mv_wup_plan_kjmo_owg_2 pln
    	JOIN DBP_MSI_VIEW_VIS.MV_OWG_INT_2 owg
    	ON owg.owg_id = pln.owg_id  
    	JOIN DBP_MSI_VIEW_VIS.MV_HWG_INT_2 hwg
    	ON hwg.hwg_id = owg.hwg_id
    	JOIN DBP_MSI_VIEW_VIS.MV_ABT_INT_2 abt_2
    	ON abt.abt_id = hwg.abt_id
    	JOIN DBP_DATA.MONAT_2 zeit_2
    	ON zeit.kjmo = pln.kjmo AND zeit.akt_gj = 0
    	LEFT JOIN DBP_MSI_VIEW_VIS.MV_VIS_JZG_ZIEL_WERT_2 jzg50 /* 503 Inventur_2 OWG */
		ON jzg50.mandant_id = pln.mandant_id AND jzg50.wup_id = pln.wup_id
		AND jzg50.wrg_id = pln.wrg_id AND jzg50.gj = zeit.gj
		AND jzg50.metrik_id = 50 AND jzg50.typ_id = 3 
    	AND jzg50.level_id = (abt.abt_id * 1000000 + ABS(hwg.hwg_id) * 10000 + ABS(owg.owg_id))
    	WHERE abt.abt_id = 5 /* Ultra Frische */
    	GROUP BY pln.mandant_id, pln.nb_id, pln.wup_id, zeit.gj, pln.wrg_id, abt.abt_id, hwg.hwg_id, owg.owg_id
    ) plnsub
    GROUP BY plnsub.mandant_id, plnsub.nb_id, plnsub.wup_id, plnsub.gj, plnsub.wrg_id, plnsub.abt_id
    /* JZG Inventur_2 - Eingabe HWG Food Frische */
    UNION ALL 
	SELECT pln.mandant_id, pln.nb_id, pln.wup_id, zeit.gj, pln.wrg_id, abt.abt_id, hwg.hwg_id, 0 AS owg_id
    , 2::INTEGER AS TYP_ID
    , (abt.abt_id * 1000000 + ABS(hwg.hwg_id) * 10000)::INTEGER AS LEVEL_ID
    , SUM(pln.umsatz_netto_plan) AS ums_owg_plan
    , MAX(jzg50.wert_eingabe)    AS inv_eingabe
    , MAX(jzg50.kommentar_eingabe) AS inv_kommentar
    , ums_owg_plan * inv_eingabe AS inv_wert
    FROM dbp_msi_view_vis.mv_wup_plan_kjmo_owg_2 pln
    JOIN DBP_MSI_VIEW_VIS.MV_OWG_INT_2 owg
    ON owg.owg_id = pln.owg_id  
    JOIN DBP_MSI_VIEW_VIS.MV_HWG_INT_2 hwg
    ON hwg.hwg_id = owg.hwg_id
    JOIN DBP_MSI_VIEW_VIS.MV_ABT_INT_2 abt_2
    ON abt.abt_id = hwg.abt_id
    JOIN DBP_DATA.MONAT_2 zeit_2
    ON zeit.kjmo = pln.kjmo AND zeit.akt_gj = 0
    LEFT JOIN DBP_MSI_VIEW_VIS.MV_VIS_JZG_ZIEL_WERT_2 jzg50 /* 503 Inventur_2 HWG */
	ON jzg50.mandant_id = pln.mandant_id AND jzg50.wup_id = pln.wup_id
	AND jzg50.wrg_id = pln.wrg_id AND jzg50.gj = zeit.gj
	AND jzg50.metrik_id = 50 AND jzg50.typ_id = 2 
    AND jzg50.level_id = (abt.abt_id * 1000000 + ABS(hwg.hwg_id) * 10000)
    WHERE hwg.hwg_id IN (65,81,82) /* Ultra Frische + Wurst SB alt/neu */
    GROUP BY pln.mandant_id, pln.nb_id, pln.wup_id, zeit.gj, pln.wrg_id, abt.abt_id, hwg.hwg_id
    /* JZG Inventur_2 - Berechnung HWG Ultra Frische */
	UNION ALL 
	SELECT plnsub.mandant_id, plnsub.nb_id, plnsub.wup_id, plnsub.gj, plnsub.wrg_id, plnsub.abt_id, plnsub.hwg_id, 0 AS owg_id
    , 2::INTEGER AS TYP_ID
   	, (plnsub.abt_id * 1000000 + ABS(plnsub.hwg_id) * 10000)::INTEGER AS LEVEL_ID
   	, SUM(plnsub.ums_owg_plan) AS ums_owg_plan
   	, NULL AS inv_eingabe   /* BERECHNET */
   	, NULL AS inv_kommentar /* INAKTIV */
   	, SUM(plnsub.inv_wert) AS inv_wert
    FROM (
    	SELECT pln.mandant_id, pln.nb_id, pln.wup_id, zeit.gj, pln.wrg_id, abt.abt_id, hwg.hwg_id, owg.owg_id
        , (abt.abt_id * 1000000 + ABS(hwg.hwg_id) * 10000 + ABS(owg.owg_id))::INTEGER AS LEVEL_ID
	    , SUM(pln.umsatz_netto_plan) AS ums_owg_plan
    	, MAX(jzg50.wert_eingabe)    AS inv_eingabe
    	, MAX(jzg50.kommentar_eingabe) AS inv_kommentar
    	, ums_owg_plan * inv_eingabe AS inv_wert
        FROM dbp_msi_view_vis.mv_wup_plan_kjmo_owg_2 pln
        JOIN DBP_MSI_VIEW_VIS.MV_OWG_INT_2 owg
        ON owg.owg_id = pln.owg_id  
        JOIN DBP_MSI_VIEW_VIS.MV_HWG_INT_2 hwg
        ON hwg.hwg_id = owg.hwg_id
        JOIN DBP_MSI_VIEW_VIS.MV_ABT_INT_2 abt_2
        ON abt.abt_id = hwg.abt_id
        JOIN DBP_DATA.MONAT_2 zeit_2
        ON zeit.kjmo = pln.kjmo AND zeit.akt_gj = 0
        LEFT JOIN DBP_MSI_VIEW_VIS.MV_VIS_JZG_ZIEL_WERT_2 jzg50 /* 503 Inventur_2 OWG */
    	ON jzg50.mandant_id = pln.mandant_id AND jzg50.wup_id = pln.wup_id
    	AND jzg50.wrg_id = pln.wrg_id AND jzg50.gj = zeit.gj
    	AND jzg50.metrik_id = 50 AND jzg50.typ_id = 3 
        AND jzg50.level_id = (abt.abt_id * 1000000 + ABS(hwg.hwg_id) * 10000 + ABS(owg.owg_id))
        WHERE abt.abt_id = 5 /* Ultra Frische */
        GROUP BY pln.mandant_id, pln.nb_id, pln.wup_id, zeit.gj, pln.wrg_id, abt.abt_id, hwg.hwg_id, owg.owg_id    
    ) plnsub
    GROUP BY plnsub.mandant_id, plnsub.nb_id, plnsub.wup_id, plnsub.gj, plnsub.wrg_id, plnsub.abt_id, plnsub.hwg_id
    /* JZG Inventur_2 - Eingabe OWG Ultra Frische */
    UNION ALL 
	SELECT pln.mandant_id, pln.nb_id, pln.wup_id, zeit.gj, pln.wrg_id, abt.abt_id, hwg.hwg_id, owg.owg_id
    , 3::INTEGER AS TYP_ID
    , (abt.abt_id * 1000000 + ABS(hwg.hwg_id) * 10000 + ABS(owg.owg_id))::INTEGER AS LEVEL_ID
    , SUM(pln.umsatz_netto_plan) AS ums_owg_plan
   	, MAX(jzg50.wert_eingabe)    AS inv_eingabe
   	, MAX(jzg50.kommentar_eingabe) AS inv_kommentar
   	, ums_owg_plan * inv_eingabe AS inv_wert
    FROM dbp_msi_view_vis.mv_wup_plan_kjmo_owg_2 pln
    JOIN DBP_MSI_VIEW_VIS.MV_OWG_INT_2 owg
    ON owg.owg_id = pln.owg_id  
    JOIN DBP_MSI_VIEW_VIS.MV_HWG_INT_2 hwg
    ON hwg.hwg_id = owg.hwg_id
    JOIN DBP_MSI_VIEW_VIS.MV_ABT_INT_2 abt_2
    ON abt.abt_id = hwg.abt_id
    JOIN DBP_DATA.MONAT_2 zeit_2
    ON zeit.kjmo = pln.kjmo AND zeit.akt_gj = 0
    LEFT JOIN DBP_MSI_VIEW_VIS.MV_VIS_JZG_ZIEL_WERT_2 jzg50 /* 503 Inventur_2 OWG */
	ON jzg50.mandant_id = pln.mandant_id AND jzg50.wup_id = pln.wup_id
	AND jzg50.wrg_id = pln.wrg_id AND jzg50.gj = zeit.gj
	AND jzg50.metrik_id = 50 AND jzg50.typ_id = 3 
    AND jzg50.level_id = (abt.abt_id * 1000000 + ABS(hwg.hwg_id) * 10000 + ABS(owg.owg_id))
    WHERE abt.abt_id = 5 /* Ultra Frische */
    GROUP BY pln.mandant_id, pln.nb_id, pln.wup_id, zeit.gj, pln.wrg_id, abt.abt_id, hwg.hwg_id, owg.owg_id
) vis_pln
ON vis_pln.mandant_id = vis.mandant_id AND vis_pln.wup_id = vis.wup_id 
AND vis_pln.wrg_id = vis.wrg_id AND vis_pln.gj = vis.gj 
 
/* JZG 700 - Personalkosten_2 FILIALE */
UNION ALL 
SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id
, vis.gj      AS GJ
, 70::INTEGER AS METRIK_ID
, 0::INTEGER  AS TYP_ID
, 0::INTEGER  AS LEVEL_ID
, vis.pers_kosten_plan AS PLAN_GJ1 
, vis.ums_netto_plan   AS PLAN_GJ2
, NULLIFZERO(vis.pers_kosten_plan) / NULLIFZERO(vis.ums_netto_plan) AS PLAN_GJ
, jzg70.wert_eingabe AS EINGABE
, NULL AS ANTEIL
, jzg70.wert_eingabe AS ZIEL1 /* Eingabe PK Prozent */
, 1 AS ZIEL2
, COALESCE(jzg70.wert_eingabe, 0)       AS ZIEL 
, COALESCE(jzg70.kommentar_eingabe, '') AS KOMMENTAR
FROM ( /* JZG Filiale - PK */
	SELECT vis.mandant_id, vis.nb_id, vis.wup_id, zeit.gj, vis.wrg_id
	, SUM(vis.pers_kosten_plan) AS pers_kosten_plan
	, SUM(vis.ums_netto_plan)   AS ums_netto_plan
	FROM DBP_MSI_DATA.VIS_MONAT_UMS_KUNDE_PERS_WUP_2   vis
	JOIN DBP_DATA.MONAT_2 zeit_2
	ON zeit.kjmo = vis.kjmo
	WHERE zeit.akt_gj = 0 AND vis.nb_id = 0
	GROUP BY vis.mandant_id, vis.nb_id, vis.wup_id, zeit.gj, vis.wrg_id
) vis
LEFT JOIN DBP_MSI_VIEW_VIS.MV_VIS_JZG_ZIEL_WERT_2 jzg70 /* 70 Personalkosten_2 */
ON jzg70.mandant_id = vis.mandant_id AND jzg70.wup_id = vis.wup_id
AND jzg70.wrg_id = vis.wrg_id AND jzg70.gj = vis.gj
AND jzg70.metrik_id = 70 AND jzg70.typ_id = 0 AND jzg70.level_id = 0 
 
/* JZG xx0-0 Dummies ohne Plan / Pflege */ 
UNION ALL
SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id
, vis.gj AS GJ    
, jzg.METRIK_ID
, 0::INTEGER AS TYP_ID
, 0::INTEGER AS LEVEL_ID
, NULL AS WERT_VJ1 
, NULL AS WERT_VJ2 
, NULL AS WERT_VJ 
, NULL AS PLAN_VJ1 
, NULL AS PLAN_VJ2 
, NULL AS PLAN_VJ 
, NULL AS DELTA
, NULL AS ABW 
, ''   AS KOMMENTAR 
FROM ( /* JZG Filiale */
	SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.gj
	FROM DBP_MSI_DATA.VIS_MONAT_UMS_KUNDE_PERS_WUP_2   vis
	JOIN DBP_DATA.MONAT_2 zeit_2
	ON   zeit.kjmo = vis.kjmo AND zeit.akt_gj = 0
	GROUP BY vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.gj
) vis
CROSS JOIN ( /* JZG Dummies */ 
	SELECT 30::INTEGER AS METRIK_ID 
	UNION ALL 
	SELECT 33::INTEGER AS METRIK_ID
	UNION ALL 
	SELECT 36::INTEGER AS METRIK_ID
	UNION ALL 
	SELECT 39::INTEGER AS METRIK_ID
	UNION ALL 
	SELECT 60::INTEGER AS METRIK_ID
	UNION ALL 
	SELECT 62::INTEGER AS METRIK_ID
	UNION ALL 
	SELECT 64::INTEGER AS METRIK_ID
	UNION ALL 
	SELECT 66::INTEGER AS METRIK_ID
	UNION ALL 
	SELECT 68::INTEGER AS METRIK_ID
	UNION ALL 
	SELECT 72::INTEGER AS METRIK_ID
	UNION ALL 
	SELECT 73::INTEGER AS METRIK_ID
	UNION ALL 
	SELECT 74::INTEGER AS METRIK_ID
	UNION ALL 
	SELECT 75::INTEGER AS METRIK_ID
	UNION ALL 
	SELECT 76::INTEGER AS METRIK_ID
	UNION ALL 
	SELECT 77::INTEGER AS METRIK_ID
	UNION ALL 
	SELECT 78::INTEGER AS METRIK_ID
	UNION ALL 
	SELECT 80::INTEGER AS METRIK_ID
	UNION ALL 
	SELECT 82::INTEGER AS METRIK_ID
	UNION ALL 
	SELECT 84::INTEGER AS METRIK_ID
	UNION ALL 
	SELECT 86::INTEGER AS METRIK_ID
	UNION ALL 
	SELECT 88::INTEGER AS METRIK_ID
	UNION ALL 
	SELECT 90::INTEGER AS METRIK_ID
	UNION ALL 
	SELECT 92::INTEGER AS METRIK_ID
	UNION ALL 
	SELECT 94::INTEGER AS METRIK_ID
	UNION ALL 
	SELECT 96::INTEGER AS METRIK_ID
	UNION ALL 
	SELECT 98::INTEGER AS METRIK_ID
) jzg
;