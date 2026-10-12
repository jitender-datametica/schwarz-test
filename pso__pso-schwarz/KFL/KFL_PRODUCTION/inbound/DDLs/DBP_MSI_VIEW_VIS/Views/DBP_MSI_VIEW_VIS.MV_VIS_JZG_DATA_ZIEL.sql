CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_VIS_JZG_DATA_ZIEL(
	MANDANT_ID,
	NB_ID,
	WUP_ID,
	WRG_ID,
	GJ,
	METRIK_ID,
	TYP_ID,
	LEVEL_ID,
	EINGABE,
	KOMMENTAR,
	HELPER,
	ANTEIL1,
	ANTEIL2,
	ANTEIL,
	ZIEL1,
	ZIEL2,
	ZIEL
) AS
/*	JZG FAKT DENORM : Jahreszielgespräch Zielwerte berechnet + Kommentare
	2023-02-15 ssch0611 : Initial Setup als JZG_DATA_PLAN. AP0144461
	2023-10-26 ssch0611 : REVIEW AP0144461. Neue Struktur ohne Plan GJ. Inventur(Fil/Abt)
	2024-01-12 ssch0611 : Release version
	2024-01-26 ssch0611 : Finetuning/Metriken 
	2024-02-28 ssch0611 : Review Zielwert Berechnung
*/ 
 
/* JZG 10.0.0 Umsatz Filiale */ 
SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, vis.gj
, 10::INTEGER AS METRIK_ID, 0::INTEGER AS TYP_ID, 0::INTEGER  AS LEVEL_ID
, COALESCE(jzg10.wert_eingabe,0)       AS EING /* Eingabe Umsatz Filiale */
, COALESCE(jzg10.kommentar_eingabe,'') AS KOMM /* Eingabe Kommentar */
, NULL  AS HLPR 
, 1.000 AS A1
, NULL  AS A2
, A1    AS ANTL 
, EING  AS Z1 /* Ziel = Eingabe */
, NULL  AS Z2
, Z1    AS ZIEL 
FROM ( /* JZG MAIN - Filiale GJ*/
	SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.gj
	, SUM(vis.ums_netto_plan) AS ums_plan
	FROM DBP_MSI_DATA.VIS_MONAT_UMS_KUNDE_PERS_WUP vis
	JOIN DBP_DATA.MONAT zeit
	ON zeit.kjmo = vis.kjmo AND zeit.akt_gj = 0
	/* Standard Filter VTC = Filiale (ohne NB) unbereinigt */
	INNER JOIN dbp_data.wup wup 
	ON wup.wup_id = vis.wup_id AND wup.mandant_id = vis.mandant_id AND wup.nb_id=0
	AND wup.dat_eroeffnung < '2090-12-31' /* fix */
	AND (EXTRACT(YEAR FROM wup.dat_bis)+CASE WHEN EXTRACT(MONTH FROM wup.dat_bis)<3 THEN -1 ELSE 0 END)>zeit.gj+1 /* dynamisch*/
	GROUP BY vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.gj
) vis
LEFT JOIN DBP_MSI_VIEW_VIS.MV_VIS_JZG_ZIEL_WERT  jzg10 /* 10 Umsatz */
ON  jzg10.mandant_id = vis.mandant_id AND jzg10.wup_id = vis.wup_id
AND jzg10.wrg_id = vis.wrg_id AND jzg10.gj = vis.gj
AND jzg10.metrik_id = 10 AND jzg10.typ_id = 0 AND jzg10.level_id = 0 
 
/* JZG 10.1.x000000 Umsatz Abteilung */ 
UNION ALL SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, vis.gj
, 10::INTEGER AS METRIK_ID , 1::INTEGER  AS TYP_ID
, (CASE pln.abt_id WHEN 4 THEN 9999999 ELSE pln.abt_id*1000000 END)::INTEGER AS LEVEL_ID
, NULL               AS EING /* keine direkte Eingabe */
, ''                 AS KOMM /* kein Kommentar */
, jzg10.wert_eingabe AS HLPR /* Eingabe Umsatz Filiale */
, pln.ums_plan       AS A1
, vis.ums_plan       AS A2 
, A1/NULLIFZERO(A2)  AS ANTL /* Anteil/Faktor Plan Abteilung/Filiale */
, HLPR*ANTL          AS Z1   /* Ziel berechnet aus Plananteil */
, NULL               AS Z2
, ZEROIFNULL(Z1)     AS ZIEL 
FROM ( /* JZG MAIN - Filiale GJ*/
	SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.gj
	, SUM(vis.ums_netto_plan) AS ums_plan
	FROM DBP_MSI_DATA.VIS_MONAT_UMS_KUNDE_PERS_WUP vis
	JOIN DBP_DATA.MONAT zeit
	ON zeit.kjmo = vis.kjmo AND zeit.akt_gj = 0
	/* Standard Filter VTC = Filiale (ohne NB) unbereinigt */
	INNER JOIN dbp_data.wup wup 
	ON wup.wup_id = vis.wup_id AND wup.mandant_id = vis.mandant_id AND wup.nb_id=0
	AND wup.dat_eroeffnung < '2090-12-31' /* fix */
	AND (EXTRACT(YEAR FROM wup.dat_bis)+CASE WHEN EXTRACT(MONTH FROM wup.dat_bis)<3 THEN -1 ELSE 0 END)>zeit.gj+1 /* dynamisch*/
	GROUP BY vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.gj
) vis
LEFT JOIN ( /* JZG PLAN - Abteilung */
	SELECT plan.mandant_id, plan.nb_id, plan.wup_id, plan.wrg_id, zeit.gj, abt.abt_id
	, SUM(plan.umsatz_netto_plan) AS ums_plan
	FROM dbp_msi_view_vis.mv_wup_plan_kjmo_owg plan
	JOIN DBP_MSI_VIEW_VIS.MV_OWG_INT owg
	ON   owg.owg_id = plan.owg_id  
	JOIN DBP_MSI_VIEW_VIS.MV_HWG_INT hwg
	ON   hwg.hwg_id = owg.hwg_id
	JOIN DBP_MSI_VIEW_VIS.MV_ABT_INT abt
	ON   abt.abt_id = hwg.abt_id
	JOIN DBP_DATA.MONAT  zeit
	ON   zeit.kjmo = plan.kjmo AND zeit.akt_gj = 0
	WHERE abt.abt_id IN (4,5,6,7,8) /* alle Abteilungen */
	GROUP BY plan.mandant_id, plan.nb_id, plan.wup_id, plan.wrg_id, zeit.gj, abt.abt_id
) pln
ON pln.mandant_id = vis.mandant_id AND pln.wup_id = vis.wup_id
AND pln.wrg_id = vis.wrg_id AND pln.gj = vis.gj 
LEFT JOIN DBP_MSI_VIEW_VIS.MV_VIS_JZG_ZIEL_WERT jzg10 /* 10 Umsatz */
ON  jzg10.mandant_id = vis.mandant_id AND jzg10.wup_id = vis.wup_id
AND jzg10.wrg_id = vis.wrg_id AND jzg10.gj = vis.gj
AND jzg10.metrik_id = 10 AND jzg10.typ_id = 0 AND jzg10.level_id = 0 
 
/* JZG 10.2.xxx0000 Umsatz HWG Utra-Frische, Food Frische*/ 
UNION ALL SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, vis.gj
, 10::INTEGER AS METRIK_ID, 2::INTEGER  AS TYP_ID
, (pln.abt_id * 1000000 + ABS(pln.hwg_id)*10000)::INTEGER AS LEVEL_ID
, NULL               AS EING /* keine direkte Eingabe */
, ''                 AS KOMM /* kein Kommentar */
, jzg10.wert_eingabe AS HLPR /* Eingabe Umsatz Filiale */
, pln.ums_plan       AS A1
, vis.ums_plan       AS A2 
, A1/NULLIFZERO(A2)  AS ANTL /* Anteil/Faktor Plan HWG/Filiale */
, HLPR*ANTL          AS Z1   /* Ziel berechnet aus Plananteil */
, NULL               AS Z2
, ZEROIFNULL(Z1)     AS ZIEL 
FROM ( /* JZG MAIN - Filiale GJ*/
	SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.gj
	, SUM(vis.ums_netto_plan) AS ums_plan
	FROM DBP_MSI_DATA.VIS_MONAT_UMS_KUNDE_PERS_WUP vis
	JOIN DBP_DATA.MONAT zeit
	ON zeit.kjmo = vis.kjmo AND zeit.akt_gj = 0
	/* Standard Filter VTC = Filiale (ohne NB) unbereinigt */
	INNER JOIN dbp_data.wup wup 
	ON wup.wup_id = vis.wup_id AND wup.mandant_id = vis.mandant_id AND wup.nb_id=0
	AND wup.dat_eroeffnung < '2090-12-31' /* fix */
	AND (EXTRACT(YEAR FROM wup.dat_bis)+CASE WHEN EXTRACT(MONTH FROM wup.dat_bis)<3 THEN -1 ELSE 0 END)>zeit.gj+1 /* dynamisch*/
	GROUP BY vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.gj
) vis
LEFT JOIN ( /* JZG PLAN - HWG */
	SELECT plan.mandant_id, plan.nb_id, plan.wup_id, plan.wrg_id, zeit.gj, abt.abt_id, hwg.hwg_id
	, SUM(plan.umsatz_netto_plan) AS ums_plan
	FROM dbp_msi_view_vis.mv_wup_plan_kjmo_owg plan
	JOIN DBP_MSI_VIEW_VIS.MV_OWG_INT owg
	ON   owg.owg_id = plan.owg_id  
	JOIN DBP_MSI_VIEW_VIS.MV_HWG_INT hwg
	ON   hwg.hwg_id = owg.hwg_id
	JOIN DBP_MSI_VIEW_VIS.MV_ABT_INT abt
	ON   abt.abt_id = hwg.abt_id
	JOIN DBP_DATA.MONAT  zeit
	ON   zeit.kjmo = plan.kjmo AND zeit.akt_gj = 0
	WHERE abt.abt_id IN (5,6) /* Utra-Frische, Food Frische */
	GROUP BY plan.mandant_id, plan.nb_id, plan.wup_id, plan.wrg_id, zeit.gj, abt.abt_id, hwg.hwg_id
) pln
ON pln.mandant_id = vis.mandant_id AND pln.wup_id = vis.wup_id
AND pln.wrg_id = vis.wrg_id AND pln.gj = vis.gj 
LEFT JOIN DBP_MSI_VIEW_VIS.MV_VIS_JZG_ZIEL_WERT jzg10 /* 10 Umsatz */
ON  jzg10.mandant_id = vis.mandant_id AND jzg10.wup_id = vis.wup_id
AND jzg10.wrg_id = vis.wrg_id AND jzg10.gj = vis.gj
AND jzg10.metrik_id = 10 AND jzg10.typ_id = 0 AND jzg10.level_id = 0 
 
 /* JZG 10.3.5xxxxxx Umsatz OWG Ultra-Frische */ 
UNION ALL SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, vis.gj 
 , 10::INTEGER AS METRIK_ID, 3::INTEGER  AS TYP_ID
, (pln.abt_id * 1000000 + ABS(pln.hwg_id)*10000 + pln.owg_id)::INTEGER AS LEVEL_ID
, NULL               AS EING /* keine direkte Eingabe */
, ''                 AS KOMM /* kein Kommentar */
, jzg10.wert_eingabe AS HLPR /* Eingabe Umsatz Filiale */
, pln.ums_plan       AS A1
, vis.ums_plan       AS A2 
, A1/NULLIFZERO(A2)  AS ANTL /* Anteil/Faktor Plan OWG/Filiale */
, HLPR*ANTL          AS Z1   /* Ziel berechnet aus Plananteil */
, NULL               AS Z2
, ZEROIFNULL(Z1)     AS ZIEL 
FROM ( /* JZG MAIN - Filiale GJ*/
	SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.gj
	, SUM(vis.ums_netto_plan) AS ums_plan
	FROM DBP_MSI_DATA.VIS_MONAT_UMS_KUNDE_PERS_WUP vis
	JOIN DBP_DATA.MONAT zeit
	ON zeit.kjmo = vis.kjmo AND zeit.akt_gj = 0
	/* Standard Filter VTC = Filiale (ohne NB) unbereinigt */
	INNER JOIN dbp_data.wup wup 
	ON wup.wup_id = vis.wup_id AND wup.mandant_id = vis.mandant_id AND wup.nb_id=0
	AND wup.dat_eroeffnung < '2090-12-31' /* fix */
	AND (EXTRACT(YEAR FROM wup.dat_bis)+CASE WHEN EXTRACT(MONTH FROM wup.dat_bis)<3 THEN -1 ELSE 0 END)>zeit.gj+1 /* dynamisch*/
	GROUP BY vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.gj
) vis
LEFT JOIN ( /* JZG PLAN - OWG */
	SELECT plan.mandant_id, plan.nb_id, plan.wup_id, plan.wrg_id, zeit.gj, abt.abt_id, hwg.hwg_id, owg.owg_id
	, SUM(plan.umsatz_netto_plan) AS ums_plan
	FROM dbp_msi_view_vis.mv_wup_plan_kjmo_owg plan
	JOIN DBP_MSI_VIEW_VIS.MV_OWG_INT owg
	ON   owg.owg_id = plan.owg_id  
	JOIN DBP_MSI_VIEW_VIS.MV_HWG_INT hwg
	ON   hwg.hwg_id = owg.hwg_id
	JOIN DBP_MSI_VIEW_VIS.MV_ABT_INT abt
	ON   abt.abt_id = hwg.abt_id
	JOIN DBP_DATA.MONAT  zeit
	ON   zeit.kjmo = plan.kjmo AND zeit.akt_gj = 0
	WHERE abt.abt_id IN (5) /* Utra-Frische */
	GROUP BY plan.mandant_id, plan.nb_id, plan.wup_id, plan.wrg_id, zeit.gj, abt.abt_id, hwg.hwg_id, owg.owg_id
) pln
ON pln.mandant_id = vis.mandant_id AND pln.wup_id = vis.wup_id
AND pln.wrg_id = vis.wrg_id AND pln.gj = vis.gj 
LEFT JOIN DBP_MSI_VIEW_VIS.MV_VIS_JZG_ZIEL_WERT jzg10 /* 10 Umsatz */
ON  jzg10.mandant_id = vis.mandant_id AND jzg10.wup_id = vis.wup_id
AND jzg10.wrg_id = vis.wrg_id AND jzg10.gj = vis.gj
AND jzg10.metrik_id = 10 AND jzg10.typ_id = 0 AND jzg10.level_id = 0  
 
/* JZG 16.0.0 Kunden Filiale */ 
UNION ALL SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, vis.gj
, 16::INTEGER AS METRIK_ID, 0::INTEGER AS TYP_ID, 0::INTEGER  AS LEVEL_ID
, COALESCE(jzg16.wert_eingabe,0)       AS EING /* Eingabe Kunden Filiale */
, COALESCE(jzg16.kommentar_eingabe,'') AS KOMM /* Eingabe Kommentar */
, NULL  AS HLPR 
, 1.000 AS A1
, NULL  AS A2
, A1    AS ANTL 
, EING  AS Z1 /* Ziel = Eingabe */
, NULL  AS Z2
, Z1    AS ZIEL 
FROM ( /* JZG MAIN - Filiale GJ*/
	SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.gj
	, SUM(vis.ums_netto_plan) AS ums_plan
	FROM DBP_MSI_DATA.VIS_MONAT_UMS_KUNDE_PERS_WUP vis
	JOIN DBP_DATA.MONAT zeit
	ON zeit.kjmo = vis.kjmo AND zeit.akt_gj = 0
	/* Standard Filter VTC = Filiale (ohne NB) unbereinigt */
	INNER JOIN dbp_data.wup wup 
	ON wup.wup_id = vis.wup_id AND wup.mandant_id = vis.mandant_id AND wup.nb_id=0
	AND wup.dat_eroeffnung < '2090-12-31' /* fix */
	AND (EXTRACT(YEAR FROM wup.dat_bis)+CASE WHEN EXTRACT(MONTH FROM wup.dat_bis)<3 THEN -1 ELSE 0 END)>zeit.gj+1 /* dynamisch*/
	GROUP BY vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.gj
) vis
LEFT JOIN DBP_MSI_VIEW_VIS.MV_VIS_JZG_ZIEL_WERT jzg16 /* 16 Kunde */
ON  jzg16.mandant_id = vis.mandant_id AND jzg16.wup_id = vis.wup_id
AND jzg16.wrg_id = vis.wrg_id AND jzg16.gj = vis.gj
AND jzg16.metrik_id = 16 AND jzg16.typ_id = 0 AND jzg16.level_id = 0 
 
/* JZG 18.0.0 Ø-Bon Filiale */ 
UNION ALL SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, vis.gj
, 18::INTEGER AS METRIK_ID, 0::INTEGER  AS TYP_ID, 0::INTEGER  AS LEVEL_ID
, NULL  AS EING /* keine direkte Eingabe */
, ''    AS KOMM /* kein Kommentar */
, NULL  AS HLPR 
, 1.000 AS A1
, NULL  AS A2
, A1    AS ANTL
, jzg10.wert_eingabe            AS Z1 /* aus Eingabe Umsatz */
, jzg16.wert_eingabe            AS Z2 /* aus Eingabe Kunden */
, ZEROIFNULL(Z1/NULLIFZERO(Z2)) AS ZIEL  /* Ziel berechnet */
FROM ( /* JZG MAIN - Filiale GJ*/
	SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.gj
	, SUM(vis.ums_netto_plan) AS ums_plan
	FROM DBP_MSI_DATA.VIS_MONAT_UMS_KUNDE_PERS_WUP vis
	JOIN DBP_DATA.MONAT zeit
	ON zeit.kjmo = vis.kjmo AND zeit.akt_gj = 0
	/* Standard Filter VTC = Filiale (ohne NB) unbereinigt */
	INNER JOIN dbp_data.wup wup 
	ON wup.wup_id = vis.wup_id AND wup.mandant_id = vis.mandant_id AND wup.nb_id=0
	AND wup.dat_eroeffnung < '2090-12-31' /* fix */
	AND (EXTRACT(YEAR FROM wup.dat_bis)+CASE WHEN EXTRACT(MONTH FROM wup.dat_bis)<3 THEN -1 ELSE 0 END)>zeit.gj+1 /* dynamisch*/
	GROUP BY vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.gj
) vis
LEFT JOIN DBP_MSI_VIEW_VIS.MV_VIS_JZG_ZIEL_WERT  jzg10 /* 10 Umsatz */
ON  jzg10.mandant_id = vis.mandant_id AND jzg10.wup_id = vis.wup_id
AND jzg10.wrg_id = vis.wrg_id AND jzg10.gj = vis.gj
AND jzg10.metrik_id = 10 AND jzg10.typ_id = 0 AND jzg10.level_id = 0 
LEFT JOIN DBP_MSI_VIEW_VIS.MV_VIS_JZG_ZIEL_WERT jzg16 /* 16 Kunde */
ON  jzg16.mandant_id = vis.mandant_id AND jzg16.wup_id = vis.wup_id
AND jzg16.wrg_id = vis.wrg_id AND jzg16.gj = vis.gj
AND jzg16.metrik_id = 16 AND jzg16.typ_id = 0 AND jzg16.level_id = 0 
 
/* JZG 20.0.0 Nettoleistung Filiale */ 
UNION ALL SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, vis.gj
, 20::INTEGER AS METRIK_ID, 0::INTEGER  AS TYP_ID, 0::INTEGER  AS LEVEL_ID
, NULL  AS EING /* keine direkte Eingabe */
, ''    AS KOMM /* kein Kommentar */
, NULL  AS HLPR 
, 1.000 AS A1
, NULL  AS A2
, A1    AS ANTL 
, jzg10.wert_eingabe AS Z1 /* aus Eingabe Umsatz */
, jzg24.wert_eingabe AS Z2 /* aus Eingabe Stunden */
, Z1/NULLIFZERO(Z2)  AS ZIEL /* Ziel berechnet */
FROM ( /* JZG MAIN - Filiale GJ*/
	SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.gj
	, SUM(vis.ums_netto_plan) AS ums_plan
	FROM DBP_MSI_DATA.VIS_MONAT_UMS_KUNDE_PERS_WUP vis
	JOIN DBP_DATA.MONAT zeit
	ON zeit.kjmo = vis.kjmo AND zeit.akt_gj = 0
	/* Standard Filter VTC = Filiale (ohne NB) unbereinigt */
	INNER JOIN dbp_data.wup wup 
	ON wup.wup_id = vis.wup_id AND wup.mandant_id = vis.mandant_id AND wup.nb_id=0
	AND wup.dat_eroeffnung < '2090-12-31' /* fix */
	AND (EXTRACT(YEAR FROM wup.dat_bis)+CASE WHEN EXTRACT(MONTH FROM wup.dat_bis)<3 THEN -1 ELSE 0 END)>zeit.gj+1 /* dynamisch*/
	GROUP BY vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.gj
) vis
LEFT JOIN DBP_MSI_VIEW_VIS.MV_VIS_JZG_ZIEL_WERT  jzg10 /* 10 Umsatz */
ON  jzg10.mandant_id = vis.mandant_id AND jzg10.wup_id = vis.wup_id
AND jzg10.wrg_id = vis.wrg_id AND jzg10.gj = vis.gj
AND jzg10.metrik_id = 10 AND jzg10.typ_id = 0 AND jzg10.level_id = 0 
LEFT JOIN DBP_MSI_VIEW_VIS.MV_VIS_JZG_ZIEL_WERT jzg24 /* 24 Stunden */
ON jzg24.mandant_id = vis.mandant_id AND jzg24.wup_id = vis.wup_id
AND jzg24.wrg_id = vis.wrg_id AND jzg24.gj = vis.gj
AND jzg24.metrik_id = 24 AND jzg24.typ_id = 0 AND jzg24.level_id = 0 
 
/* JZG 24.0.0 Nettostunden Filiale */ 
UNION ALL SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, vis.gj
, 24::INTEGER AS METRIK_ID, 0::INTEGER  AS TYP_ID, 0::INTEGER  AS LEVEL_ID
, COALESCE(jzg24.wert_eingabe,0)       AS EING /* Eingabe Nettostunden Filiale */
, COALESCE(jzg24.kommentar_eingabe,'') AS KOMM /* Eingabe Kommentar */
, NULL  AS HLPR 
, 1.000 AS A1
, NULL  AS A2
, A1    AS ANTL 
, EING  AS Z1 /* Ziel = Eingabe */
, NULL  AS Z2
, Z1    AS ZIEL 
FROM ( /* JZG MAIN - Filiale GJ*/
	SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.gj
	, SUM(vis.ums_netto_plan) AS ums_plan
	FROM DBP_MSI_DATA.VIS_MONAT_UMS_KUNDE_PERS_WUP vis
	JOIN DBP_DATA.MONAT zeit
	ON zeit.kjmo = vis.kjmo AND zeit.akt_gj = 0
	/* Standard Filter VTC = Filiale (ohne NB) unbereinigt */
	INNER JOIN dbp_data.wup wup 
	ON wup.wup_id = vis.wup_id AND wup.mandant_id = vis.mandant_id AND wup.nb_id=0
	AND wup.dat_eroeffnung < '2090-12-31' /* fix */
	AND (EXTRACT(YEAR FROM wup.dat_bis)+CASE WHEN EXTRACT(MONTH FROM wup.dat_bis)<3 THEN -1 ELSE 0 END)>zeit.gj+1 /* dynamisch*/
	GROUP BY vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.gj
) vis
LEFT JOIN DBP_MSI_VIEW_VIS.MV_VIS_JZG_ZIEL_WERT jzg24 /* 24 Stunden */
ON jzg24.mandant_id = vis.mandant_id AND jzg24.wup_id = vis.wup_id
AND jzg24.wrg_id = vis.wrg_id AND jzg24.gj = vis.gj
AND jzg24.metrik_id = 24 AND jzg24.typ_id = 0 AND jzg24.level_id = 0  
 
/* JZG 40.x.x Abschriften operativ */ 
UNION ALL SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, vis.gj
, 40::INTEGER AS METRIK_ID, jzg.TYP AS TYP_ID, jzg.LEVEL AS LEVEL_ID 
, jzg.abs_ein        AS EIN /* Eingabe nur definierte Ebenen */
, jzg.kommentar      AS KOMM /* Kommentar nur bei Eingabe */
, NULL               AS HLPR 
, jzg10.wert_eingabe AS A1
, vis.ums_plan       AS A2 
, A1/NULLIFZERO(A2)  AS ANTL /* Faktor Umsatz Eingabe / Umsatz Plan */
, jzg.abs_calc*ANTL  AS Z1   /* Helper Abschriften absolut */
, jzg.abs_ums*ANTL   AS Z2   /* Helper Abschriften Umsatz */
, Z1/NULLIFZERO(Z2)  AS ZIEL /* Ziel berechnet */
FROM ( /* JZG MAIN - Filiale GJ*/
	SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.gj
	, SUM(vis.ums_netto_plan) AS ums_plan
	FROM DBP_MSI_DATA.VIS_MONAT_UMS_KUNDE_PERS_WUP vis
	JOIN DBP_DATA.MONAT zeit
	ON zeit.kjmo = vis.kjmo AND zeit.akt_gj = 0
	/* Standard Filter VTC = Filiale (ohne NB) unbereinigt */
	INNER JOIN dbp_data.wup wup 
	ON wup.wup_id = vis.wup_id AND wup.mandant_id = vis.mandant_id AND wup.nb_id=0
	AND wup.dat_eroeffnung < '2090-12-31' /* fix */
	AND (EXTRACT(YEAR FROM wup.dat_bis)+CASE WHEN EXTRACT(MONTH FROM wup.dat_bis)<3 THEN -1 ELSE 0 END)>zeit.gj+1 /* dynamisch*/
	GROUP BY vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.gj
) vis
LEFT JOIN DBP_MSI_VIEW_VIS.MV_VIS_JZG_ZIEL_WERT jzg10 /* 10 Umsatz Filiale */
ON  jzg10.mandant_id = vis.mandant_id AND jzg10.wup_id = vis.wup_id
AND jzg10.wrg_id = vis.wrg_id AND jzg10.gj = vis.gj
AND jzg10.metrik_id = 10 AND jzg10.typ_id = 0 AND jzg10.level_id = 0 
LEFT JOIN ( /* Berechnung Zielwerte pro Level */
	/* Ultra-Frische OWG direkt */
	SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, vis.gj, vis.abt_id, vis.hwg_id, vis.owg_id
	, vis.typ_id AS TYP, vis.level_id AS LEVEL
	, vis.ums_plan                       AS abs_ums
	, COALESCE(jzg.wert_eingabe,0)       AS abs_ein
	, COALESCE(jzg.kommentar_eingabe,'') AS kommentar
	, jzg.wert_eingabe*vis.ums_plan      AS abs_calc
	FROM( /* Plan Ultra-Frische OWG */
		SELECT pln.mandant_id, pln.nb_id, pln.wup_id, pln.wrg_id, zeit.gj, abt.abt_id, hwg.hwg_id, owg.owg_id
		,3::INTEGER AS TYP_ID, (abt.abt_id*1000000 + ABS(hwg.hwg_id)*10000 + ABS(owg.owg_id))::INTEGER AS LEVEL_ID
		, SUM(pln.umsatz_netto_plan) AS ums_plan
		FROM dbp_msi_view_vis.mv_wup_plan_kjmo_owg pln
		JOIN DBP_MSI_VIEW_VIS.MV_OWG_INT owg
		ON owg.owg_id = pln.owg_id 
		JOIN DBP_MSI_VIEW_VIS.MV_HWG_INT hwg
		ON hwg.hwg_id = owg.hwg_id
		JOIN DBP_MSI_VIEW_VIS.MV_ABT_INT abt
		ON abt.abt_id = hwg.abt_id
		JOIN DBP_DATA.MONAT zeit
		ON zeit.kjmo = pln.kjmo AND zeit.akt_gj=0
		WHERE owg.owg_id IN (1001,1002,1003,1004,1005,1006,1007,1008,1009,1010,1013) /* Plan Ultra-Frische */
		GROUP BY pln.mandant_id, pln.nb_id, pln.wup_id, pln.wrg_id, zeit.gj, abt.abt_id, hwg.hwg_id, owg.owg_id
	) vis
	LEFT JOIN DBP_MSI_VIEW_VIS.MV_VIS_JZG_ZIEL_WERT jzg /* 40 Abschriften OWG */
	ON jzg.mandant_id = vis.mandant_id AND jzg.wup_id = vis.wup_id
	AND jzg.wrg_id = vis.wrg_id AND jzg.gj = vis.gj
	AND jzg.metrik_id = 40 AND jzg.typ_id = 3 
	AND jzg.level_id = vis.level_id
	/* Ultra-Frische HWG agg */
	UNION ALL SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, vis.gj, vis.abt_id, vis.hwg_id, 0 AS owg_id
	, 2::INTEGER AS TYP, (vis.abt_id*1000000 + ABS(vis.hwg_id)*10000)::INTEGER AS LEVEL
	, SUM(vis.ums_plan) AS abs_ums
	, NULL              AS abs_ein
	, ''                AS kommentar
	, SUM(jzg.wert_eingabe*vis.ums_plan) AS abs_calc
	FROM( /* Plan Ultra-Frische OWG */
		SELECT pln.mandant_id, pln.nb_id, pln.wup_id, pln.wrg_id, zeit.gj, abt.abt_id, hwg.hwg_id, owg.owg_id
		,3::INTEGER AS TYP_ID, (abt.abt_id*1000000 + ABS(hwg.hwg_id)*10000 + ABS(owg.owg_id))::INTEGER AS LEVEL_ID
		, SUM(pln.umsatz_netto_plan) AS ums_plan
		FROM dbp_msi_view_vis.mv_wup_plan_kjmo_owg pln
		JOIN DBP_MSI_VIEW_VIS.MV_OWG_INT owg
		ON owg.owg_id = pln.owg_id 
		JOIN DBP_MSI_VIEW_VIS.MV_HWG_INT hwg
		ON hwg.hwg_id = owg.hwg_id
		JOIN DBP_MSI_VIEW_VIS.MV_ABT_INT abt
		ON abt.abt_id = hwg.abt_id
		JOIN DBP_DATA.MONAT zeit
		ON zeit.kjmo = pln.kjmo AND zeit.akt_gj=0
		WHERE owg.owg_id IN (1001,1002,1003,1004,1005,1006,1007,1008,1009,1010,1013) /* Plan Ultra-Frische */
		GROUP BY pln.mandant_id, pln.nb_id, pln.wup_id, pln.wrg_id, zeit.gj, abt.abt_id, hwg.hwg_id, owg.owg_id
	) vis
	LEFT JOIN DBP_MSI_VIEW_VIS.MV_VIS_JZG_ZIEL_WERT jzg /* 40 Abschriften OWG */
	ON jzg.mandant_id = vis.mandant_id AND jzg.wup_id = vis.wup_id
	AND jzg.wrg_id = vis.wrg_id AND jzg.gj = vis.gj
	AND jzg.metrik_id = 40 AND jzg.typ_id = 3 
	AND jzg.level_id = vis.level_id
	GROUP BY vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, vis.gj, vis.abt_id, vis.hwg_id
	/* Food Frische HWG direkt */
	UNION ALL SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, vis.gj, vis.abt_id, vis.hwg_id, vis.owg_id
	, vis.typ_id, vis.level_id
	, vis.ums_plan                       AS abs_ums
	, COALESCE(jzg.wert_eingabe,0)       AS abs_ein
	, COALESCE(jzg.kommentar_eingabe,'') AS kommentar
	, jzg.wert_eingabe*vis.ums_plan      AS abs_calc    
	FROM ( /* Plan Food Frische HWG */
		SELECT pln.mandant_id, pln.nb_id, pln.wup_id, pln.wrg_id, zeit.gj, abt.abt_id, hwg.hwg_id, 0 AS owg_id
		,2::INTEGER AS TYP_ID, (abt.abt_id*1000000 + ABS(hwg.hwg_id)*10000)::INTEGER AS LEVEL_ID
		, SUM(pln.umsatz_netto_plan) AS ums_plan
		FROM dbp_msi_view_vis.mv_wup_plan_kjmo_owg pln
		JOIN DBP_MSI_VIEW_VIS.MV_OWG_INT owg
		ON owg.owg_id = pln.owg_id 
		JOIN DBP_MSI_VIEW_VIS.MV_HWG_INT hwg
		ON hwg.hwg_id = owg.hwg_id
		JOIN DBP_MSI_VIEW_VIS.MV_ABT_INT abt
		ON abt.abt_id = hwg.abt_id
		JOIN DBP_DATA.MONAT zeit
		ON zeit.kjmo = pln.kjmo AND zeit.akt_gj=0
		WHERE pln.owg_id IN (-1027,-1022,-1019,-1017,-1015) /* Plan Food Frische */
		GROUP BY pln.mandant_id, pln.nb_id, pln.wup_id, pln.wrg_id, zeit.gj, abt.abt_id, hwg.hwg_id
	) vis
	LEFT JOIN DBP_MSI_VIEW_VIS.MV_VIS_JZG_ZIEL_WERT jzg /* 40 Abschriften HWG */
	ON jzg.mandant_id = vis.mandant_id AND jzg.wup_id = vis.wup_id
	AND jzg.wrg_id = vis.wrg_id -- AND jzg.gj = zeit.gj
	AND jzg.metrik_id = 40 AND jzg.typ_id = 2 
	AND jzg.level_id = vis.level_id
	/* Ultra-Frische Abteilung agg */
	UNION ALL SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, vis.gj, vis.abt_id, 0 AS hwg_id, 0 AS owg_id
	, 1::INTEGER AS TYP_ID, (CASE vis.abt_id WHEN 4 THEN 9999999 ELSE vis.abt_id * 1000000 END)::INTEGER AS LEVEL_ID /* ABT aggregated */
	, SUM(vis.ums_plan) AS abs_ums
	, NULL              AS abs_ein
	, ''                AS kommentar
	, SUM(jzg.wert_eingabe*vis.ums_plan) AS abs_calc
	FROM( /* Plan Ultra-Frische OWG */
		SELECT pln.mandant_id, pln.nb_id, pln.wup_id, pln.wrg_id, zeit.gj, abt.abt_id, hwg.hwg_id, owg.owg_id
		,3::INTEGER AS TYP_ID, (abt.abt_id*1000000 + ABS(hwg.hwg_id)*10000 + ABS(owg.owg_id))::INTEGER AS LEVEL_ID
		, SUM(pln.umsatz_netto_plan) AS ums_plan
		FROM dbp_msi_view_vis.mv_wup_plan_kjmo_owg pln
		JOIN DBP_MSI_VIEW_VIS.MV_OWG_INT owg
		ON owg.owg_id = pln.owg_id 
		JOIN DBP_MSI_VIEW_VIS.MV_HWG_INT hwg
		ON hwg.hwg_id = owg.hwg_id
		JOIN DBP_MSI_VIEW_VIS.MV_ABT_INT abt
		ON abt.abt_id = hwg.abt_id
		JOIN DBP_DATA.MONAT zeit
		ON zeit.kjmo = pln.kjmo AND zeit.akt_gj=0
		WHERE owg.owg_id IN (1001,1002,1003,1004,1005,1006,1007,1008,1009,1010,1013) /* Plan Ultra-Frische */
		GROUP BY pln.mandant_id, pln.nb_id, pln.wup_id, pln.wrg_id, zeit.gj, abt.abt_id, hwg.hwg_id, owg.owg_id
	) vis
	LEFT JOIN DBP_MSI_VIEW_VIS.MV_VIS_JZG_ZIEL_WERT jzg /* 40 Abschriften OWG */
	ON jzg.mandant_id = vis.mandant_id AND jzg.wup_id = vis.wup_id
	AND jzg.wrg_id = vis.wrg_id AND jzg.gj = vis.gj
	AND jzg.metrik_id = 40 AND jzg.typ_id = 3 
	AND jzg.level_id = vis.level_id
	GROUP BY vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, vis.gj, vis.abt_id
	/* Food Frische Abteilung agg */
	UNION ALL SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, vis.gj, vis.abt_id, 0 AS hwg_id, 0 AS owg_id
	, 1::INTEGER AS TYP_ID, (CASE vis.abt_id WHEN 4 THEN 9999999 ELSE vis.abt_id * 1000000 END)::INTEGER AS LEVEL_ID /* ABT agg */
	, SUM(vis.ums_plan) AS abs_ums
	, NULL              AS abs_ein
	, ''                AS kommentar
	, SUM(jzg.wert_eingabe*vis.ums_plan) AS abs_calc
	FROM( /* Plan Food Frische HWG */
		SELECT pln.mandant_id, pln.nb_id, pln.wup_id, pln.wrg_id, zeit.gj, abt.abt_id, hwg.hwg_id, 0 AS owg_id
		,2::INTEGER AS TYP_ID, (abt.abt_id*1000000 + ABS(hwg.hwg_id)*10000)::INTEGER AS LEVEL_ID
		, SUM(pln.umsatz_netto_plan) AS ums_plan
		FROM dbp_msi_view_vis.mv_wup_plan_kjmo_owg pln
		JOIN DBP_MSI_VIEW_VIS.MV_OWG_INT owg
		ON owg.owg_id = pln.owg_id 
		JOIN DBP_MSI_VIEW_VIS.MV_HWG_INT hwg
		ON hwg.hwg_id = owg.hwg_id
		JOIN DBP_MSI_VIEW_VIS.MV_ABT_INT abt
		ON abt.abt_id = hwg.abt_id
		JOIN DBP_DATA.MONAT zeit
		ON zeit.kjmo = pln.kjmo AND zeit.akt_gj=0
		WHERE pln.owg_id IN (-1027,-1022,-1019,-1017,-1015) /* Plan Food Frische */
		GROUP BY pln.mandant_id, pln.nb_id, pln.wup_id, pln.wrg_id, zeit.gj, abt.abt_id, hwg.hwg_id
	) vis
	LEFT JOIN DBP_MSI_VIEW_VIS.MV_VIS_JZG_ZIEL_WERT jzg /* 40 Abschriften HWG */
	ON jzg.mandant_id = vis.mandant_id AND jzg.wup_id = vis.wup_id
	AND jzg.wrg_id = vis.wrg_id -- AND jzg.gj = zeit.gj
	AND jzg.metrik_id = 40 AND jzg.typ_id = 2 
	AND jzg.level_id = vis.level_id
	GROUP BY vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, vis.gj, vis.abt_id
	/* Abteilung Food, Nonfood, Nebengeschäft direkt */
	UNION ALL SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, vis.gj, vis.abt_id, vis.hwg_id, vis.owg_id
	, vis.typ_id, vis.level_id
	, vis.ums_plan                       AS abs_ums
	, COALESCE(jzg.wert_eingabe,0)       AS abs_ein
	, COALESCE(jzg.kommentar_eingabe,'') AS kommentar
	, jzg.wert_eingabe*vis.ums_plan      AS abs_calc
	FROM ( /* Plan Abteilung Food, Nonfood, Nebengeschäft */
		SELECT pln.mandant_id, pln.nb_id, pln.wup_id, pln.wrg_id, zeit.gj, abt.abt_id, 0 AS hwg_id, 0 AS owg_id
		,1::INTEGER AS TYP_ID, (CASE abt.abt_id WHEN 4 THEN 9999999 ELSE abt.abt_id * 1000000 END)::INTEGER AS LEVEL_ID
		, SUM(pln.umsatz_netto_plan) AS ums_plan
		FROM dbp_msi_view_vis.mv_wup_plan_kjmo_owg pln
		JOIN DBP_MSI_VIEW_VIS.MV_OWG_INT owg
		ON owg.owg_id = pln.owg_id 
		JOIN DBP_MSI_VIEW_VIS.MV_HWG_INT hwg
		ON hwg.hwg_id = owg.hwg_id
		JOIN DBP_MSI_VIEW_VIS.MV_ABT_INT abt
		ON abt.abt_id = hwg.abt_id
		JOIN DBP_DATA.MONAT zeit
		ON zeit.kjmo = pln.kjmo AND zeit.akt_gj=0
		WHERE pln.owg_id IN (-1092,-1068,-1028) /* Plan Food,Nonfood,Nebengeschäft */
		GROUP BY pln.mandant_id, pln.nb_id, pln.wup_id, pln.wrg_id, zeit.gj, abt.abt_id
	) vis
	LEFT JOIN DBP_MSI_VIEW_VIS.MV_VIS_JZG_ZIEL_WERT jzg /* 40 Abschriften Abteilung */
	ON jzg.mandant_id = vis.mandant_id AND jzg.wup_id = vis.wup_id
	AND jzg.wrg_id = vis.wrg_id AND jzg.gj = vis.gj
	AND jzg.metrik_id = 40 AND jzg.typ_id = 1
	AND jzg.level_id = vis.level_id
	/* Filiale agg */
	UNION ALL SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, vis.gj, 0 AS abt_id, 0 AS hwg_id, 0 AS owg_id
	, 0::INTEGER AS TYP, 0::INTEGER AS LEVEL 
	, SUM(vis.ums_plan) AS abs_ums
	, NULL              AS abs_ein
	, ''                AS kommentar
	, SUM(jzg.wert_eingabe*vis.ums_plan) AS abs_calc
	FROM( /* Plan OWG/HWG/ABT */
		/* Plan Ultra-Frische OWG */
		SELECT pln.mandant_id, pln.nb_id, pln.wup_id, pln.wrg_id, zeit.gj, abt.abt_id, hwg.hwg_id, owg.owg_id
		, 3::INTEGER AS TYP_ID, (abt.abt_id*1000000 + ABS(hwg.hwg_id)*10000 + ABS(owg.owg_id))::INTEGER AS LEVEL_ID
		, SUM(pln.umsatz_netto_plan) AS ums_plan
		FROM dbp_msi_view_vis.mv_wup_plan_kjmo_owg pln
		JOIN DBP_MSI_VIEW_VIS.MV_OWG_INT owg
		ON owg.owg_id = pln.owg_id 
		JOIN DBP_MSI_VIEW_VIS.MV_HWG_INT hwg
		ON hwg.hwg_id = owg.hwg_id
		JOIN DBP_MSI_VIEW_VIS.MV_ABT_INT abt
		ON abt.abt_id = hwg.abt_id
		JOIN DBP_DATA.MONAT zeit
		ON zeit.kjmo = pln.kjmo AND zeit.akt_gj=0
		WHERE owg.owg_id IN (1001,1002,1003,1004,1005,1006,1007,1008,1009,1010,1013) /* Plan Ultra-Frische */
		GROUP BY pln.mandant_id, pln.nb_id, pln.wup_id, pln.wrg_id, zeit.gj, abt.abt_id, hwg.hwg_id, owg.owg_id
		/* Plan HWG Food Frische */
		UNION ALL SELECT pln.mandant_id, pln.nb_id, pln.wup_id, pln.wrg_id, zeit.gj, abt.abt_id, hwg.hwg_id, 0 AS owg_id
		, 2::INTEGER AS TYP_ID, (abt.abt_id*1000000 + ABS(hwg.hwg_id)*10000)::INTEGER AS LEVEL_ID
		, SUM(pln.umsatz_netto_plan) AS ums_plan
		FROM dbp_msi_view_vis.mv_wup_plan_kjmo_owg pln
		JOIN DBP_MSI_VIEW_VIS.MV_OWG_INT owg
		ON owg.owg_id = pln.owg_id 
		JOIN DBP_MSI_VIEW_VIS.MV_HWG_INT hwg
		ON hwg.hwg_id = owg.hwg_id
		JOIN DBP_MSI_VIEW_VIS.MV_ABT_INT abt
		ON abt.abt_id = hwg.abt_id
		JOIN DBP_DATA.MONAT zeit
		ON zeit.kjmo = pln.kjmo AND zeit.akt_gj=0
		WHERE pln.owg_id IN (-1027,-1022,-1019,-1017,-1015) /* Plan Food Frische */
		GROUP BY pln.mandant_id, pln.nb_id, pln.wup_id, pln.wrg_id, zeit.gj, abt.abt_id, hwg.hwg_id
		/* Plan Abteilung Food, Nonfood, Nebengeschäft */
		UNION ALL SELECT pln.mandant_id, pln.nb_id, pln.wup_id, pln.wrg_id, zeit.gj, abt.abt_id, 0 AS hwg_id, 0 AS owg_id
		, 1::INTEGER AS TYP_ID, (CASE abt.abt_id WHEN 4 THEN 9999999 ELSE abt.abt_id * 1000000 END)::INTEGER AS LEVEL_ID
		, SUM(pln.umsatz_netto_plan) AS ums_plan
		FROM dbp_msi_view_vis.mv_wup_plan_kjmo_owg pln
		JOIN DBP_MSI_VIEW_VIS.MV_OWG_INT owg
		ON owg.owg_id = pln.owg_id 
		JOIN DBP_MSI_VIEW_VIS.MV_HWG_INT hwg
		ON hwg.hwg_id = owg.hwg_id
		JOIN DBP_MSI_VIEW_VIS.MV_ABT_INT abt
		ON abt.abt_id = hwg.abt_id
		JOIN DBP_DATA.MONAT zeit
		ON zeit.kjmo = pln.kjmo AND zeit.akt_gj=0
		WHERE pln.owg_id IN (-1092,-1068,-1028) /* Plan Food,Nonfood,Nebengeschäft */
		GROUP BY pln.mandant_id, pln.nb_id, pln.wup_id, pln.wrg_id, zeit.gj, abt.abt_id
	) vis
	LEFT JOIN DBP_MSI_VIEW_VIS.MV_VIS_JZG_ZIEL_WERT jzg /* 40 Abschriften OWG */
	ON jzg.mandant_id = vis.mandant_id AND jzg.wup_id = vis.wup_id
	AND jzg.wrg_id = vis.wrg_id AND jzg.gj = vis.gj
	AND jzg.metrik_id = 40 /* ohne jzg.typ_id */
	AND jzg.level_id = vis.level_id
	GROUP BY vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, vis.gj
) jzg
ON jzg.mandant_id = vis.mandant_id AND jzg.wup_id = vis.wup_id
AND jzg.wrg_id = vis.wrg_id AND jzg.gj = vis.gj 
 
/* JZG 46.0.0 Inventur Filiale + 46.1.x000000 Inventur Abteilung */
UNION ALL SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, vis.gj
, 46::INTEGER AS METRIK_ID, pln.TYP_ID, pln.LEVEL_ID AS LEVEL_ID
, pln.inv_ein   AS EING /* Eingabe nur Abteilung */
, pln.kommentar AS KOMM /* Kommentar nur Abteilung */
, NULL          AS HLPR 
, jzg10.wert_eingabe AS A1
, vis.ums_plan       AS A2
, A1/NULLIFZERO(A2)  AS ANTL /* Faktor Umsatz Eingabe / Umsatz Plan*/
, pln.inv_calc*ANTL  AS Z1   /* Helper Inventur absolut */
, pln.ums_plan*ANTL  AS Z2   /* Helper Inventur Umsatz */
, Z1/NULLIFZERO(Z2)  AS ZIEL /* Ziel berechnet */
FROM ( /* JZG MAIN - Filiale GJ*/
	SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.gj
	, SUM(vis.ums_netto_plan) AS ums_plan
	FROM DBP_MSI_DATA.VIS_MONAT_UMS_KUNDE_PERS_WUP vis
	JOIN DBP_DATA.MONAT zeit
	ON zeit.kjmo = vis.kjmo AND zeit.akt_gj = 0
	/* Standard Filter VTC = Filiale (ohne NB) unbereinigt */
	INNER JOIN dbp_data.wup wup 
	ON wup.wup_id = vis.wup_id AND wup.mandant_id = vis.mandant_id AND wup.nb_id=0
	AND wup.dat_eroeffnung < '2090-12-31' /* fix */
	AND (EXTRACT(YEAR FROM wup.dat_bis)+CASE WHEN EXTRACT(MONTH FROM wup.dat_bis)<3 THEN -1 ELSE 0 END)>zeit.gj+1 /* dynamisch*/
	GROUP BY vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.gj
) vis
LEFT JOIN DBP_MSI_VIEW_VIS.MV_VIS_JZG_ZIEL_WERT  jzg10 /* 10 Umsatz Filiale */
ON  jzg10.mandant_id = vis.mandant_id AND jzg10.wup_id = vis.wup_id
AND jzg10.wrg_id = vis.wrg_id AND jzg10.gj = vis.gj
AND jzg10.metrik_id = 10 AND jzg10.typ_id = 0 AND jzg10.level_id = 0  
LEFT JOIN ( /* JZG Inventur - Abteilung Zielwerte */
	SELECT pln.mandant_id, pln.nb_id, pln.wup_id, zeit.gj, pln.wrg_id, abt.abt_id
	, 1::INTEGER AS TYP_ID, (CASE abt.abt_id WHEN 4 THEN 9999999 ELSE abt.abt_id * 1000000 END)::INTEGER AS LEVEL_ID
	, SUM(pln.umsatz_netto_plan)   AS ums_plan
	, MAX(jzg50.wert_eingabe)      AS inv_ein
	, MAX(jzg50.kommentar_eingabe) AS kommentar
	, SUM(pln.umsatz_netto_plan*jzg50.wert_eingabe) AS inv_calc
	FROM dbp_msi_view_vis.mv_wup_plan_kjmo_owg pln
	JOIN DBP_MSI_VIEW_VIS.MV_OWG_INT owg
	ON owg.owg_id = pln.owg_id  
	JOIN DBP_MSI_VIEW_VIS.MV_HWG_INT hwg
	ON hwg.hwg_id = owg.hwg_id
	JOIN DBP_MSI_VIEW_VIS.MV_ABT_INT abt
	ON abt.abt_id = hwg.abt_id
	JOIN DBP_DATA.MONAT zeit
	ON zeit.kjmo = pln.kjmo AND zeit.akt_gj = 0
	LEFT JOIN DBP_MSI_VIEW_VIS.MV_VIS_JZG_ZIEL_WERT jzg50 /* 46 Inventur Abt */
	ON jzg50.mandant_id = pln.mandant_id AND jzg50.wup_id = pln.wup_id
	AND jzg50.wrg_id = pln.wrg_id AND jzg50.gj = zeit.gj
	AND jzg50.metrik_id = 46 AND typ_id = 1 
	AND jzg50.level_id = (CASE abt.abt_id WHEN 4 THEN 9999999 ELSE abt.abt_id * 1000000 END)
	WHERE abt.abt_id IN (4,5,6,7,8) /* Alle Abt */
	GROUP BY pln.mandant_id, pln.nb_id, pln.wup_id, zeit.gj, pln.wrg_id, abt.abt_id
	/* JZG Inventur - Filiale aggregiert */
	UNION ALL SELECT pln.mandant_id, pln.nb_id, pln.wup_id, zeit.gj, pln.wrg_id, 0
	, 0::INTEGER AS TYP_ID, 0::INTEGER AS LEVEL_ID 
	, SUM(pln.umsatz_netto_plan) AS ums_plan
	, NULL AS inv_ein
	, ''   AS kommentar
	, SUM(pln.umsatz_netto_plan*jzg50.wert_eingabe) AS inv_calc
	FROM dbp_msi_view_vis.mv_wup_plan_kjmo_owg pln
	JOIN DBP_MSI_VIEW_VIS.MV_OWG_INT owg
	ON owg.owg_id = pln.owg_id  
	JOIN DBP_MSI_VIEW_VIS.MV_HWG_INT hwg
	ON hwg.hwg_id = owg.hwg_id
	JOIN DBP_MSI_VIEW_VIS.MV_ABT_INT abt
	ON abt.abt_id = hwg.abt_id
	JOIN DBP_DATA.MONAT zeit
	ON zeit.kjmo = pln.kjmo AND zeit.akt_gj = 0
	LEFT JOIN DBP_MSI_VIEW_VIS.MV_VIS_JZG_ZIEL_WERT jzg50 /* 46 Inventur Abt */
	ON jzg50.mandant_id = pln.mandant_id AND jzg50.wup_id = pln.wup_id
	AND jzg50.wrg_id = pln.wrg_id AND jzg50.gj = zeit.gj
	AND jzg50.metrik_id = 46
	AND jzg50.level_id = (CASE abt.abt_id WHEN 4 THEN 9999999 ELSE abt.abt_id * 1000000 END)
	WHERE abt.abt_id IN (4,5,6,7,8) /* Alle Abt */
	GROUP BY pln.mandant_id, pln.nb_id, pln.wup_id, zeit.gj, pln.wrg_id
)pln 
ON pln.mandant_id = vis.mandant_id AND pln.wup_id = vis.wup_id
AND pln.wrg_id = vis.wrg_id AND pln.gj = vis.gj   
 
/* JZG 70.0.0 Personalkosten (%) Filiale */
UNION ALL SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, vis.gj AS GJ
, 70::INTEGER AS METRIK_ID, 0::INTEGER AS TYP_ID, 0::INTEGER  AS LEVEL_ID
, COALESCE(jzg70.wert_eingabe,0)       AS EING /* Eingabe Personalkosten (%) */
, COALESCE(jzg70.kommentar_eingabe,'') AS KOMM /* Eingabe Kommentar */
, COALESCE(jzg10.wert_eingabe,0)       AS HLPR /* aus Umsatz Eingabe */
, 1.000 AS A1
, NULL  AS A2
, A1    AS ANTL 
, HLPR*EING AS Z1 /* Helper PK absolut*/
, HLPR      AS Z2 /* Helper Umsatz Eingabe */
, EING      AS ZIEL 
FROM ( /* JZG MAIN - Filiale GJ*/
	SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.gj
	, SUM(vis.ums_netto_plan) AS ums_plan
	FROM DBP_MSI_DATA.VIS_MONAT_UMS_KUNDE_PERS_WUP vis
	JOIN DBP_DATA.MONAT zeit
	ON zeit.kjmo = vis.kjmo AND zeit.akt_gj = 0
	/* Standard Filter VTC = Filiale (ohne NB) unbereinigt */
	INNER JOIN dbp_data.wup wup 
	ON wup.wup_id = vis.wup_id AND wup.mandant_id = vis.mandant_id AND wup.nb_id=0
	AND wup.dat_eroeffnung < '2090-12-31' /* fix */
	AND (EXTRACT(YEAR FROM wup.dat_bis)+CASE WHEN EXTRACT(MONTH FROM wup.dat_bis)<3 THEN -1 ELSE 0 END)>zeit.gj+1 /* dynamisch*/
	GROUP BY vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.gj
) vis
LEFT JOIN DBP_MSI_VIEW_VIS.MV_VIS_JZG_ZIEL_WERT  jzg10 /* 10 Umsatz */
ON  jzg10.mandant_id = vis.mandant_id AND jzg10.wup_id = vis.wup_id
AND jzg10.wrg_id = vis.wrg_id AND jzg10.gj = vis.gj
AND jzg10.metrik_id = 10 AND jzg10.typ_id = 0 AND jzg10.level_id = 0 
LEFT JOIN DBP_MSI_VIEW_VIS.MV_VIS_JZG_ZIEL_WERT jzg70 /* 70 Personalkosten */
ON jzg70.mandant_id = vis.mandant_id AND jzg70.wup_id = vis.wup_id
AND jzg70.wrg_id = vis.wrg_id AND jzg70.gj = vis.gj
AND jzg70.metrik_id = 70 AND jzg70.typ_id = 0 AND jzg70.level_id = 0 
 
/* JZG9x.0.0 TOP Metriken  */
UNION ALL SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, vis.gj
, jzg.METRIK_ID AS METRIK_ID, 0::INTEGER  AS TYP_ID, 0::INTEGER  AS LEVEL_ID
, NULL                                  AS EING /* keine Eingabe TOP Wert */
, COALESCE(jzg90.kommentar_eingabe, '') AS KOMM /* Eingabe TOP Kommentar */
, NULL  AS HLPR 
, NULL  AS A1
, NULL  AS A2
, NULL  AS ANTL
, NULL  AS Z1
, NULL  AS Z2
, NULL  AS ZIEL 
FROM ( /* JZG MAIN - Filiale GJ*/
	SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.gj
	, SUM(vis.ums_netto_plan) AS ums_plan
	FROM DBP_MSI_DATA.VIS_MONAT_UMS_KUNDE_PERS_WUP vis
	JOIN DBP_DATA.MONAT zeit
	ON zeit.kjmo = vis.kjmo AND zeit.akt_gj = 0
	/* Standard Filter VTC = Filiale (ohne NB) unbereinigt */
	INNER JOIN dbp_data.wup wup 
	ON wup.wup_id = vis.wup_id AND wup.mandant_id = vis.mandant_id AND wup.nb_id=0
	AND wup.dat_eroeffnung < '2090-12-31' /* fix */
	AND (EXTRACT(YEAR FROM wup.dat_bis)+CASE WHEN EXTRACT(MONTH FROM wup.dat_bis)<3 THEN -1 ELSE 0 END)>zeit.gj+1 /* dynamisch*/
	GROUP BY vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.gj
) vis
CROSS JOIN ( /* JZG Dummies */ 
	SELECT 91::INTEGER AS METRIK_ID
	UNION ALL SELECT 92::INTEGER AS METRIK_ID
	UNION ALL SELECT 93::INTEGER AS METRIK_ID
	UNION ALL SELECT 94::INTEGER AS METRIK_ID
	UNION ALL SELECT 95::INTEGER AS METRIK_ID
) jzg
LEFT JOIN DBP_MSI_VIEW_VIS.MV_VIS_JZG_ZIEL_WERT jzg90 /* 90 TOP */
ON jzg90.mandant_id = vis.mandant_id AND jzg90.wup_id = vis.wup_id
AND jzg90.wrg_id = vis.wrg_id AND jzg90.gj = vis.gj
AND jzg90.metrik_id = jzg.metrik_id AND jzg90.typ_id = 0 AND jzg90.level_id = 0  
 
/* JZGxx.0.0 Alle übrigen Metriken */
UNION ALL SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, vis.gj
, jzg.METRIK_ID AS METRIK_ID, 0::INTEGER AS TYP_ID, 0::INTEGER  AS LEVEL_ID
, NULL  AS EING
, ''    AS KOMM 
, NULL  AS HLPR 
, NULL  AS A1
, NULL  AS A2
, NULL  AS ANTL
, NULL  AS Z1
, NULL  AS Z2
, NULL  AS ZIEL 
FROM ( /* JZG MAIN - Filiale GJ*/
	SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.gj
	, SUM(vis.ums_netto_plan) AS ums_plan
	FROM DBP_MSI_DATA.VIS_MONAT_UMS_KUNDE_PERS_WUP vis
	JOIN DBP_DATA.MONAT zeit
	ON zeit.kjmo = vis.kjmo AND zeit.akt_gj = 0
	/* Standard Filter VTC = Filiale (ohne NB) unbereinigt */
	INNER JOIN dbp_data.wup wup 
	ON wup.wup_id = vis.wup_id AND wup.mandant_id = vis.mandant_id AND wup.nb_id=0
	AND wup.dat_eroeffnung < '2090-12-31' /* fix */
	AND (EXTRACT(YEAR FROM wup.dat_bis)+CASE WHEN EXTRACT(MONTH FROM wup.dat_bis)<3 THEN -1 ELSE 0 END)>zeit.gj+1 /* dynamisch*/
	GROUP BY vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.gj
) vis
CROSS JOIN ( /* JZG Dummies */ 
	SELECT 30::INTEGER AS METRIK_ID 
	UNION ALL SELECT 32::INTEGER AS METRIK_ID
	UNION ALL SELECT 34::INTEGER AS METRIK_ID
	UNION ALL SELECT 36::INTEGER AS METRIK_ID
	UNION ALL SELECT 50::INTEGER AS METRIK_ID
	UNION ALL SELECT 54::INTEGER AS METRIK_ID
	UNION ALL SELECT 55::INTEGER AS METRIK_ID
	UNION ALL SELECT 56::INTEGER AS METRIK_ID
	UNION ALL SELECT 57::INTEGER AS METRIK_ID
	UNION ALL SELECT 58::INTEGER AS METRIK_ID
	UNION ALL SELECT 59::INTEGER AS METRIK_ID
	UNION ALL SELECT 60::INTEGER AS METRIK_ID
	UNION ALL SELECT 61::INTEGER AS METRIK_ID
	UNION ALL SELECT 62::INTEGER AS METRIK_ID
	UNION ALL SELECT 63::INTEGER AS METRIK_ID
	UNION ALL SELECT 72::INTEGER AS METRIK_ID
	UNION ALL SELECT 73::INTEGER AS METRIK_ID
	UNION ALL SELECT 74::INTEGER AS METRIK_ID
	UNION ALL SELECT 75::INTEGER AS METRIK_ID
	UNION ALL SELECT 76::INTEGER AS METRIK_ID
	UNION ALL SELECT 77::INTEGER AS METRIK_ID
	UNION ALL SELECT 78::INTEGER AS METRIK_ID
	UNION ALL SELECT 80::INTEGER AS METRIK_ID
	UNION ALL SELECT 81::INTEGER AS METRIK_ID
	UNION ALL SELECT 82::INTEGER AS METRIK_ID
	UNION ALL SELECT 84::INTEGER AS METRIK_ID
	UNION ALL SELECT 86::INTEGER AS METRIK_ID
	UNION ALL SELECT 88::INTEGER AS METRIK_ID
) jzg
;