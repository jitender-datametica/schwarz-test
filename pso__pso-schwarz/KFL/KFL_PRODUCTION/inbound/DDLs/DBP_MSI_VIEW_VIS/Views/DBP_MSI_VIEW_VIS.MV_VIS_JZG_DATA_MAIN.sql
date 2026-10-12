CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_VIS_JZG_DATA_MAIN(
	MANDANT_ID,
	NB_ID,
	WUP_ID,
	WRG_ID,
	GJ,
	METRIK_ID,
	TYP_ID,
	LEVEL_ID,
	WERT_VJ1,
	WERT_VJ2,
	PLAN_VJ1,
	PLAN_VJ2,
	PLAN_GJ1,
	PLAN_GJ2,
	WERT_VJ,
	PLAN_VJ,
	PLAN_GJ,
	DELTA,
	ABW
) AS
 
/*	FAKT DENORM JZG - Jahreszielgespräch Wert VJ / Plan VJ / Abw. / Plan GJ
	2023-02-15 ssch0611 : Intital Setup AP0144461
	2023-02-21 ssch0611 : Finetuning
	2023-10-18 TEMP VERSION kassentyp
	2023-10-25 ssch0611 : REVIEW AP0144461. Neue Struktur mit Plan GJ. Inventur(Fil/Abt). ohne Kundenfeedback
	2023-12-11 ssch0611 : CHECK Spalten >> FIX Umsatz HWG
	2024-01-25 ssch0611 : Finetuning + Fix SCO-Quote, Kurzcheck + Umstellung auf SHR_WUP 
	2024-02-07 ssch0611 : Fix Abschriften Plan, MA Vertragsstunden    
*/
 
/* JZG 10.0.0 Umsatz Filiale */ 
SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, (vis.gj+1) AS GJ 
, 10::INTEGER AS METRIK_ID, 0::INTEGER AS TYP_ID, 0::INTEGER AS LEVEL_ID
, vis.ums_wert AS WERT_VJ1, NULL AS WERT_VJ2
, vis.ums_plan AS PLAN_VJ1, NULL AS PLAN_VJ2
, plngj.ums_plan AS PLAN_GJ1, NULL AS PLAN_GJ2
, WERT_VJ1 AS WERT_VJ 
, PLAN_VJ1 AS PLAN_VJ
, PLAN_GJ1 AS PLAN_GJ
, WERT_VJ-PLAN_VJ AS DELTA /* WRG */
, DELTA/NULLIFZERO(PLAN_VJ) AS ABW /* prozent */
FROM ( /* JZG MAIN - KVJ */
	SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.gj
	, SUM(vis.ums_netto) AS ums_wert
	, SUM(vis.ums_netto_plan) AS ums_plan
	, SUM(vis.anz_kunde) AS anz_kunde
	, SUM(vis.pers_std) AS std_wert
	, SUM(vis.pers_std_plan) AS std_plan
	FROM DBP_MSI_DATA.VIS_MONAT_UMS_KUNDE_PERS_WUP vis
	INNER JOIN DBP_DATA.MONAT zeit
	ON zeit.kjmo = vis.kjmo AND zeit.akt_gj=-1
	/* Standard Filter VTC = Filiale (ohne NB) unbereinigt */
	INNER JOIN dbp_data.wup wup 
	ON wup.wup_id = vis.wup_id AND wup.mandant_id = vis.mandant_id AND wup.nb_id=0
	AND wup.dat_eroeffnung<'2090-12-31' /* fix */
	AND (EXTRACT(YEAR FROM wup.dat_bis)+CASE WHEN EXTRACT(MONTH FROM wup.dat_bis)<3 THEN -1 ELSE 0 END)>zeit.gj+1 /* dynamisch*/
	GROUP BY vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.gj
) vis
INNER JOIN ( /* JZG MAIN - GJ */
	SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.gj
	, SUM(vis.ums_netto_plan) AS ums_plan
	, SUM(vis.pers_std_plan)  AS std_plan
	FROM DBP_MSI_DATA.VIS_MONAT_UMS_KUNDE_PERS_WUP   vis
	JOIN DBP_DATA.MONAT zeit
	ON zeit.kjmo = vis.kjmo AND zeit.akt_gj=0
	/* Standard Filter VTC = Filiale (ohne NB) unbereinigt */
	INNER JOIN dbp_data.wup wup 
	ON wup.wup_id = vis.wup_id AND wup.mandant_id = vis.mandant_id AND wup.nb_id=0
	AND wup.dat_eroeffnung<'2090-12-31' /* fix */
	AND (EXTRACT(YEAR FROM wup.dat_bis)+CASE WHEN EXTRACT(MONTH FROM wup.dat_bis)<3 THEN -1 ELSE 0 END)>zeit.gj+1 /* dynamisch*/
	GROUP BY vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.gj
) plngj
ON plngj.mandant_id = vis.mandant_id AND plngj.wup_id = vis.wup_id
AND plngj.wrg_id = vis.wrg_id AND plngj.gj = (vis.gj+1) 
 
/* JZG 10.1.x000000 Umsatz Abteilung */ 
UNION ALL SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, (vis.gj+1) AS GJ 
, 10::INTEGER AS METRIK_ID, 1::INTEGER AS TYP_ID, (CASE vis.abt_id WHEN 4 THEN 9999999 ELSE vis.abt_id * 1000000 END)::INTEGER AS LEVEL_ID
, vis.ums_wert AS WERT_VJ1, NULL AS WERT_VJ2
, pln.ums_plan AS PLAN_VJ1, NULL AS PLAN_VJ2
, plngj.ums_plan AS PLAN_GJ1, NULL AS PLAN_GJ2
, WERT_VJ1 AS WERT_VJ 
, PLAN_VJ1 AS PLAN_VJ
, PLAN_GJ1 AS PLAN_GJ
, WERT_VJ-PLAN_VJ AS DELTA /* WRG */
, DELTA/NULLIFZERO(PLAN_VJ) AS ABW /* prozent */
FROM ( /* JZG WARE - Umsatz Abteilung KVJ */
	SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.gj, abt.abt_id
	, SUM(vis.ums_netto) AS ums_wert
	FROM DBP_MSI_DATA.VIS_MONAT_UMSATZ_WG vis
	JOIN DBP_MSI_VIEW_VIS.MV_WG_INT wg 
	ON wg.wg_id = vis.wg_id
	JOIN DBP_MSI_VIEW_VIS.MV_OWG_INT owg
	ON owg.owg_id = wg.owg_id
	JOIN DBP_MSI_VIEW_VIS.MV_HWG_INT hwg
	ON hwg.hwg_id = owg.hwg_id
	JOIN DBP_MSI_VIEW_VIS.MV_ABT_INT abt
	ON abt.abt_id = hwg.abt_id
	INNER JOIN DBP_DATA.MONAT zeit
	ON zeit.kjmo = vis.kjmo AND zeit.akt_gj=-1
	/* Standard Filter VTC = Filiale (ohne NB) unbereinigt */
	INNER JOIN dbp_data.wup wup 
	ON wup.wup_id = vis.wup_id AND wup.mandant_id = vis.mandant_id AND wup.nb_id=0
	AND wup.dat_eroeffnung<'2090-12-31' /* fix */
	AND (EXTRACT(YEAR FROM wup.dat_bis)+CASE WHEN EXTRACT(MONTH FROM wup.dat_bis)<3 THEN -1 ELSE 0 END)>zeit.gj+1 /* dynamisch*/
	GROUP BY vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.gj, abt.abt_id
) vis
LEFT JOIN ( /* JZG PLAN - Abteilung KVJ */
	SELECT plan.mandant_id, plan.nb_id, plan.wup_id, plan.wrg_id, zeit.gj, abt.abt_id
	, SUM(plan.umsatz_netto_plan) AS ums_plan
	, SUM(plan.abschriften_netto_operativ_plan) AS abs_plan
	FROM dbp_msi_view_vis.mv_wup_plan_kjmo_owg plan
	JOIN DBP_MSI_VIEW_VIS.MV_OWG_INT owg
	ON owg.owg_id = plan.owg_id 
	JOIN DBP_MSI_VIEW_VIS.MV_HWG_INT hwg
	ON hwg.hwg_id = owg.hwg_id
	JOIN DBP_MSI_VIEW_VIS.MV_ABT_INT abt
	ON abt.abt_id = hwg.abt_id
	JOIN DBP_DATA.MONAT zeit
	ON zeit.kjmo = plan.kjmo AND zeit.akt_gj=-1
	GROUP BY plan.mandant_id, plan.nb_id, plan.wup_id, plan.wrg_id, zeit.gj, abt.abt_id
) pln
ON pln.mandant_id = vis.mandant_id AND pln.wup_id = vis.wup_id
AND pln.wrg_id = vis.wrg_id AND pln.gj = vis.gj AND pln.abt_id = vis.abt_id 
LEFT JOIN ( /* JZG PLAN - Abteilung GJ */
	SELECT plan.mandant_id, plan.nb_id, plan.wup_id, plan.wrg_id, zeit.gj, abt.abt_id
	, SUM(plan.umsatz_netto_plan) AS ums_plan
	, SUM(plan.abschriften_netto_operativ_plan) AS abs_plan
	FROM dbp_msi_view_vis.mv_wup_plan_kjmo_owg plan
	JOIN DBP_MSI_VIEW_VIS.MV_OWG_INT owg
	ON owg.owg_id = plan.owg_id 
	JOIN DBP_MSI_VIEW_VIS.MV_HWG_INT hwg
	ON hwg.hwg_id = owg.hwg_id
	JOIN DBP_MSI_VIEW_VIS.MV_ABT_INT abt
	ON abt.abt_id = hwg.abt_id
	JOIN DBP_DATA.MONAT zeit
	ON zeit.kjmo = plan.kjmo AND zeit.akt_gj=0
	GROUP BY plan.mandant_id, plan.nb_id, plan.wup_id, plan.wrg_id, zeit.gj, abt.abt_id
) plngj
ON plngj.mandant_id = vis.mandant_id AND plngj.wup_id = vis.wup_id
AND plngj.wrg_id = vis.wrg_id AND plngj.gj = (vis.gj+1) AND plngj.abt_id = vis.abt_id 
 
/* JZG 10.2.5xx0000 + 6xx0000 Umsatz HWG Ultra-Frische + Food Frische*/ 
UNION ALL SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, (vis.gj+1) AS GJ 
, 10::INTEGER AS METRIK_ID, 2::INTEGER AS TYP_ID, (vis.abt_id * 1000000 + ABS(vis.hwg_id) * 10000)::INTEGER AS LEVEL_ID
, vis.ums_wert AS WERT_VJ1, NULL AS WERT_VJ2
, pln.ums_plan AS PLAN_VJ1, NULL AS PLAN_VJ2
, plngj.ums_plan AS PLAN_GJ1, NULL AS PLAN_GJ2
, WERT_VJ1 AS WERT_VJ 
, PLAN_VJ1 AS PLAN_VJ
, PLAN_GJ1 AS PLAN_GJ
, WERT_VJ-PLAN_VJ AS DELTA /* WRG */
, DELTA/NULLIFZERO(PLAN_VJ) AS ABW /* prozent */
FROM ( /* JZG WARE - Umsatz HWG KVJ */
	SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.gj, abt.abt_id, hwg.hwg_id
	, SUM(vis.ums_netto) AS ums_wert
	FROM DBP_MSI_DATA.VIS_MONAT_UMSATZ_WG vis 
	JOIN DBP_MSI_VIEW_VIS.MV_WG_INT wg 
	ON wg.wg_id = vis.wg_id
	JOIN DBP_MSI_VIEW_VIS.MV_OWG_INT owg
	ON owg.owg_id = wg.owg_id
	JOIN DBP_MSI_VIEW_VIS.MV_HWG_INT hwg
	ON hwg.hwg_id = owg.hwg_id
	JOIN DBP_MSI_VIEW_VIS.MV_ABT_INT abt
	ON abt.abt_id = hwg.abt_id
	JOIN DBP_DATA.MONAT zeit
	ON zeit.kjmo = vis.kjmo AND zeit.akt_gj=-1
	/* Standard Filter VTC = Filiale (ohne NB) unbereinigt */
	INNER JOIN dbp_data.wup wup 
	ON wup.wup_id = vis.wup_id AND wup.mandant_id = vis.mandant_id AND wup.nb_id=0
	AND wup.dat_eroeffnung<'2090-12-31' /* fix */
	AND (EXTRACT(YEAR FROM wup.dat_bis)+CASE WHEN EXTRACT(MONTH FROM wup.dat_bis)<3 THEN -1 ELSE 0 END)>zeit.gj+1 /* dynamisch*/
	WHERE abt.abt_id IN (5,6) /* Ultra-Frische + Food Frische */
	GROUP BY vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.gj, abt.abt_id, hwg.hwg_id
) vis
LEFT JOIN ( /* JZG PLAN - HWG KVJ */
	SELECT plan.mandant_id, plan.nb_id, plan.wup_id, plan.wrg_id, zeit.gj, abt.abt_id, hwg.hwg_id
	, SUM(plan.umsatz_netto_plan) AS ums_plan
	, SUM(plan.abschriften_netto_operativ_plan) AS abs_plan
	FROM dbp_msi_view_vis.mv_wup_plan_kjmo_owg plan
	JOIN DBP_MSI_VIEW_VIS.MV_OWG_INT owg
	ON owg.owg_id = plan.owg_id 
	JOIN DBP_MSI_VIEW_VIS.MV_HWG_INT hwg
	ON hwg.hwg_id = owg.hwg_id
	JOIN DBP_MSI_VIEW_VIS.MV_ABT_INT abt
	ON abt.abt_id = hwg.abt_id
	JOIN DBP_DATA.MONAT zeit
	ON zeit.kjmo = plan.kjmo AND zeit.akt_gj=-1
	WHERE abt.abt_id IN (5,6) /* Ultra-Frische + Food Frische */
	GROUP BY plan.mandant_id, plan.nb_id, plan.wup_id, plan.wrg_id, zeit.gj, abt.abt_id, hwg.hwg_id
) pln
ON pln.mandant_id = vis.mandant_id AND pln.wup_id = vis.wup_id
AND pln.wrg_id = vis.wrg_id AND pln.gj = vis.gj AND pln.hwg_id = vis.hwg_id 
LEFT JOIN ( /* JZG PLAN - HWG GJ */
	SELECT plan.mandant_id, plan.nb_id, plan.wup_id, plan.wrg_id, zeit.gj, abt.abt_id, hwg.hwg_id
	, SUM(plan.umsatz_netto_plan) AS ums_plan
	, SUM(plan.abschriften_netto_operativ_plan) AS abs_plan
	FROM dbp_msi_view_vis.mv_wup_plan_kjmo_owg plan
	JOIN DBP_MSI_VIEW_VIS.MV_OWG_INT owg
	ON owg.owg_id = plan.owg_id 
	JOIN DBP_MSI_VIEW_VIS.MV_HWG_INT hwg
	ON hwg.hwg_id = owg.hwg_id
	JOIN DBP_MSI_VIEW_VIS.MV_ABT_INT abt
	ON abt.abt_id = hwg.abt_id
	JOIN DBP_DATA.MONAT zeit
	ON zeit.kjmo = plan.kjmo AND zeit.akt_gj=0
	WHERE abt.abt_id IN (5,6) /* Ultra-Frische + Food Frische */
	GROUP BY plan.mandant_id, plan.nb_id, plan.wup_id, plan.wrg_id, zeit.gj, abt.abt_id, hwg.hwg_id
) plngj
ON plngj.mandant_id = vis.mandant_id AND plngj.wup_id = vis.wup_id
AND plngj.wrg_id = vis.wrg_id AND plngj.gj = (vis.gj+1) AND plngj.hwg_id = vis.hwg_id 
 
/* JZG 10.3.5xxxxxx Umsatz OWG Ultra-Frische */ 
UNION ALL SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, (vis.gj+1) AS GJ
, 10::INTEGER AS METRIK_ID, 3::INTEGER AS TYP_ID, (vis.abt_id * 1000000 + ABS(vis.hwg_id) * 10000 + ABS(vis.owg_id))::INTEGER AS LEVEL_ID
, vis.ums_wert AS WERT_VJ1, NULL AS WERT_VJ2
, pln.ums_plan AS PLAN_VJ1, NULL AS PLAN_VJ2
, plngj.ums_plan AS PLAN_GJ1, NULL AS PLAN_GJ2
, WERT_VJ1 AS WERT_VJ 
, PLAN_VJ1 AS PLAN_VJ
, PLAN_GJ1 AS PLAN_GJ
, WERT_VJ-PLAN_VJ AS DELTA /* WRG */
, DELTA/NULLIFZERO(PLAN_VJ) AS ABW /* prozent */
FROM ( /* JZG WARE - Umsatz OWG */
	SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.gj, abt.abt_id, hwg.hwg_id, owg.owg_id
	, SUM(vis.ums_netto) AS ums_wert
	FROM DBP_MSI_DATA.VIS_MONAT_UMSATZ_WG vis 
	JOIN DBP_MSI_VIEW_VIS.MV_WG_INT wg 
	ON wg.wg_id = vis.wg_id
	JOIN DBP_MSI_VIEW_VIS.MV_OWG_INT owg
	ON owg.owg_id = wg.owg_id
	JOIN DBP_MSI_VIEW_VIS.MV_HWG_INT hwg
	ON hwg.hwg_id = owg.hwg_id
	JOIN DBP_MSI_VIEW_VIS.MV_ABT_INT abt
	ON abt.abt_id = hwg.abt_id
	JOIN DBP_DATA.MONAT zeit
	ON vis.kjmo = zeit.kjmo AND zeit.akt_gj=-1
	/* Standard Filter VTC = Filiale (ohne NB) unbereinigt */
	INNER JOIN dbp_data.wup wup 
	ON wup.wup_id = vis.wup_id AND wup.mandant_id = vis.mandant_id AND wup.nb_id=0
	AND wup.dat_eroeffnung<'2090-12-31' /* fix */
	AND (EXTRACT(YEAR FROM wup.dat_bis)+CASE WHEN EXTRACT(MONTH FROM wup.dat_bis)<3 THEN -1 ELSE 0 END)>zeit.gj+1 /* dynamisch*/
	WHERE abt.abt_id = 5 /* Ultra-Frische */
	GROUP BY vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.gj, abt.abt_id, hwg.hwg_id, owg.owg_id
) vis
LEFT JOIN ( /* JZG PLAN - OWG KVJ */
	SELECT plan.mandant_id, plan.nb_id, plan.wup_id, plan.wrg_id, zeit.gj, abt.abt_id, hwg.hwg_id, owg.owg_id
	, SUM(plan.umsatz_netto_plan) AS ums_plan
	, SUM(plan.abschriften_netto_operativ_plan) AS abs_plan
	FROM dbp_msi_view_vis.mv_wup_plan_kjmo_owg plan
	JOIN DBP_MSI_VIEW_VIS.MV_OWG_INT owg
	ON owg.owg_id = plan.owg_id 
	JOIN DBP_MSI_VIEW_VIS.MV_HWG_INT hwg
	ON hwg.hwg_id = owg.hwg_id
	JOIN DBP_MSI_VIEW_VIS.MV_ABT_INT abt
	ON abt.abt_id = hwg.abt_id 
	JOIN DBP_DATA.MONAT zeit
	ON zeit.kjmo = plan.kjmo AND zeit.akt_gj=-1
	WHERE abt.abt_id IN (5) /* Ultra-Frische */
	GROUP BY plan.mandant_id, plan.nb_id, plan.wup_id, zeit.gj, plan.wrg_id, abt.abt_id, hwg.hwg_id, owg.owg_id
) pln
ON pln.mandant_id = vis.mandant_id AND pln.wup_id = vis.wup_id
AND pln.wrg_id = vis.wrg_id AND pln.gj = vis.gj AND pln.owg_id = vis.owg_id 
LEFT JOIN ( /* JZG PLAN - OWG KVJ */
	SELECT plan.mandant_id, plan.nb_id, plan.wup_id, plan.wrg_id, zeit.gj, abt.abt_id, hwg.hwg_id, owg.owg_id
	, SUM(plan.umsatz_netto_plan) AS ums_plan
	, SUM(plan.abschriften_netto_operativ_plan) AS abs_plan
	FROM dbp_msi_view_vis.mv_wup_plan_kjmo_owg plan
	JOIN DBP_MSI_VIEW_VIS.MV_OWG_INT owg
	ON owg.owg_id = plan.owg_id 
	JOIN DBP_MSI_VIEW_VIS.MV_HWG_INT hwg
	ON hwg.hwg_id = owg.hwg_id
	JOIN DBP_MSI_VIEW_VIS.MV_ABT_INT abt
	ON abt.abt_id = hwg.abt_id 
	JOIN DBP_DATA.MONAT zeit
	ON zeit.kjmo = plan.kjmo AND zeit.akt_gj=0
	WHERE abt.abt_id IN (5) /* Ultra-Frische */
	GROUP BY plan.mandant_id, plan.nb_id, plan.wup_id, zeit.gj, plan.wrg_id, abt.abt_id, hwg.hwg_id, owg.owg_id
) plngj
ON plngj.mandant_id = vis.mandant_id AND plngj.wup_id = vis.wup_id
AND plngj.wrg_id = vis.wrg_id AND plngj.gj = (vis.gj+1) AND plngj.owg_id = vis.owg_id 
 
/* JZG 16.0.0 Kunden Filiale */ 
UNION ALL SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, (vis.gj+1) AS GJ 
, 16::INTEGER AS METRIK_ID, 0::INTEGER AS TYP_ID, 0::INTEGER AS LEVEL_ID
, vis.anz_kunde AS WERT_VJ1, NULL AS WERT_VJ2
, NULL AS PLAN_VJ1, NULL AS PLAN_VJ2
, NULL AS PLAN_GJ1, NULL AS PLAN_GJ2
, WERT_VJ1 AS WERT_VJ 
, NULL AS PLAN_VJ
, NULL AS PLAN_GJ
, NULL AS DELTA
, NULL AS ABW
FROM ( /* JZG MAIN - KVJ */
	SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.gj
	, SUM(vis.ums_netto) AS ums_wert
	, SUM(vis.ums_netto_plan) AS ums_plan
	, SUM(vis.anz_kunde) AS anz_kunde
	, SUM(vis.pers_std) AS std_wert
	, SUM(vis.pers_std_plan) AS std_plan
	FROM DBP_MSI_DATA.VIS_MONAT_UMS_KUNDE_PERS_WUP vis
	INNER JOIN DBP_DATA.MONAT zeit
	ON zeit.kjmo = vis.kjmo AND zeit.akt_gj = -1
	/* Standard Filter VTC = Filiale (ohne NB) unbereinigt */
	INNER JOIN dbp_data.wup wup 
	ON wup.wup_id = vis.wup_id AND wup.mandant_id = vis.mandant_id AND wup.nb_id=0
	AND wup.dat_eroeffnung<'2090-12-31' /* fix */
	AND (EXTRACT(YEAR FROM wup.dat_bis)+CASE WHEN EXTRACT(MONTH FROM wup.dat_bis)<3 THEN -1 ELSE 0 END)>zeit.gj+1 /* dynamisch*/
	GROUP BY vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.gj
) vis
 
/* JZG18.0.0 Ø-Bon Filiale */ 
UNION ALL SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, (vis.gj+1) AS GJ 
, 18::INTEGER AS METRIK_ID, 0::INTEGER AS TYP_ID, 0::INTEGER AS LEVEL_ID
, vis.ums_wert AS WERT_VJ1, vis.anz_kunde AS WERT_VJ2
, NULL AS PLAN_VJ1, NULL AS PLAN_VJ2
, NULL AS PLAN_GJ1, NULL AS PLAN_GJ2
, vis.ums_wert/NULLIFZERO(vis.anz_kunde) AS WERT_VJ 
, NULL AS PLAN_VJ
, NULL AS PLAN_GJ
, NULL AS DELTA
, NULL AS ABW
FROM ( /* JZG MAIN - KVJ */
	SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.gj
	, SUM(vis.ums_netto) AS ums_wert
	, SUM(vis.ums_netto_plan) AS ums_plan
	, SUM(vis.anz_kunde) AS anz_kunde
	, SUM(vis.pers_std) AS std_wert
	, SUM(vis.pers_std_plan) AS std_plan
	FROM DBP_MSI_DATA.VIS_MONAT_UMS_KUNDE_PERS_WUP vis
	INNER JOIN DBP_DATA.MONAT zeit
	ON zeit.kjmo = vis.kjmo AND zeit.akt_gj = -1
	/* Standard Filter VTC = Filiale (ohne NB) unbereinigt */
	INNER JOIN dbp_data.wup wup 
	ON wup.wup_id = vis.wup_id AND wup.mandant_id = vis.mandant_id AND wup.nb_id=0
	AND wup.dat_eroeffnung<'2090-12-31' /* fix */
	AND (EXTRACT(YEAR FROM wup.dat_bis)+CASE WHEN EXTRACT(MONTH FROM wup.dat_bis)<3 THEN -1 ELSE 0 END)>zeit.gj+1 /* dynamisch*/
	GROUP BY vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.gj
) vis 
 
/* JZG 20.0.0 Nettoleistung Filiale */ 
UNION ALL SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, (vis.gj+1) AS GJ 
, 20::INTEGER AS METRIK_ID, 0::INTEGER AS TYP_ID, 0::INTEGER AS LEVEL_ID
, vis.ums_wert AS WERT_VJ1, vis.std_wert AS WERT_VJ2
, vis.ums_plan AS PLAN_VJ1, vis.std_plan AS PLAN_VJ2
, plngj.ums_plan AS PLAN_GJ1, plngj.std_plan AS PLAN_GJ2
, WERT_VJ1/NULLIFZERO(WERT_VJ2) AS WERT_VJ 
, PLAN_VJ1/NULLIFZERO(PLAN_VJ2) AS PLAN_VJ
, PLAN_GJ1/NULLIFZERO(PLAN_GJ2) AS PLAN_GJ
, WERT_VJ-PLAN_VJ AS DELTA /* WRG/h */
, DELTA/NULLIFZERO(PLAN_VJ) AS ABW /* prozent */
FROM ( /* JZG MAIN - KVJ */
	SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.gj
	, SUM(vis.ums_netto) AS ums_wert
	, SUM(vis.ums_netto_plan) AS ums_plan
	, SUM(vis.anz_kunde) AS anz_kunde
	, SUM(vis.pers_std) AS std_wert
	, SUM(vis.pers_std_plan) AS std_plan
	FROM DBP_MSI_DATA.VIS_MONAT_UMS_KUNDE_PERS_WUP vis
	INNER JOIN DBP_DATA.MONAT zeit
	ON zeit.kjmo = vis.kjmo AND zeit.akt_gj = -1
	/* Standard Filter VTC = Filiale (ohne NB) unbereinigt */
	INNER JOIN dbp_data.wup wup 
	ON wup.wup_id = vis.wup_id AND wup.mandant_id = vis.mandant_id AND wup.nb_id=0
	AND wup.dat_eroeffnung<'2090-12-31' /* fix */
	AND (EXTRACT(YEAR FROM wup.dat_bis)+CASE WHEN EXTRACT(MONTH FROM wup.dat_bis)<3 THEN -1 ELSE 0 END)>zeit.gj+1 /* dynamisch*/
	GROUP BY vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.gj
) vis 
INNER JOIN ( /* JZG MAIN - GJ */
	SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.gj
	, SUM(vis.ums_netto_plan) AS ums_plan
	, SUM(vis.pers_std_plan)  AS std_plan
	FROM DBP_MSI_DATA.VIS_MONAT_UMS_KUNDE_PERS_WUP   vis
	JOIN DBP_DATA.MONAT zeit
	ON zeit.kjmo = vis.kjmo AND zeit.akt_gj=0
	/* Standard Filter VTC = Filiale (ohne NB) unbereinigt */
	INNER JOIN dbp_data.wup wup 
	ON wup.wup_id = vis.wup_id AND wup.mandant_id = vis.mandant_id AND wup.nb_id=0
	AND wup.dat_eroeffnung<'2090-12-31' /* fix */
	AND (EXTRACT(YEAR FROM wup.dat_bis)+CASE WHEN EXTRACT(MONTH FROM wup.dat_bis)<3 THEN -1 ELSE 0 END)>zeit.gj+1 /* dynamisch*/
	GROUP BY vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.gj
) plngj
ON plngj.mandant_id = vis.mandant_id AND plngj.wup_id = vis.wup_id
AND plngj.wrg_id = vis.wrg_id AND plngj.gj = (vis.gj+1) 
/* JZG 23.0.0 - Nettostunden Filiale */ 
UNION ALL SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, (vis.gj+1) AS GJ 
, 24::INTEGER AS METRIK_ID, 0::INTEGER AS TYP_ID, 0::INTEGER AS LEVEL_ID
, vis.std_wert AS WERT_VJ1, NULL AS WERT_VJ2
, vis.std_plan AS PLAN_VJ1, NULL AS PLAN_VJ2
, plngj.std_plan AS PLAN_GJ1, NULL AS PLAN_GJ2
, WERT_VJ1 AS WERT_VJ 
, PLAN_VJ1 AS PLAN_VJ
, PLAN_GJ1 AS PLAN_GJ
, WERT_VJ-PLAN_VJ AS DELTA /* h */
, DELTA/NULLIFZERO(PLAN_VJ) AS ABW /* prozent */
FROM ( /* JZG MAIN - KVJ */
	SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.gj
	, SUM(vis.ums_netto) AS ums_wert
	, SUM(vis.ums_netto_plan) AS ums_plan
	, SUM(vis.anz_kunde) AS anz_kunde
	, SUM(vis.pers_std) AS std_wert
	, SUM(vis.pers_std_plan) AS std_plan
	FROM DBP_MSI_DATA.VIS_MONAT_UMS_KUNDE_PERS_WUP vis
	INNER JOIN DBP_DATA.MONAT zeit
	ON zeit.kjmo = vis.kjmo AND zeit.akt_gj = -1
	/* Standard Filter VTC = Filiale (ohne NB) unbereinigt */
	INNER JOIN dbp_data.wup wup 
	ON wup.wup_id = vis.wup_id AND wup.mandant_id = vis.mandant_id AND wup.nb_id=0
	AND wup.dat_eroeffnung<'2090-12-31' /* fix */
	AND (EXTRACT(YEAR FROM wup.dat_bis)+CASE WHEN EXTRACT(MONTH FROM wup.dat_bis)<3 THEN -1 ELSE 0 END)>zeit.gj+1 /* dynamisch*/
	GROUP BY vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.gj
) vis 
INNER JOIN ( /* JZG MAIN - GJ */
	SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.gj
	, SUM(vis.ums_netto_plan) AS ums_plan
	, SUM(vis.pers_std_plan)  AS std_plan
	FROM DBP_MSI_DATA.VIS_MONAT_UMS_KUNDE_PERS_WUP   vis
	JOIN DBP_DATA.MONAT zeit
	ON zeit.kjmo = vis.kjmo AND zeit.akt_gj=0
	/* Standard Filter VTC = Filiale (ohne NB) unbereinigt */
	INNER JOIN dbp_data.wup wup 
	ON wup.wup_id = vis.wup_id AND wup.mandant_id = vis.mandant_id AND wup.nb_id=0
	AND wup.dat_eroeffnung<'2090-12-31' /* fix */
	AND (EXTRACT(YEAR FROM wup.dat_bis)+CASE WHEN EXTRACT(MONTH FROM wup.dat_bis)<3 THEN -1 ELSE 0 END)>zeit.gj+1 /* dynamisch*/
	GROUP BY vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.gj
) plngj
ON plngj.mandant_id = vis.mandant_id AND plngj.wup_id = vis.wup_id
AND plngj.wrg_id = vis.wrg_id AND plngj.gj = (vis.gj+1) 
 
/* JZG 3x.0.0 Kassenkennzahlen Filiale */ 
UNION ALL SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, (vis.gj+1) AS GJ 
, jzg.METRIK_ID AS METRIK_ID, 0::INTEGER AS TYP_ID, 0::INTEGER AS LEVEL_ID
, CASE jzg.METRIK_ID
  WHEN 30 THEN vis.ums_chk
  WHEN 32 THEN vis.anz_artikel
  WHEN 34 THEN vis.ums_sco
  WHEN 36 THEN vis.kun_sco
  ELSE NULL 
 END WERT_VJ1
, CASE jzg.METRIK_ID
  WHEN 30 THEN vis.kassier_zeit
  WHEN 32 THEN vis.scan_zeit
  WHEN 34 THEN (vis.ums_sco+vis.ums_chk) 
  WHEN 36 THEN (vis.kun_sco+vis.kun_chk)
  ELSE NULL 
 END WERT_VJ2
, NULL AS PLAN_VJ1, NULL AS PLAN_VJ2
, NULL AS PLAN_GJ1, NULL AS PLAN_GJ2
, WERT_VJ1/ NULLIFZERO(WERT_VJ2) AS WERT_VJ 
, NULL AS PLAN_VJ 
, NULL AS PLAN_GJ 
, NULL AS DELTA
, NULL AS ABW
FROM ( /* JZG Kasse - VJ */
	SELECT vtk.mandant_id, vtk.nb_id, vtk.wup_id, vtk.wrg_id, zeit.gj
	, SUM(CASE WHEN ktp.kasse_typ_id = 1 THEN vtk.umsatz_netto ELSE 0 END) AS ums_chk /* Checkout */
	, SUM(CASE WHEN ktp.kasse_typ_id IN (8,9,10,11) THEN vtk.umsatz_netto ELSE 0 END) AS ums_sco /* SCO + Paystation */
	, SUM(CASE WHEN ktp.kasse_typ_id = 1 THEN vtk.anz_kunden ELSE 0 END) AS kun_chk /* Checkout */
	, SUM(CASE WHEN ktp.kasse_typ_id IN (8,9,10,11) THEN vtk.anz_kunden ELSE 0 END) AS kun_sco  /* SCO + Paystation */
	, SUM(CASE WHEN ktp.kasse_typ_id = 1 THEN vtk.kassierzeit/3600 ELSE 0 END) AS kassier_zeit /* Stunde */
	, SUM(CASE WHEN ktp.kasse_typ_id = 1 THEN vtk.anz_artikel ELSE 0 END) AS anz_artikel
	, SUM(CASE WHEN ktp.kasse_typ_id = 1 THEN vtk.registrierzeit/60 ELSE 0 END) AS scan_zeit /* Minute */
	FROM dbp_msi_view_vis.mv_vis_tag_kasse vtk
	JOIN DBP_MSI_VIEW_VIS.MV_KASSE_TYP_PER ktp
	ON ktp.mandant_id = vtk.mandant_id AND ktp.wup_id = vtk.wup_id 
	AND ktp.dat = vtk.dat AND ktp.kasse_nr = vtk.kasse_nr
	JOIN dbp_msi_view_vis.mv_tag zeit
	ON zeit.dat = vtk.dat AND zeit.akt_gj = -1
	GROUP BY vtk.mandant_id, vtk.nb_id, vtk.wup_id, vtk.wrg_id, zeit.gj
) vis
CROSS JOIN ( /* 3x Kasse Metriken */ 
	SELECT 30::INTEGER AS METRIK_ID /* Kassierleistung */
	UNION ALL SELECT 32::INTEGER AS METRIK_ID /* Scans/min */
	UNION ALL SELECT 34::INTEGER AS METRIK_ID /* SCO Nutzungsquote (Umsatz) */
	UNION ALL SELECT 36::INTEGER AS METRIK_ID /* SCO Nutzungsquote (Kunden) */
) jzg 
 
/* JZG 40.0.0 Abschriften Filiale */  
UNION ALL SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, (vis.gj+1) AS GJ 
, 40::INTEGER AS METRIK_ID, 0::INTEGER AS TYP_ID, 0::INTEGER AS LEVEL_ID
, visabs.abs_netto AS WERT_VJ1, vis.ums_netto AS WERT_VJ2 
, plnvj.abs_plan AS PLAN_VJ1, plnvj.ums_plan AS PLAN_VJ2 
, plngj.abs_plan AS PLAN_GJ1, plngj.ums_plan AS PLAN_GJ2
, WERT_VJ1/NULLIFZERO(WERT_VJ2) AS WERT_VJ 
, PLAN_VJ1/NULLIFZERO(PLAN_VJ2) AS PLAN_VJ
, PLAN_GJ1/NULLIFZERO(PLAN_GJ2) AS PLAN_GJ
, (WERT_VJ-PLAN_VJ)*100 AS DELTA /* prozentpkt */
, ((WERT_VJ-PLAN_VJ)*-1)/NULLIFZERO(PLAN_VJ) AS ABW /* prozent */
FROM ( /* JZG Filiale - Umsatz Ware */
	SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.gj
	, SUM(vis.ums_netto) AS ums_netto
	FROM DBP_MSI_DATA.VIS_MONAT_UMSATZ_WG vis
	JOIN DBP_MSI_VIEW_VIS.MV_WG_INT wg 
	ON wg.wg_id = vis.wg_id
	JOIN DBP_MSI_VIEW_VIS.MV_OWG_INT owg
	ON owg.owg_id = wg.owg_id
	JOIN DBP_MSI_VIEW_VIS.MV_HWG_INT hwg
	ON hwg.hwg_id = owg.hwg_id
	JOIN DBP_MSI_VIEW_VIS.MV_ABT_INT abt
	ON abt.abt_id = hwg.abt_id
	JOIN DBP_DATA.MONAT zeit
	ON zeit.kjmo = vis.kjmo AND zeit.akt_gj=-1
	WHERE abt.abt_id IN (4,5,6,7,8)
	GROUP BY vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.gj
) vis
LEFT JOIN ( /* JZG Filiale - Abschriften Ware */
	SELECT vis.mandant_id, vis.nb_id, vis.wup_id, zeit.gj, vis.wrg_id
	, SUM(CASE 
		WHEN vis.mandant_id IN (6) AND vis.abschriftart_id = 2 THEN 1 
		WHEN vis.mandant_id IN (3) AND vis.abschriftart_id = 11 THEN 1 
		WHEN vis.mandant_id IN (2,4,5,7,8) AND vis.abschriftart_id = 7 THEN 1 
		WHEN vis.mandant_id IN (2,5) AND vis.abschriftart_id = 10 THEN 1 
		WHEN vis.mandant_id NOT IN (1) AND vis.abschriftart_id = 20 THEN 1 
		ELSE -1 
	 END * vis.abschrift_netto) AS abs_netto
	FROM DBP_MSI_DATA.VIS_TAG_ABSCHRIFTEN_WG vis 
	JOIN DBP_MSI_VIEW_VIS.MV_WG_INT wg 
	ON wg.wg_id = vis.wg_id
	JOIN DBP_MSI_VIEW_VIS.MV_OWG_INT owg
	ON owg.owg_id = wg.owg_id
	JOIN DBP_MSI_VIEW_VIS.MV_HWG_INT hwg
	ON hwg.hwg_id = owg.hwg_id
	JOIN DBP_MSI_VIEW_VIS.MV_ABT_INT abt
	ON abt.abt_id = hwg.abt_id
	JOIN DBP_MSI_VIEW_VIS.MV_ABSCHRIFTART_INT_ZU aaz
	ON aaz.abschriftart_id = vis.abschriftart_id AND aaz.mandant_id = vis.mandant_id
	JOIN DBP_MSI_VIEW_VIS.MV_ABSCHRIFTART_INT_THEMA_ZU atz
	ON atz.abschriftart_int_id = aaz.abschriftart_int_id
	JOIN DBP_DATA.MONAT zeit
	ON vis.kjmo = zeit.kjmo AND zeit.akt_gj=-1 
	WHERE atz.abschriftart_thema_int_id IN (1,4) AND abt.abt_id IN (4,5,6,7,8)
	GROUP BY vis.mandant_id, vis.nb_id, vis.wup_id, zeit.gj, vis.wrg_id
) visabs
ON visabs.mandant_id = vis.mandant_id AND visabs.wup_id = vis.wup_id
AND visabs.wrg_id = vis.wrg_id AND visabs.gj = vis.gj 
LEFT JOIN ( /* JZG Filiale - Plan Ware VJ */
	SELECT plan.mandant_id, plan.nb_id, plan.wup_id, plan.wrg_id, zeit.gj
	, SUM(plan.umsatz_netto_plan) AS ums_plan
	, SUM(plan.abschriften_netto_operativ_plan) AS abs_plan
	FROM DBP_MSI_VIEW_VIS.MV_WUP_PLAN_KJMO_OWG plan
	JOIN DBP_MSI_VIEW_VIS.MV_OWG_INT owg
	ON owg.owg_id = plan.owg_id
	JOIN DBP_MSI_VIEW_VIS.MV_HWG_INT hwg
	ON hwg.hwg_id = owg.hwg_id
	JOIN DBP_MSI_VIEW_VIS.MV_ABT_INT abt
	ON abt.abt_id = hwg.abt_id
	JOIN DBP_DATA.MONAT zeit
	ON zeit.kjmo = plan.kjmo AND zeit.akt_gj=-1 
	WHERE abt.abt_id IN (4,5,6,7,8)
	GROUP BY plan.mandant_id, plan.nb_id, plan.wup_id, plan.wrg_id, zeit.gj
) plnvj
ON plnvj.mandant_id = vis.mandant_id AND plnvj.wup_id = vis.wup_id
AND plnvj.wrg_id = vis.wrg_id AND plnvj.gj = vis.gj 
LEFT JOIN ( /* JZG Filiale - Plan Ware VJ */
	SELECT plan.mandant_id, plan.nb_id, plan.wup_id, plan.wrg_id, zeit.gj
	, SUM(plan.umsatz_netto_plan) AS ums_plan
	, SUM(plan.abschriften_netto_operativ_plan) AS abs_plan
	FROM DBP_MSI_VIEW_VIS.MV_WUP_PLAN_KJMO_OWG plan
	JOIN DBP_MSI_VIEW_VIS.MV_OWG_INT owg
	ON owg.owg_id = plan.owg_id
	JOIN DBP_MSI_VIEW_VIS.MV_HWG_INT hwg
	ON hwg.hwg_id = owg.hwg_id
	JOIN DBP_MSI_VIEW_VIS.MV_ABT_INT abt
	ON abt.abt_id = hwg.abt_id
	JOIN DBP_DATA.MONAT zeit
	ON zeit.kjmo = plan.kjmo AND zeit.akt_gj = 0
	WHERE abt.abt_id IN (4,5,6,7,8)
	GROUP BY plan.mandant_id, plan.nb_id, plan.wup_id, plan.wrg_id, zeit.gj
) plngj
ON plngj.mandant_id = vis.mandant_id AND plngj.wup_id = vis.wup_id
AND plngj.wrg_id = vis.wrg_id AND plngj.gj = (vis.gj+1) 
/* JZG 40.1.x000000 Abschriften Abteilung */ 
UNION ALL SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, (vis.gj+1) AS GJ 
, 40::INTEGER AS METRIK_ID, 1::INTEGER AS TYP_ID, (CASE vis.abt_id WHEN 4 THEN 9999999 ELSE vis.abt_id*1000000 END)::INTEGER AS LEVEL_ID
, visabs.abs_netto AS WERT_VJ1, vis.ums_netto AS WERT_VJ2 
, plnvj.abs_plan AS PLAN_VJ1, plnvj.ums_plan AS PLAN_VJ2 
, plngj.abs_plan AS PLAN_GJ1, plngj.ums_plan AS PLAN_GJ2
, WERT_VJ1/NULLIFZERO(WERT_VJ2) AS WERT_VJ 
, PLAN_VJ1/NULLIFZERO(PLAN_VJ2) AS PLAN_VJ
, PLAN_GJ1/NULLIFZERO(PLAN_GJ2) AS PLAN_GJ
, (WERT_VJ-PLAN_VJ)*100 AS DELTA /* prozentpkt */
, ((WERT_VJ-PLAN_VJ)*-1)/NULLIFZERO(PLAN_VJ) AS ABW /* prozent */
FROM ( /* JZG Abteilung - Umsatz Ware */
	SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.gj, abt.abt_id
	, SUM(vis.ums_netto) AS ums_netto
	FROM DBP_MSI_DATA.VIS_MONAT_UMSATZ_WG vis
	JOIN DBP_MSI_VIEW_VIS.MV_WG_INT wg 
	ON wg.wg_id = vis.wg_id
	JOIN DBP_MSI_VIEW_VIS.MV_OWG_INT owg
	ON owg.owg_id = wg.owg_id
	JOIN DBP_MSI_VIEW_VIS.MV_HWG_INT hwg
	ON hwg.hwg_id = owg.hwg_id
	JOIN DBP_MSI_VIEW_VIS.MV_ABT_INT abt
	ON abt.abt_id = hwg.abt_id
	JOIN DBP_DATA.MONAT zeit
	ON zeit.kjmo = vis.kjmo AND zeit.akt_gj=-1
	WHERE abt.abt_id IN (4,5,6,7,8)
	GROUP BY vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.gj, abt.abt_id
) vis
LEFT JOIN ( /* JZG Abteilung - Abschriften Ware */
	SELECT vis.mandant_id, vis.nb_id, vis.wup_id, zeit.gj, vis.wrg_id, abt.abt_id
	, SUM(CASE 
		WHEN vis.mandant_id IN (6) AND vis.abschriftart_id = 2 THEN 1 
		WHEN vis.mandant_id IN (3) AND vis.abschriftart_id = 11 THEN 1 
		WHEN vis.mandant_id IN (2,4,5,7,8) AND vis.abschriftart_id = 7 THEN 1 
		WHEN vis.mandant_id IN (2,5) AND vis.abschriftart_id = 10 THEN 1 
		WHEN vis.mandant_id NOT IN (1) AND vis.abschriftart_id = 20 THEN 1 
		ELSE -1 
	 END * vis.abschrift_netto) AS abs_netto
	FROM DBP_MSI_DATA.VIS_TAG_ABSCHRIFTEN_WG vis 
	JOIN DBP_MSI_VIEW_VIS.MV_WG_INT wg 
	ON wg.wg_id = vis.wg_id
	JOIN DBP_MSI_VIEW_VIS.MV_OWG_INT owg
	ON owg.owg_id = wg.owg_id
	JOIN DBP_MSI_VIEW_VIS.MV_HWG_INT hwg
	ON hwg.hwg_id = owg.hwg_id
	JOIN DBP_MSI_VIEW_VIS.MV_ABT_INT abt
	ON abt.abt_id = hwg.abt_id
	JOIN DBP_MSI_VIEW_VIS.MV_ABSCHRIFTART_INT_ZU aaz
	ON aaz.abschriftart_id = vis.abschriftart_id AND aaz.mandant_id = vis.mandant_id
	JOIN DBP_MSI_VIEW_VIS.MV_ABSCHRIFTART_INT_THEMA_ZU atz
	ON atz.abschriftart_int_id = aaz.abschriftart_int_id
	JOIN DBP_DATA.MONAT zeit
	ON vis.kjmo = zeit.kjmo AND zeit.akt_gj=-1 
	WHERE atz.abschriftart_thema_int_id IN (1,4) AND abt.abt_id IN (4,5,6,7,8)
	GROUP BY vis.mandant_id, vis.nb_id, vis.wup_id, zeit.gj, vis.wrg_id, abt.abt_id
) visabs
ON visabs.mandant_id = vis.mandant_id AND visabs.wup_id = vis.wup_id
AND visabs.wrg_id = vis.wrg_id AND visabs.gj = vis.gj 
AND visabs.abt_id = vis.abt_id
LEFT JOIN ( /* JZG Abteilung - Plan Ware VJ */
	SELECT plan.mandant_id, plan.nb_id, plan.wup_id, plan.wrg_id, zeit.gj, abt.abt_id
	, SUM(plan.umsatz_netto_plan) AS ums_plan
	, SUM(plan.abschriften_netto_operativ_plan) AS abs_plan
	FROM DBP_MSI_VIEW_VIS.MV_WUP_PLAN_KJMO_OWG plan
	JOIN DBP_MSI_VIEW_VIS.MV_OWG_INT owg
	ON owg.owg_id = plan.owg_id
	JOIN DBP_MSI_VIEW_VIS.MV_HWG_INT hwg
	ON hwg.hwg_id = owg.hwg_id
	JOIN DBP_MSI_VIEW_VIS.MV_ABT_INT abt
	ON abt.abt_id = hwg.abt_id
	JOIN DBP_DATA.MONAT zeit
	ON zeit.kjmo = plan.kjmo AND zeit.akt_gj=-1 
	WHERE abt.abt_id IN (4,5,6,7,8)
	GROUP BY plan.mandant_id, plan.nb_id, plan.wup_id, plan.wrg_id, zeit.gj, abt.abt_id
) plnvj
ON plnvj.mandant_id = vis.mandant_id AND plnvj.wup_id = vis.wup_id
AND plnvj.wrg_id = vis.wrg_id AND plnvj.gj = vis.gj 
AND plnvj.abt_id = vis.abt_id
LEFT JOIN ( /* JZG Abteilung - Plan Ware VJ */
	SELECT plan.mandant_id, plan.nb_id, plan.wup_id, plan.wrg_id, zeit.gj, abt.abt_id
	, SUM(plan.umsatz_netto_plan) AS ums_plan
	, SUM(plan.abschriften_netto_operativ_plan) AS abs_plan
	FROM DBP_MSI_VIEW_VIS.MV_WUP_PLAN_KJMO_OWG plan
	JOIN DBP_MSI_VIEW_VIS.MV_OWG_INT owg
	ON owg.owg_id = plan.owg_id
	JOIN DBP_MSI_VIEW_VIS.MV_HWG_INT hwg
	ON hwg.hwg_id = owg.hwg_id
	JOIN DBP_MSI_VIEW_VIS.MV_ABT_INT abt
	ON abt.abt_id = hwg.abt_id
	JOIN DBP_DATA.MONAT zeit
	ON zeit.kjmo = plan.kjmo AND zeit.akt_gj=0 
	WHERE abt.abt_id IN (4,5,6,7,8)
	GROUP BY plan.mandant_id, plan.nb_id, plan.wup_id, plan.wrg_id, zeit.gj, abt.abt_id
) plngj
ON plngj.mandant_id = vis.mandant_id AND plngj.wup_id = vis.wup_id
AND plngj.wrg_id = vis.wrg_id AND plngj.gj = (vis.gj+1)
AND plngj.abt_id = vis.abt_id
/* JZG 40.2.5xx0000/6xx0000 - Abschriften HWG Ultra-Frische/Food Frische */ 
UNION ALL SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, (vis.gj+1) AS GJ 
, 40::INTEGER AS METRIK_ID, 2::INTEGER AS TYP_ID, (vis.abt_id*1000000 + ABS(vis.hwg_id)*10000)::INTEGER AS LEVEL_ID
, visabs.abs_netto AS WERT_VJ1, vis.ums_netto AS WERT_VJ2 
, plnvj.abs_plan AS PLAN_VJ1, plnvj.ums_plan AS PLAN_VJ2 
, plngj.abs_plan AS PLAN_GJ1, plngj.ums_plan AS PLAN_GJ2
, WERT_VJ1/NULLIFZERO(WERT_VJ2) AS WERT_VJ 
, PLAN_VJ1/NULLIFZERO(PLAN_VJ2) AS PLAN_VJ
, PLAN_GJ1/NULLIFZERO(PLAN_GJ2) AS PLAN_GJ
, (WERT_VJ-PLAN_VJ)*100 AS DELTA /* prozentpkt */
, ((WERT_VJ-PLAN_VJ)*-1)/NULLIFZERO(PLAN_VJ) AS ABW /* prozent */
FROM ( /* JZG HWG - Umsatz Ware */
	SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.gj, abt.abt_id, hwg.hwg_id
	, SUM(vis.ums_netto) AS ums_netto
	FROM DBP_MSI_DATA.VIS_MONAT_UMSATZ_WG vis
	JOIN DBP_MSI_VIEW_VIS.MV_WG_INT wg 
	ON wg.wg_id = vis.wg_id
	JOIN DBP_MSI_VIEW_VIS.MV_OWG_INT owg
	ON owg.owg_id = wg.owg_id
	JOIN DBP_MSI_VIEW_VIS.MV_HWG_INT hwg
	ON hwg.hwg_id = owg.hwg_id
	JOIN DBP_MSI_VIEW_VIS.MV_ABT_INT abt
	ON abt.abt_id = hwg.abt_id
	JOIN DBP_DATA.MONAT zeit
	ON zeit.kjmo = vis.kjmo AND zeit.akt_gj=-1
	WHERE abt.abt_id IN (5,6)
	GROUP BY vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.gj, abt.abt_id, hwg.hwg_id
) vis
LEFT JOIN ( /* JZG HWG - Abschriften Ware */
	SELECT vis.mandant_id, vis.nb_id, vis.wup_id, zeit.gj, vis.wrg_id, abt.abt_id, hwg.hwg_id
	, SUM(CASE 
		WHEN vis.mandant_id IN (6) AND vis.abschriftart_id = 2 THEN 1 
		WHEN vis.mandant_id IN (3) AND vis.abschriftart_id = 11 THEN 1 
		WHEN vis.mandant_id IN (2,4,5,7,8) AND vis.abschriftart_id = 7 THEN 1 
		WHEN vis.mandant_id IN (2,5) AND vis.abschriftart_id = 10 THEN 1 
		WHEN vis.mandant_id NOT IN (1) AND vis.abschriftart_id = 20 THEN 1 
		ELSE -1 
	 END * vis.abschrift_netto) AS abs_netto
	FROM DBP_MSI_DATA.VIS_TAG_ABSCHRIFTEN_WG vis 
	JOIN DBP_MSI_VIEW_VIS.MV_WG_INT wg 
	ON wg.wg_id = vis.wg_id
	JOIN DBP_MSI_VIEW_VIS.MV_OWG_INT owg
	ON owg.owg_id = wg.owg_id
	JOIN DBP_MSI_VIEW_VIS.MV_HWG_INT hwg
	ON hwg.hwg_id = owg.hwg_id
	JOIN DBP_MSI_VIEW_VIS.MV_ABT_INT abt
	ON abt.abt_id = hwg.abt_id
	JOIN DBP_MSI_VIEW_VIS.MV_ABSCHRIFTART_INT_ZU aaz
	ON aaz.abschriftart_id = vis.abschriftart_id AND aaz.mandant_id = vis.mandant_id
	JOIN DBP_MSI_VIEW_VIS.MV_ABSCHRIFTART_INT_THEMA_ZU atz
	ON atz.abschriftart_int_id = aaz.abschriftart_int_id
	JOIN DBP_DATA.MONAT zeit
	ON vis.kjmo = zeit.kjmo AND zeit.akt_gj=-1 
	WHERE atz.abschriftart_thema_int_id IN (1,4) AND abt.abt_id IN (5,6)
	GROUP BY vis.mandant_id, vis.nb_id, vis.wup_id, zeit.gj, vis.wrg_id, abt.abt_id, hwg.hwg_id
) visabs
ON visabs.mandant_id = vis.mandant_id AND visabs.wup_id = vis.wup_id
AND visabs.wrg_id = vis.wrg_id AND visabs.gj = vis.gj 
AND visabs.hwg_id = vis.hwg_id
LEFT JOIN ( /* JZG HWG - Plan Ware VJ */
	SELECT plan.mandant_id, plan.nb_id, plan.wup_id, plan.wrg_id, zeit.gj, abt.abt_id, hwg.hwg_id
	, SUM(plan.umsatz_netto_plan) AS ums_plan
	, SUM(plan.abschriften_netto_operativ_plan) AS abs_plan
	FROM DBP_MSI_VIEW_VIS.MV_WUP_PLAN_KJMO_OWG plan
	JOIN DBP_MSI_VIEW_VIS.MV_OWG_INT owg
	ON owg.owg_id = plan.owg_id
	JOIN DBP_MSI_VIEW_VIS.MV_HWG_INT hwg
	ON hwg.hwg_id = owg.hwg_id
	JOIN DBP_MSI_VIEW_VIS.MV_ABT_INT abt
	ON abt.abt_id = hwg.abt_id
	JOIN DBP_DATA.MONAT zeit
	ON zeit.kjmo = plan.kjmo AND zeit.akt_gj = -1 
	WHERE abt.abt_id IN (5,6)
	GROUP BY plan.mandant_id, plan.nb_id, plan.wup_id, plan.wrg_id, zeit.gj, abt.abt_id, hwg.hwg_id
) plnvj
ON plnvj.mandant_id = vis.mandant_id AND plnvj.wup_id = vis.wup_id
AND plnvj.wrg_id = vis.wrg_id AND plnvj.gj = vis.gj 
AND plnvj.hwg_id = vis.hwg_id
LEFT JOIN ( /* JZG HWG - Plan Ware VJ */
	SELECT plan.mandant_id, plan.nb_id, plan.wup_id, plan.wrg_id, zeit.gj, abt.abt_id, hwg.hwg_id
	, SUM(plan.umsatz_netto_plan) AS ums_plan
	, SUM(plan.abschriften_netto_operativ_plan) AS abs_plan
	FROM DBP_MSI_VIEW_VIS.MV_WUP_PLAN_KJMO_OWG plan
	JOIN DBP_MSI_VIEW_VIS.MV_OWG_INT owg
	ON owg.owg_id = plan.owg_id
	JOIN DBP_MSI_VIEW_VIS.MV_HWG_INT hwg
	ON hwg.hwg_id = owg.hwg_id
	JOIN DBP_MSI_VIEW_VIS.MV_ABT_INT abt
	ON abt.abt_id = hwg.abt_id
	JOIN DBP_DATA.MONAT zeit
	ON zeit.kjmo = plan.kjmo AND zeit.akt_gj=0 
	WHERE abt.abt_id IN (5,6)
	GROUP BY plan.mandant_id, plan.nb_id, plan.wup_id, plan.wrg_id, zeit.gj, abt.abt_id, hwg.hwg_id
) plngj
ON plngj.mandant_id = vis.mandant_id AND plngj.wup_id = vis.wup_id
AND plngj.wrg_id = vis.wrg_id AND plngj.gj = (vis.gj+1)
AND plngj.hwg_id = vis.hwg_id
/* JZG 40.3.5xxxxxx - Abschriften OWG Ultra-Frische */ 
UNION ALL SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, (vis.gj+1) AS GJ 
, 40::INTEGER AS METRIK_ID, 3::INTEGER AS TYP_ID, (vis.abt_id*1000000 + ABS(vis.hwg_id)*10000 + ABS(vis.owg_id))::INTEGER AS LEVEL_ID
, visabs.abs_netto AS WERT_VJ1, vis.ums_netto AS WERT_VJ2 
, plnvj.abs_plan AS PLAN_VJ1, plnvj.ums_plan AS PLAN_VJ2 
, plngj.abs_plan AS PLAN_GJ1, plngj.ums_plan AS PLAN_GJ2
, WERT_VJ1/NULLIFZERO(WERT_VJ2) AS WERT_VJ 
, PLAN_VJ1/NULLIFZERO(PLAN_VJ2) AS PLAN_VJ
, PLAN_GJ1/NULLIFZERO(PLAN_GJ2) AS PLAN_GJ
, (WERT_VJ-PLAN_VJ)*100 AS DELTA /* prozentpkt */
, ((WERT_VJ-PLAN_VJ)*-1)/NULLIFZERO(PLAN_VJ) AS ABW /* prozent */
FROM ( /* JZG OWG - Umsatz Ware */
	SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.gj, abt.abt_id, hwg.hwg_id, owg.owg_id
	, SUM(vis.ums_netto) AS ums_netto
	FROM DBP_MSI_DATA.VIS_MONAT_UMSATZ_WG vis
	JOIN DBP_MSI_VIEW_VIS.MV_WG_INT wg 
	ON wg.wg_id = vis.wg_id
	JOIN DBP_MSI_VIEW_VIS.MV_OWG_INT owg
	ON owg.owg_id = wg.owg_id
	JOIN DBP_MSI_VIEW_VIS.MV_HWG_INT hwg
	ON hwg.hwg_id = owg.hwg_id
	JOIN DBP_MSI_VIEW_VIS.MV_ABT_INT abt
	ON abt.abt_id = hwg.abt_id
	JOIN DBP_DATA.MONAT zeit
	ON zeit.kjmo = vis.kjmo AND zeit.akt_gj=-1
	WHERE abt.abt_id IN (5)
	GROUP BY vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.gj, abt.abt_id, hwg.hwg_id, owg.owg_id
) vis
LEFT JOIN ( /* JZG OWG - Abschriften Ware */
	SELECT vis.mandant_id, vis.nb_id, vis.wup_id, zeit.gj, vis.wrg_id, abt.abt_id, hwg.hwg_id, owg.owg_id
	, SUM(CASE 
		WHEN vis.mandant_id IN (6) AND vis.abschriftart_id = 2 THEN 1 
		WHEN vis.mandant_id IN (3) AND vis.abschriftart_id = 11 THEN 1 
		WHEN vis.mandant_id IN (2,4,5,7,8) AND vis.abschriftart_id = 7 THEN 1 
		WHEN vis.mandant_id IN (2,5) AND vis.abschriftart_id = 10 THEN 1 
		WHEN vis.mandant_id NOT IN (1) AND vis.abschriftart_id = 20 THEN 1 
		ELSE -1 
	 END * vis.abschrift_netto) AS abs_netto
	FROM DBP_MSI_DATA.VIS_TAG_ABSCHRIFTEN_WG vis 
	JOIN DBP_MSI_VIEW_VIS.MV_WG_INT wg 
	ON wg.wg_id = vis.wg_id
	JOIN DBP_MSI_VIEW_VIS.MV_OWG_INT owg
	ON owg.owg_id = wg.owg_id
	JOIN DBP_MSI_VIEW_VIS.MV_HWG_INT hwg
	ON hwg.hwg_id = owg.hwg_id
	JOIN DBP_MSI_VIEW_VIS.MV_ABT_INT abt
	ON abt.abt_id = hwg.abt_id
	JOIN DBP_MSI_VIEW_VIS.MV_ABSCHRIFTART_INT_ZU aaz
	ON aaz.abschriftart_id = vis.abschriftart_id AND aaz.mandant_id = vis.mandant_id
	JOIN DBP_MSI_VIEW_VIS.MV_ABSCHRIFTART_INT_THEMA_ZU atz
	ON atz.abschriftart_int_id = aaz.abschriftart_int_id
	JOIN DBP_DATA.MONAT zeit
	ON vis.kjmo = zeit.kjmo AND zeit.akt_gj=-1 
	WHERE atz.abschriftart_thema_int_id IN (1,4) AND abt.abt_id IN (5)
	GROUP BY vis.mandant_id, vis.nb_id, vis.wup_id, zeit.gj, vis.wrg_id, abt.abt_id, hwg.hwg_id, owg.owg_id
) visabs
ON visabs.mandant_id = vis.mandant_id AND visabs.wup_id = vis.wup_id
AND visabs.wrg_id = vis.wrg_id AND visabs.gj = vis.gj 
AND visabs.owg_id = vis.owg_id
LEFT JOIN ( /* JZG OWG - Plan Ware VJ */
	SELECT plan.mandant_id, plan.nb_id, plan.wup_id, plan.wrg_id, zeit.gj, abt.abt_id, hwg.hwg_id, owg.owg_id
	, SUM(plan.umsatz_netto_plan) AS ums_plan
	, SUM(plan.abschriften_netto_operativ_plan) AS abs_plan
	FROM DBP_MSI_VIEW_VIS.MV_WUP_PLAN_KJMO_OWG plan
	JOIN DBP_MSI_VIEW_VIS.MV_OWG_INT owg
	ON owg.owg_id = plan.owg_id
	JOIN DBP_MSI_VIEW_VIS.MV_HWG_INT hwg
	ON hwg.hwg_id = owg.hwg_id
	JOIN DBP_MSI_VIEW_VIS.MV_ABT_INT abt
	ON abt.abt_id = hwg.abt_id
	JOIN DBP_DATA.MONAT zeit
	ON zeit.kjmo = plan.kjmo AND zeit.akt_gj=-1 
	WHERE abt.abt_id IN (5)
	GROUP BY plan.mandant_id, plan.nb_id, plan.wup_id, plan.wrg_id, zeit.gj, abt.abt_id, hwg.hwg_id, owg.owg_id
) plnvj
ON plnvj.mandant_id = vis.mandant_id AND plnvj.wup_id = vis.wup_id
AND plnvj.wrg_id = vis.wrg_id AND plnvj.gj = vis.gj 
AND plnvj.owg_id = vis.owg_id
LEFT JOIN ( /* JZG OWG - Plan Ware VJ */
	SELECT plan.mandant_id, plan.nb_id, plan.wup_id, plan.wrg_id, zeit.gj, abt.abt_id, hwg.hwg_id, owg.owg_id
	, SUM(plan.umsatz_netto_plan) AS ums_plan
	, SUM(plan.abschriften_netto_operativ_plan) AS abs_plan
	FROM DBP_MSI_VIEW_VIS.MV_WUP_PLAN_KJMO_OWG plan
	JOIN DBP_MSI_VIEW_VIS.MV_OWG_INT owg
	ON owg.owg_id = plan.owg_id
	JOIN DBP_MSI_VIEW_VIS.MV_HWG_INT hwg
	ON hwg.hwg_id = owg.hwg_id
	JOIN DBP_MSI_VIEW_VIS.MV_ABT_INT abt
	ON abt.abt_id = hwg.abt_id
	JOIN DBP_DATA.MONAT zeit
	ON zeit.kjmo = plan.kjmo AND zeit.akt_gj=0 
	WHERE abt.abt_id IN (5)
	GROUP BY plan.mandant_id, plan.nb_id, plan.wup_id, plan.wrg_id, zeit.gj, abt.abt_id, hwg.hwg_id, owg.owg_id
) plngj
ON plngj.mandant_id = vis.mandant_id AND plngj.wup_id = vis.wup_id
AND plngj.wrg_id = vis.wrg_id AND plngj.gj = (vis.gj+1) 
AND plngj.owg_id = vis.owg_id 
 
/* JZG 46.0.0 Inventur Filiale */  
UNION ALL SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, (vis.gj+1) AS GJ 
, 46::INTEGER AS METRIK_ID, 0::INTEGER AS TYP_ID, 0::INTEGER AS LEVEL_ID
, inv.inv_wert AS WERT_VJ1, inv.inv_ums AS WERT_VJ2
, NULL AS PLAN_VJ1, NULL AS PLAN_VJ2
, NULL AS PLAN_GJ1, NULL AS PLAN_GJ2
, inv.inv_wert/NULLIFZERO(inv.inv_ums) AS WERT_VJ 
, NULL AS PLAN_VJ
, NULL AS PLAN_GJ
, NULL AS DELTA, NULL AS ABW 
FROM ( /* JZG MAIN - KVJ */
	SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.gj
	, SUM(vis.ums_netto) AS ums_wert
	, SUM(vis.ums_netto_plan) AS ums_plan
	, SUM(vis.anz_kunde) AS anz_kunde
	, SUM(vis.pers_std) AS std_wert
	, SUM(vis.pers_std_plan) AS std_plan
	FROM DBP_MSI_DATA.VIS_MONAT_UMS_KUNDE_PERS_WUP vis
	INNER JOIN DBP_DATA.MONAT zeit
	ON zeit.kjmo = vis.kjmo AND zeit.akt_gj = -1
	/* Standard Filter VTC = Filiale (ohne NB) unbereinigt */
	INNER JOIN dbp_data.wup wup 
	ON wup.wup_id = vis.wup_id AND wup.mandant_id = vis.mandant_id AND wup.nb_id=0
	AND wup.dat_eroeffnung<'2090-12-31' /* fix */
	AND (EXTRACT(YEAR FROM wup.dat_bis)+CASE WHEN EXTRACT(MONTH FROM wup.dat_bis)<3 THEN -1 ELSE 0 END)>zeit.gj+1 /* dynamisch*/
	GROUP BY vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.gj
) vis
LEFT JOIN ( /* JZG Inventur - Filiale KVJ */
	SELECT vis_inv.mandant_id, vis_inv.nb_id, vis_inv.wup_id, vis_inv.wrg_id,vis_inv.gj
	, SUM(vis_inv.inventur_wert_netto) AS inv_wert
	, SUM(vis_inv.inventur_ums_netto) AS inv_ums
	FROM DBP_MSI_VIEW_VIS.MV_VIS_MONAT_HFM_INVENTUR vis_inv
	JOIN DBP_DATA.TAG zeit
	ON zeit.dat = vis_inv.dat_plan_zaehlung AND zeit.akt_gj = -1 
	WHERE vis_inv.inventurart_int_id IN (8) /* Historie GJ */
	GROUP BY vis_inv.mandant_id, vis_inv.nb_id, vis_inv.wup_id, vis_inv.wrg_id, vis_inv.gj
) inv
ON inv.mandant_id=vis.mandant_id AND inv.wup_id=vis.wup_id
AND inv.wrg_id = vis.wrg_id AND inv.gj = vis.gj
/* JZG 46.1.x000000 Inventur Abteilung */  
UNION ALL SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, (vis.gj+1) AS GJ 
, 46::INTEGER AS METRIK_ID, 1::INTEGER AS TYP_ID, (CASE inv.abt_id WHEN 4 THEN 9999999 ELSE inv.abt_id * 1000000 END)::INTEGER AS LEVEL_ID
, inv.inv_wert AS WERT_VJ1, inv.inv_ums AS WERT_VJ2
, NULL AS PLAN_VJ1, NULL AS PLAN_VJ2
, NULL AS PLAN_GJ1, NULL AS PLAN_GJ2
, WERT_VJ1/NULLIFZERO(WERT_VJ2) AS WERT_VJ 
, NULL AS PLAN_VJ
, NULL AS PLAN_GJ 
, NULL AS DELTA
, NULL AS ABW 
FROM ( /* JZG MAIN - KVJ */
	SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.gj
	, SUM(vis.ums_netto) AS ums_wert
	, SUM(vis.ums_netto_plan) AS ums_plan
	, SUM(vis.anz_kunde) AS anz_kunde
	, SUM(vis.pers_std) AS std_wert
	, SUM(vis.pers_std_plan) AS std_plan
	FROM DBP_MSI_DATA.VIS_MONAT_UMS_KUNDE_PERS_WUP vis
	INNER JOIN DBP_DATA.MONAT zeit
	ON zeit.kjmo = vis.kjmo AND zeit.akt_gj = -1
	/* Standard Filter VTC = Filiale (ohne NB) unbereinigt */
	INNER JOIN dbp_data.wup wup 
	ON wup.wup_id = vis.wup_id AND wup.mandant_id = vis.mandant_id AND wup.nb_id=0
	AND wup.dat_eroeffnung<'2090-12-31' /* fix */
	AND (EXTRACT(YEAR FROM wup.dat_bis)+CASE WHEN EXTRACT(MONTH FROM wup.dat_bis)<3 THEN -1 ELSE 0 END)>zeit.gj+1 /* dynamisch*/
	GROUP BY vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.gj
) vis
LEFT JOIN ( /* JZG Inventur - Abteilung KVJ */
	SELECT vis_inv.mandant_id, vis_inv.nb_id, vis_inv.wup_id, vis_inv.wrg_id, vis_inv.gj, abt.abt_id
	, SUM(vis_inv.inventur_wert_netto) AS inv_wert
	, SUM(vis_inv.inventur_ums_netto) AS inv_ums
	FROM DBP_MSI_VIEW_VIS.MV_VIS_MONAT_HFM_INVENTUR vis_inv
	JOIN dbp_msi_view_vis.mv_owg_int owg
	ON owg.owg_id = vis_inv.owg_id
	JOIN dbp_msi_view_vis.mv_hwg_int hwg
	ON hwg.hwg_id = owg.hwg_id
	JOIN dbp_msi_view_vis.mv_abt_int abt
	ON abt.abt_id = hwg.abt_id
	JOIN DBP_DATA.TAG zeit
	ON zeit.dat = vis_inv.dat_plan_zaehlung AND zeit.akt_gj = -1 
	WHERE vis_inv.inventurart_int_id IN (8) /* Historie GJ */
	AND abt.abt_id IN (4,5,6,7,8) /* Alle Abteilungen */
	GROUP BY vis_inv.mandant_id, vis_inv.nb_id, vis_inv.wup_id, vis_inv.wrg_id, vis_inv.gj, abt.abt_id
) inv
ON inv.mandant_id=vis.mandant_id AND inv.wup_id=vis.wup_id
AND inv.wrg_id = vis.wrg_id AND inv.gj = vis.gj 
 
/* JZG 60.0.0 Kundenfeeback (MDL) Filiale > entfernt */ 
 
/* JZG 50.0.0 Kurzcheck/AMX Filiale */ 
UNION ALL SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, (vis.gj+1) AS GJ 
, 50::INTEGER AS METRIK_ID, 0::INTEGER AS TYP_ID, 0::INTEGER AS LEVEL_ID
, CASE WHEN amx1.kc_anzahl > 0 THEN ZEROIFNULL(amx2.kc_feststell) ELSE NULL END AS WERT_VJ1 
, amx1.kc_anzahl AS WERT_VJ2
, NULL AS PLAN_VJ1, NULL AS PLAN_VJ2
, NULL AS PLAN_GJ1, NULL AS PLAN_GJ2
, WERT_VJ1/NULLIFZERO(WERT_VJ2) AS WERT_VJ /* NOK% */
, NULL AS PLAN_VJ
, NULL AS PLAN_GJ
, NULL AS DELTA
, NULL AS ABW
FROM ( /* JZG MAIN - KVJ */
	SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.gj
	, SUM(vis.ums_netto) AS ums_wert
	, SUM(vis.ums_netto_plan) AS ums_plan
	, SUM(vis.anz_kunde) AS anz_kunde
	, SUM(vis.pers_std) AS std_wert
	, SUM(vis.pers_std_plan) AS std_plan
	FROM DBP_MSI_DATA.VIS_MONAT_UMS_KUNDE_PERS_WUP vis
	INNER JOIN DBP_DATA.MONAT zeit
	ON zeit.kjmo = vis.kjmo AND zeit.akt_gj=-1
	/* Standard Filter VTC = Filiale (ohne NB) unbereinigt */
	INNER JOIN dbp_data.wup wup 
	ON wup.wup_id = vis.wup_id AND wup.mandant_id = vis.mandant_id AND wup.nb_id=0
	AND wup.dat_eroeffnung<'2090-12-31' /* fix */
	AND (EXTRACT(YEAR FROM wup.dat_bis)+CASE WHEN EXTRACT(MONTH FROM wup.dat_bis)<3 THEN -1 ELSE 0 END)>zeit.gj+1 /* dynamisch*/
	GROUP BY vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.gj
) vis
LEFT JOIN (
	SELECT a15.mandant_id, a15.wup_id, zeit.gj
	, COUNT(a11.amx_frage_id) AS kc_anzahl
	FROM dbp_msi_view_vis.MV_AMX_FRAGE a11
	JOIN dbp_msi_view_vis.MV_TAG zeit 
	ON zeit.dat = a11.DAT_ENDE AND zeit.akt_gj = -1
	JOIN dbp_msi_view_vis.MV_AMX_PRUEF_KAPITEL	a14
	ON a11.pruef_kapitel_id = a14.pruef_kapitel_id
	JOIN dbp_msi_view_vis.MV_AMX_PRUEFUNG	a15
	ON a11.DAT_ENDE = a15.DAT_ENDE AND a14.pruefung_id = a15.pruefung_id
	WHERE EXISTS(
		SELECT s21.amx_frage_id, s21.kmr_quelle_id
		FROM dbp_msi_view_vis.MV_AMX_FRAGE	s21
		JOIN dbp_msi_view_vis.MV_AMX_FRAGE_KATALOG	s23
		ON s21.amx_frage_katalog_id = s23.amx_frage_katalog_id AND s21.kmr_quelle_id = s23.kmr_quelle_id
		JOIN dbp_msi_view_vis.MV_AMX_TEILBEREICH_SPR_ZU	s24
		ON s23.teilbereich_id = s24.teilbereich_id 
		JOIN dbp_msi_view_vis.MV_AMX_PRUEF_KAPITEL	s25
		ON s21.pruef_kapitel_id = s25.pruef_kapitel_id
		JOIN dbp_msi_view_vis.MV_AMX_PRUEFUNG	s26
		ON s21.DAT_ENDE = s26.DAT_ENDE AND s25.pruefung_id = s26.pruefung_id
		WHERE s21.antwort_wert IN (0,1,4) AND s23.hauptbereich_id IN (597230) AND s24.invers_kat_id IN (7) AND s23.amx_handlung_typ_id IN (1, 50000) 
		AND s21.amx_frage_id = a11.amx_frage_id AND	s21.kmr_quelle_id = a11.kmr_quelle_id
		GROUP BY s21.amx_frage_id,s21.kmr_quelle_id
	)
	GROUP BY a15.mandant_id, a15.wup_id, zeit.gj
) amx1
ON amx1.mandant_id = vis.mandant_id AND amx1.wup_id = vis.wup_id 
AND amx1.gj = vis.gj
LEFT JOIN (
	SELECT a15.mandant_id, a15.wup_id, zeit.gj
	, COUNT(a11.amx_frage_id) AS kc_feststell
	FROM dbp_msi_view_vis.MV_AMX_FRAGE a11
	JOIN dbp_msi_view_vis.MV_TAG zeit 
	ON zeit.dat = a11.DAT_ENDE AND zeit.akt_gj = -1
	JOIN dbp_msi_view_vis.MV_AMX_PRUEF_KAPITEL	a14
	ON a11.pruef_kapitel_id = a14.pruef_kapitel_id
	JOIN dbp_msi_view_vis.MV_AMX_PRUEFUNG	a15
	ON a11.DAT_ENDE = a15.DAT_ENDE AND a14.pruefung_id = a15.pruefung_id
	WHERE EXISTS(
		SELECT s21.amx_frage_id, s21.kmr_quelle_id
		FROM dbp_msi_view_vis.MV_AMX_FRAGE	s21
		JOIN dbp_msi_view_vis.MV_AMX_FRAGE_KATALOG	s23
		ON s21.amx_frage_katalog_id = s23.amx_frage_katalog_id AND s21.kmr_quelle_id = s23.kmr_quelle_id
		JOIN dbp_msi_view_vis.MV_AMX_TEILBEREICH_SPR_ZU	s24
		ON s23.teilbereich_id = s24.teilbereich_id 
		JOIN dbp_msi_view_vis.MV_AMX_PRUEF_KAPITEL	s25
		ON s21.pruef_kapitel_id = s25.pruef_kapitel_id
		JOIN dbp_msi_view_vis.MV_AMX_PRUEFUNG	s26
		ON s21.DAT_ENDE = s26.DAT_ENDE AND s25.pruefung_id = s26.pruefung_id
		WHERE s21.antwort_wert IN (1,4) AND s23.hauptbereich_id IN (597230) AND s24.invers_kat_id IN (7) AND s23.amx_handlung_typ_id IN (1, 50000) 
		AND s21.amx_frage_id = a11.amx_frage_id AND	s21.kmr_quelle_id = a11.kmr_quelle_id
		GROUP BY s21.amx_frage_id,s21.kmr_quelle_id
	)
	GROUP BY a15.mandant_id, a15.wup_id, zeit.gj
) amx2
ON amx2.mandant_id = vis.mandant_id AND amx2.wup_id = vis.wup_id 
AND amx2.gj = vis.gj
 
/*	JZG 54.0.0 Kundengarantien + Ø 
	JZG 63.0.0 Reklamationen + Ø  */ 
UNION ALL SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, (vis.gj+1) AS GJ 
, jzg.METRIK_ID::INTEGER AS METRIK_ID, 0::INTEGER AS TYP_ID, 0::INTEGER AS LEVEL_ID
, CASE 
	WHEN METRIK_ID IN (54,55) THEN warten_kasse
	WHEN METRIK_ID IN (56,57) THEN warten_theke
	WHEN METRIK_ID IN (58,59) THEN mangel_mhd
	WHEN METRIK_ID IN (60,61) THEN fehler_preis
	WHEN METRIK_ID IN (62,63) THEN fehler_kasse
	ELSE NULL 
  END AS WERT_VJ1
, CASE 
	WHEN jzg.METRIK_ID IN (55,57,59,61) THEN vis.anz_kunde/10000.00 /* pro 10T Kunden */
	WHEN jzg.METRIK_ID IN (63) THEN vtg.art_anz/100000.00 /* pro 100T Scans */
	ELSE NULL 
  END AS WERT_VJ2 
, NULL AS PLAN_VJ1, NULL AS PLAN_VJ2
, NULL AS PLAN_GJ1, NULL AS PLAN_GJ2
, CASE 
    WHEN jzg.METRIK_ID IN (54,56,58,60,62) THEN WERT_VJ1
    WHEN jzg.METRIK_ID IN (55,57,59,61,63) THEN WERT_VJ1/NULLIFZERO(WERT_VJ2)
    ELSE NULL 
  END AS WERT_VJ
, NULL AS PLAN_VJ
, NULL AS PLAN_GJ
, NULL AS DELTA
, NULL AS ABW
FROM ( /* JZG MAIN - KVJ */
	SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.gj
	, SUM(vis.ums_netto) AS ums_wert
	, SUM(vis.ums_netto_plan) AS ums_plan
	, SUM(vis.anz_kunde) AS anz_kunde
	, SUM(vis.pers_std) AS std_wert
	, SUM(vis.pers_std_plan) AS std_plan
	FROM DBP_MSI_DATA.VIS_MONAT_UMS_KUNDE_PERS_WUP vis
	INNER JOIN DBP_DATA.MONAT zeit
	ON zeit.kjmo = vis.kjmo AND zeit.akt_gj=-1
	/* Standard Filter VTC = Filiale (ohne NB) unbereinigt */
	INNER JOIN dbp_data.wup wup 
	ON wup.wup_id = vis.wup_id AND wup.mandant_id = vis.mandant_id AND wup.nb_id=0
	AND wup.dat_eroeffnung<'2090-12-31' /* fix */
	AND (EXTRACT(YEAR FROM wup.dat_bis)+CASE WHEN EXTRACT(MONTH FROM wup.dat_bis)<3 THEN -1 ELSE 0 END)>zeit.gj+1 /* dynamisch*/
	GROUP BY vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.gj
) vis
LEFT JOIN ( /* JZG Filiale - REKL */
	SELECT rekl.mandant_id, rekl.nb_id, rekl.wup_id, rekl.wrg_id, zeit.gj
	, SUM(CASE WHEN reklamationsgrund_id IN(12,19) THEN 1 ELSE 0 END) AS fehler_preis
	, SUM(CASE WHEN reklamationsgrund_id IN(13,14) THEN 1 ELSE 0 END) AS fehler_kasse
	, SUM(CASE WHEN rekl.reklamationsgrund_id = 91 THEN rekl.vk_menge_kuga ELSE NULL END) AS warten_theke
	, SUM(CASE WHEN rekl.reklamationsgrund_id = 92 THEN rekl.vk_menge_kuga ELSE NULL END) AS warten_kasse
	, SUM(CASE WHEN rekl.reklamationsgrund_id = 93 AND rekl.mandant_id <> 6 THEN rekl.vk_menge_kuga ELSE NULL END) AS mangel_mhd
	FROM dbp_msi_view_vis.MV_VIS_TAG_REKL_ART rekl
	JOIN dbp_data.tag zeit
	ON zeit.dat = rekl.dat AND zeit.akt_gj = -1
	/* Definierte Gründe, ohne Pfand */
	WHERE rekl.reklamationsgrund_id IN (12,13,14,19,91,92,93)
	AND (rekl.mandant_id, rekl.art_id) IN ( 
		SELECT mandant_id, art_id FROM DBP_MSI_VIEW_VIS.MV_ART_WG_ZU WHERE wg_id NOT IN (980)
	) 
	GROUP BY rekl.mandant_id, rekl.nb_id, rekl.wup_id, rekl.wrg_id, zeit.gj
) rekl 
ON rekl.mandant_id = vis.mandant_id AND rekl.wup_id = vis.wup_id
AND rekl.wrg_id = vis.wrg_id AND rekl.gj = vis.gj
LEFT OUTER JOIN ( /* SUB021 VIS_TAG_KASSE_IST (aus mv_view) */
		SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.gj
		, SUM(CASE WHEN ktp.kasse_typ_id IN (1) THEN vis.anz_artikel END) AS art_anz
		FROM DBP_MSI_VIEW_VIS.MV_VIS_TAG_KASSE vis
		JOIN DBP_MSI_VIEW_VIS.MV_KASSE_TYP_PER ktp
		ON ktp.mandant_id = vis.mandant_id AND ktp.wup_id = vis.wup_id 
		AND ktp.dat = vis.dat AND ktp.kasse_nr = vis.kasse_nr
		INNER JOIN dbp_data.tag zeit1
		ON zeit1.dat = vis.dat
		INNER JOIN DBP_DATA.MONAT zeit
		ON zeit.kjmo = zeit1.kjmo AND zeit.akt_gj IN (-1)
		/* Kassentyp 1 = POS (Checkout) + 8,9,10,11 = SCO (Express + Paystation) */
		WHERE ktp.kasse_typ_id IN (1,8,9,10,11) 
		GROUP BY vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.gj
) vtg
ON vtg.mandant_id = vis.mandant_id AND vtg.wup_id = vis.wup_id
AND vtg.wrg_id = vis.wrg_id AND vtg.gj = vis.gj
CROSS JOIN ( /* SHR Metriken */ 
	SELECT 54::INTEGER AS METRIK_ID  /* Warten Kasse */
	UNION ALL SELECT 55::INTEGER AS METRIK_ID  /* Ø Warten Kasse */
	UNION ALL SELECT 56::INTEGER AS METRIK_ID /* Warten Theke */
	UNION ALL SELECT 57::INTEGER AS METRIK_ID /* Ø Warten Theke */
	UNION ALL SELECT 58::INTEGER AS METRIK_ID /* Mangel MHD */
	UNION ALL SELECT 59::INTEGER AS METRIK_ID /*  Ø Mangel MHD */
	UNION ALL SELECT 60::INTEGER AS METRIK_ID /* Preisauszeichnung  */
	UNION ALL SELECT 61::INTEGER AS METRIK_ID /* Ø Preisauszeichnung  */
	UNION ALL SELECT 62::INTEGER AS METRIK_ID /* Kassierfehler  */
	UNION ALL SELECT 63::INTEGER AS METRIK_ID /* Ø Kassierfehler  */
) jzg
 
/* JZG 76.0.0 Resturlaub Filiale */ 
UNION ALL SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, (vis.gj+1) AS GJ 
, 76::INTEGER AS METRIK_ID, 0::INTEGER AS TYP_ID, 0::INTEGER AS LEVEL_ID
, ((u_anspruch+u_rest)-(u_abgelt+u_genomm)) AS WERT_VGJ1, vis.u_anspruch AS WERT_VGJ2
, NULL AS PLAN_VJ1, NULL AS PLAN_VJ2
, NULL AS PLAN_GJ1, NULL AS PLAN_GJ2
, WERT_VGJ1/NULLIFZERO(WERT_VGJ2) AS WERT_VGJ 
, NULL AS PLAN_VJ
, NULL AS PLAN_GJ
, NULL AS DELTA
, NULL AS ABW
FROM ( /* JZG Filiale - SHR_URLAUB */
	SELECT visu.mandant_id, visu.nb_id, visu.wup_id, visu.wrg_id, zeit.gj
	, SUM(visu.tage_urlaub_anspruch_akt_kj) AS u_anspruch
	, SUM(visu.tage_urlaub_abgeltung_kj_kum) AS u_abgelt
	, SUM(visu.tage_urlaub_rest_vj_kj) AS u_rest
	, SUM(visu.tage_urlaub_genommen_kj_kum) AS u_genomm
	FROM dbp_msi_view_vis.MV_VIS_MONAT_SHR_WUP_URLAUB visu
	JOIN dbp_msi_view_vis.MV_MONAT zeit
	ON zeit.kjmo = visu.kjmo
	WHERE zeit.mo_kj = 12 AND akt_gj = -1 AND visu.nb_id = 0 /* Stand zum KJ Ende > Mapping auf GJ */
	GROUP BY visu.mandant_id, visu.nb_id, visu.wup_id, visu.wrg_id, zeit.gj
) vis
 
/* JZG 70.0.0 Personalkosten (%) Filiale 
   JZG 7x.0.0 SHR Stunden/Fluktuation 
   JZG 8x.0.0 SHR Köpfe/MA 
   JZG 9x.0.0 TOP */ 
UNION ALL SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, (vis.gj+1) AS GJ
, jzg.METRIK_ID
, 0::INTEGER AS TYP_ID, 0::INTEGER AS LEVEL_ID
, CASE jzg.METRIK_ID 
	WHEN 70 THEN vis.pk_wert
	WHEN 72 THEN shr.std_spaet
	WHEN 73 THEN shr.std_wende
	WHEN 74 THEN shr.std_ftag
	WHEN 75 THEN shr.std_mehr
	WHEN 77 THEN shr.krank
	WHEN 78 THEN shr.austr_roll
	WHEN 80 THEN shr.kopf_ges
	WHEN 81 THEN shr.kopf_ma
	WHEN 82 THEN shr.vzk_ma
	WHEN 84 THEN shr.std_vtg
	WHEN 86 THEN shr.std_vtg
	WHEN 88 THEN shr.tzk_ma
	ELSE NULL 
  END AS WERT_VJ1 
, CASE jzg.METRIK_ID 
	WHEN 70 THEN vis.ums_wert
	WHEN 72 THEN vis.std_wert
	WHEN 73 THEN vis.std_wert
	WHEN 74 THEN vis.std_wert
	WHEN 75 THEN vis.std_wert
	WHEN 77 THEN shr.soll
	WHEN 78 THEN shr.kopf_roll
	WHEN 80 THEN 1.00
	WHEN 81 THEN 1.00
	WHEN 82 THEN 1.00
	WHEN 84 THEN 1.00
	WHEN 86 THEN shr.kopf_ma
	WHEN 88 THEN shr.kopf_ma
	ELSE NULL 
  END AS WERT_VJ2 
, CASE jzg.METRIK_ID WHEN 70 THEN vis.pk_plan ELSE NULL END AS PLAN_VJ1 /* kein pk plan */
, CASE jzg.METRIK_ID WHEN 70 THEN vis.ums_plan ELSE NULL END AS PLAN_VJ2 
, CASE jzg.METRIK_ID WHEN 70 THEN plngj.pk_plan ELSE NULL END AS PLAN_GJ1 /* kein pk plan */
, CASE jzg.METRIK_ID WHEN 70 THEN plngj.ums_plan ELSE NULL END AS PLAN_GJ2 
, WERT_VJ1/NULLIFZERO(WERT_VJ2) AS WERT_VJ 
, PLAN_VJ1/NULLIFZERO(PLAN_VJ2) AS PLAN_VJ
, PLAN_GJ1/NULLIFZERO(PLAN_GJ2) AS PLAN_GJ
, NULLIFZERO(WERT_VJ)-NULLIFZERO(PLAN_VJ) AS DELTA /* WRG/h */
, NULL AS ABW /* kein prozent */
FROM ( /* JZG MAIN - KVJ */
	SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.gj
	, SUM(vis.ums_netto) AS ums_wert
	, SUM(vis.ums_netto_plan) AS ums_plan
	, SUM(vis.anz_kunde) AS anz_kunde
	, SUM(vis.pers_std) AS std_wert
	, SUM(vis.pers_std_plan) AS std_plan
	, SUM(vis.pers_kosten) AS pk_wert
	, SUM(vis.pers_kosten_plan) AS pk_plan
	FROM DBP_MSI_DATA.VIS_MONAT_UMS_KUNDE_PERS_WUP vis
	INNER JOIN DBP_DATA.MONAT zeit
	ON zeit.kjmo = vis.kjmo AND zeit.akt_gj = -1
	/* Standard Filter VTC = Filiale (ohne NB) unbereinigt */
	INNER JOIN dbp_data.wup wup 
	ON wup.wup_id = vis.wup_id AND wup.mandant_id = vis.mandant_id AND wup.nb_id=0
	AND wup.dat_eroeffnung<'2090-12-31' /* fix */
	AND (EXTRACT(YEAR FROM wup.dat_bis)+CASE WHEN EXTRACT(MONTH FROM wup.dat_bis)<3 THEN -1 ELSE 0 END)>zeit.gj+1 /* dynamisch*/
	GROUP BY vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.gj
) vis
INNER JOIN ( /* JZG MAIN PLAN GJ */
	SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.gj
	, SUM(vis.ums_netto_plan) AS ums_plan
	, SUM(vis.pers_std_plan)  AS std_plan
	, SUM(vis.pers_kosten) AS pk_wert
	, SUM(vis.pers_kosten_plan) AS pk_plan
	FROM DBP_MSI_DATA.VIS_MONAT_UMS_KUNDE_PERS_WUP   vis
	JOIN DBP_DATA.MONAT zeit
	ON zeit.kjmo = vis.kjmo AND zeit.akt_gj = 0
	GROUP BY vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.gj
) plngj
ON plngj.mandant_id = vis.mandant_id AND plngj.wup_id = vis.wup_id
AND plngj.wrg_id = vis.wrg_id AND plngj.gj = (vis.gj+1) 
LEFT JOIN ( /* JZG SHR - Filiale KVJ */
	SELECT vis_shr.mandant_id, vis_shr.nb_id, vis_shr.wup_id, vis_shr.wrg_id, zeit.gj
	, SUM(vis_shr.STUNDEN_ZUSCHLAG_FEIERTAG) AS std_ftag /* GJ aufg. */ 
	, SUM(vis_shr.STUNDEN_ZUSCHLAG_MEHR) AS std_mehr /* GJ aufg. */ 
	, SUM(vis_shr.STUNDEN_ZUSCHLAG_SPAET_NACHT) AS std_spaet /* GJ aufg. */ 
	, SUM(vis_shr.STUNDEN_ZUSCHLAG_WOCHENENDE) AS std_wende /* GJ aufg. */ 
	, SUM(vis_shr.TAGE_KRANK) AS krank /* GJ aufg. */ 
	, SUM(vis_shr.TAGE_ARBEIT_SOLL) AS soll /* GJ aufg. */ 
	, SUM(CASE WHEN zeit.mo_kj = 2 THEN vis_shr.KOPF_AUSTRITTE_ROL ELSE 0 END ) AS austr_roll /* GJ Stand Februar */
	, SUM(CASE WHEN zeit.mo_kj = 2 THEN vis_shr.KOPF_FLUKTUATION_ROL ELSE 0 END) AS kopf_roll /* GJ Stand Februar */
	, SUM(CASE WHEN zeit.mo_kj = 2 THEN vis_shr.KOPF_FILIALE ELSE 0 END) AS kopf_ges /* Kopf gesamte Filiale */ 
	, SUM(CASE WHEN zeit.mo_kj = 2 THEN vis_shr.KOPF_MA ELSE 0 END) AS kopf_ma /* GJ Stand Februar */ 
    , SUM(CASE WHEN zeit.mo_kj = 2 THEN vis_shr.STUNDEN_VERTRAG_MA ELSE 0 END) AS std_vtg /* GJ Stand Februar. */ 
    , SUM(CASE WHEN zeit.mo_kj = 2 THEN vis_shr.VZK_MA ELSE 0 END) AS vzk_ma /* GJ Stand Februar */ 
	, SUM(CASE WHEN zeit.mo_kj = 2 THEN vis_shr.KOPF_TEILZEIT ELSE 0 END) AS tzk_ma /* GJ Stand Februar */ 
	FROM dbp_msi_view_vis.mv_vis_monat_shr_wup vis_shr
	JOIN dbp_msi_view_vis.MV_MONAT zeit
	ON zeit.kjmo = vis_shr.kjmo AND zeit.akt_gj = -1 
	/* Standard Filter VTC = Filiale (ohne NB) unbereinigt */
	INNER JOIN dbp_data.wup wup 
	ON wup.wup_id = vis_shr.wup_id AND wup.mandant_id = vis_shr.mandant_id AND wup.nb_id=0
	AND wup.dat_eroeffnung<'2090-12-31' /* fix */
	AND (EXTRACT(YEAR FROM wup.dat_bis)+CASE WHEN EXTRACT(MONTH FROM wup.dat_bis)<3 THEN -1 ELSE 0 END)>zeit.gj+1 /* dynamisch*/
	GROUP BY vis_shr.mandant_id, vis_shr.nb_id, vis_shr.wup_id, vis_shr.wrg_id, zeit.gj
) shr
ON shr.mandant_id = vis.mandant_id AND shr.wup_id = vis.wup_id
AND shr.wrg_id = vis.wrg_id AND shr.gj = vis.gj 
CROSS JOIN ( /* 7x + 8x + 9x Metriken */ 
	SELECT 70::INTEGER AS METRIK_ID /* PK */
	UNION ALL SELECT 72::INTEGER AS METRIK_ID /* Nachtzuschläge */
	UNION ALL SELECT 73::INTEGER AS METRIK_ID /* Wochenendzuschläge */
	UNION ALL SELECT 74::INTEGER AS METRIK_ID /* Feiertagszuschläge */
	UNION ALL SELECT 75::INTEGER AS METRIK_ID /* Mehrstunden */
	/* 76 Resturlaub separater Block */
	UNION ALL SELECT 77::INTEGER AS METRIK_ID /* Krankenstand */
	UNION ALL SELECT 78::INTEGER AS METRIK_ID /* Fluktuation */
	UNION ALL SELECT 80::INTEGER AS METRIK_ID /* Köpfe Gesamt */
	UNION ALL SELECT 81::INTEGER AS METRIK_ID /* Anzahl MA */
	UNION ALL SELECT 82::INTEGER AS METRIK_ID /* Anzahl VZK */
	UNION ALL SELECT 84::INTEGER AS METRIK_ID /* Anz. Vertragsstunden */
	UNION ALL SELECT 86::INTEGER AS METRIK_ID /* Ø Vertragsstunden */
	UNION ALL SELECT 88::INTEGER AS METRIK_ID /* Anteil TZK */
	UNION ALL SELECT 91::INTEGER AS METRIK_ID /* TOP1 */
	UNION ALL SELECT 92::INTEGER AS METRIK_ID /* TOP2 */
	UNION ALL SELECT 93::INTEGER AS METRIK_ID /* TOP3 */
	UNION ALL SELECT 94::INTEGER AS METRIK_ID /* TOP4 */
	UNION ALL SELECT 95::INTEGER AS METRIK_ID /* TOP5 */
) jzg 
; 