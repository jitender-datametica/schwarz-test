create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_VIS.MV_VIS_MONAT_FILIALWETTBEWERB_OG(
	MANDANT_ID,
	NB_ID,
	VS_ID,
	WUP_ID,
	WRG_ID,
	GJ,
	KJMO,
	OGM_OFFEN,
	OGM_UMS_NETTO_IST,
	OGM_UMS_NETTO_KVJ,
	OGM_UMS_NETTO,
	OGM_UMS_NETTO_RANK,
	OGM_UMS_NETTO_DENSE,
	OGM_UMS_NETTO_FIL_IST,
	OGM_UMS_NETTO_FIL_KVJ,
	OGM_UMSATZANTEIL_NETTO_IST,
	OGM_UMSATZANTEIL_NETTO_KVJ,
	OGM_UMSATZANTEIL_NETTO,
	OGM_UMSATZANTEIL_NETTO_RANK,
	OGM_UMSATZANTEIL_NETTO_DENSE,
	OGM_ABS_OP_IST,
	OGM_ABS_OWG_PLAN,
	OGM_UMS_OWG_PLAN,
	OGM_ABSCHRIFT_OP_IST,
	OGM_ABSCHRIFT_OP_PLAN,
	OGM_ABSCHRIFT_OP,
	OGM_ABSCHRIFT_OP_RANK,
	OGM_ABSCHRIFT_OP_DENSE,
	OGM_PREISABS_IST,
	OGM_PREISABS,
	OGM_PREISABS_RANK,
	OGM_PREISABS_DENSE,
	OGM_ANZAHL_KUNDEN_IST,
	OGM_ANZAHL_KUNDEN_KVJ,
	OGM_ANZAHL_KUNDEN,
	OGM_ANZAHL_KUNDEN_RANK,
	OGM_ANZAHL_KUNDEN_DENSE,
	OGM_ANZAHL_KUNDEN_FIL_IST,
	OGM_ANZAHL_KUNDEN_FIL_KVJ,
	OGM_KUNDENANTEIL_IST,
	OGM_KUNDENANTEIL_KVJ,
	OGM_KUNDENANTEIL,
	OGM_KUNDENANTEIL_RANK,
	OGM_KUNDENANTEIL_DENSE,
	OGM_INVENTUR_WERT_NETTO,
	OGM_INVENTUR_UMS_NETTO,
	OGM_INVENTUR,
	OGM_INVENTUR_RANK,
	OGM_INVENTUR_DENSE,
	OGM_AVG_BON_IST,
	OGM_AVG_BON_KVJ,
	OGM_AVG_BON,
	OGM_AVG_BON_RANK,
	OGM_AVG_BON_DENSE,
	OGM_UEQ_BEST_VOR,
	OGM_UEQ_BEST_MAN,
	OGM_UEQ_BEST_KOR,
	OGM_UEQ,
	OGM_UEQ_RANK,
	OGM_UEQ_DENSE,
	OGM_KMR_KC_OG_ERGEBNIS_NOK,
	OGM_KMR_KC_OG_ERGEBNIS_ANZ,
	OGM_KMR_KC_OG_PRUEFUNG_ANZ,
	OGM_KMR_KC_OG_NOK,
	OGM_KMR_KC_OG_NOK_RANK,
	OGM_KMR_KC_OG_NOK_DENSE,
	OGM_KC_SAUBERKEIT_FEST,
	OGM_KC_SAUBERKEIT_GES,
	OGM_KC_SAUBERKEIT_NOK,
	OGM_KC_SAUBERKEIT_NOK_RANK,
	OGM_KC_SAUBERKEIT_NOK_DENSE,
	OGM_KC_WARENFRISCHE_OG_FEST,
	OGM_KC_WARENFRISCHE_OG_GES,
	OGM_KC_WARENFRISCHE_OG_NOK,
	OGM_KC_WARENFRISCHE_OG_NOK_RANK,
	OGM_KC_WARENFRISCHE_OG_NOK_DENSE,
	OGM_KC_WARENFRISCHE_PFL_FEST,
	OGM_KC_WARENFRISCHE_PFL_GES,
	OGM_KC_WARENFRISCHE_PFL_NOK,
	OGM_KC_WARENFRISCHE_PFL_NOK_RANK,
	OGM_KC_WARENFRISCHE_PFL_NOK_DENSE,
	OGM_KC_WARENVERFUEGBARKEIT_FEST,
	OGM_KC_WARENVERFUEGBARKEIT_GES,
	OGM_KC_WARENVERFUEGBARKEIT_NOK,
	OGM_KC_WARENVERFUEGBARKEIT_NOK_RANK,
	OGM_KC_WARENVERFUEGBARKEIT_NOK_DENSE
) as 















WITH 

 wup AS ( 
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
			WHEN wup.mandant_id = 1 AND wup.wup_id IN (1263, 1273, 3166, 6623, 8120, 8563, 8940, 5876) THEN 1 
			WHEN wup.mandant_id = 3 AND wup.wup_id IN (1010)                                           THEN 1 
			WHEN wup.mandant_id = 7 AND wup.wup_id IN (1110, 1410, 6210, 6310, 6410)                   THEN 1 
			
			
			WHEN wup.mandant_id = 2 AND wup.wup_id IN (1700, 6800)                                     THEN 2 
			ELSE 0 END AS aus_fg
	FROM DBP_DATA.WUP wup
	WHERE wup.nb_id = 0 AND wup.dat_eroeffnung < '2090-12-31' 
	)


, zeit AS(
	SELECT zeit.gj 
		, zeit.akt_gj 
		, zeit.akt_gj + IFF(EXTRACT(MONTH FROM CURRENT_DATE - 1) = 3, 1, 0) AS akt_gj_mo 
		, zeit.kjmo 
		, zeit.kjmo_vj 
		, zeit.akt_mo 
		, zeit.min_dat 
		, zeit.max_dat 
	FROM DBP_DATA.MONAT zeit
	WHERE akt_gj_mo = 0 AND zeit.akt_mo < 0 
	)




SELECT vis.mandant_id
	, vis.nb_id
	, vis.vs_id
	, vis.wup_id
	, vis.wrg_id
	, vis.gj
	, vis.kjmo
	, vis.offen_ist AS OGM_offen
	
	, vishwg.ums_netto_ist AS OGM_ums_netto_ist
	, vishwg.ums_netto_vj  AS OGM_ums_netto_kvj
	, vishwg.ums_netto_ist / NULLIFZERO(vishwg.ums_netto_vj) AS OGM_ums_netto
	, RANK ()       OVER (PARTITION BY vis.mandant_id, vis.vs_id, vis.wrg_id, vis.kjmo ORDER BY OGM_ums_netto DESC NULLS LAST) AS OGM_ums_netto_rank
	, DENSE_RANK () OVER (PARTITION BY vis.mandant_id, vis.vs_id, vis.wrg_id, vis.kjmo ORDER BY OGM_ums_netto DESC NULLS LAST) AS OGM_ums_netto_dense
	
	, vis.ums_netto_fil_ist AS OGM_ums_netto_fil_ist
	, vis.ums_netto_fil_kvj AS OGM_ums_netto_fil_kvj
	, OGM_ums_netto_ist / NULLIFZERO(OGM_ums_netto_fil_ist)               AS OGM_umsatzanteil_netto_ist
	, OGM_ums_netto_kvj / NULLIFZERO(OGM_ums_netto_fil_kvj)               AS OGM_umsatzanteil_netto_kvj
	, OGM_umsatzanteil_netto_ist - NULLIFZERO(OGM_umsatzanteil_netto_kvj) AS OGM_umsatzanteil_netto
	, RANK ()       OVER (PARTITION BY vis.mandant_id, vis.vs_id, vis.wrg_id, vis.kjmo ORDER BY OGM_umsatzanteil_netto DESC NULLS LAST) AS OGM_umsatzanteil_netto_rank
	, DENSE_RANK () OVER (PARTITION BY vis.mandant_id, vis.vs_id, vis.wrg_id, vis.kjmo ORDER BY OGM_umsatzanteil_netto DESC NULLS LAST) AS OGM_umsatzanteil_netto_dense
	
	, visabs.abs_op_ist    AS OGM_abs_op_ist
	, planowg.abs_owg_plan AS OGM_abs_owg_plan
	, planowg.ums_owg_plan AS OGM_ums_owg_plan
	, OGM_abs_op_ist   / NULLIFZERO(OGM_ums_netto_ist)         AS OGM_abschrift_op_ist
	, OGM_abs_owg_plan / NULLIFZERO(OGM_ums_owg_plan)          AS OGM_abschrift_op_plan
	, OGM_abschrift_op_ist - NULLIFZERO(OGM_abschrift_op_plan) AS OGM_abschrift_op
	, RANK ()       OVER (PARTITION BY vis.mandant_id, vis.vs_id, vis.wrg_id, vis.kjmo ORDER BY OGM_abschrift_op DESC NULLS LAST) AS OGM_abschrift_op_rank
	, DENSE_RANK () OVER (PARTITION BY vis.mandant_id, vis.vs_id, vis.wrg_id, vis.kjmo ORDER BY OGM_abschrift_op DESC NULLS LAST) AS OGM_abschrift_op_dense
	
	, visabs.preisabs_ist AS OGM_preisabs_ist
	, OGM_preisabs_ist / NULLIFZERO(OGM_abs_op_ist) AS OGM_preisabs
	, RANK ()       OVER (PARTITION BY vis.mandant_id, vis.vs_id, vis.wrg_id, vis.kjmo ORDER BY OGM_preisabs DESC NULLS LAST) AS OGM_preisabs_rank
	, DENSE_RANK () OVER (PARTITION BY vis.mandant_id, vis.vs_id, vis.wrg_id, vis.kjmo ORDER BY OGM_preisabs DESC NULLS LAST) AS OGM_preisabs_dense
	
	, kunde_hwg.anzahl_kunden_ist AS OGM_anzahl_kunden_ist
	, kunde_hwg.anzahl_kunden_kvj AS OGM_anzahl_kunden_kvj
	, OGM_anzahl_kunden_ist / NULLIFZERO(OGM_anzahl_kunden_kvj) AS OGM_anzahl_kunden
	, RANK ()       OVER (PARTITION BY vis.mandant_id, vis.vs_id, vis.wrg_id, vis.kjmo ORDER BY OGM_anzahl_kunden DESC NULLS LAST) AS OGM_anzahl_kunden_rank
	, DENSE_RANK () OVER (PARTITION BY vis.mandant_id, vis.vs_id, vis.wrg_id, vis.kjmo ORDER BY OGM_anzahl_kunden DESC NULLS LAST) AS OGM_anzahl_kunden_dense
	
	, vis.anz_kunden_fil_ist AS OGM_anzahl_kunden_fil_ist
	, vis.anz_kunden_fil_kvj  AS OGM_anzahl_kunden_fil_kvj
	, OGM_anzahl_kunden_ist / NULLIFZERO(OGM_anzahl_kunden_fil_ist) AS OGM_kundenanteil_ist
	, OGM_anzahl_kunden_kvj / NULLIFZERO(OGM_anzahl_kunden_fil_kvj) AS OGM_kundenanteil_kvj
	, OGM_kundenanteil_ist - NULLIFZERO(OGM_kundenanteil_kvj)       AS OGM_kundenanteil
	, RANK ()       OVER (PARTITION BY vis.mandant_id, vis.vs_id, vis.wrg_id, vis.kjmo ORDER BY OGM_kundenanteil DESC NULLS LAST) AS OGM_kundenantiel_rank
	, DENSE_RANK () OVER (PARTITION BY vis.mandant_id, vis.vs_id, vis.wrg_id, vis.kjmo ORDER BY OGM_kundenanteil DESC NULLS LAST) AS OGM_kundenanteil_dense
	
	, inv.inventur_wert_netto AS OGM_inventur_wert_netto
	, inv.inventur_ums_netto  AS OGM_inventur_ums_netto
	, inv.inventur_wert_netto / NULLIFZERO(inv.inventur_ums_netto) AS OGM_inventur
	, RANK ()       OVER (PARTITION BY vis.mandant_id, vis.vs_id, vis.wrg_id, vis.kjmo ORDER BY OGM_inventur DESC NULLS LAST) AS OGM_inventur_rank
	, DENSE_RANK () OVER (PARTITION BY vis.mandant_id, vis.vs_id, vis.wrg_id, vis.kjmo ORDER BY OGM_inventur DESC NULLS LAST) AS OGM_inventur_dense
	
	, OGM_ums_netto_ist / NULLIFZERO(OGM_anzahl_kunden_ist) AS OGM_avg_bon_ist
	, OGM_ums_netto_kvj / NULLIFZERO(OGM_anzahl_kunden_kvj) AS OGM_avg_bon_kvj
	, OGM_avg_bon_ist   / NULLIFZERO(OGM_avg_bon_kvj)       AS OGM_avg_bon
	, RANK ()       OVER (PARTITION BY vis.mandant_id, vis.vs_id, vis.wrg_id, vis.kjmo ORDER BY OGM_avg_bon DESC NULLS LAST) AS OGM_avg_bon_rank
	, DENSE_RANK () OVER (PARTITION BY vis.mandant_id, vis.vs_id, vis.wrg_id, vis.kjmo ORDER BY OGM_avg_bon DESC NULLS LAST) AS OGM_avg_bon_dense
	
	, ueq.best_vor AS OGM_ueq_best_vor
	, ueq.best_man AS OGM_ueq_best_man
	, ueq.best_kor AS OGM_ueq_best_kor
	, (OGM_ueq_best_vor - OGM_ueq_best_kor) / (OGM_ueq_best_vor + OGM_ueq_best_man) AS OGM_ueq
	, RANK ()       OVER (PARTITION BY vis.mandant_id, vis.vs_id, vis.wrg_id, vis.kjmo ORDER BY OGM_ueq DESC NULLS LAST) AS OGM_ueq_rank
	, DENSE_RANK () OVER (PARTITION BY vis.mandant_id, vis.vs_id, vis.wrg_id, vis.kjmo ORDER BY OGM_ueq DESC NULLS LAST) AS OGM_ueq_dense
	
	, kmr.kmr_ergebnis_nok AS OGM_kmr_kc_og_ergebnis_nok
	, kmr.kmr_ergebnis_anz AS OGM_kmr_kc_og_ergebnis_anz
	, kmr.kmr_pruefung_anz AS OGM_kmr_kc_og_pruefung_anz
	, kmr.kmr_ergebnis_nok / NULLIFZERO(kmr.kmr_ergebnis_anz) AS OGM_kmr_kc_og_nok
	, RANK ()       OVER (PARTITION BY vis.mandant_id, vis.vs_id, vis.wrg_id, vis.kjmo ORDER BY OGM_kmr_kc_og_nok DESC NULLS LAST) AS OGM_kmr_kc_og_nok_rank
	, DENSE_RANK () OVER (PARTITION BY vis.mandant_id, vis.vs_id, vis.wrg_id, vis.kjmo ORDER BY OGM_kmr_kc_og_nok DESC NULLS LAST) AS OGM_kmr_kc_og_nok_dense
	
	, NULL AS OGM_kc_sauberkeit_fest
	, NULL AS OGM_kc_sauberkeit_ges
	, NULL AS OGM_kc_sauberkeit_nok
	, NULL AS OGM_kc_sauberkeit_nok_rank
	, NULL AS OGM_kc_sauberkeit_nok_dense
	, NULL AS OGM_kc_warenfrische_og_fest
	, NULL AS OGM_kc_warenfrische_og_ges
	, NULL AS OGM_kc_warenfrische_og_nok
	, NULL AS OGM_kc_warenfrische_og_nok_rank
	, NULL AS OGM_kc_warenfrische_og_nok_dense
	, NULL AS OGM_kc_warenfrische_pfl_fest
	, NULL AS OGM_kc_warenfrische_pfl_ges
	, NULL AS OGM_kc_warenfrische_pfl_nok
	, NULL AS OGM_kc_warenfrische_pfl_nok_rank
	, NULL AS OGM_kc_warenfrische_pfl_nok_dense
	, NULL AS OGM_kc_warenverfuegbarkeit_fest
	, NULL AS OGM_kc_warenverfuegbarkeit_ges
	, NULL AS OGM_kc_warenverfuegbarkeit_nok
	, NULL AS OGM_kc_warenverfuegbarkeit_nok_rank
	, NULL AS OGM_kc_warenverfuegbarkeit_nok_dense


FROM ( 
	SELECT vis0.mandant_id, vis0.nb_id, wup.vs_id, vis0.wrg_id
		, wup.aktuell_wup_id AS wup_id
		, vis0.gj, vis0.kjmo
		, SUM(vis0.anz_offen)     AS offen_ist
		, SUM(vis0.ums_netto)     AS ums_netto_fil_ist
		, SUM(vis0.ums_netto_kvj) AS ums_netto_fil_kvj
		, SUM(vis0.anz_kunde)     AS anz_kunden_fil_ist
		, SUM(vis0.anz_kunde_kvj) AS anz_kunden_fil_kvj
	FROM dbp_msi_data.vis_monat_ums_kunde_pers_wup vis0
	INNER JOIN zeit 
		ON zeit.kjmo = vis0.kjmo 
	INNER JOIN wup 
		ON wup.wup_id = vis0.wup_id AND wup.mandant_id = vis0.mandant_id
	WHERE wup.neo_gj < (zeit.gj - 1)   
		AND wup.stl_dat > zeit.max_dat 
		AND wup.aus_fg <> 1            
		AND NOT (wup.aus_fg = 2 AND zeit.kjmo BETWEEN 202409 AND 202602) 
	GROUP BY ALL
) vis 


LEFT OUTER JOIN ( 
	SELECT vis0.mandant_id, vis0.wrg_id
		, wup.aktuell_wup_id AS wup_id
		, vis0.kjmo
		, SUM(vis0.ums_netto)     AS ums_netto_ist
		, SUM(vis0.ums_netto_kvj) AS ums_netto_vj
	FROM dbp_msi_view_vis.MV_VIS_MONAT_FAKT_WG vis0
	JOIN dbp_msi_view_vis.MV_WG_INT	wg
		ON vis0.wg_id = wg.wg_id
	JOIN dbp_msi_view_vis.MV_OWG_INT owg
		ON wg.owg_id = owg.owg_id
	INNER JOIN zeit 
		ON zeit.kjmo = vis0.kjmo 
	INNER JOIN wup 
		ON wup.wup_id = vis0.wup_id AND wup.mandant_id = vis0.mandant_id
	WHERE wup.neo_gj < (zeit.gj - 1)   
		AND wup.stl_dat > zeit.max_dat 
		AND wup.aus_fg <> 1            
		AND NOT (wup.aus_fg = 2 AND zeit.kjmo BETWEEN 202409 AND 202602) 
		AND owg.hwg_id = 64 
	GROUP BY ALL
) vishwg
ON vishwg.wup_id = vis.wup_id AND vishwg.mandant_id = vis.mandant_id
AND vishwg.wrg_id = vis.wrg_id AND vishwg.kjmo = vis.kjmo


LEFT OUTER JOIN ( 
	SELECT vis0.mandant_id, vis0.wrg_id
		, wup.aktuell_wup_id AS wup_id
		, vis0.kjmo
		, SUM(CASE 
			WHEN vis0.mandant_id IN (6) AND vis0.abschriftart_id=2 THEN 1 
			WHEN vis0.mandant_id IN (3) AND vis0.abschriftart_id=11 THEN 1 
			WHEN vis0.mandant_id IN (2,4,5,7,8) AND vis0.abschriftart_id=7 THEN 1 
			WHEN vis0.mandant_id IN (2,5) AND vis0.abschriftart_id=10 THEN 1 
			WHEN vis0.mandant_id NOT IN (1) AND vis0.abschriftart_id=20 THEN 1 
			ELSE -1 END * vis0.abschrift_netto) AS abs_op_ist
		, SUM(CASE 
			WHEN vis0.mandant_id IN (6) AND abs_thema.abschriftart_thema_int_id = 4 AND vis0.abschriftart_id=2 THEN 1 
			WHEN vis0.mandant_id IN (3) AND abs_thema.abschriftart_thema_int_id = 4 AND vis0.abschriftart_id=11 THEN 1 
			WHEN vis0.mandant_id IN (2,4,5,7,8) AND abs_thema.abschriftart_thema_int_id = 4AND vis0.abschriftart_id=7 THEN 1 
			WHEN vis0.mandant_id IN (2,5) AND abs_thema.abschriftart_thema_int_id = 4 AND vis0.abschriftart_id=10 THEN 1 
			WHEN vis0.mandant_id NOT IN (1) AND abs_thema.abschriftart_thema_int_id = 4 AND vis0.abschriftart_id=20 THEN 1 
			WHEN abs_thema.abschriftart_thema_int_id = 4 THEN -1
			ELSE 0 END * vis0.abschrift_netto) AS preisabs_ist
	FROM dbp_msi_view_vis.MV_VIS_TAG_ABSCHRIFTEN_WG vis0
	JOIN dbp_msi_view_vis.MV_ABSCHRIFTART_INT_ZU abs_art
		ON abs_art.abschriftart_id = vis0.abschriftart_id AND abs_art.mandant_id = vis0.mandant_id 
	JOIN dbp_msi_view_vis.MV_ABSCHRIFTART_INT_THEMA_ZU abs_thema
		ON abs_thema.abschriftart_int_id = abs_art.abschriftart_int_id
	JOIN dbp_msi_view_vis.MV_WG_INT wg
		ON vis0.wg_id = wg.wg_id
	JOIN dbp_msi_view_vis.MV_OWG_INT owg
		ON wg.owg_id = owg.owg_id
	INNER JOIN zeit 
		ON zeit.kjmo = vis0.kjmo 
	INNER JOIN wup 
		ON wup.wup_id = vis0.wup_id AND wup.mandant_id = vis0.mandant_id
	WHERE wup.neo_gj < (zeit.gj - 1)   
		AND wup.stl_dat > zeit.max_dat 
		AND wup.aus_fg <> 1            
		AND NOT (wup.aus_fg = 2 AND zeit.kjmo BETWEEN 202409 AND 202602) 
		AND abs_thema.abschriftart_thema_int_id IN (1, 4) 
		AND owg.hwg_id = 64 
	GROUP BY ALL
) visabs
ON visabs.wup_id = vis.wup_id AND visabs.mandant_id = vis.mandant_id
AND visabs.wrg_id = vis.wrg_id AND visabs.kjmo = vis.kjmo


LEFT OUTER JOIN ( 
	SELECT vis0.mandant_id, vis0.wrg_id
		, wup.aktuell_wup_id AS wup_id
		, vis0.kjmo
		, SUM(vis0.abschriften_netto_operativ_plan) AS abs_owg_plan
		, SUM(vis0.umsatz_netto_plan) AS ums_owg_plan
	FROM dbp_msi_view_vis.mv_wup_plan_kjmo_owg vis0
	JOIN dbp_msi_view_vis.MV_OWG_INT owg
		ON vis0.owg_id = owg.owg_id
	INNER JOIN zeit 
		ON zeit.kjmo = vis0.kjmo 
	INNER JOIN wup 
		ON wup.wup_id = vis0.wup_id AND wup.mandant_id = vis0.mandant_id
	WHERE wup.neo_gj < (zeit.gj - 1)   
		AND wup.stl_dat > zeit.max_dat 
		AND wup.aus_fg <> 1            
		AND NOT (wup.aus_fg = 2 AND zeit.kjmo BETWEEN 202409 AND 202602) 
		AND owg.hwg_id = 64 
	GROUP BY ALL
) planowg
ON planowg.wup_id = vis.wup_id AND planowg.mandant_id = vis.mandant_id
AND planowg.wrg_id = vis.wrg_id AND planowg.kjmo = vis.kjmo


LEFT OUTER JOIN ( 
	SELECT vis0.mandant_id
	, wup.aktuell_wup_id AS wup_id
	, zeit.kjmo
	, SUM(vis0.anz_kunde_hwg)     AS anzahl_kunden_ist
	, SUM(vis0.anz_kunde_hwg_kvj) AS anzahl_kunden_kvj
	FROM dbp_msi_view_vis.MV_VIS_TAG_KUNDE_HWG vis0
	INNER JOIN dbp_msi_view_vis.MV_TAG zeit0
		ON zeit0.dat = vis0.dat
	INNER JOIN zeit 
		ON zeit.kjmo = zeit0.kjmo 
	INNER JOIN wup 
		ON wup.wup_id = vis0.wup_id AND wup.mandant_id = vis0.mandant_id
	WHERE wup.neo_gj < (zeit.gj - 1)   
		AND wup.stl_dat > zeit.max_dat 
		AND wup.aus_fg <> 1            
		AND NOT (wup.aus_fg = 2 AND zeit.kjmo BETWEEN 202409 AND 202602) 
		AND vis0.hwg_id = 64 
	GROUP BY ALL
) kunde_hwg
ON kunde_hwg.mandant_id = vis.mandant_id AND kunde_hwg.wup_id = vis.wup_id
AND kunde_hwg.kjmo = vis.kjmo


LEFT OUTER JOIN ( 
	SELECT vis0.mandant_id, vis0.wrg_id
		, wup.aktuell_wup_id AS wup_id
		, zeit.kjmo
		, SUM(vis0.inventur_wert_netto)  AS inventur_wert_netto
		, SUM(vis0.inventur_ums_netto)  AS inventur_ums_netto
	FROM dbp_msi_view_vis.MV_VIS_MONAT_HFM_INVENTUR vis0
	JOIN dbp_msi_view_vis.MV_OWG_INT owg
		ON vis0.owg_id = owg.owg_id
	JOIN dbp_msi_view_vis.MV_TAG zeit0
		ON zeit0.dat = vis0.dat_plan_zaehlung 
	INNER JOIN zeit 
		ON zeit.kjmo = zeit0.kjmo
	INNER JOIN wup 
		ON wup.wup_id = vis0.wup_id AND wup.mandant_id = vis0.mandant_id
	WHERE wup.neo_gj < (zeit.gj - 1)    
		AND wup.stl_dat > zeit.max_dat  
		AND wup.aus_fg <> 1             
		AND NOT (wup.aus_fg = 2 AND zeit.kjmo BETWEEN 202409 AND 202602) 
		AND vis0.hwg_id = 64                                             
		AND vis0.inventurart_int_id = 7 
	GROUP BY ALL
) inv
ON inv.mandant_id = vis.mandant_id AND inv.wup_id = vis.wup_id
AND inv.wrg_id = vis.wrg_id AND inv.kjmo = vis.kjmo


LEFT OUTER JOIN ( 
	SELECT vis0.mandant_id
		, wup.aktuell_wup_id AS wup_id
		, zeit.kjmo
		, SUM(CASE WHEN vis0.status NOT IN ('0B','0N')  THEN 1 ELSE 0 END) AS best_vor 
		, SUM(CASE WHEN vis0.status IN ('0B')           THEN 1 ELSE 0 END) AS best_man 
		, SUM(CASE WHEN vis0.status IN ('V0','V-','V+') THEN 1 ELSE 0 END) AS best_kor 
	FROM dbp_msi_view_vis.MV_BSCH_BESTVOR_DET vis0
	JOIN dbp_msi_view_vis.MV_ART_WG_ZU art
	ON vis0.art_id = art.art_id AND vis0.mandant_id = art.mandant_id
	JOIN dbp_msi_view_vis.MV_WG_INT	wg
	ON art.wg_id = wg.wg_id
	JOIN dbp_msi_view_vis.MV_OWG_INT owg
		ON wg.owg_id = owg.owg_id
	JOIN dbp_msi_view_vis.MV_TAG zeit0
		ON zeit0.dat = vis0.dat_plan
	INNER JOIN zeit 
		ON zeit.kjmo = zeit0.kjmo 
	INNER JOIN wup 
		ON wup.wup_id = vis0.wup_id AND wup.mandant_id = vis0.mandant_id 
	WHERE wup.neo_gj < (zeit.gj - 1)   
		AND wup.stl_dat > zeit.max_dat 
		AND wup.aus_fg <> 1            
		AND NOT (wup.aus_fg = 2 AND zeit.kjmo BETWEEN 202409 AND 202602) 
		AND owg.hwg_id = 64 
		AND vis0.status NOT IN ('0N')
	GROUP BY ALL 
) ueq
ON ueq.mandant_id = vis.mandant_id AND ueq.wup_id = vis.wup_id 
AND ueq.kjmo = vis.kjmo


LEFT OUTER JOIN ( 
	SELECT wup.mandant_id
		, wup.aktuell_wup_id AS wup_id
		, zeit.kjmo 
		, SUM(CASE WHEN wup.mandant_id <> 1 AND kmr_frg.ergebnis_num =  1 THEN 1 ELSE 0 END) AS kmr_ergebnis_nok 
		, SUM(CASE WHEN wup.mandant_id <> 1 AND kmr_frg.ergebnis_num >= 0 THEN 1 ELSE 0 END) AS kmr_ergebnis_anz 
		, COUNT(DISTINCT CASE WHEN wup.mandant_id <> 1 THEN kmr_kap.pruefung_id  ELSE 0 END) AS kmr_pruefung_anz 
	FROM DBP_VIEW.V_KMR_FRAGE kmr_frg
	INNER JOIN DBP_VIEW.V_KMR_PRUEFPROGRAMM_KAPITEL kmr_kap
		ON kmr_kap.kapitel_id = kmr_frg.kapitel_id AND kmr_kap.amx_system_id = kmr_frg.amx_system_id
	INNER JOIN DBP_VIEW.V_KMR_PRUEFUNG kmr_prf
		ON kmr_prf.pruefung_id = kmr_kap.pruefung_id AND kmr_prf.amx_system_id = kmr_kap.amx_system_id
	INNER JOIN DBP_VIEW.V_KMR_L_ORGANISATIONSEINHEIT kmr_loe
		ON kmr_loe.orga_einheit_id = kmr_prf.gepr_oe_id AND kmr_loe.amx_system_id = kmr_prf.amx_system_id
	INNER JOIN DBP_DATA.TAG zeit0
		ON zeit0.dat = kmr_prf.dat_pruef_zeitraum_bis
	INNER JOIN zeit 
		ON zeit.kjmo = zeit0.kjmo 
	INNER JOIN wup 
		ON wup.wup_id = kmr_loe.wup_id AND wup.mandant_id = kmr_loe.mandant_id 
	WHERE wup.neo_gj < (zeit.gj - 1)   
		AND wup.stl_dat > zeit.max_dat 
		AND wup.aus_fg <> 1            
		AND NOT (wup.aus_fg = 2 AND zeit.kjmo BETWEEN 202409 AND 202602) 
		AND kmr_frg.amx_system_id = 1                      
		AND kmr_prf.pruefung_klasse_id IN (100003)         
		AND kmr_prf.pruefung_status_id IN (100005, 100041) 
		AND TRY_TO_NUMBER(SUBSTR(kmr_frg.sort_nr, 14, 2)) IN (5) 
	GROUP BY ALL
) kmr
ON kmr.mandant_id = vis.mandant_id AND kmr.wup_id = vis.wup_id 
AND kmr.kjmo = vis.kjmo
;
