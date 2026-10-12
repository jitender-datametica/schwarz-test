CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_VIS_JZG_DATA_REST_1(
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
	WERT_VJ,
	PLAN_VJ1,
	PLAN_VJ2,
	PLAN_VJ,
	DELTA,
	ABW
) AS  
/*
   FAKT DENORM JZG - Jahreszielgespräch VJ / Plan VJ / Abw.
   2023-02-21 ssch0611 : MAIN mit Personal/MA. AP0144461
   2023-02-24 ssch0611 : Finetuning & Bugfix. 
   2023-10-18 TEMP VERSION kassentyp
*/ 
 
/* JZG 100-0 - Umsatz Filiale */
SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id
, vis.gj + 1  AS GJ    
, 10::INTEGER AS METRIK_ID
, 0::INTEGER  AS TYP_ID
, 0::INTEGER  AS LEVEL_ID
, vis.ums_netto AS WERT_VJ1 /* Umsatz KER */
, 1.00 AS WERT_VJ2 
, vis.ums_netto AS WERT_VJ 
, vis.ums_netto_plan AS PLAN_VJ1 /* Plan Filiale */
, 1.00 AS PLAN_VJ2
, vis.ums_netto_plan AS PLAN_VJ
, WERT_VJ - PLAN_VJ AS DELTA /* IN WRG_1 */
, DELTA / NULLIFZERO(PLAN_VJ) AS ABW   /* IN PROZ */
FROM ( /* JZG Filiale - MAIN */
	SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.gj
	, SUM(vis.ums_netto)      AS ums_netto
	, SUM(vis.ums_netto_plan) AS ums_netto_plan
	, SUM(vis.anz_kunde)      AS anz_kunde
	, SUM(vis.pers_std)       AS pers_std_kvj
	, SUM(vis.pers_std_plan)  AS pers_std_plan
	FROM DBP_MSI_DATA.VIS_MONAT_UMS_KUNDE_PERS_WUP_1   vis
	JOIN DBP_DATA.MONAT_1 zeit_1
	ON   zeit.kjmo = vis.kjmo AND zeit.akt_gj = -1
	GROUP BY vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.gj
) vis
 
/* JZG 101-x000000 - Umsatz Abteilung */ 
UNION ALL 
SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id
, vis.gj + 1  AS GJ 
, 10::INTEGER AS METRIK_ID
, 1::INTEGER AS TYP_ID
, (CASE vis.abt_id WHEN 4 THEN 9999999 ELSE vis.abt_id * 1000000 END)::INTEGER AS LEVEL_ID
, vis.ums_netto AS WERT_VJ1 /* Umsatz Ware */
, 1.00 AS WERT_VJ2 
, vis.ums_netto AS WERT_VJ 
, plan.ums_netto_plan AS PLAN_VJ1 /* Plan Ware */
, 1.00 AS PLAN_VJ2
, plan.ums_netto_plan AS PLAN_VJ
, WERT_VJ - PLAN_VJ           AS DELTA /* IN WRG_1 */
, DELTA / NULLIFZERO(PLAN_VJ) AS ABW   /* IN PROZ */
FROM ( /* JZG Abteilung - Umsatz Ware */
	SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.gj, abt.abt_id
	, SUM(vis.ums_netto) AS ums_netto
	FROM DBP_MSI_DATA.VIS_MONAT_UMSATZ_WG_1  vis
	JOIN DBP_MSI_VIEW_VIS.MV_WG_INT_1 wg 
	ON   wg.wg_id = vis.wg_id
	JOIN DBP_MSI_VIEW_VIS.MV_OWG_INT_1 owg
	ON   owg.owg_id = wg.owg_id
	JOIN DBP_MSI_VIEW_VIS.MV_HWG_INT_1 hwg
	ON   hwg.hwg_id = owg.hwg_id
	JOIN DBP_MSI_VIEW_VIS.MV_ABT_INT_1 abt_1
	ON   abt.abt_id = hwg.abt_id
	JOIN DBP_DATA.MONAT_1  zeit_1
	ON   zeit.kjmo = vis.kjmo AND zeit.akt_gj = -1
	GROUP BY vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.gj, abt.abt_id
) vis
LEFT JOIN ( /* JZG Abteilung - Plan VJ */
	SELECT plan.mandant_id, plan.nb_id, plan.wup_id, plan.wrg_id, zeit.gj, abt.abt_id
	, SUM(plan.umsatz_netto_plan) AS ums_netto_plan
	, SUM(plan.abschriften_netto_operativ_plan) AS abs_netto_plan
	FROM dbp_msi_view_vis.mv_wup_plan_kjmo_owg_1 plan
	JOIN DBP_MSI_VIEW_VIS.MV_OWG_INT_1 owg
	ON   owg.owg_id = plan.owg_id  
	JOIN DBP_MSI_VIEW_VIS.MV_HWG_INT_1 hwg
	ON   hwg.hwg_id = owg.hwg_id
	JOIN DBP_MSI_VIEW_VIS.MV_ABT_INT_1 abt_1
	ON   abt.abt_id = hwg.abt_id
	JOIN DBP_DATA.MONAT_1  zeit_1
	ON   zeit.kjmo = plan.kjmo AND zeit.akt_gj = -1
	GROUP BY plan.mandant_id, plan.nb_id, plan.wup_id, plan.wrg_id, zeit.gj, abt.abt_id
) plan
ON plan.mandant_id = vis.mandant_id AND plan.wup_id = vis.wup_id
AND plan.wrg_id = vis.wrg_id AND plan.gj = vis.gj AND plan.abt_id = vis.abt_id 
 
/* JZG 102-xxx0000 - UMSATZ HWG */
UNION ALL    
SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id
, vis.gj + 1  AS GJ    
, 10::INTEGER AS METRIK_ID
, 2::INTEGER  AS TYP_ID
, (vis.abt_id * 1000000 + ABS(vis.hwg_id) * 10000)::INTEGER AS LEVEL_ID
, vis.ums_netto AS WERT_VJ1 /* Umsatz Ware */
, 1.00 AS WERT_VJ2 
, vis.ums_netto AS WERT_VJ 
, plan.ums_netto_plan AS PLAN_VJ1 /* Plan Ware */
, 1.00 AS PLAN_VJ2
, plan.ums_netto_plan AS PLAN_VJ
, WERT_VJ - PLAN_VJ AS DELTA /* IN WRG_1 */
, DELTA / NULLIFZERO(PLAN_VJ) AS ABW   /* IN PROZ */
FROM ( /* JZG HWG - Umsatz Ware */
	SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.gj, abt.abt_id, hwg.hwg_id
	, SUM(vis.ums_netto) AS ums_netto
	FROM DBP_MSI_DATA.VIS_MONAT_UMSATZ_WG_1  vis 
	JOIN DBP_MSI_VIEW_VIS.MV_WG_INT_1 wg 
	ON   wg.wg_id = vis.wg_id
	JOIN DBP_MSI_VIEW_VIS.MV_OWG_INT_1 owg
	ON   owg.owg_id = wg.owg_id
	JOIN DBP_MSI_VIEW_VIS.MV_HWG_INT_1 hwg
	ON   hwg.hwg_id = owg.hwg_id
	JOIN DBP_MSI_VIEW_VIS.MV_ABT_INT_1 abt_1
	ON   abt.abt_id = hwg.abt_id
	JOIN DBP_DATA.MONAT_1  zeit_1
	ON   vis.kjmo = zeit.kjmo AND zeit.akt_gj = -1 
	WHERE abt.abt_id IN (5,6)
	GROUP BY vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.gj, abt.abt_id, hwg.hwg_id
) vis
LEFT JOIN ( /* JZG HWG - Plan VJ */
	SELECT plan.mandant_id, plan.nb_id, plan.wup_id, plan.wrg_id, zeit.gj, abt.abt_id, hwg.hwg_id
	, SUM(plan.umsatz_netto_plan) AS ums_netto_plan
	, SUM(plan.abschriften_netto_operativ_plan) AS abs_netto_plan
	FROM dbp_msi_view_vis.mv_wup_plan_kjmo_owg_1 plan
	JOIN DBP_DATA.MONAT_1 zeit_1
	ON   zeit.kjmo = plan.kjmo
	JOIN DBP_MSI_VIEW_VIS.MV_OWG_INT_1 owg
	ON   owg.owg_id = plan.owg_id  
	JOIN DBP_MSI_VIEW_VIS.MV_HWG_INT_1 hwg
	ON   hwg.hwg_id = owg.hwg_id
	JOIN DBP_MSI_VIEW_VIS.MV_ABT_INT_1 abt_1
	ON   abt.abt_id = hwg.abt_id
	WHERE zeit.akt_gj = -1 AND plan.nb_id = 0 AND abt.abt_id IN (5,6)
	GROUP BY plan.mandant_id, plan.nb_id, plan.wup_id, plan.wrg_id, zeit.gj, abt.abt_id, hwg.hwg_id
) plan
ON plan.mandant_id = vis.mandant_id AND plan.wup_id = vis.wup_id
AND plan.wrg_id = vis.wrg_id AND plan.gj = vis.gj AND plan.hwg_id = vis.hwg_id 
 
/* JZG 103-5xxxxxx - Umsatz OWG */
UNION ALL    
SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id
, vis.gj + 1  AS GJ
, 10::INTEGER AS METRIK_ID
, 3::INTEGER  AS TYP_ID
, (vis.abt_id * 1000000 + ABS(vis.hwg_id) * 10000 + ABS(vis.owg_id))::INTEGER AS LEVEL_ID
, vis.ums_netto AS WERT_VJ1 /* Umsatz Ware */
, 1.00 AS WERT_VJ2 
, vis.ums_netto AS WERT_VJ 
, plan.ums_netto_plan AS PLAN_VJ1 /* Plan Ware */
, 1.00 AS PLAN_VJ2
, plan.ums_netto_plan AS PLAN_VJ
, WERT_VJ - PLAN_VJ           AS DELTA /* IN WRG_1 */
, DELTA / NULLIFZERO(PLAN_VJ) AS ABW   /* IN PROZ */
FROM ( /* JZG OWG - Umsatz */
	SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.gj, abt.abt_id, hwg.hwg_id, owg.owg_id
	, SUM(vis.ums_netto) AS ums_netto
	FROM DBP_MSI_DATA.VIS_MONAT_UMSATZ_WG_1  vis 
	JOIN DBP_MSI_VIEW_VIS.MV_WG_INT_1 wg 
	ON   wg.wg_id = vis.wg_id
	JOIN DBP_MSI_VIEW_VIS.MV_OWG_INT_1 owg
	ON   owg.owg_id = wg.owg_id
	JOIN DBP_MSI_VIEW_VIS.MV_HWG_INT_1 hwg
	ON   hwg.hwg_id = owg.hwg_id
	JOIN DBP_MSI_VIEW_VIS.MV_ABT_INT_1 abt_1
	ON   abt.abt_id = hwg.abt_id
	JOIN DBP_DATA.MONAT_1  zeit_1
	ON   vis.kjmo = zeit.kjmo AND zeit.akt_gj = -1
	WHERE abt.abt_id = 5
	GROUP BY vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.gj, abt.abt_id, hwg.hwg_id, owg.owg_id
) vis
LEFT JOIN ( /* JZG OWG - Plan */
	SELECT plan.mandant_id, plan.nb_id, plan.wup_id, plan.wrg_id, zeit.gj, abt.abt_id, hwg.hwg_id, owg.owg_id
	, SUM(plan.umsatz_netto_plan) AS ums_netto_plan
	, SUM(plan.abschriften_netto_operativ_plan) AS abschriften_netto_operativ_plan
	FROM dbp_msi_view_vis.mv_wup_plan_kjmo_owg_1 plan
	JOIN DBP_DATA.MONAT_1 zeit_1
	ON   zeit.kjmo = plan.kjmo
	JOIN DBP_MSI_VIEW_VIS.MV_OWG_INT_1 owg
	ON   owg.owg_id = plan.owg_id  
	JOIN DBP_MSI_VIEW_VIS.MV_HWG_INT_1 hwg
	ON   hwg.hwg_id = owg.hwg_id
	JOIN DBP_MSI_VIEW_VIS.MV_ABT_INT_1 abt_1
	ON   abt.abt_id = hwg.abt_id
	WHERE zeit.akt_gj = -1 AND plan.nb_id = 0 AND abt.abt_id IN (5)
	GROUP BY plan.mandant_id, plan.nb_id, plan.wup_id, zeit.gj, plan.wrg_id, abt.abt_id, hwg.hwg_id, owg.owg_id
) plan
ON plan.mandant_id = vis.mandant_id AND plan.wup_id = vis.wup_id
AND plan.wrg_id = vis.wrg_id AND plan.gj = vis.gj AND plan.owg_id = vis.owg_id 
 
/* JZG130-0 - Kunden Filiale */
UNION ALL 
SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id
, vis.gj + 1  AS GJ    
, 13::INTEGER AS METRIK_ID
, 0::INTEGER  AS TYP_ID
, 0::INTEGER  AS LEVEL_ID
, vis.anz_kunde AS WERT_VJ1 /* Kunden Filiale */
, 1.00 AS WERT_VJ2 
, vis.anz_kunde AS WERT_VJ 
, NULL AS PLAN_VJ1 /* kein Plan */
, NULL AS PLAN_VJ2
, NULL AS PLAN_VJ
, NULL AS DELTA
, NULL AS ABW
FROM ( /* JZG Filiale - MAIN */
	SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.gj
	, SUM(vis.ums_netto)      AS ums_netto
	, SUM(vis.ums_netto_plan) AS ums_netto_plan
	, SUM(vis.anz_kunde)      AS anz_kunde
	, SUM(vis.pers_std)       AS pers_std_kvj
	, SUM(vis.pers_std_plan)  AS pers_std_plan
	FROM DBP_MSI_DATA.VIS_MONAT_UMS_KUNDE_PERS_WUP_1   vis
	JOIN DBP_DATA.MONAT_1 zeit_1
	ON   zeit.kjmo = vis.kjmo AND zeit.akt_gj = -1
	GROUP BY vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.gj
) vis
 
/* JZG160-00 - Ø Bon Filiale */
UNION ALL 
SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id
, vis.gj + 1  AS GJ    
, 16::INTEGER AS METRIK_ID
, 0::INTEGER  AS TYP_ID
, 0::INTEGER  AS LEVEL_ID
, vis.ums_netto AS WERT_VJ1 /* Umsatz KER */
, vis.anz_kunde AS WERT_VJ2 /* Kunden Filiale */
, vis.ums_netto / NULLIFZERO(vis.anz_kunde) AS WERT_VJ 
, NULL AS PLAN_VJ1 /* kein Plan */
, NULL AS PLAN_VJ2
, NULL AS PLAN_VJ
, NULL AS DELTA
, NULL AS ABW
FROM ( /* JZG Filiale - MAIN */
	SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.gj
	, SUM(vis.ums_netto)      AS ums_netto
	, SUM(vis.ums_netto_plan) AS ums_netto_plan
	, SUM(vis.anz_kunde)      AS anz_kunde
	, SUM(vis.pers_std)       AS pers_std_kvj
	, SUM(vis.pers_std_plan)  AS pers_std_plan
	FROM DBP_MSI_DATA.VIS_MONAT_UMS_KUNDE_PERS_WUP_1   vis
	JOIN DBP_DATA.MONAT_1 zeit_1
	ON   zeit.kjmo = vis.kjmo AND zeit.akt_gj = -1
	GROUP BY vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.gj
) vis
 
/* JZG200-0 - Nettoleistung Filiale */
UNION ALL     
SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id
, vis.gj + 1  AS GJ    
, 20::INTEGER AS METRIK_ID
, 0::INTEGER  AS TYP_ID
, 0::INTEGER  AS LEVEL_ID
, vis.ums_netto AS WERT_VJ1 /* Umsatz KER */
, vis.pers_std  AS WERT_VJ2 /* Stunden_1 Filiale */
, vis.ums_netto / NULLIFZERO(vis.anz_kunde) AS WERT_VJ 
, vis.ums_netto_plan AS PLAN_VJ1 
, vis.pers_std_plan  AS PLAN_VJ2
, vis.ums_netto_plan / NULLIFZERO(vis.pers_std_plan) AS PLAN_VJ
, WERT_VJ - PLAN_VJ           AS DELTA /* IN WRG_1/h */
, DELTA / NULLIFZERO(PLAN_VJ) AS ABW   /* IN PROZ */
FROM ( /* JZG Filiale - MAIN */
	SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.gj
	, SUM(vis.ums_netto)      AS ums_netto
	, SUM(vis.ums_netto_plan) AS ums_netto_plan
	, SUM(vis.anz_kunde)      AS anz_kunde
	, SUM(vis.pers_std)       AS pers_std
	, SUM(vis.pers_std_plan)  AS pers_std_plan
	FROM DBP_MSI_DATA.VIS_MONAT_UMS_KUNDE_PERS_WUP_1   vis
	JOIN DBP_DATA.MONAT_1 zeit_1
	ON   zeit.kjmo = vis.kjmo AND zeit.akt_gj = -1
	GROUP BY vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.gj
) vis 
 
/* JZG230-0 - Nettoleistung Filiale */
UNION ALL     
SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id
, vis.gj + 1  AS GJ    
, 23::INTEGER AS METRIK_ID
, 0::INTEGER  AS TYP_ID
, 0::INTEGER  AS LEVEL_ID
, vis.pers_std  AS WERT_VJ1 /* Stunden_1 Filiale */
, 1.00 AS WERT_VJ2 
, vis.pers_std  AS WERT_VJ 
, vis.pers_std_plan AS PLAN_VJ1 
, 1.00 AS PLAN_VJ2
, vis.pers_std_plan AS PLAN_VJ
, WERT_VJ - PLAN_VJ AS DELTA /* IN h */
, DELTA / NULLIFZERO(PLAN_VJ) AS ABW /* IN PROZ */
FROM ( /* JZG Filiale - MAIN */
	SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.gj
	, SUM(vis.ums_netto)      AS ums_netto
	, SUM(vis.ums_netto_plan) AS ums_netto_plan
	, SUM(vis.anz_kunde)      AS anz_kunde
	, SUM(vis.pers_std)       AS pers_std
	, SUM(vis.pers_std_plan)  AS pers_std_plan
	FROM DBP_MSI_DATA.VIS_MONAT_UMS_KUNDE_PERS_WUP_1   vis
	JOIN DBP_DATA.MONAT_1 zeit_1
	ON   zeit.kjmo = vis.kjmo AND zeit.akt_gj = -1
	GROUP BY vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.gj
) vis 

 
/* JZG 400-0 - Abschriften_1 Filiale */ 
UNION ALL
SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id
, vis.gj + 1  AS GJ 
, 40::INTEGER AS METRIK_ID
, 0::INTEGER  AS TYP_ID
, 0::INTEGER  AS LEVEL_ID
, visabs.abs_netto AS WERT_VJ1 /* Umsatz Ware */
, vis.ums_netto  AS WERT_VJ2 
, visabs.abs_netto / NULLIFZERO(vis.ums_netto) AS WERT_VJ 
, plan.abs_netto_plan AS PLAN_VJ1 /* Plan Ware */
, plan.ums_netto_plan AS PLAN_VJ2
, abs_netto_plan / NULLIFZERO(plan.ums_netto_plan) AS PLAN_VJ
, (WERT_VJ - PLAN_VJ) * 100 AS DELTA /* IN PROZ.PKT */
, (WERT_VJ - PLAN_VJ) * -1 / NULLIFZERO(PLAN_VJ) AS ABW /* IN PROZ */
FROM ( /* JZG Filiale - Umsatz Ware */
	SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.gj
	, SUM(vis.ums_netto) AS ums_netto
	FROM DBP_MSI_DATA.VIS_MONAT_UMSATZ_WG_1  vis
	JOIN DBP_DATA.MONAT_1  zeit_1
	ON   zeit.kjmo = vis.kjmo AND zeit.akt_gj = -1
	GROUP BY vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.gj
) vis
JOIN ( /* JZG Filiale - Abschriften_1 Ware */
	SELECT vis.mandant_id, vis.nb_id, vis.wup_id, zeit.gj, vis.wrg_id
	, SUM(CASE 
		WHEN vis.mandant_id IN (6) AND vis.abschriftart_id = 2 THEN 1 
		WHEN vis.mandant_id IN (3) AND vis.abschriftart_id = 11 THEN 1 
		WHEN vis.mandant_id IN (2,4,5,7,8) AND vis.abschriftart_id = 7 THEN 1 
		WHEN vis.mandant_id IN (2,5) AND vis.abschriftart_id = 10 THEN 1 
		WHEN vis.mandant_id NOT IN (1) AND vis.abschriftart_id = 20 THEN 1 
		ELSE -1 
	  END * vis.abschrift_netto) AS abs_netto
	FROM DBP_MSI_DATA.VIS_TAG_ABSCHRIFTEN_WG_1 vis 
	JOIN DBP_MSI_VIEW_VIS.MV_ABSCHRIFTART_INT_ZU_1 aaz
	ON   aaz.abschriftart_id = vis.abschriftart_id AND aaz.mandant_id = vis.mandant_id
	JOIN DBP_MSI_VIEW_VIS.MV_ABSCHRIFTART_INT_THEMA_ZU_1 atz
	ON   atz.abschriftart_int_id = aaz.abschriftart_int_id
	JOIN DBP_DATA.MONAT_1  zeit_1
	ON   vis.kjmo = zeit.kjmo AND zeit.akt_gj = -1 
	WHERE atz.abschriftart_thema_int_id IN (1,4)
	GROUP BY vis.mandant_id, vis.nb_id, vis.wup_id, zeit.gj, vis.wrg_id
) visabs
ON visabs.mandant_id = vis.mandant_id AND visabs.wup_id = vis.wup_id
AND visabs.wrg_id = vis.wrg_id AND visabs.gj = vis.gj
LEFT JOIN ( /*  JZG Filiale - Plan Ware */
	SELECT plan.mandant_id, plan.nb_id, plan.wup_id, plan.wrg_id, zeit.gj
	, SUM(plan.umsatz_netto_plan) AS ums_netto_plan
	, SUM(plan.abschriften_netto_operativ_plan) AS abs_netto_plan
	FROM DBP_MSI_VIEW_VIS.MV_WUP_PLAN_KJMO_OWG_1 plan
	JOIN DBP_DATA.MONAT_1 zeit_1
	ON   zeit.kjmo = plan.kjmo AND zeit.akt_gj = -1 
	GROUP BY plan.mandant_id, plan.nb_id, plan.wup_id, plan.wrg_id, zeit.gj
) plan
ON plan.mandant_id = vis.mandant_id AND plan.wup_id = vis.wup_id
AND plan.wrg_id = vis.wrg_id AND plan.gj = vis.gj
 
/* JZG 401-x000000 - Abschriften_1 Abteilung */ 
UNION ALL 
SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id
, vis.gj + 1  AS GJ    
, 40::INTEGER AS METRIK_ID
, 1::INTEGER  AS TYP_ID
, (CASE vis.abt_id WHEN 4 THEN 9999999 ELSE vis.abt_id * 1000000 END)::INTEGER AS LEVEL_ID
, visabs.abs_netto AS WERT_VJ1 /* Umsatz Ware */
, vis.ums_netto  AS WERT_VJ2 
, visabs.abs_netto / NULLIFZERO(vis.ums_netto) AS WERT_VJ 
, plan.abs_netto_plan AS PLAN_VJ1 /* Plan Ware */
, plan.ums_netto_plan AS PLAN_VJ2
, abs_netto_plan / NULLIFZERO(plan.ums_netto_plan) AS PLAN_VJ
, (WERT_VJ - PLAN_VJ) * 100 AS DELTA /* IN PROZ.PKT */
, (WERT_VJ - PLAN_VJ) * -1 / NULLIFZERO(PLAN_VJ) AS ABW /* IN PROZ */
FROM ( /* JZG Abteilung - Umsatz Ware */
	SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.gj, abt.abt_id
	, SUM(vis.ums_netto) AS ums_netto
	FROM DBP_MSI_DATA.VIS_MONAT_UMSATZ_WG_1  vis
	JOIN DBP_MSI_VIEW_VIS.MV_WG_INT_1 wg 
	ON   wg.wg_id = vis.wg_id
	JOIN DBP_MSI_VIEW_VIS.MV_OWG_INT_1 owg
	ON   owg.owg_id = wg.owg_id
	JOIN DBP_MSI_VIEW_VIS.MV_HWG_INT_1 hwg
	ON   hwg.hwg_id = owg.hwg_id
	JOIN DBP_MSI_VIEW_VIS.MV_ABT_INT_1 abt_1
	ON   abt.abt_id = hwg.abt_id
	JOIN DBP_DATA.MONAT_1  zeit_1
	ON   zeit.kjmo = vis.kjmo AND zeit.akt_gj = -1
	WHERE abt.abt_id > 0
	GROUP BY vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.gj, abt.abt_id
) vis
JOIN ( /* JZG Abteilung - Abschriften_1 Ware */
	SELECT vis.mandant_id, vis.nb_id, vis.wup_id, zeit.gj, vis.wrg_id, abt.abt_id
	, SUM(CASE 
		WHEN vis.mandant_id IN (6) AND vis.abschriftart_id = 2 THEN 1 
		WHEN vis.mandant_id IN (3) AND vis.abschriftart_id = 11 THEN 1 
		WHEN vis.mandant_id IN (2,4,5,7,8) AND vis.abschriftart_id = 7 THEN 1 
		WHEN vis.mandant_id IN (2,5) AND vis.abschriftart_id = 10 THEN 1 
		WHEN vis.mandant_id NOT IN (1) AND vis.abschriftart_id = 20 THEN 1 
		ELSE -1 
	  END * vis.abschrift_netto) AS abs_netto
	FROM DBP_MSI_DATA.VIS_TAG_ABSCHRIFTEN_WG_1 vis 
	JOIN DBP_MSI_VIEW_VIS.MV_WG_INT_1 wg 
	ON   wg.wg_id = vis.wg_id
	JOIN DBP_MSI_VIEW_VIS.MV_OWG_INT_1 owg
	ON   owg.owg_id = wg.owg_id
	JOIN DBP_MSI_VIEW_VIS.MV_HWG_INT_1 hwg
	ON   hwg.hwg_id = owg.hwg_id
	JOIN DBP_MSI_VIEW_VIS.MV_ABT_INT_1 abt_1
	ON   abt.abt_id = hwg.abt_id
	JOIN DBP_MSI_VIEW_VIS.MV_ABSCHRIFTART_INT_ZU_1 aaz
	ON   aaz.abschriftart_id = vis.abschriftart_id AND aaz.mandant_id = vis.mandant_id
	JOIN DBP_MSI_VIEW_VIS.MV_ABSCHRIFTART_INT_THEMA_ZU_1 atz
	ON   atz.abschriftart_int_id = aaz.abschriftart_int_id
	JOIN DBP_DATA.MONAT_1  zeit_1
	ON   vis.kjmo = zeit.kjmo AND zeit.akt_gj = -1 
	WHERE atz.abschriftart_thema_int_id IN (1,4) AND abt.abt_id > 0
	GROUP BY vis.mandant_id, vis.nb_id, vis.wup_id, zeit.gj, vis.wrg_id, abt.abt_id
) visabs
ON visabs.mandant_id = vis.mandant_id AND visabs.wup_id = vis.wup_id
AND visabs.wrg_id = vis.wrg_id AND visabs.gj = vis.gj AND visabs.abt_id = vis.abt_id
LEFT JOIN ( /*  JZG Abteilung - Plan Ware */
	SELECT plan.mandant_id, plan.nb_id, plan.wup_id, plan.wrg_id, zeit.gj, abt.abt_id
	, SUM(plan.umsatz_netto_plan) AS ums_netto_plan
	, SUM(plan.abschriften_netto_operativ_plan) AS abs_netto_plan
	FROM DBP_MSI_VIEW_VIS.MV_WUP_PLAN_KJMO_OWG_1 plan
	JOIN DBP_MSI_VIEW_VIS.MV_OWG_INT_1 owg
	ON   owg.owg_id = plan.owg_id
	JOIN DBP_MSI_VIEW_VIS.MV_HWG_INT_1 hwg
	ON   hwg.hwg_id = owg.hwg_id
	JOIN DBP_MSI_VIEW_VIS.MV_ABT_INT_1 abt_1
	ON   abt.abt_id = hwg.abt_id
	JOIN DBP_DATA.MONAT_1 zeit_1
	ON   zeit.kjmo = plan.kjmo AND zeit.akt_gj = -1 
	WHERE abt.abt_id > 0
	GROUP BY plan.mandant_id, plan.nb_id, plan.wup_id, plan.wrg_id, zeit.gj, abt.abt_id
) plan
ON plan.mandant_id = vis.mandant_id AND plan.wup_id = vis.wup_id
AND plan.wrg_id = vis.wrg_id AND plan.gj = vis.gj AND plan.abt_id = vis.abt_id
 
/* JZG 402-xxx0000 - Abschriften_1 HWG */ 
UNION ALL 
SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id
, vis.gj + 1  AS GJ    
, 40::INTEGER AS METRIK_ID
, 2::INTEGER  AS TYP_ID
, (vis.abt_id * 1000000 + ABS(vis.hwg_id) * 10000)::INTEGER AS LEVEL_ID
, visabs.abs_netto AS WERT_VJ1 /* Umsatz Ware */
, vis.ums_netto  AS WERT_VJ2 
, visabs.abs_netto / NULLIFZERO(vis.ums_netto) AS WERT_VJ 
, plan.abs_netto_plan AS PLAN_VJ1 /* Plan Ware */
, plan.ums_netto_plan AS PLAN_VJ2
, abs_netto_plan / NULLIFZERO(plan.ums_netto_plan) AS PLAN_VJ
, (WERT_VJ - PLAN_VJ) * 100 AS DELTA /* IN PROZ.PKT */
, (WERT_VJ - PLAN_VJ) * -1 / NULLIFZERO(PLAN_VJ) AS ABW /* IN PROZ */
FROM ( /* JZG HWG - Umsatz Ware */
	SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.gj, abt.abt_id, hwg.hwg_id
	, SUM(vis.ums_netto) AS ums_netto
	FROM DBP_MSI_DATA.VIS_MONAT_UMSATZ_WG_1  vis
	JOIN DBP_MSI_VIEW_VIS.MV_WG_INT_1 wg 
	ON   wg.wg_id = vis.wg_id
	JOIN DBP_MSI_VIEW_VIS.MV_OWG_INT_1 owg
	ON   owg.owg_id = wg.owg_id
	JOIN DBP_MSI_VIEW_VIS.MV_HWG_INT_1 hwg
	ON   hwg.hwg_id = owg.hwg_id
	JOIN DBP_MSI_VIEW_VIS.MV_ABT_INT_1 abt_1
	ON   abt.abt_id = hwg.abt_id
	JOIN DBP_DATA.MONAT_1  zeit_1
	ON   zeit.kjmo = vis.kjmo AND zeit.akt_gj = -1
	WHERE abt.abt_id IN (5,6)
	GROUP BY vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.gj, abt.abt_id, hwg.hwg_id
) vis
JOIN ( /* JZG HWG - Abschriften_1 Ware */
	SELECT vis.mandant_id, vis.nb_id, vis.wup_id, zeit.gj, vis.wrg_id, abt.abt_id, hwg.hwg_id
	, SUM(CASE 
		WHEN vis.mandant_id IN (6) AND vis.abschriftart_id = 2 THEN 1 
		WHEN vis.mandant_id IN (3) AND vis.abschriftart_id = 11 THEN 1 
		WHEN vis.mandant_id IN (2,4,5,7,8) AND vis.abschriftart_id = 7 THEN 1 
		WHEN vis.mandant_id IN (2,5) AND vis.abschriftart_id = 10 THEN 1 
		WHEN vis.mandant_id NOT IN (1) AND vis.abschriftart_id = 20 THEN 1 
		ELSE -1 
	  END * vis.abschrift_netto) AS abs_netto
	FROM DBP_MSI_DATA.VIS_TAG_ABSCHRIFTEN_WG_1 vis 
	JOIN DBP_MSI_VIEW_VIS.MV_WG_INT_1 wg 
	ON   wg.wg_id = vis.wg_id
	JOIN DBP_MSI_VIEW_VIS.MV_OWG_INT_1 owg
	ON   owg.owg_id = wg.owg_id
	JOIN DBP_MSI_VIEW_VIS.MV_HWG_INT_1 hwg
	ON   hwg.hwg_id = owg.hwg_id
	JOIN DBP_MSI_VIEW_VIS.MV_ABT_INT_1 abt_1
	ON   abt.abt_id = hwg.abt_id
	JOIN DBP_MSI_VIEW_VIS.MV_ABSCHRIFTART_INT_ZU_1 aaz
	ON   aaz.abschriftart_id = vis.abschriftart_id AND aaz.mandant_id = vis.mandant_id
	JOIN DBP_MSI_VIEW_VIS.MV_ABSCHRIFTART_INT_THEMA_ZU_1 atz
	ON   atz.abschriftart_int_id = aaz.abschriftart_int_id
	JOIN DBP_DATA.MONAT_1  zeit_1
	ON   vis.kjmo = zeit.kjmo AND zeit.akt_gj = -1 
	WHERE atz.abschriftart_thema_int_id IN (1,4) AND abt.abt_id IN (5,6)
	GROUP BY vis.mandant_id, vis.nb_id, vis.wup_id, zeit.gj, vis.wrg_id, abt.abt_id, hwg.hwg_id
) visabs
ON visabs.mandant_id = vis.mandant_id AND visabs.wup_id = vis.wup_id
AND visabs.wrg_id = vis.wrg_id AND visabs.gj = vis.gj AND visabs.hwg_id = vis.hwg_id
LEFT JOIN ( /*  JZG HWG - Plan Ware */
	SELECT plan.mandant_id, plan.nb_id, plan.wup_id, plan.wrg_id, zeit.gj, abt.abt_id, hwg.hwg_id
	, SUM(plan.umsatz_netto_plan) AS ums_netto_plan
	, SUM(plan.abschriften_netto_operativ_plan) AS abs_netto_plan
	FROM DBP_MSI_VIEW_VIS.MV_WUP_PLAN_KJMO_OWG_1 plan
	JOIN DBP_MSI_VIEW_VIS.MV_OWG_INT_1 owg
	ON   owg.owg_id = plan.owg_id
	JOIN DBP_MSI_VIEW_VIS.MV_HWG_INT_1 hwg
	ON   hwg.hwg_id = owg.hwg_id
	JOIN DBP_MSI_VIEW_VIS.MV_ABT_INT_1 abt_1
	ON   abt.abt_id = hwg.abt_id
	JOIN DBP_DATA.MONAT_1 zeit_1
	ON   zeit.kjmo = plan.kjmo AND zeit.akt_gj = -1 
	WHERE abt.abt_id IN (5,6)
	GROUP BY plan.mandant_id, plan.nb_id, plan.wup_id, plan.wrg_id, zeit.gj, abt.abt_id, hwg.hwg_id
) plan
ON plan.mandant_id = vis.mandant_id AND plan.wup_id = vis.wup_id
AND plan.wrg_id = vis.wrg_id AND plan.gj = vis.gj AND plan.hwg_id = vis.hwg_id
 
/* JZG 403-5xxxxxx - Abschriften_1 OWG */ 
UNION ALL 
SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id
, vis.gj + 1  AS GJ    
, 40::INTEGER AS METRIK_ID
, 3::INTEGER  AS TYP_ID
, (vis.abt_id * 1000000 + ABS(vis.hwg_id) * 10000 + ABS(vis.owg_id))::INTEGER AS LEVEL_ID
, visabs.abs_netto AS WERT_VJ1 /* Umsatz Ware */
, vis.ums_netto  AS WERT_VJ2 
, visabs.abs_netto / NULLIFZERO(vis.ums_netto) AS WERT_VJ 
, plan.abs_netto_plan AS PLAN_VJ1 /* Plan Ware */
, plan.ums_netto_plan AS PLAN_VJ2
, abs_netto_plan / NULLIFZERO(plan.ums_netto_plan) AS PLAN_VJ
, (WERT_VJ - PLAN_VJ) * 100 AS DELTA /* IN PROZ.PKT */
, (WERT_VJ - PLAN_VJ) * -1 / NULLIFZERO(PLAN_VJ) AS ABW /* IN PROZ */
FROM ( /* JZG OWG - Umsatz Ware */
	SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.gj, abt.abt_id, hwg.hwg_id, owg.owg_id
	, SUM(vis.ums_netto) AS ums_netto
	FROM DBP_MSI_DATA.VIS_MONAT_UMSATZ_WG_1  vis
	JOIN DBP_MSI_VIEW_VIS.MV_WG_INT_1 wg 
	ON   wg.wg_id = vis.wg_id
	JOIN DBP_MSI_VIEW_VIS.MV_OWG_INT_1 owg
	ON   owg.owg_id = wg.owg_id
	JOIN DBP_MSI_VIEW_VIS.MV_HWG_INT_1 hwg
	ON   hwg.hwg_id = owg.hwg_id
	JOIN DBP_MSI_VIEW_VIS.MV_ABT_INT_1 abt_1
	ON   abt.abt_id = hwg.abt_id
	JOIN DBP_DATA.MONAT_1  zeit_1
	ON   zeit.kjmo = vis.kjmo AND zeit.akt_gj = -1
	WHERE abt.abt_id = 5
	GROUP BY vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.gj, abt.abt_id, hwg.hwg_id, owg.owg_id
) vis
JOIN ( /* JZG OWG - Abschriften_1 Ware */
	SELECT vis.mandant_id, vis.nb_id, vis.wup_id, zeit.gj, vis.wrg_id, abt.abt_id, hwg.hwg_id, owg.owg_id
	, SUM(CASE 
		WHEN vis.mandant_id IN (6) AND vis.abschriftart_id = 2 THEN 1 
		WHEN vis.mandant_id IN (3) AND vis.abschriftart_id = 11 THEN 1 
		WHEN vis.mandant_id IN (2,4,5,7,8) AND vis.abschriftart_id = 7 THEN 1 
		WHEN vis.mandant_id IN (2,5) AND vis.abschriftart_id = 10 THEN 1 
		WHEN vis.mandant_id NOT IN (1) AND vis.abschriftart_id = 20 THEN 1 
		ELSE -1 
	  END * vis.abschrift_netto) AS abs_netto
	FROM DBP_MSI_DATA.VIS_TAG_ABSCHRIFTEN_WG_1 vis 
	JOIN DBP_MSI_VIEW_VIS.MV_WG_INT_1 wg 
	ON   wg.wg_id = vis.wg_id
	JOIN DBP_MSI_VIEW_VIS.MV_OWG_INT_1 owg
	ON   owg.owg_id = wg.owg_id
	JOIN DBP_MSI_VIEW_VIS.MV_HWG_INT_1 hwg
	ON   hwg.hwg_id = owg.hwg_id
	JOIN DBP_MSI_VIEW_VIS.MV_ABT_INT_1 abt_1
	ON   abt.abt_id = hwg.abt_id
	JOIN DBP_MSI_VIEW_VIS.MV_ABSCHRIFTART_INT_ZU_1 aaz
	ON   aaz.abschriftart_id = vis.abschriftart_id AND aaz.mandant_id = vis.mandant_id
	JOIN DBP_MSI_VIEW_VIS.MV_ABSCHRIFTART_INT_THEMA_ZU_1 atz
	ON   atz.abschriftart_int_id = aaz.abschriftart_int_id
	JOIN DBP_DATA.MONAT_1  zeit_1
	ON   vis.kjmo = zeit.kjmo AND zeit.akt_gj = -1 
	WHERE atz.abschriftart_thema_int_id IN (1,4) AND abt.abt_id = 5
	GROUP BY vis.mandant_id, vis.nb_id, vis.wup_id, zeit.gj, vis.wrg_id, abt.abt_id, hwg.hwg_id, owg.owg_id
) visabs
ON visabs.mandant_id = vis.mandant_id AND visabs.wup_id = vis.wup_id
AND visabs.wrg_id = vis.wrg_id AND visabs.gj = vis.gj AND visabs.owg_id = vis.owg_id
LEFT JOIN ( /*  JZG OWG - Plan Ware */
	SELECT plan.mandant_id, plan.nb_id, plan.wup_id, plan.wrg_id, zeit.gj, abt.abt_id, hwg.hwg_id, owg.owg_id
	, SUM(plan.umsatz_netto_plan) AS ums_netto_plan
	, SUM(plan.abschriften_netto_operativ_plan) AS abs_netto_plan
	FROM DBP_MSI_VIEW_VIS.MV_WUP_PLAN_KJMO_OWG_1 plan
	JOIN DBP_MSI_VIEW_VIS.MV_OWG_INT_1 owg
	ON   owg.owg_id = plan.owg_id
	JOIN DBP_MSI_VIEW_VIS.MV_HWG_INT_1 hwg
	ON   hwg.hwg_id = owg.hwg_id
	JOIN DBP_MSI_VIEW_VIS.MV_ABT_INT_1 abt_1
	ON   abt.abt_id = hwg.abt_id
	JOIN DBP_DATA.MONAT_1 zeit_1
	ON   zeit.kjmo = plan.kjmo AND zeit.akt_gj = -1 
	WHERE abt.abt_id = 5
	GROUP BY plan.mandant_id, plan.nb_id, plan.wup_id, plan.wrg_id, zeit.gj, abt.abt_id, hwg.hwg_id, owg.owg_id
) plan
ON plan.mandant_id = vis.mandant_id AND plan.wup_id = vis.wup_id
AND plan.wrg_id = vis.wrg_id AND plan.gj = vis.gj AND plan.owg_id = vis.owg_id
 
/* JZG 500-0 - Inventur_1 Filiale */ 
UNION ALL
SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id
, vis.gj + 1  AS GJ    
, 50::INTEGER AS METRIK_ID
, 0::INTEGER  AS TYP_ID
, 0::INTEGER  AS LEVEL_ID
, vis.inv_wert AS WERT_VJ1 
, vis.inv_ums  AS WERT_VJ2
, vis.inv_wert / NULLIFZERO(vis.inv_ums) AS WERT_VJ 
, NULL AS PLAN_VJ1 /* kein Plan */
, NULL AS PLAN_VJ2
, NULL AS PLAN_VJ
, NULL AS DELTA 
, NULL AS ABW 
FROM ( /* JZG Inventur_1 - Filiale */
	SELECT vis_inv.mandant_id, vis_inv.nb_id, vis_inv.wup_id, vis_inv.wrg_id,vis_inv.gj
	, SUM(vis_inv.inventur_wert_netto) AS inv_wert
	, SUM(vis_inv.inventur_ums_netto)  AS inv_ums
	FROM DBP_MSI_VIEW_VIS.MV_VIS_MONAT_HFM_INVENTUR_1 vis_inv
	JOIN DBP_DATA.TAG_1 zeit_1
	ON   zeit.dat = vis_inv.dat_plan_zaehlung AND zeit.akt_gj = -1 
	WHERE vis_inv.inventurart_int_id IN (8)
	GROUP BY vis_inv.mandant_id, vis_inv.nb_id, vis_inv.wup_id, vis_inv.wrg_id, vis_inv.gj
) vis
 
/* JZG 501-x000000 - Inventur_1 Abteilung */ 
UNION ALL
SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id
, vis.gj + 1  AS GJ    
, 50::INTEGER AS METRIK_ID
, 1::INTEGER  AS TYP_ID
, (CASE vis.abt_id WHEN 4 THEN 9999999 ELSE vis.abt_id * 1000000 END)::INTEGER AS LEVEL_ID
, vis.inv_wert AS WERT_VJ1
, vis.inv_ums  AS WERT_VJ2 /* Umsatz Inventur_1 */ 
, vis.inv_wert / NULLIFZERO(vis.inv_ums) AS WERT_VJ 
, NULL AS PLAN_VJ1 /* kein Plan */
, NULL AS PLAN_VJ2
, NULL AS PLAN_VJ
, NULL AS DELTA 
, NULL AS ABW 
FROM ( /* JZG Inventur_1 - Filiale */
	SELECT vis_inv.mandant_id, vis_inv.nb_id, vis_inv.wup_id, vis_inv.wrg_id, vis_inv.gj, abt.abt_id
	, SUM(vis_inv.inventur_wert_netto) AS inv_wert
	, SUM(vis_inv.inventur_ums_netto)  AS inv_ums
	FROM DBP_MSI_VIEW_VIS.MV_VIS_MONAT_HFM_INVENTUR_1 vis_inv
	JOIN dbp_msi_view_vis.mv_owg_int_1 owg
	ON   owg.owg_id = vis_inv.owg_id
	JOIN dbp_msi_view_vis.mv_hwg_int_1 hwg
	ON   hwg.hwg_id = owg.hwg_id
	JOIN dbp_msi_view_vis.mv_abt_int_1 abt_1
	ON   abt.abt_id = hwg.abt_id
	JOIN DBP_DATA.TAG_1 zeit_1
	ON   zeit.dat = vis_inv.dat_plan_zaehlung AND zeit.akt_gj = -1 
	WHERE vis_inv.inventurart_int_id IN (8) AND abt.abt_id IN (5,6)
	GROUP BY vis_inv.mandant_id, vis_inv.nb_id, vis_inv.wup_id, vis_inv.wrg_id, vis_inv.gj, abt.abt_id
) vis 
 
/* JZG 502-xxx0000 - Inventur_1 HWG */ 
UNION ALL
SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id
, vis.gj + 1  AS GJ    
, 50::INTEGER AS METRIK_ID
, 2::INTEGER  AS TYP_ID
, (vis.abt_id * 1000000 + ABS(vis.hwg_id) * 10000)::INTEGER AS LEVEL_ID
, vis.inv_wert AS WERT_VJ1
, vis.inv_ums  AS WERT_VJ2 /* Umsatz Inventur_1 */ 
, vis.inv_wert / NULLIFZERO(vis.inv_ums) AS WERT_VJ 
, NULL AS PLAN_VJ1 /* kein Plan */
, NULL AS PLAN_VJ2
, NULL AS PLAN_VJ
, NULL AS DELTA 
, NULL AS ABW 
FROM ( /* JZG Inventur_1 - Filiale */
	SELECT vis_inv.mandant_id, vis_inv.nb_id, vis_inv.wup_id, vis_inv.wrg_id, vis_inv.gj, abt.abt_id, hwg.hwg_id
	, SUM(vis_inv.inventur_wert_netto) AS inv_wert
	, SUM(vis_inv.inventur_ums_netto)  AS inv_ums
	FROM DBP_MSI_VIEW_VIS.MV_VIS_MONAT_HFM_INVENTUR_1 vis_inv
	JOIN dbp_msi_view_vis.mv_owg_int_1 owg
	ON   owg.owg_id = vis_inv.owg_id
	JOIN dbp_msi_view_vis.mv_hwg_int_1 hwg
	ON   hwg.hwg_id = owg.hwg_id
	JOIN dbp_msi_view_vis.mv_abt_int_1 abt_1
	ON   abt.abt_id = hwg.abt_id
	JOIN DBP_DATA.TAG_1 zeit_1
	ON   zeit.dat = vis_inv.dat_plan_zaehlung AND zeit.akt_gj = -1 
	WHERE vis_inv.inventurart_int_id IN (8) AND hwg.hwg_id IN (60,61,62,63,64,65,81)
	GROUP BY vis_inv.mandant_id, vis_inv.nb_id, vis_inv.wup_id, vis_inv.wrg_id, vis_inv.gj, abt.abt_id, hwg.hwg_id
) vis 
 
/* JZG 503-5xxxxxx - Inventur_1 OWG */ 
UNION ALL
SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id
, vis.gj + 1  AS GJ    
, 50::INTEGER AS METRIK_ID
, 3::INTEGER  AS TYP_ID
, (vis.abt_id * 1000000 + ABS(vis.hwg_id) * 10000 + ABS(vis.owg_id))::INTEGER AS LEVEL_ID
, vis.inv_wert AS WERT_VJ1
, vis.inv_ums  AS WERT_VJ2 /* Umsatz Inventur_1 */ 
, vis.inv_wert / NULLIFZERO(vis.inv_ums) AS WERT_VJ 
, NULL AS PLAN_VJ1 /* kein Plan */
, NULL AS PLAN_VJ2
, NULL AS PLAN_VJ
, NULL AS DELTA 
, NULL AS ABW 
FROM ( /* JZG Inventur_1 - Filiale */
	SELECT vis_inv.mandant_id, vis_inv.nb_id, vis_inv.wup_id, vis_inv.wrg_id, vis_inv.gj, abt.abt_id, hwg.hwg_id, owg.owg_id
	, SUM(vis_inv.inventur_wert_netto) AS inv_wert
	, SUM(vis_inv.inventur_ums_netto)  AS inv_ums
	FROM DBP_MSI_VIEW_VIS.MV_VIS_MONAT_HFM_INVENTUR_1 vis_inv
	JOIN dbp_msi_view_vis.mv_owg_int_1 owg
	ON   owg.owg_id = vis_inv.owg_id
	JOIN dbp_msi_view_vis.mv_hwg_int_1 hwg
	ON   hwg.hwg_id = owg.hwg_id
	JOIN dbp_msi_view_vis.mv_abt_int_1 abt_1
	ON   abt.abt_id = hwg.abt_id
	JOIN DBP_DATA.TAG_1 zeit_1
	ON   zeit.dat = vis_inv.dat_plan_zaehlung AND zeit.akt_gj = -1 
	WHERE vis_inv.inventurart_int_id IN (8) AND abt.abt_id = 5
	GROUP BY vis_inv.mandant_id, vis_inv.nb_id, vis_inv.wup_id, vis_inv.wrg_id, vis_inv.gj, abt.abt_id, hwg.hwg_id, owg.owg_id
) vis
 
/* JZG 600-0 - Kundenfeedback MDL Filiale */
UNION ALL 
SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id
, vis.gj + 1    AS GJ    
, 60::INTEGER   AS METRIK_ID
, 0::INTEGER    AS TYP_ID
, 0::INTEGER    AS LEVEL_ID
, mdl.mdl_festell AS WERT_VJ1
, mdl.mdl_anzahl  AS WERT_VJ2 
, ZEROIFNULL(mdl.mdl_festell) / NULLIFZERO(mdl.mdl_anzahl) AS WERT_VJ /* NOK */
, NULL AS PLAN_VJ1 /* kein Plan */
, NULL AS PLAN_VJ2
, NULL AS PLAN_VJ
, NULL AS DELTA
, NULL AS ABW
FROM ( /* JZG Filiale */
	SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.gj
	, SUM(vis.anz_kunde) AS anz_kunde
	FROM DBP_MSI_DATA.VIS_MONAT_UMS_KUNDE_PERS_WUP_1   vis
	JOIN DBP_DATA.MONAT_1   zeit_1
	ON zeit.kjmo = vis.kjmo AND zeit.akt_gj = -1
	GROUP BY vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.gj
) vis
LEFT JOIN ( /* JZG Filiale - MDL */
	SELECT a11.mandant_id, a11.nb_id, a11.wup_id, zeit.gj
	, CASE 
		WHEN MAX(CASE WHEN a16.nok_fg = 1 THEN 1 ELSE 0 END) = 1 
		THEN COUNT(CASE WHEN a16.nok_fg = 1 THEN a11.feedback_id ELSE NULL END) 
		ELSE NULL END AS mdl_festell
	, CASE 
		WHEN MAX(CASE WHEN a16.nok_fg <> 2 THEN 1 ELSE 0 END) = 1 
		THEN COUNT(CASE WHEN a16.nok_fg <> 2 THEN a11.feedback_id ELSE NULL END) 
		ELSE NULL END AS mdl_anzahl
	FROM dbp_msi_view_vis.MV_MDL_FEEDBACK_1 a11
	JOIN dbp_data.tag_1 zeit_1
	ON  zeit.dat = a11.dat_einkauf AND zeit.akt_gj = -1
	JOIN dbp_msi_view_vis.MV_MDL_FRAGE_BEFRAGUNG_BEREICH_KATEGORIE_ZU_1 a14
	ON a11.frage_id = a14.frage_id
	JOIN dbp_msi_view_vis.MV_MDL_FRAGE_ANTWORT_ZU_1 a16
	ON a11.antwort_id = a16.antwort_id AND a11.frage_id = a16.frage_id
	WHERE  a14.befragung_id IN (10) AND a14.kategorie_gruppe_id = 1000 AND a14.bereich_id IN (10) AND a16.nok_fg <> 2
	AND (a11.mandant_id <> 1 OR (a11.mandant_id = 1 AND a11.de_wup_load_fg = 1))
	GROUP BY a11.mandant_id, a11.nb_id, a11.wup_id, zeit.gj
) mdl
ON mdl.mandant_id = vis.mandant_id AND mdl.wup_id = vis.wup_id 
AND mdl.gj = vis.gj
 
/* JZG 620-0 - Kurzcheck AMX Filiale */
UNION ALL     
SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id
, vis.gj + 1    AS GJ    
, 62::INTEGER   AS METRIK_ID
, 0::INTEGER    AS TYP_ID
, 0::INTEGER    AS LEVEL_ID
, amx2.kc_feststell AS WERT_VJ1 
, amx1.kc_anzahl    AS WERT_VJ2 
, ZEROIFNULL(amx2.kc_feststell) / NULLIFZERO(amx1.kc_anzahl) AS WERT_VJ /* NOK */
, NULL          AS PLAN_VJ1 /* kein Plan */
, NULL          AS PLAN_VJ2
, NULL          AS PLAN_VJ
, NULL          AS DELTA
, NULL          AS ABW
FROM ( /* JZG Filiale */
	SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.gj
	, SUM(vis.anz_kunde) AS anz_kunde
	FROM DBP_MSI_DATA.VIS_MONAT_UMS_KUNDE_PERS_WUP_1   vis
	JOIN DBP_DATA.MONAT_1   zeit_1
	ON zeit.kjmo = vis.kjmo AND zeit.akt_gj = -1
	GROUP BY vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.gj
) vis
LEFT JOIN (
	SELECT a15.mandant_id, a15.wup_id, zeit.gj
	, COUNT(a11.amx_frage_id) AS kc_anzahl
	FROM dbp_msi_view_vis.MV_AMX_FRAGE_1 a11
	JOIN dbp_msi_view_vis.MV_TAG_1 zeit_1 
	ON zeit.dat = a11.DAT_ENDE AND zeit.akt_gj = -1
	JOIN dbp_msi_view_vis.MV_AMX_PRUEF_KAPITEL_1	a14
	ON a11.pruef_kapitel_id = a14.pruef_kapitel_id
	JOIN dbp_msi_view_vis.MV_AMX_PRUEFUNG_1	a15
	ON a11.DAT_ENDE = a15.DAT_ENDE AND a14.pruefung_id = a15.pruefung_id
	WHERE EXISTS(
		SELECT s21.amx_frage_id, s21.kmr_quelle_id
		FROM dbp_msi_view_vis.MV_AMX_FRAGE_1	s21
		JOIN dbp_msi_view_vis.MV_AMX_FRAGE_KATALOG_1	s23
		ON s21.amx_frage_katalog_id = s23.amx_frage_katalog_id AND s21.kmr_quelle_id = s23.kmr_quelle_id
		JOIN dbp_msi_view_vis.MV_AMX_TEILBEREICH_SPR_ZU_1	s24
		ON s23.teilbereich_id = s24.teilbereich_id 
		JOIN dbp_msi_view_vis.MV_AMX_PRUEF_KAPITEL_1	s25
		ON s21.pruef_kapitel_id = s25.pruef_kapitel_id
		JOIN dbp_msi_view_vis.MV_AMX_PRUEFUNG_1	s26
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
	FROM dbp_msi_view_vis.MV_AMX_FRAGE_1 a11
	JOIN dbp_msi_view_vis.MV_TAG_1 zeit_1 
	ON zeit.dat = a11.DAT_ENDE AND zeit.akt_gj = -1
	JOIN dbp_msi_view_vis.MV_AMX_PRUEF_KAPITEL_1	a14
	ON a11.pruef_kapitel_id = a14.pruef_kapitel_id
	JOIN dbp_msi_view_vis.MV_AMX_PRUEFUNG_1	a15
	ON a11.DAT_ENDE = a15.DAT_ENDE AND a14.pruefung_id = a15.pruefung_id
	WHERE EXISTS(
		SELECT s21.amx_frage_id, s21.kmr_quelle_id
		FROM dbp_msi_view_vis.MV_AMX_FRAGE_1	s21
		JOIN dbp_msi_view_vis.MV_AMX_FRAGE_KATALOG_1	s23
		ON s21.amx_frage_katalog_id = s23.amx_frage_katalog_id AND s21.kmr_quelle_id = s23.kmr_quelle_id
		JOIN dbp_msi_view_vis.MV_AMX_TEILBEREICH_SPR_ZU_1	s24
		ON s23.teilbereich_id = s24.teilbereich_id 
		JOIN dbp_msi_view_vis.MV_AMX_PRUEF_KAPITEL_1	s25
		ON s21.pruef_kapitel_id = s25.pruef_kapitel_id
		JOIN dbp_msi_view_vis.MV_AMX_PRUEFUNG_1	s26
		ON s21.DAT_ENDE = s26.DAT_ENDE AND s25.pruefung_id = s26.pruefung_id
		WHERE s21.antwort_wert IN (1,4) AND s23.hauptbereich_id IN (597230) AND s24.invers_kat_id IN (7) AND s23.amx_handlung_typ_id IN (1, 50000) 
		AND s21.amx_frage_id = a11.amx_frage_id AND	s21.kmr_quelle_id = a11.kmr_quelle_id
		GROUP BY s21.amx_frage_id,s21.kmr_quelle_id
	)
	GROUP BY a15.mandant_id, a15.wup_id, zeit.gj
) amx2
ON amx2.mandant_id = vis.mandant_id AND amx2.wup_id = vis.wup_id 
AND amx2.gj = vis.gj
 
/* JZG 640-0 - Kundengarantie Warten Kasse */
UNION ALL
SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id
, vis.gj + 1  AS GJ    
, 64::INTEGER AS METRIK_ID
, 0::INTEGER  AS TYP_ID
, 0::INTEGER  AS LEVEL_ID
, rekl.warten_kasse AS WERT_VJ1
, 1.00 AS WERT_VJ2 
, rekl.warten_kasse AS WERT_VJ 
, NULL AS PLAN_VJ1 /* kein Plan */
, NULL AS PLAN_VJ2
, NULL AS PLAN_VJ
, NULL AS DELTA
, NULL AS ABW
FROM ( /* JZG Filiale - MAIN */
	SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.gj
	, SUM(vis.anz_kunde)      AS anz_kunde
	FROM DBP_MSI_DATA.VIS_MONAT_UMS_KUNDE_PERS_WUP_1   vis
	JOIN DBP_DATA.MONAT_1 zeit_1
	ON   zeit.kjmo = vis.kjmo AND zeit.akt_gj = -1
	GROUP BY vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.gj
) vis
LEFT JOIN ( /* JZG Filiale - REKL_1 */
	SELECT rekl.mandant_id, rekl.nb_id, rekl.wup_id, rekl.wrg_id, zeit.gj
	, SUM(CASE WHEN rekl.reklamationsgrund_id = 91 THEN rekl.vk_menge_kuga ELSE NULL END) AS warten_theke
	, SUM(CASE WHEN rekl.reklamationsgrund_id = 92 THEN rekl.vk_menge_kuga ELSE NULL END) AS warten_kasse
	, SUM(CASE WHEN rekl.reklamationsgrund_id = 93 AND rekl.mandant_id <> 6 THEN rekl.vk_menge_kuga ELSE NULL END) AS mangel_mhd
	FROM dbp_msi_view_vis.MV_VIS_TAG_REKL_ART_1 rekl_1
	JOIN dbp_data.tag_1 zeit_1
	ON  zeit.dat = rekl.dat AND zeit.akt_gj = -1
	WHERE rekl.reklamationsgrund_id IN (91,92,93)
	GROUP BY rekl.mandant_id, rekl.nb_id, rekl.wup_id, rekl.wrg_id, zeit.gj
) rekl_1  
ON rekl.mandant_id = vis.mandant_id AND rekl.wup_id = vis.wup_id
AND rekl.wrg_id = vis.wrg_id AND rekl.gj = vis.gj
 
/* JZG 660-0 - Kundengarantie Warten Theke */
UNION ALL
SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id
, vis.gj + 1  AS GJ    
, 66::INTEGER AS METRIK_ID
, 0::INTEGER  AS TYP_ID
, 0::INTEGER  AS LEVEL_ID
, rekl.warten_theke AS WERT_VJ1
, 1.00 AS WERT_VJ2 
, rekl.warten_theke AS WERT_VJ 
, NULL AS PLAN_VJ1 /* kein Plan */
, NULL AS PLAN_VJ2
, NULL AS PLAN_VJ
, NULL AS DELTA
, NULL AS ABW
FROM ( /* JZG Filiale - MAIN */
	SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.gj
	, SUM(vis.anz_kunde)      AS anz_kunde
	FROM DBP_MSI_DATA.VIS_MONAT_UMS_KUNDE_PERS_WUP_1   vis
	JOIN DBP_DATA.MONAT_1 zeit_1
	ON   zeit.kjmo = vis.kjmo AND zeit.akt_gj = -1
	GROUP BY vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.gj
) vis
LEFT JOIN ( /* JZG Filiale - REKL_1 */
	SELECT rekl.mandant_id, rekl.nb_id, rekl.wup_id, rekl.wrg_id, zeit.gj
	, SUM(CASE WHEN rekl.reklamationsgrund_id = 91 THEN rekl.vk_menge_kuga ELSE NULL END) AS warten_theke
	, SUM(CASE WHEN rekl.reklamationsgrund_id = 92 THEN rekl.vk_menge_kuga ELSE NULL END) AS warten_kasse
	, SUM(CASE WHEN rekl.reklamationsgrund_id = 93 AND rekl.mandant_id <> 6 THEN rekl.vk_menge_kuga ELSE NULL END) AS mangel_mhd
	FROM dbp_msi_view_vis.MV_VIS_TAG_REKL_ART_1 rekl_1
	JOIN dbp_data.tag_1 zeit_1
	ON  zeit.dat = rekl.dat AND zeit.akt_gj = -1
	WHERE rekl.reklamationsgrund_id IN (91,92,93)
	GROUP BY rekl.mandant_id, rekl.nb_id, rekl.wup_id, rekl.wrg_id, zeit.gj
) rekl_1  
ON rekl.mandant_id = vis.mandant_id AND rekl.wup_id = vis.wup_id
AND rekl.wrg_id = vis.wrg_id AND rekl.gj = vis.gj
 
/* JZG 680-0 - Kundengarantie Mangel MHD */
UNION ALL
SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id
, vis.gj + 1  AS GJ    
, 68::INTEGER AS METRIK_ID
, 0::INTEGER  AS TYP_ID
, 0::INTEGER  AS LEVEL_ID
, rekl.mangel_mhd AS WERT_VJ1
, 1.00 AS WERT_VJ2 
, rekl.mangel_mhd AS WERT_VJ 
, NULL AS PLAN_VJ1 /* kein Plan */
, NULL AS PLAN_VJ2
, NULL AS PLAN_VJ
, NULL AS DELTA
, NULL AS ABW
FROM ( /* JZG Filiale - MAIN */
	SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.gj
	, SUM(vis.anz_kunde) AS anz_kunde
	FROM DBP_MSI_DATA.VIS_MONAT_UMS_KUNDE_PERS_WUP_1   vis
	JOIN DBP_DATA.MONAT_1 zeit_1
	ON   zeit.kjmo = vis.kjmo AND zeit.akt_gj = -1
	GROUP BY vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.gj
) vis
LEFT JOIN ( /* JZG Filiale - REKL_1 */
	SELECT rekl.mandant_id, rekl.nb_id, rekl.wup_id, rekl.wrg_id, zeit.gj
	, SUM(CASE WHEN rekl.reklamationsgrund_id = 91 THEN rekl.vk_menge_kuga ELSE NULL END) AS warten_theke
	, SUM(CASE WHEN rekl.reklamationsgrund_id = 92 THEN rekl.vk_menge_kuga ELSE NULL END) AS warten_kasse
	, SUM(CASE WHEN rekl.reklamationsgrund_id = 93 AND rekl.mandant_id <> 6 THEN rekl.vk_menge_kuga ELSE NULL END) AS mangel_mhd
	FROM dbp_msi_view_vis.MV_VIS_TAG_REKL_ART_1 rekl_1
	JOIN dbp_data.tag_1 zeit_1
	ON  zeit.dat = rekl.dat AND zeit.akt_gj = -1
	WHERE rekl.reklamationsgrund_id IN (91,92,93)
	GROUP BY rekl.mandant_id, rekl.nb_id, rekl.wup_id, rekl.wrg_id, zeit.gj
) rekl_1  
ON rekl.mandant_id = vis.mandant_id AND rekl.wup_id = vis.wup_id
AND rekl.wrg_id = vis.wrg_id AND rekl.gj = vis.gj
 
/* JZG 700-0 - Personalkosten_1 Filiale */
UNION ALL 
SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id
, vis.gj + 1  AS GJ
, 70::INTEGER AS METRIK_ID
, 0::INTEGER  AS TYP_ID
, 0::INTEGER  AS LEVEL_ID
, vis.pers_kosten AS WERT_VJ1 /* Umsatz KER */
, vis.ums_netto   AS WERT_VJ2 /* Stunden_1 Filiale */
, vis.pers_kosten / NULLIFZERO(vis.ums_netto) AS WERT_VJ 
, vis.pers_kosten_plan AS PLAN_VJ1 
, vis.ums_netto_plan   AS PLAN_VJ2
, NULLIFZERO(vis.pers_kosten_plan) / NULLIFZERO(vis.ums_netto_plan) AS PLAN_VJ
, WERT_VJ - NULLIFZERO(PLAN_VJ) AS DELTA /* IN WRG_1/h */
, NULL AS ABW   /* IN PROZ */
FROM ( /* JZG Filiale - MAIN */
	SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.gj
	, SUM(vis.ums_netto)   AS ums_netto
	, SUM(vis.pers_kosten) AS pers_kosten
	, SUM(vis.ums_netto_plan)   AS ums_netto_plan
	, SUM(vis.pers_kosten_plan) AS pers_kosten_plan
	FROM DBP_MSI_DATA.VIS_MONAT_UMS_KUNDE_PERS_WUP_1 vis
	JOIN DBP_DATA.MONAT_1 zeit_1
	ON   zeit.kjmo = vis.kjmo AND zeit.akt_gj = -1
	GROUP BY vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.gj
) vis
 
/* JZG 780 - Resturlaub KJ Ende */
UNION ALL 
SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id
, vis.gj + 1  AS GJ    
, 78::INTEGER AS METRIK_ID
, 0::INTEGER  AS TYP_ID
, 0::INTEGER  AS LEVEL_ID
, ((u_anspruch+u_rest) - (u_abgelt+u_genomm)) AS METRIK_VGJ1 
, vis.u_anspruch AS METRIK_VGJ2 
, ((u_anspruch+u_rest) - (u_abgelt+u_genomm)) / NULLIFZERO(u_anspruch) AS METRIK_VGJ 
, NULL AS PLAN_VJ1 /* kein Plan */
, NULL AS PLAN_VJ2
, NULL AS PLAN_VJ
, NULL AS DELTA
, NULL AS ABW
FROM ( /* JZG Filiale - SHR_URLAUB */
    SELECT visu.mandant_id, visu.nb_id, visu.wup_id, visu.wrg_id, zeit.gj
    , SUM(visu.tage_urlaub_anspruch_akt_kj)  AS u_anspruch
    , SUM(visu.tage_urlaub_abgeltung_kj_kum) AS u_abgelt
    , SUM(visu.tage_urlaub_rest_vj_kj)       AS u_rest
    , SUM(visu.tage_urlaub_genommen_kj_kum)  AS u_genomm
    FROM dbp_msi_view_vis.MV_VIS_MONAT_SHR_WUP_URLAUB_1 visu
    JOIN dbp_msi_view_vis.MV_MONAT_1 zeit_1
    ON zeit.kjmo = visu.kjmo
    WHERE zeit.mo_kj = 12 AND akt_gj = -1 AND visu.nb_id = 0  /* GJ Mapping / Stand KJ Ende */
    GROUP BY visu.mandant_id, visu.nb_id, visu.wup_id, visu.wrg_id, zeit.gj
) vis
 
/* JZG xxx_1 - Personal/MA/TOP */
UNION ALL
SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id
, vis.gj + 1 AS GJ    
, jzg.METRIK_ID
, 0::INTEGER AS TYP_ID
, 0::INTEGER AS LEVEL_ID
, CASE jzg.METRIK_ID 
	WHEN 72 THEN vis.std_spaet
	WHEN 73 THEN vis.std_wende
	WHEN 74 THEN vis.std_ftag
	WHEN 75 THEN vis.std_mehr
	WHEN 76 THEN vis.austr_roll
	WHEN 77 THEN vis.krank
	WHEN 80 THEN vis.kopf_ma
	WHEN 82 THEN vis.vzk_ma
	WHEN 84 THEN vis.std_ma
	WHEN 86 THEN vis.std_ma
	WHEN 88 THEN vis.tzk_ma
	ELSE NULL 
  END AS WERT_VJ1 
, CASE jzg.METRIK_ID 
	WHEN 72 THEN vis.std_ma
	WHEN 73 THEN vis.std_ma
	WHEN 74 THEN vis.std_ma
	WHEN 75 THEN vis.std_ma
	WHEN 76 THEN vis.kopf_roll
	WHEN 77 THEN vis.soll
	WHEN 80 THEN 1.00
	WHEN 82 THEN 1.00
	WHEN 84 THEN 1.00
	WHEN 86 THEN vis.kopf_ma
	WHEN 88 THEN vis.kopf_ma
	ELSE NULL 
  END AS WERT_VJ2 
, WERT_VJ1 / NULLIFZERO(WERT_VJ2) AS WERT_VJ 
, NULL AS PLAN_VJ1 
, NULL AS PLAN_VJ2 
, NULL AS PLAN_VJ 
, NULL AS DELTA
, NULL AS ABW 
FROM ( /* JZG Filiale - SHR_WUP_FUNKTION*/
	SELECT vis_shr.mandant_id, vis_shr.nb_id, vis_shr.wup_id, vis_shr.wrg_id, zeit.gj
	, SUM(vis_shr.KOPF_GESAMT) AS kopf 
	, SUM(vis_shr.VZK_GESAMT)  AS vzk 
	, SUM(vis_shr.KOPF_TEILZEIT)   AS tzk 
	, SUM(vis_shr.STUNDEN_VERTRAG) AS std 
	, SUM(vis_shr.KOPF_AUSTRITTE_ROL)   AS austr_roll
	, SUM(vis_shr.KOPF_FLUKTUATION_ROL) AS kopf_roll
	, SUM(vis_shr.TAGE_KRANK) AS krank
	, SUM(vis_shr.TAGE_ARBEIT_SOLL) AS soll
	, SUM(CASE WHEN vis_shr.shr_ma_funktion_gruppe_id = 50 THEN vis_shr.KOPF_GESAMT ELSE 0 END) AS kopf_ma 
	, SUM(CASE WHEN vis_shr.shr_ma_funktion_gruppe_id = 50 THEN vis_shr.VZK_GESAMT ELSE 0 END) AS vzk_ma 
	, SUM(CASE WHEN vis_shr.shr_ma_funktion_gruppe_id = 50 THEN vis_shr.KOPF_TEILZEIT ELSE 0 END) AS tzk_ma 
	, SUM(CASE WHEN vis_shr.shr_ma_funktion_gruppe_id = 50 THEN vis_shr.STUNDEN_VERTRAG ELSE 0 END) AS std_ma 
	, SUM(CASE WHEN vis_shr.shr_ma_funktion_gruppe_id = 50 THEN vis_shr.STUNDEN_ZUSCHLAG_FEIERTAG ELSE 0 END) AS std_ftag 
	, SUM(CASE WHEN vis_shr.shr_ma_funktion_gruppe_id = 50 THEN vis_shr.STUNDEN_ZUSCHLAG_MEHR ELSE 0 END) AS std_mehr 
	, SUM(CASE WHEN vis_shr.shr_ma_funktion_gruppe_id = 50 THEN vis_shr.STUNDEN_ZUSCHLAG_SPAET_NACHT ELSE 0 END) AS std_spaet 
	, SUM(CASE WHEN vis_shr.shr_ma_funktion_gruppe_id = 50 THEN vis_shr.STUNDEN_ZUSCHLAG_WOCHENENDE ELSE 0 END)  AS std_wende 
	FROM dbp_msi_view_vis.mv_vis_monat_shr_wup_funktion_1	vis_shr
	JOIN dbp_msi_view_vis.MV_MONAT_1 zeit_1
	ON zeit.kjmo = vis_shr.kjmo AND zeit.akt_gj = -1 AND zeit.mo_kj = 2 /* Stand Feb. */
	GROUP BY vis_shr.mandant_id, vis_shr.nb_id, vis_shr.wup_id, vis_shr.wrg_id, zeit.gj
) vis
CROSS JOIN ( /* JZG Dummies */ 
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
    UNION ALL SELECT 30::INTEGER AS METRIK_ID
	UNION ALL SELECT 33::INTEGER AS METRIK_ID
	UNION ALL SELECT 36::INTEGER AS METRIK_ID
	UNION ALL SELECT 39::INTEGER AS METRIK_ID
/* JZG 300-0 - Kassierleistung Filiale*/
/* JZG 330-0 - Scans/min Filiale*/
/* JZG 360-0 - SCO Nutzung Umsatz */
/* JZG 390-0 - SCO Nutzung Kunde */
) jzg;