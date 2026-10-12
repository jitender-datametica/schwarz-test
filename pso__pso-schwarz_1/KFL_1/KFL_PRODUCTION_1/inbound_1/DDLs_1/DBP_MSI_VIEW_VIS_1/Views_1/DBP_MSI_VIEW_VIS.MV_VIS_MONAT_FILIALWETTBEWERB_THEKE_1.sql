create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_VIS.MV_VIS_MONAT_FILIALWETTBEWERB_THEKE_1(
	MANDANT_ID,
	NB_ID,
	VS_ID,
	WUP_ID,
	WRG_ID,
	GJ,
	KJMO,
	TDM_OFFEN,
	TDM_UMS_NETTO_IST,
	TDM_UMS_NETTO_KVJ,
	TDM_UMS_NETTO,
	TDM_UMS_NETTO_RANK,
	TDM_UMS_NETTO_DENSE,
	TDM_UMS_NETTO_FIL_IST,
	TDM_UMS_NETTO_FIL_KVJ,
	TDM_UMSATZANTEIL_NETTO_IST,
	TDM_UMSATZANTEIL_NETTO_KVJ,
	TDM_UMSATZANTEIL_NETTO,
	TDM_UMSATZANTEIL_NETTO_RANK,
	TDM_UMSATZANTEIL_NETTO_DENSE,
	TDM_ANZAHL_KUNDEN_IST,
	TDM_ANZAHL_KUNDEN_KVJ,
	TDM_ANZAHL_KUNDEN,
	TDM_ANZAHL_KUNDEN_RANK,
	TDM_ANZAHL_KUNDEN_DENSE,
	TDM_ANZAHL_KUNDEN_FIL_IST,
	TDM_ANZAHL_KUNDEN_FIL_KVJ,
	TDM_KUNDENANTEIL_IST,
	TDM_KUNDENANTEIL_KVJ,
	TDM_KUNDENANTEIL,
	TDM_KUNDENANTIEL_RANK,
	TDM_KUNDENANTEIL_DENSE,
	TDM_AVG_BON_IST,
	TDM_AVG_BON_KVJ,
	TDM_AVG_BON,
	TDM_AVG_BON_RANK,
	TDM_AVG_BON_DENSE,
	TDM_ABS_OP_IST,
	TDM_ABS_OP_KVJ,
	TDM_ABSCHRIFT_OP_IST,
	TDM_ABSCHRIFT_OP_KVJ,
	TDM_ABSCHRIFT_OP,
	TDM_ABSCHRIFT_OP_RANK,
	TDM_ABSCHRIFT_OP_DENSE,
	TDM_INVENTUR_WERT_NETTO,
	TDM_INVENTUR_UMS_NETTO,
	TDM_INVENTUR,
	TDM_INVENTUR_RANK,
	TDM_INVENTUR_DENSE,
	TDM_KMR_KC_THEKE_ERGEBNIS_NOK,
	TDM_KMR_KC_THEKE_ERGEBNIS_ANZ,
	TDM_KMR_KC_THEKE_PRUEFUNG_ANZ,
	TDM_KMR_KC_THEKE_NOK,
	TDM_KMR_KC_THEKE_NOK_RANK,
	TDM_KMR_KC_THEKE_NOK_DENSE,
	TDM_WARTEN_THEKE,
	TDM_WARTEN_THEKE_RANK,
	TDM_WARTEN_THEKE_DENSE,
	TDM_KC_WARENFRISCHE_FEST,
	TDM_KC_WARENFRISCHE_GES,
	TDM_KC_WARENFRISCHE_NOK,
	TDM_KC_WARENFRISCHE_NOK_RANK,
	TDM_KC_WARENFRISCHE_NOK_DENSE,
	TDM_KC_SAUBERKEIT_FEST,
	TDM_KC_SAUBERKEIT_GES,
	TDM_KC_SAUBERKEIT_NOK,
	TDM_KC_SAUBERKEIT_NOK_RANK,
	TDM_KC_SAUBERKEIT_NOK_DENSE
) as 




















WITH 

 wup_1 AS ( 
	SELECT wup.mandant_id
		, wup.nb_id
		, wup.vs_id
		, wup.aktuell_wup_id
		, wup.wup_id
		, COALESCE(wup.dat_eroeffnung_alt, wup.dat_eroeffnung) AS neo_dat  
		, IFF(wup_aenderung_grund_id = 3, '9999-12-31', NULL)  AS dat_umgl 
		, COALESCE(dat_umgl, wup.dat_bis)                      AS stl_dat  
		, EXTRACT(YEAR FROM neo_dat) - IFF(EXTRACT(MONTH FROM neo_dat) < 3, 1, 0) AS neo_gj 
		, EXTRACT(YEAR FROM stl_dat) - IFF(EXTRACT(MONTH FROM stl_dat) < 3, 1, 0) AS stl_gj 
		
		, CASE
			WHEN wup.mandant_id = 1 AND wup.wup_id IN (1263, 1273, 3166, 6623, 8120, 8563, 8940, 5876)             THEN 1 
			WHEN wup.mandant_id = 3 AND wup.wup_id IN (1010)                                                       THEN 1 
			WHEN wup.mandant_id = 7 AND wup.wup_id IN (1110, 1410, 6210, 6310, 6410)                               THEN 1 
		
		
			WHEN wup.mandant_id = 1 AND wup.wup_id IN (1300, 1380, 1383, 1403, 1413, 1423, 1430, 1473, 1503, 1510) THEN 1 
			WHEN wup.mandant_id = 1 AND wup.wup_id IN (1513, 1520, 1563, 1583, 1613, 1663, 1690, 1760, 1830, 1863) THEN 1 
			WHEN wup.mandant_id = 1 AND wup.wup_id IN (1950, 1960, 1970, 2083, 2213, 2220, 2363, 2370, 2380, 2443) THEN 1 
			WHEN wup.mandant_id = 1 AND wup.wup_id IN (2590, 2613, 2733, 2753, 2800, 2810, 2820, 2920, 2930, 2973) THEN 1 
			WHEN wup.mandant_id = 1 AND wup.wup_id IN (3063, 3166, 3223, 3280, 3400, 3770, 3790, 3850, 3960, 4043) THEN 1 
			WHEN wup.mandant_id = 1 AND wup.wup_id IN (4103, 4160, 4300, 4323, 4373, 4530, 4620, 4760, 4890, 4950) THEN 1 
			WHEN wup.mandant_id = 1 AND wup.wup_id IN (4973, 4980, 5060, 5110, 5340, 5353, 5373, 5413, 5433, 5463) THEN 1 
			WHEN wup.mandant_id = 1 AND wup.wup_id IN (5473, 5493, 5520, 5533, 5553, 5590, 5670, 5800, 5876, 5900) THEN 1 
			WHEN wup.mandant_id = 1 AND wup.wup_id IN (5910, 6030, 6070, 6310, 6330, 6380, 6480, 6590, 6623, 6690) THEN 1 
			WHEN wup.mandant_id = 1 AND wup.wup_id IN (6730, 6760, 6800, 6970, 7210, 7280, 7300, 7370, 7380, 7440) THEN 1
			WHEN wup.mandant_id = 1 AND wup.wup_id IN (7600, 7690, 7790, 7820, 7830, 8130, 8240, 8370, 8480, 8550) THEN 1 
			WHEN wup.mandant_id = 1 AND wup.wup_id IN (8563, 8600, 8780, 8940)                                     THEN 1
		
			WHEN wup.mandant_id = 2 AND wup.wup_id IN (1700, 6800)                                                 THEN 2 
			ELSE 0 END AS aus_fg
	FROM DBP_DATA.WUP_1 wup_1
	WHERE wup.nb_id = 0 AND wup.dat_eroeffnung < '2090-12-31' 
	)


, zeit_1 AS(
	SELECT zeit.gj 
		, zeit.akt_gj 
		, zeit.akt_gj + IFF(EXTRACT(MONTH FROM CURRENT_DATE - 1) = 3, 1, 0) AS akt_gj_mo 
		, zeit.kjmo 
		, zeit.kjmo_vj 
		, zeit.akt_mo 
		, zeit.min_dat 
		, zeit.max_dat 
	FROM DBP_DATA.MONAT_1 zeit_1
	WHERE akt_gj_mo = 0 AND zeit.akt_mo < 0 
	)




SELECT vis.mandant_id
	, vis.nb_id
	, vis.vs_id
	, vis.wup_id
	, vis.wrg_id
	, vis.gj
	, vis.kjmo
	, vis.offen_ist AS TDM_offen
	
	, visowg.ums_netto_ist AS TDM_ums_netto_ist
	, visowg.ums_netto_kvj AS TDM_ums_netto_kvj
	, TDM_ums_netto_ist / NULLIFZERO(TDM_ums_netto_kvj) AS TDM_ums_netto
	, RANK ()       OVER (PARTITION BY vis.mandant_id, vis.vs_id, vis.wrg_id, vis.kjmo ORDER BY TDM_ums_netto DESC NULLS LAST) AS TDM_ums_netto_rank
	, DENSE_RANK () OVER (PARTITION BY vis.mandant_id, vis.vs_id, vis.wrg_id, vis.kjmo ORDER BY TDM_ums_netto DESC NULLS LAST) AS TDM_ums_netto_dense
	 
	, vistag.ums_fil_ist AS TDM_ums_netto_fil_ist
	, vistag.ums_fil_vj  AS TDM_ums_netto_fil_kvj
	, TDM_ums_netto_ist / NULLIFZERO(TDM_ums_netto_fil_ist)               AS TDM_umsatzanteil_netto_ist
	, TDM_ums_netto_kvj / NULLIFZERO(TDM_ums_netto_fil_kvj)               AS TDM_umsatzanteil_netto_kvj
	, TDM_umsatzanteil_netto_ist - NULLIFZERO(TDM_umsatzanteil_netto_kvj) AS TDM_umsatzanteil_netto
	, RANK ()       OVER (PARTITION BY vis.mandant_id, vis.vs_id, vis.wrg_id, vis.kjmo ORDER BY TDM_umsatzanteil_netto DESC NULLS LAST) AS TDM_umsatzanteil_netto_rank
	, DENSE_RANK () OVER (PARTITION BY vis.mandant_id, vis.vs_id, vis.wrg_id, vis.kjmo ORDER BY TDM_umsatzanteil_netto DESC NULLS LAST) AS TDM_umsatzanteil_netto_dense
	
	, wcalowg.anzahl_kunden_ist AS TDM_anzahl_kunden_ist
	, wcalowg.anzahl_kunden_vj  AS TDM_anzahl_kunden_kvj
	, TDM_anzahl_kunden_ist / NULLIFZERO(TDM_anzahl_kunden_kvj) AS TDM_anzahl_kunden
	, RANK ()       OVER (PARTITION BY vis.mandant_id, vis.vs_id, vis.wrg_id, vis.kjmo ORDER BY TDM_anzahl_kunden DESC NULLS LAST) AS TDM_anzahl_kunden_rank
	, DENSE_RANK () OVER (PARTITION BY vis.mandant_id, vis.vs_id, vis.wrg_id, vis.kjmo ORDER BY TDM_anzahl_kunden DESC NULLS LAST) AS TDM_anzahl_kunden_dense
	
	, vis.anz_kunden_fil_ist AS TDM_anzahl_kunden_fil_ist
	, vis.anz_kunden_fil_vj  AS TDM_anzahl_kunden_fil_kvj
	, TDM_anzahl_kunden_ist / NULLIFZERO(TDM_anzahl_kunden_fil_ist) AS TDM_kundenanteil_ist
	, TDM_anzahl_kunden_kvj / NULLIFZERO(TDM_anzahl_kunden_fil_kvj) AS TDM_kundenanteil_kvj
	, TDM_kundenanteil_ist - NULLIFZERO(TDM_kundenanteil_kvj)       AS TDM_kundenanteil
	, RANK ()       OVER (PARTITION BY vis.mandant_id, vis.vs_id, vis.wrg_id, vis.kjmo ORDER BY TDM_kundenanteil DESC NULLS LAST) AS TDM_kundenantiel_rank
	, DENSE_RANK () OVER (PARTITION BY vis.mandant_id, vis.vs_id, vis.wrg_id, vis.kjmo ORDER BY TDM_kundenanteil DESC NULLS LAST) AS TDM_kundenanteil_dense
	
	, TDM_ums_netto_ist / NULLIFZERO(TDM_anzahl_kunden_ist) AS TDM_avg_bon_ist
	, TDM_ums_netto_kvj / NULLIFZERO(TDM_anzahl_kunden_kvj) AS TDM_avg_bon_kvj
	, TDM_avg_bon_ist / NULLIFZERO(TDM_avg_bon_kvj) AS TDM_avg_bon
	, RANK ()       OVER (PARTITION BY vis.mandant_id, vis.vs_id, vis.wrg_id, vis.kjmo ORDER BY TDM_avg_bon DESC NULLS LAST) AS TDM_avg_bon_rank
	, DENSE_RANK () OVER (PARTITION BY vis.mandant_id, vis.vs_id, vis.wrg_id, vis.kjmo ORDER BY TDM_avg_bon DESC NULLS LAST) AS TDM_avg_bon_dense
	
	, visabs.abs_op_ist AS TDM_abs_op_ist
	, visabs.abs_op_kvj AS TDM_abs_op_kvj
	, TDM_abs_op_ist / NULLIFZERO(TDM_ums_netto_ist)          AS TDM_abschrift_op_ist
	, TDM_abs_op_kvj / NULLIFZERO(TDM_ums_netto_kvj)          AS TDM_abschrift_op_kvj
	, TDM_abschrift_op_ist - NULLIFZERO(TDM_abschrift_op_kvj) AS TDM_abschrift_op
	, RANK ()       OVER (PARTITION BY vis.mandant_id, vis.vs_id, vis.wrg_id, vis.kjmo ORDER BY TDM_abschrift_op DESC NULLS LAST) AS TDM_abschrift_op_rank
	, DENSE_RANK () OVER (PARTITION BY vis.mandant_id, vis.vs_id, vis.wrg_id, vis.kjmo ORDER BY TDM_abschrift_op DESC NULLS LAST) AS TDM_abschrift_op_dense
	
	, inv.inventur_wert_netto AS TDM_inventur_wert_netto
	, inv.inventur_ums_netto  AS TDM_inventur_ums_netto
	, TDM_inventur_wert_netto / NULLIFZERO(TDM_inventur_ums_netto) AS TDM_inventur
	, RANK ()       OVER (PARTITION BY vis.mandant_id, vis.vs_id, vis.wrg_id, vis.kjmo ORDER BY TDM_inventur DESC NULLS LAST) AS TDM_inventur_rank
	, DENSE_RANK () OVER (PARTITION BY vis.mandant_id, vis.vs_id, vis.wrg_id, vis.kjmo ORDER BY TDM_inventur DESC NULLS LAST) AS TDM_inventur_dense
	
	, kmr.kmr_ergebnis_nok AS TDM_kmr_kc_theke_ergebnis_nok
	, kmr.kmr_ergebnis_anz AS TDM_kmr_kc_theke_ergebnis_anz
	, kmr.kmr_pruefung_anz AS TDM_kmr_kc_theke_pruefung_anz
	, TDM_kmr_kc_theke_ergebnis_nok / NULLIFZERO(TDM_kmr_kc_theke_ergebnis_anz) AS TDM_kmr_kc_theke_nok
	, RANK ()       OVER (PARTITION BY vis.mandant_id, vis.vs_id, vis.wrg_id, vis.kjmo ORDER BY TDM_kmr_kc_theke_nok DESC NULLS LAST) AS TDM_kmr_kc_theke_nok_rank
	, DENSE_RANK () OVER (PARTITION BY vis.mandant_id, vis.vs_id, vis.wrg_id, vis.kjmo ORDER BY TDM_kmr_kc_theke_nok DESC NULLS LAST) AS TDM_kmr_kc_theke_nok_dense
	
	, NULL AS TDM_warten_theke
	, NULL AS TDM_warten_theke_rank
	, NULL AS TDM_warten_theke_dense
	 
	, NULL AS TDM_kc_warenfrische_fest
	, NULL AS TDM_kc_warenfrische_ges
	, NULL AS TDM_kc_warenfrische_nok
	, NULL AS TDM_kc_warenfrische_nok_rank
	, NULL AS TDM_kc_warenfrische_nok_dense
	, NULL AS TDM_kc_sauberkeit_fest
	, NULL AS TDM_kc_sauberkeit_ges
	, NULL AS TDM_kc_sauberkeit_nok
	, NULL AS TDM_kc_sauberkeit_nok_rank
	, NULL AS TDM_kc_sauberkeit_nok_dense
	

FROM (
	SELECT vis0.mandant_id, vis0.nb_id, wup.vs_id, vis0.wrg_id
		, wup.aktuell_wup_id AS wup_id
		, vis0.gj
		, vis0.kjmo
		, SUM(vis0.anz_offen)     AS offen_ist
		, SUM(vis0.anz_kunde)     AS anz_kunden_fil_ist
		, SUM(vis0.anz_kunde_kvj) AS anz_kunden_fil_vj
	FROM dbp_msi_data.vis_monat_ums_kunde_pers_wup_1 vis0
	INNER JOIN zeit_1 
		ON zeit.kjmo = vis0.kjmo 
	INNER JOIN wup_1 
		ON wup.wup_id = vis0.wup_id AND wup.mandant_id = vis0.mandant_id
	WHERE wup.neo_gj < (zeit.gj - 1)   
		AND wup.stl_dat > zeit.max_dat 
		AND wup.aus_fg <> 1            
		AND NOT (wup.aus_fg = 2 AND zeit.kjmo BETWEEN 202409 AND 202602) 
	GROUP BY ALL
) vis 


INNER JOIN (
	SELECT vis0.mandant_id, vis0.wrg_id
		, wup.aktuell_wup_id AS wup_id
		, zeit.kjmo
		, SUM(vis0.ums_netto)     AS ums_fil_ist
		, SUM(vis0.ums_netto_kvj) AS ums_fil_vj
	FROM dbp_msi_data.vis_tag_umsatz_kunde_wup_1 vis0
	JOIN dbp_data.tag_1 zeit0
		ON zeit0.dat = vis0.dat
	INNER JOIN zeit_1 
		ON zeit.kjmo = zeit0.kjmo 
	INNER JOIN wup_1 
		ON wup.wup_id = vis0.wup_id AND wup.mandant_id = vis0.mandant_id 
	WHERE wup.neo_gj < (zeit.gj - 1)   
		AND wup.stl_dat > zeit.max_dat 
		AND wup.aus_fg <> 1            
		AND NOT (wup.aus_fg = 2 AND zeit.kjmo BETWEEN 202409 AND 202602) 
	GROUP BY ALL
) vistag
	ON vistag.wup_id = vis.wup_id AND vistag.mandant_id = vis.mandant_id AND vistag.wrg_id = vis.wrg_id 
	AND vistag.kjmo = vis.kjmo


LEFT OUTER JOIN ( 
	SELECT vis0.mandant_id, vis0.wrg_id
		, wup.aktuell_wup_id AS wup_id
		, vis0.kjmo
		, SUM(vis0.ums_netto)     AS ums_netto_ist
		, SUM(vis0.ums_netto_kvj) AS ums_netto_kvj
	FROM dbp_msi_view_vis.MV_VIS_MONAT_FAKT_WG_1 vis0
	INNER JOIN dbp_msi_view_vis.MV_WG_INT_1 wg
		ON wg.wg_id = vis0.wg_id
	INNER JOIN zeit_1 
		ON zeit.kjmo = vis0.kjmo 
	INNER JOIN wup_1 
		ON wup.wup_id = vis0.wup_id AND wup.mandant_id = vis0.mandant_id
	WHERE wup.neo_gj < (zeit.gj - 1)   
		AND wup.stl_dat > zeit.max_dat 
		AND wup.aus_fg <> 1            
		AND NOT (wup.aus_fg = 2 AND zeit.kjmo BETWEEN 202409 AND 202602) 
		AND wg.owg_id IN (1001, 1002, 1003, 1004) 
	GROUP BY ALL
) visowg
ON visowg.wup_id = vis.wup_id AND visowg.mandant_id = vis.mandant_id AND visowg.wrg_id = vis.wrg_id 
	AND visowg.kjmo = vis.kjmo


LEFT OUTER JOIN ( 
	SELECT vis0.mandant_id, vis0.wrg_id
		, wup.aktuell_wup_id AS wup_id
		, zeit.kjmo
		, SUM(CASE 
			WHEN vis0.mandant_id IN (6)         AND vis0.abschriftart_id =  2 THEN 1 
			WHEN vis0.mandant_id IN (3)         AND vis0.abschriftart_id = 11 THEN 1 
			WHEN vis0.mandant_id IN (2,4,5,7,8) AND vis0.abschriftart_id =  7 THEN 1 
			WHEN vis0.mandant_id IN (2,5)       AND vis0.abschriftart_id = 10 THEN 1 
			WHEN vis0.mandant_id NOT IN (1)     AND vis0.abschriftart_id = 20 THEN 1 
			ELSE -1 END * vis0.abschrift_netto) AS abs_op_ist
		, SUM(CASE 
			WHEN vis0.mandant_id IN (6)         AND vis0.abschriftart_id =  2 THEN 1 
			WHEN vis0.mandant_id IN (3)         AND vis0.abschriftart_id = 11 THEN 1 
			WHEN vis0.mandant_id IN (2,4,5,7,8) AND vis0.abschriftart_id =  7 THEN 1 
			WHEN vis0.mandant_id IN (2,5)       AND vis0.abschriftart_id = 10 THEN 1 
			WHEN vis0.mandant_id NOT IN (1)     AND vis0.abschriftart_id = 20 THEN 1 
			ELSE -1 END * vis0.abschrift_netto_kvj) AS abs_op_kvj
	FROM dbp_msi_view_vis.MV_VIS_TAG_ABSCHRIFTEN_WG_1 vis0
	INNER JOIN dbp_msi_view_vis.MV_ABSCHRIFTART_INT_ZU_1 abs_art
		ON abs_art.abschriftart_id = vis0.abschriftart_id AND abs_art.mandant_id = vis0.mandant_id 
	INNER JOIN dbp_msi_view_vis.MV_ABSCHRIFTART_INT_THEMA_ZU_1 abs_thema
		ON abs_thema.abschriftart_int_id = abs_art.abschriftart_int_id
	INNER JOIN dbp_msi_view_vis.MV_WG_INT_1 wg
		ON vis0.wg_id = wg.wg_id
	INNER JOIN zeit_1 
		ON zeit.kjmo = vis0.kjmo 
	INNER JOIN wup_1 
		ON wup.wup_id = vis0.wup_id AND wup.mandant_id = vis0.mandant_id
	WHERE wup.neo_gj < (zeit.gj - 1)   
		AND wup.stl_dat > zeit.max_dat 
		AND wup.aus_fg <> 1            
		AND NOT (wup.aus_fg = 2 AND zeit.kjmo BETWEEN 202409 AND 202602) 
		AND abs_thema.abschriftart_thema_int_id IN (1, 4) 
		AND wg.owg_id IN (1001, 1002, 1003, 1004) 
	GROUP BY ALL
) visabs
ON visabs.wup_id = vis.wup_id AND visabs.mandant_id = vis.mandant_id AND visabs.wrg_id = vis.wrg_id 
	AND visabs.kjmo = vis.kjmo


LEFT OUTER JOIN ( 
	SELECT vis0.mandant_id
		, vis0.wrg_id
		, wup.aktuell_wup_id AS wup_id
		, zeit.kjmo
		, SUM(vis0.bonanzahl_frischetheke_ohne_fisch_ist)     AS anzahl_kunden_ist
		, SUM(vis0.bonanzahl_frischetheke_ohne_fisch_ist_kvj) AS anzahl_kunden_vj
	FROM (
		SELECT wcal.mandant_id
			, wcal.wrg_id
			, wcal.wup_id
			, wcal.dat
			, wcal.bonanzahl_frischetheke_ohne_fisch AS bonanzahl_frischetheke_ohne_fisch_ist
			, 0::INTEGER AS bonanzahl_frischetheke_ohne_fisch_ist_kvj
		FROM dbp_msi_view_vis.MV_WUPCAL_1 wcal
		UNION ALL
		SELECT wcal.mandant_id
			, wcal.wrg_id
			, wcal.wup_id
			, Add_Months(wcal.dat, 12) AS dat
			, 0::INTEGER AS bonanzahl_frischetheke_ohne_fisch_ist
			, wcal.bonanzahl_frischetheke_ohne_fisch AS bonanzahl_frischetheke_ohne_fisch_ist_kvj
		FROM dbp_msi_view_vis.MV_WUPCAL_1 wcal
		) vis0 
	JOIN dbp_msi_view_vis.MV_TAG_1 zeit0
		ON zeit0.dat = vis0.dat
	INNER JOIN zeit_1 
		ON zeit.kjmo = zeit0.kjmo
	INNER JOIN wup_1 
		ON wup.wup_id = vis0.wup_id AND wup.mandant_id = vis0.mandant_id
	WHERE wup.neo_gj < (zeit.gj - 1)   
		AND wup.stl_dat > zeit.max_dat 
		AND wup.aus_fg <> 1            
		AND NOT (wup.aus_fg = 2 AND zeit.kjmo BETWEEN 202409 AND 202602) 
	GROUP BY ALL
) wcalowg
ON wcalowg.mandant_id = vis.mandant_id AND wcalowg.wup_id = vis.wup_id AND wcalowg.wrg_id = vis.wrg_id
	AND wcalowg.kjmo = vis.kjmo


LEFT OUTER JOIN (
	SELECT vis0.mandant_id, vis0.wrg_id
		, wup.aktuell_wup_id AS wup_id
		, zeit.kjmo
		, SUM(vis0.inventur_wert_netto) AS inventur_wert_netto
		, SUM(vis0.inventur_ums_netto)  AS inventur_ums_netto
	FROM dbp_msi_view_vis.MV_VIS_MONAT_HFM_INVENTUR_1 vis0
	JOIN dbp_msi_view_vis.MV_TAG_1 zeit0
		ON zeit0.dat = vis0.dat_plan_zaehlung 
	INNER JOIN zeit_1 
		ON zeit.kjmo = zeit0.kjmo
	INNER JOIN wup_1 
		ON wup.wup_id = vis0.wup_id AND wup.mandant_id = vis0.mandant_id
	WHERE wup.neo_gj < (zeit.gj - 1)    
		AND wup.stl_dat > zeit.max_dat  
		AND wup.aus_fg <> 1             
		AND NOT (wup.aus_fg = 2 AND zeit.kjmo BETWEEN 202409 AND 202602) 
		AND owg_id IN (1001, 1002, 1003, 1004)                           
		AND vis0.inventurart_int_id = 7 
	GROUP BY ALL
) inv
ON inv.mandant_id = vis.mandant_id AND inv.wup_id = vis.wup_id
AND inv.wrg_id = vis.wrg_id AND inv.kjmo = vis.kjmo


LEFT OUTER JOIN (  
	SELECT wup.mandant_id
		, wup.aktuell_wup_id AS wup_id
		, zeit.kjmo 
		, SUM(CASE WHEN wup.mandant_id <> 1 AND kmr_frg.ergebnis_num =  1 THEN 1 ELSE 0 END) AS kmr_ergebnis_nok 
		, SUM(CASE WHEN wup.mandant_id <> 1 AND kmr_frg.ergebnis_num >= 0 THEN 1 ELSE 0 END) AS kmr_ergebnis_anz 
		, COUNT(DISTINCT CASE WHEN wup.mandant_id <> 1 THEN kmr_kap.pruefung_id ELSE 0 END) AS kmr_pruefung_anz 
	FROM DBP_VIEW.V_KMR_FRAGE_1 kmr_frg
	INNER JOIN DBP_VIEW.V_KMR_PRUEFPROGRAMM_KAPITEL_1 kmr_kap
		ON kmr_kap.kapitel_id = kmr_frg.kapitel_id AND kmr_kap.amx_system_id = kmr_frg.amx_system_id
	INNER JOIN DBP_VIEW.V_KMR_PRUEFUNG_1 kmr_prf
		ON kmr_prf.pruefung_id = kmr_kap.pruefung_id AND kmr_prf.amx_system_id = kmr_kap.amx_system_id
	INNER JOIN DBP_VIEW.V_KMR_L_ORGANISATIONSEINHEIT_1 kmr_loe
		ON kmr_loe.orga_einheit_id = kmr_prf.gepr_oe_id AND kmr_loe.amx_system_id = kmr_prf.amx_system_id
	INNER JOIN DBP_DATA.TAG_1 zeit0
		ON zeit0.dat = kmr_prf.dat_pruef_zeitraum_bis
	INNER JOIN zeit_1 
		ON zeit.kjmo = zeit0.kjmo 
	INNER JOIN wup_1 
		ON wup.wup_id = kmr_loe.wup_id AND wup.mandant_id = kmr_loe.mandant_id 
	WHERE wup.neo_gj < (zeit.gj - 1)   
		AND wup.stl_dat > zeit.max_dat 
		AND wup.aus_fg <> 1            
		AND NOT (wup.aus_fg = 2 AND zeit.kjmo BETWEEN 202409 AND 202602) 
		AND kmr_frg.amx_system_id = 1                    
		AND kmr_prf.pruefung_klasse_id IN (100003)         
		AND kmr_prf.pruefung_status_id IN (100005, 100041) 
		AND TRY_TO_NUMBER(SUBSTR(kmr_frg.sort_nr, 14, 2)) IN (40) 
	GROUP BY ALL
) kmr
ON kmr.mandant_id = vis.mandant_id AND kmr.wup_id = vis.wup_id AND kmr.kjmo = vis.kjmo
;
