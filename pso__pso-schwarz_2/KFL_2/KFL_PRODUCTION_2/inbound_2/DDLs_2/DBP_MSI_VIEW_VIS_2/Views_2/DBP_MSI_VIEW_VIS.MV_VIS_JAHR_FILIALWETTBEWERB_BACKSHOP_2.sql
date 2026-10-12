create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_VIS.MV_VIS_JAHR_FILIALWETTBEWERB_BACKSHOP_2(
	MANDANT_ID,
	NB_ID,
	VS_ID,
	WUP_ID,
	WRG_ID,
	GJ,
	BSJ_KJMO,
	BSJ_OFFEN,
	BSJ_UMS_NETTO_IST,
	BSJ_UMS_NETTO_KVJ,
	BSJ_UMS_NETTO,
	BSJ_UMS_NETTO_RANK,
	BSJ_UMS_NETTO_DENSE,
	BSJ_UMS_NETTO_FIL_IST,
	BSJ_UMS_NETTO_FIL_KVJ,
	BSJ_UMSATZANTEIL_NETTO_IST,
	BSJ_UMSATZANTEIL_NETTO_KVJ,
	BSJ_UMSATZANTEIL_NETTO,
	BSJ_UMSATZANTEIL_NETTO_RANK,
	BSJ_UMSATZANTEIL_NETTO_DENSE,
	BSJ_ABS_OP_IST,
	BSJ_ABS_OWG_PLAN,
	BSJ_UMS_OWG_PLAN,
	BSJ_ABSCHRIFT_OP_IST,
	BSJ_ABSCHRIFT_OP_PLAN,
	BSJ_ABSCHRIFT_OP,
	BSJ_ABSCHRIFT_OP_RANK,
	BSJ_ABSCHRIFT_OP_DENSE,
	BSJ_ANZAHL_KUNDEN_IST,
	BSJ_ANZAHL_KUNDEN_KVJ,
	BSJ_ANZAHL_KUNDEN,
	BSJ_ANZAHL_KUNDEN_RANK,
	BSJ_ANZAHL_KUNDEN_DENSE,
	BSJ_ANZAHL_KUNDEN_FIL_IST,
	BSJ_ANZAHL_KUNDEN_FIL_KVJ,
	BSJ_KUNDENANTEIL_IST,
	BSJ_KUNDENANTEIL_KVJ,
	BSJ_KUNDENANTEIL,
	BSJ_KUNDENANTEIL_RANK,
	BSJ_KUNDENANTEIL_DENSE,
	BSJ_KMR_KC_BS_ERGEBNIS_NOK,
	BSJ_KMR_KC_BS_ERGEBNIS_ANZ,
	BSJ_KMR_KC_BS_PRUEFUNG_ANZ,
	BSJ_KMR_KC_BS_NOK,
	BSJ_KMR_KC_BS_NOK_RANK,
	BSJ_KMR_KC_BS_NOK_DENSE,
	BSJ_INVENTUR_WERT_NETTO,
	BSJ_INVENTUR_UMS_NETTO,
	BSJ_INVENTUR,
	BSJ_INVENTUR_RANK,
	BSJ_INVENTUR_DENSE,
	BSJ_MENGE_IST,
	BSJ_MENGE_KVJ,
	BSJ_MENGE,
	BSJ_MENGE_RANK,
	BSJ_MENGE_DENSE,
	BSJ_UEQ_BEST_VOR,
	BSJ_UEQ_BEST_MAN,
	BSJ_UEQ_BEST_KOR,
	BSJ_UEQ,
	BSJ_UEQ_RANK,
	BSJ_UEQ_DENSE
) as 










WITH 

 wup_2 AS ( 
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
			
			
			WHEN wup.mandant_id = 1 AND wup.wup_id IN (2380)                                           THEN 1 
		
			WHEN wup.mandant_id = 2 AND wup.wup_id IN (1700, 6800)                                     THEN 2 
			ELSE 0 END AS aus_fg
	FROM DBP_DATA.WUP_2 wup_2
	WHERE wup.nb_id = 0 AND wup.dat_eroeffnung < '2090-12-31' 
	)


, zeit_2 AS(
	SELECT zeit.gj 
		, zeit.akt_gj 
		, zeit.akt_gj + IFF(EXTRACT(MONTH FROM CURRENT_DATE - 1) = 3, 1, 0) AS akt_gj_mo 
		, zeit.kjmo 
		, zeit.kjmo_vj 
		, zeit.akt_mo 
		, zeit.min_dat 
		, zeit.max_dat 
	FROM DBP_DATA.MONAT_2 zeit_2
	WHERE akt_gj_mo = 0 AND zeit.akt_mo < 0 
	)




SELECT vis.mandant_id
	, vis.nb_id
	, vis.vs_id
	, vis.wup_id
	, vis.wrg_id
	, vis.gj
	, vis.kjmo_max  AS BSJ_KJMO
	, vis.offen_ist AS BSJ_offen
	
	, vishwg.ums_netto_ist AS BSJ_ums_netto_ist
	, vishwg.ums_netto_kvj AS BSJ_ums_netto_kvj
	, BSJ_ums_netto_ist / NULLIFZERO(BSJ_ums_netto_kvj) AS BSJ_ums_netto
	, RANK ()       OVER (PARTITION BY vis.mandant_id, vis.vs_id, vis.wrg_id, vis.gj ORDER BY BSJ_ums_netto DESC NULLS LAST) AS BSJ_ums_netto_rank
	, DENSE_RANK () OVER (PARTITION BY vis.mandant_id, vis.vs_id, vis.wrg_id, vis.gj ORDER BY BSJ_ums_netto DESC NULLS LAST) AS BSJ_ums_netto_dense
	
	, vis.ums_netto_fil_ist AS BSJ_ums_netto_fil_ist
	, vis.ums_netto_fil_kvj AS BSJ_ums_netto_fil_kvj
	, BSJ_ums_netto_ist / NULLIFZERO(BSJ_ums_netto_fil_ist) AS BSJ_umsatzanteil_netto_ist
	, BSJ_ums_netto_kvj / NULLIFZERO(BSJ_ums_netto_fil_kvj) AS BSJ_umsatzanteil_netto_kvj
	, BSJ_umsatzanteil_netto_ist - NULLIFZERO(BSJ_umsatzanteil_netto_kvj) AS BSJ_umsatzanteil_netto
	, RANK ()       OVER (PARTITION BY vis.mandant_id, vis.vs_id, vis.wrg_id, vis.gj ORDER BY BSJ_umsatzanteil_netto DESC NULLS LAST) AS BSJ_umsatzanteil_netto_rank
	, DENSE_RANK () OVER (PARTITION BY vis.mandant_id, vis.vs_id, vis.wrg_id, vis.gj ORDER BY BSJ_umsatzanteil_netto DESC NULLS LAST) AS BSJ_umsatzanteil_netto_dense
	
	, visabs.abs_op_ist    AS BSJ_abs_op_ist
	, planowg.abs_owg_plan AS BSJ_abs_owg_plan
	, planowg.ums_owg_plan AS BSJ_ums_owg_plan
	, BSJ_abs_op_ist   / NULLIFZERO(BSJ_ums_netto_ist) AS BSJ_abschrift_op_ist
	, BSJ_abs_owg_plan / NULLIFZERO(BSJ_ums_owg_plan)  AS BSJ_abschrift_op_plan
	, BSJ_abschrift_op_ist - NULLIFZERO(BSJ_abschrift_op_plan) AS BSJ_abschrift_op
	, RANK ()       OVER (PARTITION BY vis.mandant_id, vis.vs_id, vis.wrg_id, vis.gj ORDER BY BSJ_abschrift_op DESC NULLS LAST) AS BSJ_abschrift_op_rank
	, DENSE_RANK () OVER (PARTITION BY vis.mandant_id, vis.vs_id, vis.wrg_id, vis.gj ORDER BY BSJ_abschrift_op DESC NULLS LAST) AS BSJ_abschrift_op_dense
	
	, kunde_hwg.anzahl_kunden_ist AS BSJ_anzahl_kunden_ist
	, kunde_hwg.anzahl_kunden_kvj AS BSJ_anzahl_kunden_kvj
	, BSJ_anzahl_kunden_ist / NULLIFZERO(BSJ_anzahl_kunden_kvj) AS BSJ_anzahl_kunden
	, RANK ()       OVER (PARTITION BY vis.mandant_id, vis.vs_id, vis.wrg_id, vis.gj ORDER BY BSJ_anzahl_kunden DESC NULLS LAST) AS BSJ_anzahl_kunden_rank
	, DENSE_RANK () OVER (PARTITION BY vis.mandant_id, vis.vs_id, vis.wrg_id, vis.gj ORDER BY BSJ_anzahl_kunden DESC NULLS LAST) AS BSJ_anzahl_kunden_dense
	
	, vis.anz_kunden_fil_ist AS BSJ_anzahl_kunden_fil_ist
	, vis.anz_kunden_fil_kvj  AS BSJ_anzahl_kunden_fil_kvj
	, BSJ_anzahl_kunden_ist / NULLIFZERO(BSJ_anzahl_kunden_fil_ist) AS BSJ_kundenanteil_ist
	, BSJ_anzahl_kunden_kvj / NULLIFZERO(BSJ_anzahl_kunden_fil_kvj) AS BSJ_kundenanteil_kvj
	, BSJ_kundenanteil_ist - NULLIFZERO(BSJ_kundenanteil_kvj)       AS BSJ_kundenanteil
	, RANK ()       OVER (PARTITION BY vis.mandant_id, vis.vs_id, vis.wrg_id, vis.gj ORDER BY BSJ_kundenanteil DESC NULLS LAST) AS BSJ_kundenantiel_rank
	, DENSE_RANK () OVER (PARTITION BY vis.mandant_id, vis.vs_id, vis.wrg_id, vis.gj ORDER BY BSJ_kundenanteil DESC NULLS LAST) AS BSJ_kundenanteil_dense
	
	, kmr.kmr_ergebnis_nok AS BSJ_kmr_kc_bs_ergebnis_nok
	, kmr.kmr_ergebnis_anz AS BSJ_kmr_kc_bs_ergebnis_anz
	, kmr.kmr_pruefung_anz AS BSJ_kmr_kc_bs_pruefung_anz
	, BSJ_kmr_kc_bs_ergebnis_nok / NULLIFZERO(BSJ_kmr_kc_bs_ergebnis_anz) AS BSJ_kmr_kc_bs_nok
	, RANK ()       OVER (PARTITION BY vis.mandant_id, vis.vs_id, vis.wrg_id, vis.gj ORDER BY BSJ_kmr_kc_bs_nok ASC NULLS LAST) AS BSJ_kmr_kc_bs_nok_rank
	, DENSE_RANK () OVER (PARTITION BY vis.mandant_id, vis.vs_id, vis.wrg_id, vis.gj ORDER BY BSJ_kmr_kc_bs_nok ASC NULLS LAST) AS BSJ_kmr_kc_bs_nok_dense
	
	, inv.inventur_wert_netto AS BSJ_inventur_wert_netto
	, inv.inventur_ums_netto  AS BSJ_inventur_ums_netto
	, BSJ_inventur_wert_netto / NULLIFZERO(BSJ_inventur_ums_netto) AS BSJ_inventur
	, RANK ()       OVER (PARTITION BY vis.mandant_id, vis.vs_id, vis.wrg_id, vis.gj ORDER BY BSJ_inventur DESC NULLS LAST) AS BSJ_inventur_rank
	, DENSE_RANK () OVER (PARTITION BY vis.mandant_id, vis.vs_id, vis.wrg_id, vis.gj ORDER BY BSJ_inventur DESC NULLS LAST) AS BSJ_inventur_dense
	
	, vishwg.menge_ist AS BSJ_menge_ist
	, vishwg.menge_kvj AS BSJ_menge_kvj
	, BSJ_menge_ist / NULLIFZERO(BSJ_menge_kvj) AS BSJ_menge
	, RANK ()       OVER (PARTITION BY vis.mandant_id, vis.vs_id, vis.wrg_id, vis.gj ORDER BY BSJ_menge DESC NULLS LAST) AS BSJ_menge_rank
	, DENSE_RANK () OVER (PARTITION BY vis.mandant_id, vis.vs_id, vis.wrg_id, vis.gj ORDER BY BSJ_menge DESC NULLS LAST) AS BSJ_menge_dense
	
	, ueq.best_vor AS BSJ_ueq_best_vor
	, ueq.best_man AS BSJ_ueq_best_man
	, ueq.best_kor AS BSJ_ueq_best_kor
	, (BSJ_ueq_best_vor - BSJ_ueq_best_kor) / (BSJ_ueq_best_vor + BSJ_ueq_best_man) AS BSJ_ueq
	, RANK       () OVER (PARTITION BY vis.mandant_id, vis.vs_id, vis.wrg_id, vis.gj ORDER BY BSJ_ueq DESC NULLS LAST) AS BSJ_ueq_rank
	, DENSE_RANK () OVER (PARTITION BY vis.mandant_id, vis.vs_id, vis.wrg_id, vis.gj ORDER BY BSJ_ueq DESC NULLS LAST) AS BSJ_ueq_dense


FROM ( 
	SELECT vis0.mandant_id
		, vis0.nb_id
		, wup.vs_id
		, wup.aktuell_wup_id AS wup_id
		, vis0.wrg_id
		, zeit.gj
		, MAX(zeit.kjmo)          AS kjmo_max
		, SUM(vis0.anz_offen)     AS offen_ist
		, SUM(vis0.ums_netto)     AS ums_netto_fil_ist
		, SUM(vis0.ums_netto_kvj) AS ums_netto_fil_kvj
		, SUM(vis0.anz_kunde)     AS anz_kunden_fil_ist
		, SUM(vis0.anz_kunde_kvj) AS anz_kunden_fil_kvj
	FROM dbp_msi_data.vis_monat_ums_kunde_pers_wup_2 vis0
	INNER JOIN zeit_2 
		ON zeit.kjmo = vis0.kjmo 
	INNER JOIN wup_2 
		ON wup.wup_id = vis0.wup_id AND wup.mandant_id = vis0.mandant_id
	WHERE wup.neo_gj < (zeit.gj - 1)   
		AND wup.stl_dat > zeit.max_dat 
		AND wup.aus_fg = 0             
	GROUP BY ALL
) vis 


LEFT OUTER JOIN ( 
	SELECT vis0.mandant_id
		, wup.aktuell_wup_id AS wup_id
		, vis0.wrg_id
		, zeit.gj
		, SUM(vis0.ums_netto)     AS ums_netto_ist
		, SUM(vis0.ums_netto_kvj) AS ums_netto_kvj
		, SUM(vis0.menge)     AS menge_ist
		, SUM(vis0.menge_kvj) AS menge_kvj
	FROM dbp_msi_view_vis.MV_VIS_MONAT_FAKT_WG_2 vis0
	JOIN dbp_msi_view_vis.MV_WG_INT_2	wg
		ON vis0.wg_id = wg.wg_id
	JOIN dbp_msi_view_vis.MV_OWG_INT_2 owg
		ON wg.owg_id = owg.owg_id
	INNER JOIN zeit_2 
		ON zeit.kjmo = vis0.kjmo 
	INNER JOIN wup_2 
		ON wup.wup_id = vis0.wup_id AND wup.mandant_id = vis0.mandant_id
	WHERE wup.neo_gj < (zeit.gj - 1)   
		AND wup.stl_dat > zeit.max_dat 
		AND wup.aus_fg = 0             
		AND owg.hwg_id = 62            
	GROUP BY ALL
) vishwg
ON vishwg.wup_id = vis.wup_id AND vishwg.mandant_id = vis.mandant_id AND vishwg.gj = vis.gj
AND vishwg.wrg_id = vis.wrg_id


LEFT OUTER JOIN ( 
	SELECT vis0.mandant_id
		, vis0.wrg_id
		, wup.aktuell_wup_id AS wup_id
		, zeit.gj
		, SUM(CASE 
			WHEN vis0.mandant_id IN (6) AND vis0.abschriftart_id=2 THEN 1 
			WHEN vis0.mandant_id IN (3) AND vis0.abschriftart_id=11 THEN 1 
			WHEN vis0.mandant_id IN (2,4,5,7,8) AND vis0.abschriftart_id=7 THEN 1 
			WHEN vis0.mandant_id IN (2,5) AND vis0.abschriftart_id=10 THEN 1 
			WHEN vis0.mandant_id NOT IN (1) AND vis0.abschriftart_id=20 THEN 1 
			ELSE -1 END * vis0.abschrift_netto) AS abs_op_ist
		, SUM(CASE 
			WHEN vis0.mandant_id IN (6) AND vis0.abschriftart_id=2 THEN 1 
			WHEN vis0.mandant_id IN (3) AND vis0.abschriftart_id=11 THEN 1 
			WHEN vis0.mandant_id IN (2,4,5,7,8) AND vis0.abschriftart_id=7 THEN 1 
			WHEN vis0.mandant_id IN (2,5) AND vis0.abschriftart_id=10 THEN 1 
			WHEN vis0.mandant_id NOT IN (1) AND vis0.abschriftart_id=20 THEN 1 
			ELSE -1 END * vis0.abschrift_netto_kvj) AS abs_op_vj
	FROM dbp_msi_view_vis.MV_VIS_TAG_ABSCHRIFTEN_WG_2	vis0
	JOIN dbp_msi_view_vis.MV_ABSCHRIFTART_INT_ZU_2 abs_art
		ON abs_art.abschriftart_id = vis0.abschriftart_id AND abs_art.mandant_id = vis0.mandant_id 
	JOIN dbp_msi_view_vis.MV_ABSCHRIFTART_INT_THEMA_ZU_2 abs_thema
		ON abs_thema.abschriftart_int_id = abs_art.abschriftart_int_id
	JOIN dbp_msi_view_vis.MV_WG_INT_2 wg
		ON vis0.wg_id = wg.wg_id
	JOIN dbp_msi_view_vis.MV_OWG_INT_2 owg
		ON wg.owg_id = owg.owg_id
	INNER JOIN zeit_2 
		ON zeit.kjmo = vis0.kjmo 
	INNER JOIN wup_2 
		ON wup.wup_id = vis0.wup_id AND wup.mandant_id = vis0.mandant_id 
	WHERE wup.neo_gj < (zeit.gj - 1)   
		AND wup.stl_dat > zeit.max_dat 
		AND wup.aus_fg = 0             
		AND owg.hwg_id = 62            
		AND abs_thema.abschriftart_thema_int_id IN (1, 4)  
	GROUP BY ALL
) visabs
ON visabs.wup_id = vis.wup_id AND visabs.mandant_id = vis.mandant_id AND visabs.gj = vis.gj
AND visabs.wrg_id = vis.wrg_id


LEFT OUTER JOIN ( 
	SELECT vis0.mandant_id
		, vis0.wrg_id
		, wup.aktuell_wup_id AS wup_id
		, zeit.gj
		, SUM(vis0.abschriften_netto_operativ_plan) AS abs_owg_plan
		, SUM(vis0.umsatz_netto_plan) AS ums_owg_plan
	FROM dbp_msi_view_vis.mv_wup_plan_kjmo_owg_2 vis0
	JOIN dbp_msi_view_vis.MV_OWG_INT_2 owg
		ON vis0.owg_id = owg.owg_id
	INNER JOIN zeit_2 
		ON zeit.kjmo = vis0.kjmo 
	INNER JOIN wup_2 
		ON wup.wup_id = vis0.wup_id AND wup.mandant_id = vis0.mandant_id 
	WHERE wup.neo_gj < (zeit.gj - 1)   
		AND wup.stl_dat > zeit.max_dat 
		AND wup.aus_fg = 0             
		AND owg.hwg_id = 62            
	GROUP BY ALL
) planowg
ON planowg.wup_id = vis.wup_id AND planowg.mandant_id = vis.mandant_id AND planowg.gj = vis.gj
AND planowg.wrg_id = vis.wrg_id


LEFT OUTER JOIN ( 
	SELECT vis0.mandant_id
		, wup.aktuell_wup_id AS wup_id
		, zeit.gj
		, SUM(vis0.anz_kunde_hwg)     AS anzahl_kunden_ist
		, SUM(vis0.anz_kunde_hwg_kvj) AS anzahl_kunden_kvj
	FROM dbp_msi_view_vis.MV_VIS_TAG_KUNDE_HWG_2 vis0
	INNER JOIN dbp_msi_view_vis.MV_TAG_2 zeit0
		ON zeit0.dat = vis0.dat
	INNER JOIN zeit_2 
		ON zeit.kjmo = zeit0.kjmo 
	INNER JOIN wup_2 
		ON wup.wup_id = vis0.wup_id AND wup.mandant_id = vis0.mandant_id 
	WHERE wup.neo_gj < (zeit.gj - 1)   
		AND wup.stl_dat > zeit.max_dat 
		AND wup.aus_fg = 0             
		AND vis0.hwg_id = 62           
	GROUP BY ALL
) kunde_hwg
ON kunde_hwg.mandant_id = vis.mandant_id AND kunde_hwg.wup_id = vis.wup_id AND kunde_hwg.gj = vis.gj


LEFT OUTER JOIN ( 
	SELECT vis0.mandant_id
		, wup.aktuell_wup_id AS wup_id
		, vis0.wrg_id
		, zeit.gj
		, SUM(vis0.inventur_wert_netto) AS inventur_wert_netto
		, SUM(vis0.inventur_ums_netto)  AS inventur_ums_netto
	FROM dbp_msi_view_vis.MV_VIS_MONAT_HFM_INVENTUR_2 vis0
	JOIN dbp_msi_view_vis.MV_OWG_INT_2 owg
		ON vis0.owg_id = owg.owg_id
	JOIN dbp_msi_view_vis.MV_TAG_2 zeit0
		ON zeit0.dat = vis0.dat_plan_zaehlung
	INNER JOIN zeit_2 
		ON zeit.kjmo = zeit0.kjmo 
	INNER JOIN wup_2 
		ON wup.wup_id = vis0.wup_id AND wup.mandant_id = vis0.mandant_id 
	WHERE wup.neo_gj < (zeit.gj - 1)    
		AND wup.stl_dat > zeit.max_dat  
		AND wup.aus_fg = 0              
		AND owg.hwg_id = 62             
		AND vis0.inventurart_int_id = 7 
	GROUP BY ALL 
) inv
ON inv.mandant_id = vis.mandant_id AND inv.wup_id = vis.wup_id AND inv.gj = vis.gj
AND inv.wrg_id = vis.wrg_id 


LEFT OUTER JOIN ( 
	SELECT vis0.mandant_id
		, wup.aktuell_wup_id AS wup_id
		, zeit.gj
		, SUM(CASE WHEN vis0.status_2 NOT IN ('0B','0N')  THEN 1 ELSE 0 END) AS best_vor 
		, SUM(CASE WHEN vis0.status_2 IN ('0B')           THEN 1 ELSE 0 END) AS best_man 
		, SUM(CASE WHEN vis0.status_2 IN ('V0','V-','V+') THEN 1 ELSE 0 END) AS best_kor 
	FROM dbp_msi_view_vis.MV_BSCH_BESTVOR_DET_2 vis0
	JOIN dbp_msi_view_vis.MV_ART_WG_ZU_2 art_2
		ON vis0.art_id = art.art_id AND vis0.mandant_id = art.mandant_id
	JOIN dbp_msi_view_vis.MV_WG_INT_2 wg
		ON art.wg_id = wg.wg_id
	JOIN dbp_msi_view_vis.MV_OWG_INT_2 owg
		ON wg.owg_id = owg.owg_id
	JOIN dbp_msi_view_vis.MV_TAG_2 zeit0
		ON zeit0.dat = vis0.dat_plan
	INNER JOIN zeit_2 
		ON zeit.kjmo = zeit0.kjmo 
	INNER JOIN wup_2 
		ON wup.wup_id = vis0.wup_id AND wup.mandant_id = vis0.mandant_id 
	WHERE wup.neo_gj < (zeit.gj - 1)   
		AND wup.stl_dat > zeit.max_dat 
		AND wup.aus_fg = 0             
		AND owg.hwg_id = 62            
		AND vis0.status_2 NOT IN ('0N')
	GROUP BY ALL 
) ueq
ON ueq.mandant_id = vis.mandant_id AND ueq.wup_id = vis.wup_id AND ueq.gj = vis.gj


LEFT OUTER JOIN (  
	SELECT wup.mandant_id
		, wup.aktuell_wup_id AS wup_id
		, zeit.gj 
		, SUM(CASE WHEN wup.mandant_id <> 1 AND kmr_frg.ergebnis_num =  1 THEN 1 ELSE 0 END) AS kmr_ergebnis_nok 
		, SUM(CASE WHEN wup.mandant_id <> 1 AND kmr_frg.ergebnis_num >= 0 THEN 1 ELSE 0 END) AS kmr_ergebnis_anz 
		, COUNT(DISTINCT CASE WHEN wup.mandant_id <> 1 THEN kmr_kap.pruefung_id ELSE 0 END) AS kmr_pruefung_anz 
	FROM DBP_VIEW.V_KMR_FRAGE_2 kmr_frg
	INNER JOIN DBP_VIEW.V_KMR_PRUEFPROGRAMM_KAPITEL_2 kmr_kap
		ON kmr_kap.kapitel_id = kmr_frg.kapitel_id AND kmr_kap.amx_system_id = kmr_frg.amx_system_id
	INNER JOIN DBP_VIEW.V_KMR_PRUEFUNG_2 kmr_prf
		ON kmr_prf.pruefung_id = kmr_kap.pruefung_id AND kmr_prf.amx_system_id = kmr_kap.amx_system_id
	INNER JOIN DBP_VIEW.V_KMR_L_ORGANISATIONSEINHEIT_2 kmr_loe
		ON kmr_loe.orga_einheit_id = kmr_prf.gepr_oe_id AND kmr_loe.amx_system_id = kmr_prf.amx_system_id
	INNER JOIN DBP_DATA.TAG_2 zeit0
		ON zeit0.dat = kmr_prf.dat_pruef_zeitraum_bis
	INNER JOIN zeit_2 
		ON zeit.kjmo = zeit0.kjmo 
	INNER JOIN wup_2 
		ON wup.wup_id = kmr_loe.wup_id AND wup.mandant_id = kmr_loe.mandant_id 
	WHERE wup.neo_gj < (zeit.gj - 1)   
		AND wup.stl_dat > zeit.max_dat 
		AND wup.aus_fg = 0             
		AND kmr_frg.amx_system_id = 1                      
		AND kmr_prf.pruefung_klasse_id IN (100003)         
		AND kmr_prf.pruefung_status_id IN (100005, 100041) 
		AND TRY_TO_NUMBER(SUBSTR(kmr_frg.sort_nr, 14, 2)) IN (15) 
	GROUP BY ALL
) kmr
ON kmr.mandant_id = vis.mandant_id AND kmr.wup_id = vis.wup_id AND kmr.gj = vis.gj
;
