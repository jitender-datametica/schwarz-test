CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_VIS_VTR_FAKT_MONAT_2(
	VTR_ID,
	MANDANT_ID,
	NB_ID,
	VS_ID,
	VKL_ID,
	WUP_ID,
	WRG_ID,
	GJ,
	KJMO,
	FILIST,
	FILIST2,
	FILKVJ,
	FILKVJ2,
	FILPLAN,
	FILPLAN2,
	REGIST,
	REGIST2,
	REGKVJ,
	REGKVJ2,
	LANDIST,
	LANDIST2,
	LANDKVJ,
	LANDKVJ2,
	FILMO_RANG,
	FILGJ_RANG,
	VKLMO_RANG,
	VKLGJ_RANG,
	FILMO_WERT,
	FILGJ_WERT,
	VKLMO_WERT,
	VKLGJ_WERT
) AS 

/*
	FAKT DENORM : VT Ranking + Details pro Monat_2 
	Filiale IST/VJ/Plan + Referenz Region_2/Land_2 + Ranking Filiale/VKL_2 pro Monat_2/GJ 
	2023-08-01 ssch0611 : Initial als MV_VIS_VTR_FAKT_2 [AP0176993]
	2025-02-10 ssch0611 : Review 2025. Komplett neu erstellt (CTE). Neue Metriken [AP0237182] 
	2025-02-24 ssch0611 : Fixes (Kunden, Delta %p, BIG, Ø Kuga, Inventur_2) Filter Schließungen (2GJ) [AP0237182] 
	2025-02-25 ssch0611 : Rang Null/Minusquote = ASC! [AP0237182] 
	2025-03-31 ssch0611 : Fixed: Bestandentw Rang ASC  [AP0237182] 
	2025-04-02 ssch0611 : Umstellung Scans/min (KPOS) [AP0264011]
	2025-03-31 ssch0611 : Fixed: K Card Rang VKL_GJ [AP0237182] 
*/


/* CTE */


WITH 
/* Zeit_2 inkl BS. 2 GJ bis Vormonat */
zeit_2 AS ( 
	SELECT zeit.gj
		, zeit.akt_gj /* Default. Wechsel am 02. März */
		, zeit.akt_gj + IFF(EXTRACT(MONTH FROM CURRENT_DATE - 1) = 3, 1, 0) AS akt_gj_mo /* Wechsel am 02. April */
		, zeit.kjmo
		, zeit.kjmo_vj
		, zeit.akt_mo
		, zeit.min_dat
		, zeit.max_dat
		, ker.akt_buchungs_schluss AS akt_bs
	FROM DBP_DATA.MONAT_2 zeit_2
	INNER JOIN DBP_DATA.L_BUCHUNGSSTATUS_KER_2 ker
		ON ker.kj_ker_mo_id = zeit.kjmo
	WHERE akt_gj_mo IN (- 1, 0) AND zeit.akt_mo < 0 /* 2 GJ bis Vormonat */
	)

/* Zeit_2 Tag_2 -- IST (separat wegen Schaltjahr) */
, zeit_tag_ist AS ( 
	SELECT zeit.dat
		, zeit.kjmo
		, zeit.akt_mo
		, zeit.gj
		, zeit.akt_gj + IFF(EXTRACT(MONTH FROM CURRENT_DATE - 1) = 3, 1, 0) AS akt_gj_mo /* Wechsel am 02. April */
	FROM DBP_DATA.TAG_2 zeit_2
	WHERE akt_gj_mo IN (-1, 0) AND zeit.akt_mo < 0 /* 2 GJ bis Vormonat */
	)

/* Zeit_2 Tag_2 -- KVJ (separat wegen Schaltjahr) */
, zeit_tag_kvj AS ( 
	SELECT zeit.dat AS dat_vj
		, zeit.kjmo AS kjmo_vj
		, zeit.kjmo + 100 AS kjmo /* Mapping auf Akt GJ */
		, zeit.akt_mo
		, zeit.gj
		, zeit.akt_gj + IFF(EXTRACT(MONTH FROM CURRENT_DATE - 1) = 3, 1, 0) AS akt_gj_mo /* Wechsel am 02. April */
	FROM DBP_DATA.TAG_2 zeit_2
	WHERE akt_gj_mo IN (-2, -1) AND zeit.akt_mo < -12 /* 2 GJ bis Vormonat im VJ */
	)

/* Standard VTC : Filiale + definierte ZF. Mapping NEÖ + Filter */
, wup_2 AS ( 
	SELECT wup.mandant_id, wup.nb_id, wup.vs_id
		, wup.aktuell_wup_id
		, wup.wup_id
		, IFF(wup.vkl_id > 0, wup.vkl_id, (1000 + wup.mandant_id * 100 + wup.vs_id * 10) * - 1) ::INTEGER AS vkl_id /* Dummy_2 VKL_2 */
		, COALESCE(wup.dat_eroeffnung_alt, wup.dat_eroeffnung) AS neo_dat /* Eröffnungsdatum (inkl Mapping Altfiliale) */
		, wup.dat_bis AS stl_dat
		, EXTRACT(YEAR FROM neo_dat) - IFF(EXTRACT(MONTH FROM neo_dat) < 3, 1, 0) AS neo_gj /* GJ der Eröffnung */
		, EXTRACT(YEAR FROM stl_dat) - IFF(EXTRACT(MONTH FROM stl_dat) < 3, 1, 0) AS stl_gj /* GJ der Schließung */
		, CASE /* Ausschluss : Getränkemärkte, Zeltverkauf, definierte Filialen -- 2025-01 */
			WHEN wup.mandant_id = 1 AND wup.wup_id IN (1263, 1273, 2583, 3166, 6623, 7220, 8120, 8563, 8940, 5876) THEN 1 /* DE */
			WHEN wup.mandant_id = 7 AND wup.wup_id IN (1110, 1410, 6210, 6310, 6410) THEN 1 /* RO */
			WHEN wup.mandant_id = 3 AND wup.wup_id IN (1010) THEN 1 /* PL */
			ELSE 0 END AS aus_fg
	FROM DBP_DATA.WUP_2 wup_2
	WHERE (wup.nb_id = 0 OR wup.wup_id IN (0, 2, 22, 28, 43, 46, 124, 8980, 8987, 8991, 100000, 100002, 100022, 100028, 100043, 100046, 100124)) /* Filialen + definierte ZF */
		AND wup.dat_eroeffnung < '2090-12-31' /* fix */
	)

/* Basis : MV_VIS_MONAT_FAKT_WUP_2 gruppiert -- IST/KVJ/PLAN */
, monat_fakt_wup AS ( 
	SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id
		, wup.vs_id
		, wup.vkl_id
		, zeit.gj
		, zeit.kjmo
		/* Rang : Filialen min. 1 komplettes GJ eröffnet. Ohne Schließungsmonat. Ohne definierte Ausschlussfilialen */
		, IFF(wup.nb_id = 0 AND zeit.gj > wup.neo_gj + 1 AND wup.stl_dat > zeit.max_dat AND wup.aus_fg = 0, 1, 0) AS neo_fg 
		/* Rang : relevante Monate vor Buchungsschluss */
		, IFF(zeit.akt_bs <= 0, 1, 0) AS bus_fg
		/* Rang (GJ) : Schließungen im GJ nicht enthalten */ 
		, IFF(zeit.gj = wup.stl_gj, 0, 1) AS stl_fg
		/* Rang (VKL_2) : echte VKL_2 ohne ZF */
		, IFF(wup.nb_id = 0 AND wup.vkl_id > 0, 1, 0) AS vkl_fg 
		, SUM(vis.ums_netto)        AS ums_ist
		, SUM(vis.ums_netto_kvj)    AS ums_kvj
		, SUM(vis.ums_netto_plan)   AS ums_plan
		, SUM(vis.anz_kunde)        AS knd_ist
		, SUM(vis.anz_kunde_kvj)    AS knd_kvj
		, knd_ist / 10000           AS knd_10t_ist
		, knd_kvj / 10000           AS knd_10t_kvj
		, SUM(vis.pers_std)         AS std_ist
		, SUM(vis.pers_std_kvj)     AS std_kvj
		, SUM(vis.pers_std_plan)    AS std_plan
		, SUM(vis.pers_kosten)      AS kst_ist
		, SUM(vis.pers_kosten_kvj)  AS kst_kvj
		, SUM(vis.pers_kosten_plan) AS kst_plan
	FROM DBP_MSI_VIEW_VIS.MV_VIS_MONAT_FAKT_WUP_2 vis
	INNER JOIN zeit_2
		ON zeit.kjmo = vis.kjmo
	INNER JOIN wup_2
		ON wup.wup_id = vis.wup_id AND wup.mandant_id = vis.mandant_id
	WHERE wup.stl_gj + 2 > zeit.gj /* inkl Schließungen im vorigen GJ */
	GROUP BY ALL
	)

/* MV_VIS_MONAT_FAKT_WG_2 gruppiert -- IST/KVJ */
, monat_fakt_ware AS ( 
	SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id
		, vis.kjmo
		, SUM(vis.ums_netto)                             AS ums_ware_ist
		, SUM(vis.ums_netto_kvj)                         AS ums_ware_kvj
		, SUM(IFF(vis.abt_id = 5, vis.ums_netto,     0)) AS ums_ulf_ist
		, SUM(IFF(vis.abt_id = 5, vis.ums_netto_kvj, 0)) AS ums_ulf_kvj
		, SUM(IFF(wg.owg_id <> 1092, vis.menge     , 0)) AS menge_opf_ist
		, SUM(IFF(wg.owg_id <> 1092, vis.menge_kvj , 0)) AS menge_opf_kvj
	FROM DBP_MSI_VIEW_VIS.MV_VIS_MONAT_FAKT_WG_2 vis
	INNER JOIN DBP_MSI_VIEW_VIS.MV_WG_INT_2 wg
		ON wg.wg_id = vis.wg_id
	INNER JOIN zeit_2
		ON zeit.kjmo = vis.kjmo 
	INNER JOIN wup_2
		ON wup.wup_id = vis.wup_id AND wup.mandant_id = vis.mandant_id
	WHERE wup.stl_gj + 2 > zeit.gj /* inkl Schließungen im vorigen GJ */
	GROUP BY ALL
	)

/* MV_ARTBEW_MO_SUM_2 gruppiert - IST */
, monat_artbew_ist AS ( 
	SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id
		, zeit.kjmo
		, SUM(vis.umsatz_netto)                               AS ums_artb_ist
		, SUM(IFF(vis.bewart_id = 1002, vis.umsatz_netto, 0)) AS ums_sa_ist
		, SUM(IFF(vis.bewart_id = 1001, vis.umsatz_netto, 0)) AS ums_af_ist /* Reserve */
	FROM DBP_MSI_VIEW_VIS.MV_ARTBEW_MO_SUM_2 vis
	INNER JOIN zeit_2
			ON zeit.kjmo = vis.kjmo 
	INNER JOIN wup_2 
		ON wup.wup_id = vis.wup_id AND wup.mandant_id = vis.mandant_id 
	WHERE wup.stl_gj + 2 > zeit.gj /* GJ Schließung klären! */
	GROUP BY ALL
	)

/* MV_ARTBEW_MO_SUM_2 gruppiert,transformiert - KVJ */
, monat_artbew_kvj AS ( 
	SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id
		, zeit.kjmo /* transformiert auf akt. Monat_2 */
		, SUM(vis.umsatz_netto)                               AS ums_artb_kvj
		, SUM(IFF(vis.bewart_id = 1002, vis.umsatz_netto, 0)) AS ums_sa_kvj
		, SUM(IFF(vis.bewart_id = 1001, vis.umsatz_netto, 0)) AS ums_af_kvj /* Reserve */
	FROM DBP_MSI_VIEW_VIS.MV_ARTBEW_MO_SUM_2 vis
	INNER JOIN zeit_2
		ON zeit.kjmo_vj = vis.kjmo /* Transformation KVJ */
	INNER JOIN wup_2 
		ON wup.wup_id = vis.wup_id AND wup.mandant_id = vis.mandant_id 
	WHERE wup.stl_gj + 2 > zeit.gj /* inkl Schließungen im vorigen GJ */
	GROUP BY ALL
	)

/* V_VIS_TAG_KASSE_2 + V_KASSE_TYP_PER_2 umgerechnet, gemapped, aggregiert -- IST */
, monat_kasse_ist AS ( 
	SELECT vis.mandant_id, vis.nb_id
	, wup.aktuell_wup_id AS wup_id
	, krs.nach_wrg_id AS wrg_id
	, zeit_tag_ist.kjmo
	, SUM(vis.umsatz_netto * krs.umrechnungskurs) AS ums_kass_ist
	, SUM(vis.anz_kunden) AS knd_kass_ist
	, SUM(vis.anz_artikel) AS art_kass_ist
	, SUM(IFF(ktp.kasse_typ_id = 1, vis.umsatz_netto * krs.umrechnungskurs, 0)) AS ums_pos_ist
	, SUM(IFF(ktp.kasse_typ_id = 1, vis.anz_kunden , 0)) AS knd_pos_ist
	, SUM(IFF(ktp.kasse_typ_id = 1, vis.anz_artikel , 0)) AS art_pos_ist
	, SUM(IFF(ktp.kasse_typ_id <> 1, vis.umsatz_netto * krs.umrechnungskurs, 0)) AS ums_sco_ist
	, SUM(IFF(ktp.kasse_typ_id <> 1, vis.anz_kunden , 0)) AS knd_sco_ist
	, SUM(IFF(ktp.kasse_typ_id <> 1, vis.anz_artikel , 0)) AS art_sco_ist
	, SUM(IFF(ktp.kasse_typ_id = 1, vis.anz_artikel / 100000.00, 0)) AS art_100t_ist
	, SUM(IFF(ktp.kasse_typ_id = 1, vis.registrierzeit / 60.0000, 0)) AS scan_min_ist
	, SUM(IFF(ktp.kasse_typ_id = 1, vis.kassierzeit / 3600.0000, 0)) AS kass_std_ist
	FROM DBP_VIEW.V_VIS_TAG_KASSE_2 vis
	INNER JOIN (
		SELECT ktp.mandant_id, ktp.wup_id, zeit_tag_ist.dat, ktp.kasse_nr, ktp.kasse_typ_id
		FROM DBP_VIEW.V_KASSE_TYP_PER_2 ktp
		INNER JOIN zeit_tag_ist
		ON zeit_tag_ist.dat BETWEEN ktp.dat_von AND ktp.dat_bis
		AND ktp.kasse_typ_id  IN (1,8,9,10,11) /* Kassentyp : 1 = normal/POS, 8,9 = SCO, 10,11 = Paystation */
	) ktp
		ON ktp.mandant_id = vis.mandant_id AND ktp.wup_id = vis.wup_id AND ktp.kasse_nr = vis.kasse_nr
		AND ktp.dat = vis.dat
	INNER JOIN ( 
		SELECT krs1.von_wrg_id, krs1.nach_wrg_id, krs1.umrechnungskurs 
		FROM DBP_DATA.KURS_2 krs1 
		WHERE krs1.kurstyp_id = 3 AND krs1.dat_bis = '9999-12-31' 
		AND krs1.von_wrg_id NOT IN ('AUD', 'DEM', 'SIT') 
		UNION ALL 
		SELECT krs2.von_wrg_id, krs2.von_wrg_id, 1.0000 
		FROM DBP_DATA.KURS_2 krs2 
		WHERE krs2.kurstyp_id = 3 AND krs2.dat_bis = '9999-12-31'  
		AND krs2.von_wrg_id NOT IN ('AUD', 'DEM', 'SIT', 'EUR')  
	) krs
		ON krs.von_wrg_id = vis.wrg_id
	INNER JOIN wup_2
		ON wup.mandant_id= vis.mandant_id AND wup.wup_id= vis.wup_id
	INNER JOIN zeit_tag_ist 
		ON zeit_tag_ist.dat = vis.dat
	GROUP BY ALL
	)

/* V_VIS_TAG_KASSE_2 + V_KASSE_TYP_PER_2 umgerechnet, gemapped, aggregiert, transformiert -- KVJ */
, monat_kasse_kvj AS ( 
	SELECT vis.mandant_id, vis.nb_id
	, krs.nach_wrg_id    AS wrg_id
	, wup.aktuell_wup_id AS wup_id
	, zeit_tag_kvj.kjmo  /* transformiert auf akt. Monat_2 */
	, SUM(vis.umsatz_netto * krs.umrechnungskurs) AS ums_kass_kvj
	, SUM(vis.anz_kunden) AS knd_kass_kvj
	, SUM(vis.anz_artikel) AS art_kass_kvj
	, SUM(IFF(ktp.kasse_typ_id = 1, vis.umsatz_netto  * krs.umrechnungskurs, 0)) AS ums_pos_kvj
	, SUM(IFF(ktp.kasse_typ_id = 1, vis.anz_kunden, 0)) AS knd_pos_kvj
	, SUM(IFF(ktp.kasse_typ_id = 1, vis.anz_artikel, 0)) AS art_pos_kvj
	, SUM(IFF(ktp.kasse_typ_id <> 1, vis.umsatz_netto  * krs.umrechnungskurs, 0)) AS ums_sco_kvj
	, SUM(IFF(ktp.kasse_typ_id <> 1, vis.anz_kunden, 0)) AS knd_sco_kvj
	, SUM(IFF(ktp.kasse_typ_id <> 1, vis.anz_artikel, 0)) AS art_sco_kvj
	, SUM(IFF(ktp.kasse_typ_id = 1, vis.anz_artikel / 100000.00, 0)) AS art_100t_kvj
	, SUM(IFF(ktp.kasse_typ_id = 1, vis.registrierzeit / 60.0000, 0)) AS scan_min_kvj
	, SUM(IFF(ktp.kasse_typ_id = 1, vis.kassierzeit / 3600.0000, 0)) AS kass_std_kvj
	FROM DBP_VIEW.V_VIS_TAG_KASSE_2 vis
	INNER JOIN (
		SELECT ktp.mandant_id, ktp.wup_id, zeit_tag_kvj.dat_vj AS dat, ktp.kasse_nr, ktp.kasse_typ_id
		FROM DBP_VIEW.V_KASSE_TYP_PER_2 ktp
		INNER JOIN zeit_tag_kvj /* Transformation KVJ */
		ON zeit_tag_kvj.dat_vj BETWEEN ktp.dat_von AND ktp.dat_bis
		AND ktp.kasse_typ_id  IN (1,8,9,10,11) /* Kassentyp : 1 = normal/POS, 8,9 = SCO, 10,11 = Paystation */
	) ktp
		ON ktp.mandant_id = vis.mandant_id AND ktp.wup_id = vis.wup_id AND ktp.kasse_nr = vis.kasse_nr
		AND ktp.dat = vis.dat 
	INNER JOIN ( 
		SELECT krs1.von_wrg_id, krs1.nach_wrg_id, krs1.umrechnungskurs 
		FROM DBP_DATA.KURS_2 krs1 
		WHERE krs1.kurstyp_id = 3 AND krs1.dat_bis = '9999-12-31' 
		AND krs1.von_wrg_id NOT IN ('AUD', 'DEM', 'SIT') 
		UNION ALL 
		SELECT krs2.von_wrg_id, krs2.von_wrg_id, 1.0000 
		FROM DBP_DATA.KURS_2 krs2 
		WHERE krs2.kurstyp_id = 3 AND krs2.dat_bis = '9999-12-31'  
		AND krs2.von_wrg_id NOT IN ('AUD', 'DEM', 'SIT', 'EUR')  
	) krs
		ON krs.von_wrg_id = vis.wrg_id
	INNER JOIN wup_2
		ON wup.mandant_id= vis.mandant_id AND wup.wup_id= vis.wup_id
	INNER JOIN zeit_tag_kvj 
		ON zeit_tag_kvj.dat_vj = vis.dat /* Transformation KVJ */
	GROUP BY ALL
	)

/* MV_ODS_BON_KASSENABSCHLUSS_2 (KPOS) aggregiert -- IST (ohne WRG_2) */
, woche_ods_bon_ka_ist AS ( 
	SELECT vis.mandant_id, vis.wup_id
	, zeit_tag_ist.kjmo
	, SUM(vis.anz_scans)         AS scans_ist
	, SUM(vis.sum_scan_sek / 60) AS mins_ist
	FROM DBP_MSI_VIEW_VIS.MV_ODS_BON_KASSENABSCHLUSS_2 vis
	INNER JOIN zeit_tag_ist
		ON zeit_tag_ist.dat = vis.dat
	INNER JOIN wup_2
		ON wup.mandant_id= vis.mandant_id AND wup.wup_id= vis.wup_id
	GROUP BY ALL
	)

/* MV_ODS_BON_KASSENABSCHLUSS_2 (KPOS) aggregiert, transformiert -- KVJ (ohne WRG_2) */
, woche_ods_bon_ka_kvj AS ( 
	SELECT vis.mandant_id, vis.wup_id
	, zeit_tag_kvj.kjmo  /* transformiert auf akt. Monat_2 */
	, SUM(vis.anz_scans) AS scans_kvj
	, SUM(vis.sum_scan_sek / 60) AS mins_kvj
	FROM DBP_MSI_VIEW_VIS.MV_ODS_BON_KASSENABSCHLUSS_2 vis
	INNER JOIN zeit_tag_kvj
		ON zeit_tag_kvj.dat_vj = vis.dat /* Transformation KVJ */
	INNER JOIN wup_2
		ON wup.mandant_id= vis.mandant_id AND wup.wup_id= vis.wup_id
	GROUP BY ALL
	)

/* MV_VIS_TAG_ABSCHRIFTEN_WG_2 gruppiert -- IST/KVJ */
, monat_abschriften AS ( 
	SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id
	, zeit_tag_ist.kjmo
	, SUM(CASE 
		WHEN vis.mandant_id IN (6) AND vis.abschriftart_id = 2 THEN 1 
		WHEN vis.mandant_id IN (3) AND vis.abschriftart_id = 11 THEN 1 
		WHEN vis.mandant_id IN (2,4,5,7,8) AND vis.abschriftart_id = 7 THEN 1 
		WHEN vis.mandant_id IN (2,5) AND vis.abschriftart_id = 10 THEN 1 
		WHEN vis.mandant_id NOT IN (1) AND vis.abschriftart_id = 20 THEN 1 
		ELSE -1 END * vis.abschrift_netto) AS abs_op_ist
	, SUM(CASE 
		WHEN vis.mandant_id IN (6) AND vis.abschriftart_id = 2 THEN 1 
		WHEN vis.mandant_id IN (3) AND vis.abschriftart_id = 11 THEN 1 
		WHEN vis.mandant_id IN (2,4,5,7,8) AND vis.abschriftart_id = 7 THEN 1 
		WHEN vis.mandant_id IN (2,5) AND vis.abschriftart_id = 10 THEN 1 
		WHEN vis.mandant_id NOT IN (1) AND vis.abschriftart_id = 20 THEN 1 
		ELSE -1 END * vis.abschrift_netto_kvj) AS abs_op_kvj 
	, SUM(CASE WHEN vis.abt_id = 5 
		THEN CASE
			WHEN vis.mandant_id IN (6) AND vis.abschriftart_id = 2 THEN 1 
			WHEN vis.abt_id = 5 AND vis.mandant_id IN (3) AND vis.abschriftart_id = 11 THEN 1 
			WHEN vis.abt_id = 5 AND vis.mandant_id IN (2,4,5,7,8) AND vis.abschriftart_id = 7 THEN 1 
			WHEN vis.abt_id = 5 AND vis.mandant_id IN (2,5) AND vis.abschriftart_id = 10 THEN 1 
			WHEN vis.abt_id = 5 AND vis.mandant_id NOT IN (1) AND vis.abschriftart_id = 20 THEN 1 
			ELSE -1 END
		ELSE 0 END * vis.abschrift_netto) AS abs_ulf_ist
	, SUM(CASE WHEN vis.abt_id = 5 THEN CASE
			WHEN vis.abt_id = 5 AND vis.mandant_id IN (6) AND vis.abschriftart_id = 2 THEN 1 
			WHEN vis.abt_id = 5 AND vis.mandant_id IN (3) AND vis.abschriftart_id = 11 THEN 1 
			WHEN vis.abt_id = 5 AND vis.mandant_id IN (2,4,5,7,8) AND vis.abschriftart_id = 7 THEN 1 
			WHEN vis.abt_id = 5 AND vis.mandant_id IN (2,5) AND vis.abschriftart_id = 10 THEN 1 
			WHEN vis.abt_id = 5 AND vis.mandant_id NOT IN (1) AND vis.abschriftart_id = 20 THEN 1 
			ELSE -1 END
		ELSE 0 END * vis.abschrift_netto_kvj) AS abs_ulf_kvj
	, SUM(CASE WHEN abs_thema.abschriftart_thema_int_id = 1 
		THEN CASE
			WHEN vis.mandant_id IN (6) AND vis.abschriftart_id = 2 THEN 1 
			WHEN vis.mandant_id IN (3) AND vis.abschriftart_id = 11 THEN 1 
			WHEN vis.mandant_id IN (2,4,5,7,8) AND vis.abschriftart_id = 7 THEN 1 
			WHEN vis.mandant_id IN (2,5) AND vis.abschriftart_id = 10 THEN 1 
			WHEN vis.mandant_id NOT IN (1) AND vis.abschriftart_id = 20 THEN 1 
			ELSE -1 END
		ELSE 0 END * vis.abschrift_netto) AS abs_ta_ist
	, SUM(CASE WHEN abs_thema.abschriftart_thema_int_id = 1 
		THEN CASE 
			WHEN vis.mandant_id IN (6) AND vis.abschriftart_id = 2 THEN 1 
			WHEN vis.mandant_id IN (3) AND vis.abschriftart_id = 11 THEN 1 
			WHEN vis.mandant_id IN (2,4,5,7,8) AND vis.abschriftart_id = 7 THEN 1 
			WHEN vis.mandant_id IN (2,5) AND vis.abschriftart_id = 10 THEN 1 
			WHEN vis.mandant_id NOT IN (1) AND vis.abschriftart_id = 20 THEN 1 
			ELSE -1 END
		ELSE 0 END * vis.abschrift_netto_kvj) AS abs_ta_kvj
	, SUM(CASE WHEN abs_thema.abschriftart_thema_int_id = 4 
		THEN CASE
			WHEN vis.mandant_id IN (6) AND vis.abschriftart_id = 2 THEN 1 
			WHEN vis.mandant_id IN (3) AND vis.abschriftart_id = 11 THEN 1 
			WHEN vis.mandant_id IN (2,4,5,7,8) AND vis.abschriftart_id = 7 THEN 1 
			WHEN vis.mandant_id IN (2,5) AND vis.abschriftart_id = 10 THEN 1 
			WHEN vis.mandant_id NOT IN (1) AND vis.abschriftart_id = 20 THEN 1 
			ELSE -1 END
		ELSE 0 END * vis.abschrift_netto) AS abs_pa_ist
	, SUM(CASE WHEN abs_thema.abschriftart_thema_int_id = 4 
		THEN CASE 
			WHEN vis.mandant_id IN (6) AND vis.abschriftart_id = 2 THEN 1 
			WHEN vis.mandant_id IN (3) AND vis.abschriftart_id = 11 THEN 1 
			WHEN vis.mandant_id IN (2,4,5,7,8) AND vis.abschriftart_id = 7 THEN 1 
			WHEN vis.mandant_id IN (2,5) AND vis.abschriftart_id = 10 THEN 1 
			WHEN vis.mandant_id NOT IN (1) AND vis.abschriftart_id = 20 THEN 1 
			ELSE -1 END
		ELSE 0 END * vis.abschrift_netto_kvj) AS abs_pa_kvj
	FROM dbp_msi_view_vis.MV_VIS_TAG_ABSCHRIFTEN_WG_2	vis
	JOIN dbp_msi_view_vis.MV_ABSCHRIFTART_INT_ZU_2 abs_art
		ON abs_art.abschriftart_id = vis.abschriftart_id AND abs_art.mandant_id = vis.mandant_id 
	JOIN dbp_msi_view_vis.MV_ABSCHRIFTART_INT_THEMA_ZU_2 abs_thema
		ON abs_thema.abschriftart_int_id = abs_art.abschriftart_int_id
	INNER JOIN zeit_tag_ist
		ON zeit_tag_ist.dat = vis.dat
	INNER JOIN wup_2
		ON wup.wup_id = vis.wup_id AND wup.mandant_id = vis.mandant_id 
	WHERE wup.stl_gj + 2 > zeit_tag_ist.gj /* inkl Schließungen im vorigen GJ */
		AND abs_thema.abschriftart_thema_int_id IN (1, 4) /* Abschriften_2 op = Totalabschriften + Preisabschriften */
	GROUP BY ALL
	)

/* MV_WUP_PLAN_KJMO_OWG_2 gruppiert -- PLAN */
, monat_plan_ware AS ( 
	SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id
		, zeit.kjmo 
		, SUM(vis.umsatz_netto_plan) AS ums_ware_plan
		, SUM(vis.abschriften_netto_operativ_plan) AS abs_ware_plan
		, SUM(IFF(hwg.abt_id = 5, vis.umsatz_netto_plan, 0)) AS ums_ulf_plan
		, SUM(IFF(hwg.abt_id = 5, vis.abschriften_netto_operativ_plan, 0)) AS abs_ulf_plan
	FROM DBP_MSI_VIEW_VIS.MV_WUP_PLAN_KJMO_OWG_2 vis
	INNER JOIN DBP_MSI_VIEW_VIS.MV_OWG_INT_2 owg
		ON owg.owg_id = vis.owg_id
	INNER JOIN DBP_MSI_VIEW_VIS.MV_HWG_INT_2 hwg
		ON hwg.hwg_id = owg.hwg_id
	INNER JOIN zeit_2
		ON zeit.kjmo = vis.kjmo
	INNER JOIN wup_2
		ON wup.wup_id = vis.wup_id AND wup.mandant_id = vis.mandant_id
	WHERE wup.stl_gj + 2 > (zeit.gj) /* inkl Schließungen im vorigen GJ */
	GROUP BY ALL
	)

/* MV_VIS_MONAT_HFM_INVENTUR_2 gruppiert -- IST */
, monat_inventur AS ( 
	SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id
		, zeit_tag_ist.kjmo
		, SUM(vis.inventur_wert_netto) AS inv_wert_ist
		, SUM(vis.inventur_ums_netto)  AS inv_ums_ist
	FROM DBP_MSI_VIEW_VIS.MV_VIS_MONAT_HFM_INVENTUR_2 vis
	INNER JOIN zeit_tag_ist
		ON zeit_tag_ist.dat = vis.dat_plan_zaehlung /* Mapping, abweichendes Datum */
	INNER JOIN wup_2 
		ON wup.wup_id = vis.wup_id AND wup.mandant_id = vis.mandant_id 
	WHERE wup.stl_gj + 2 > zeit_tag_ist.gj /* inkl Schließungen im vorigen GJ */
		AND vis.abt_invart_id IN (50) /* nur Frische Inventur_2 */
	GROUP BY ALL
)

/* BIG/Bestand : zwei Datenquellen  */
, monat_big AS ( 
	/* DE = MV_VIS_MONAT_BIG_DE_2 gruppiert, gefiltert (12 Monate) */
	SELECT vis.mandant_id, wup.nb_id, vis.wup_id, vis.wrg_id
	, zeit.kjmo
	, 1 ::INTEGER AS big_fg /* Wert aus BIG vorhanden */
	, SUM(IFF(vis.belastungsart_vd_id = 4, vis.vk_netto, 0)) AS big_ums_netto /* Umsatz */
	, SUM(IFF(vis.belastungsart_vd_id = 1, vis.vk_netto, 0)) AS big_01 /* Warenzugang */
	, SUM(IFF(vis.belastungsart_vd_id = 2, vis.vk_netto, 0)) AS big_02 /* Abschriften_2 inkl. B/V */
	, NULL AS big_03
	, NULL AS big_04
	, (big_01 + big_02) - big_ums_netto AS big_best_entw /* Bestandsentw. */
	FROM DBP_MSI_VIEW_VIS.MV_VIS_MONAT_BIG_DE_2 vis /* DE = MV_VIS_MONAT_BIG_DE_2 */
	INNER JOIN DBP_MSI_VIEW_VIS.MV_ART_WG_ZU_2 art_2
		ON art.mandant_id = vis.mandant_id AND art.art_id = vis.art_id 
	INNER JOIN DBP_MSI_VIEW_VIS.MV_WG_INT_2 wg 
		ON wg.wg_id = art.wg_id
	INNER JOIN zeit_2
		ON zeit.kjmo = vis.kjmo
	INNER JOIN wup_2
		ON wup.wup_id = vis.wup_id AND wup.mandant_id = vis.mandant_id 
	WHERE wup.stl_gj + 2 > zeit.gj /* inkl Schließungen im vorigen GJ */
		AND zeit.akt_mo BETWEEN -12 AND -1 /* analog mv_view (nur 12 Monate vorhanden) */
		AND vis.mandant_id = 1 AND vis.belastungsart_vd_id IN (1, 2, 4) /* DE + Filter */
		AND wg.owg_id NOT IN (1094) /* ohne Treibstoffe */
	GROUP BY ALL
	UNION ALL 
	/* Ausland = MV_VIS_MONAT_BIG_BESTANDSDIFFERENZEN_2 gruppiert, gefiltert (12 Monate) */
	SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id
	, vis.kjmo
	, 1 ::INTEGER AS big_fg /* Wert aus BIG vorhanden */
	, vis.ums_ware_ist AS big_ums_netto /* Umsatz */
	, NULL AS big_01
	, NULL AS big_02
	, big.best_mo AS big_03 /* Bestand Monat_2 */
	, big.best_vm AS big_04 /* Bestand Vormonat */
	, (big_03 - big_04) AS big_best_entw /* Bestandsentwicklung */
	FROM monat_fakt_ware vis
	INNER JOIN ( /* Ausland = MV_VIS_MONAT_BIG_BESTANDSDIFFERENZEN_2 */
		SELECT vis.mandant_id, vis.nb_id, vis.wup_id
			, krs.nach_wrg_id AS wrg_id
			, vis.kjmo
			, 1 ::INTEGER AS big_fg /* Wert aus BIG vorhanden */
			, SUM(vis.bestandswert_zvkp_vk_netto * krs.umrechnungskurs) AS best_mo
			, SUM(vis.bestandswert_vormonat_zvkp_vk_netto * krs.umrechnungskurs) AS best_vm
		FROM DBP_MSI_VIEW_VIS.MV_VIS_MONAT_BIG_BESTANDSDIFFERENZEN_2 vis
		INNER JOIN (
			SELECT krs1.von_wrg_id, krs1.nach_wrg_id, krs1.umrechnungskurs
			FROM DBP_DATA.KURS_2 krs1
			WHERE krs1.kurstyp_id = 3 AND krs1.dat_bis = '9999-12-31' AND krs1.von_wrg_id NOT IN ('AUD', 'DEM', 'SIT')
			UNION ALL
			SELECT krs2.von_wrg_id, krs2.von_wrg_id, 1.0000
			FROM DBP_DATA.KURS_2 krs2
			WHERE krs2.kurstyp_id = 3 AND krs2.dat_bis = '9999-12-31' AND krs2.von_wrg_id NOT IN ('AUD', 'DEM', 'SIT', 'EUR')
		) krs
			ON krs.von_wrg_id = vis.wrg_id
		INNER JOIN zeit_2
			ON zeit.kjmo = vis.kjmo 
		INNER JOIN wup_2
			ON wup.wup_id = vis.wup_id AND wup.mandant_id = vis.mandant_id 
		WHERE wup.stl_gj + 2 > zeit.gj /* inkl Schließungen im vorigen GJ */
			AND zeit.akt_mo BETWEEN -12 AND -1 /* analog mv_view (12 Monate) */
			AND vis.mandant_id > 1 /* Ausland */
		GROUP BY ALL
		) big 
		ON big.mandant_id = vis.mandant_id AND big.wup_id = vis.wup_id AND big.wrg_id = vis.wrg_id AND big.kjmo = vis.kjmo
	INNER JOIN zeit_2
		ON zeit.kjmo = vis.kjmo
	WHERE zeit.akt_mo BETWEEN -12 AND -1 /* analog mv_view (nur 12 Monate vorhanden) */
		AND vis.mandant_id > 1 /* Ausland */
	)

/* V_KFL_RETAIL_STORE_MO_SUM_2 gemappt -- IST (ohne WRG_2) */
, monat_google_ist AS ( 
	SELECT vis.mandant_id, vis.nb_id
		, wup.aktuell_wup_id AS wup_id
		, zeit.kjmo
		, SUM(vis.sum_review_rating) AS sum_review_ist
		, SUM(vis.anz_review_rating) AS anz_review_ist
	FROM DBP_MSI_V_VIEW.V_KFL_RETAIL_STORE_MO_SUM_2 vis
	JOIN zeit_2 
		ON zeit.kjmo = vis.kjmo
	JOIN wup_2
		ON wup.mandant_id = vis.mandant_id AND wup.wup_id = vis.wup_id
	GROUP BY ALL
	)

/* KFL_RETAIL_STORE_MO_SUM_2 (Werte ab Jan 2024) gemappt, transformiert -- KVJ (ohne WRG_2) */
, monat_google_kvj AS ( 
	SELECT vis.mandant_id, vis.nb_id
		, wup.aktuell_wup_id AS wup_id
		, zeit.kjmo /* transformiert auf akt. Monat_2 */
		, SUM(vis.sum_review_rating) AS sum_review_kvj
		, SUM(vis.anz_review_rating) AS anz_review_kvj
	FROM DBP_MSI_DATA.KFL_RETAIL_STORE_MO_SUM_2 vis
	JOIN zeit_2 
		ON zeit.kjmo_vj = vis.kjmo /* Transformation KVJ */
	JOIN wup_2
		ON wup.mandant_id = vis.mandant_id AND wup.wup_id = vis.wup_id
	WHERE wup.stl_gj + 2 > zeit.gj /* inkl Schließungen im vorigen GJ */
	GROUP BY ALL 
	)

/* WUPCAL_2 gemappt, aggregiert - IST (ohne WRG_2)*/
, monat_wcal_ist AS ( 
	SELECT wcal.mandant_id, wcal.nb_id
	, wup.aktuell_wup_id AS wup_id
	, zeit_tag_ist.kjmo
	, SUM(bonanzahl_sug)                 AS bon_ist 
	, SUM(bonanzahl_kundenkarte)         AS bon_kk 
	, SUM(bonanzahl_kundenkarte_payback) AS bon_pb 
	, bon_kk - ZEROIFNULL(bon_pb)        AS kcard_ist 
	FROM DBP_DATA.WUPCAL_2 wcal
	INNER JOIN zeit_tag_ist 
		ON zeit_tag_ist.dat = wcal.dat
	INNER JOIN wup_2
		ON wup.mandant_id = wcal.mandant_id AND wup.wup_id = wcal.wup_id
	WHERE wup.stl_gj + 2 > zeit_tag_ist.gj /* inkl Schließungen im vorigen GJ */
	GROUP BY ALL
	)

/* WUPCAL_2 gemappt, aggregiert, aggregiert - KVJ (ohne WRG_2) */
, monat_wcal_kvj AS ( 
	SELECT wcal.mandant_id, wcal.nb_id
	, wup.aktuell_wup_id AS wup_id
	, zeit_tag_kvj.kjmo
	, SUM(bonanzahl_sug)                 AS bon_kvj 
	, SUM(bonanzahl_kundenkarte)         AS bon_kk 
	, SUM(bonanzahl_kundenkarte_payback) AS bon_pb 
	, bon_kk - ZEROIFNULL(bon_pb)        AS kcard_kvj 
	FROM DBP_DATA.WUPCAL_2 wcal
	INNER JOIN zeit_tag_kvj
		ON zeit_tag_kvj.dat_vj = wcal.dat /* Transformation KVJ */
	INNER JOIN wup_2
		ON wup.mandant_id = wcal.mandant_id AND wup.wup_id = wcal.wup_id
	WHERE wup.stl_gj + 2 > zeit_tag_kvj.gj /* inkl Schließungen im vorigen GJ */
	GROUP BY ALL
	) 

/* MV_VIS_TAG_REKL_ART_2 aggregiert - IST */
, monat_rekl_ist AS ( 
	SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id
	, zeit_tag_ist.kjmo
	, SUM(IFF(reklamationsgrund_id IN(12,19), 1            , 0)) AS f_preis_ist
	, SUM(IFF(reklamationsgrund_id IN(13,14), 1            , 0)) AS f_kasse_ist
	, SUM(IFF(reklamationsgrund_id = 91     , vk_menge_kuga, 0)) AS w_theke_ist
	, SUM(IFF(reklamationsgrund_id = 92     , vk_menge_kuga, 0)) AS w_kasse_ist
	, SUM(IFF(reklamationsgrund_id = 93     , vk_menge_kuga, 0)) AS anz_mhd_ist
	FROM DBP_MSI_VIEW_VIS.MV_VIS_TAG_REKL_ART_2 vis
	INNER JOIN zeit_tag_ist 
		ON zeit_tag_ist.dat = vis.dat
	INNER JOIN wup_2 
		ON wup.wup_id = vis.wup_id AND wup.mandant_id = vis.mandant_id 
	WHERE wup.stl_gj + 2 > zeit_tag_ist.gj /* inkl Schließungen im vorigen GJ */
		AND vis.reklamationsgrund_id IN (12,13,14,19,91,92,93) /* Definierte Gründe, ohne Pfand */
		AND (vis.mandant_id, vis.art_id) IN (SELECT mandant_id, art_id FROM DBP_MSI_VIEW_VIS.MV_ART_WG_ZU_2 WHERE wg_id NOT IN (980)) 
	GROUP BY ALL
	)

/* MV_VIS_TAG_REKL_ART_2 aggregiert, transformiert - KVJ */
, monat_rekl_kvj AS ( 
	SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id
	, zeit_tag_kvj.kjmo /* transformiert auf akt. Monat_2 */
	, SUM(IFF(reklamationsgrund_id IN(12,19), 1            , 0)) AS f_preis_kvj
	, SUM(IFF(reklamationsgrund_id IN(13,14), 1            , 0)) AS f_kasse_kvj
	, SUM(IFF(reklamationsgrund_id = 91     , vk_menge_kuga, 0)) AS w_theke_kvj
	, SUM(IFF(reklamationsgrund_id = 92     , vk_menge_kuga, 0)) AS w_kasse_kvj
	, SUM(IFF(reklamationsgrund_id = 93     , vk_menge_kuga, 0)) AS anz_mhd_kvj
	FROM DBP_MSI_VIEW_VIS.MV_VIS_TAG_REKL_ART_2 vis
	INNER JOIN zeit_tag_kvj 
		ON zeit_tag_kvj.dat_vj = vis.dat /* Transformation auf kjwo_vj */
	INNER JOIN wup_2 
		ON wup.wup_id = vis.wup_id AND wup.mandant_id = vis.mandant_id 
	WHERE wup.stl_gj + 2 > zeit_tag_kvj.gj /* inkl Schließungen im vorigen GJ */
		AND vis.reklamationsgrund_id IN (12,13,14,19,91,92,93) /* Definierte Gründe, ohne Pfand */
		AND (vis.mandant_id, vis.art_id) IN (SELECT mandant_id, art_id FROM DBP_MSI_VIEW_VIS.MV_ART_WG_ZU_2 WHERE wg_id NOT IN (980)) 
	GROUP BY ALL) 

/* MV_VIS_BSCH_BESTVOR_DET aggregiert -- (ohne WRG_2) */
, monat_bestvor AS ( 
	SELECT vis.mandant_id, vis.nb_id, vis.wup_id
	, zeit_tag_ist.kjmo
	, SUM(IFF(vis.status_2 NOT IN ('0B','0N') , 1, 0)) AS best_vor /* Bestellvorschläge */
	, SUM(IFF(vis.status_2 IN ('0B')          , 1, 0)) AS best_man /* manuelle Bestellungen*/
	, SUM(IFF(vis.status_2 IN ('V0','V-','V+'), 1, 0)) AS best_kor /* korrigierte Bestellungen*/
	FROM DBP_MSI_VIEW_VIS.MV_BSCH_BESTVOR_DET_2 vis
	INNER JOIN DBP_MSI_VIEW_VIS.MV_ART_WG_ZU_2 art_2
		ON art.art_id = vis.art_id AND art.mandant_id = vis.mandant_id
	INNER JOIN DBP_MSI_VIEW_VIS.MV_WG_INT_2 wg
		ON wg.wg_id = art.wg_id
	INNER JOIN DBP_MSI_VIEW_VIS.MV_OWG_INT_2 owg
		ON owg.owg_id = wg.owg_id
	INNER JOIN DBP_MSI_VIEW_VIS.MV_HWG_INT_2 hwg
		ON hwg.hwg_id = owg.hwg_id
	INNER JOIN zeit_tag_ist
		ON zeit_tag_ist.dat = vis.dat_plan
	INNER JOIN wup_2
		ON wup.wup_id = vis.wup_id AND wup.mandant_id = vis.mandant_id 
	WHERE wup.stl_gj + 2 > zeit_tag_ist.gj /* inkl Schließungen im vorigen GJ */
		AND vis.status_2 NOT IN ('0N') /* weitere Filter/Logik siehe mv_view! */
		AND hwg.abt_id IN (5,6,7,8)    /* Abteilung ohne Nebengeschäft */
	GROUP BY ALL) 

/* MV_VIS_ZAEHL_AUFTRAG_2 gruppiert -- (ohne WRG_2) */
, monat_zaehl_auftrag AS ( 
	SELECT vis.mandant_id, vis.nb_id, vis.wup_id
	, zeit_tag_ist.kjmo
	, SUM(IFF(vis.dat_auftrag IS NOT NULL, 1 ,0)) AS auftrag
	, SUM(IFF(vis.dat_zaehl   IS NOT NULL, 1 ,0)) AS gezaehlt
	FROM DBP_MSI_VIEW_VIS.MV_VIS_ZAEHL_AUFTRAG_2 vis
	INNER JOIN DBP_MSI_VIEW_VIS.MV_ART_WG_ZU_2 art_2
		ON art.art_id = vis.art_id AND art.mandant_id = vis.mandant_id
	INNER JOIN DBP_MSI_VIEW_VIS.MV_WG_INT_2 wg
		ON wg.wg_id = art.wg_id
	INNER JOIN DBP_MSI_VIEW_VIS.MV_OWG_INT_2 owg
		ON owg.owg_id = wg.owg_id
	INNER JOIN DBP_MSI_VIEW_VIS.MV_HWG_INT_2 hwg
		ON hwg.hwg_id = owg.hwg_id
	INNER JOIN zeit_tag_ist
		ON zeit_tag_ist.dat = vis.dat_auftrag /* dat = dat_auftrag */
	INNER JOIN wup_2 
		ON wup.wup_id = vis.wup_id AND wup.mandant_id = vis.mandant_id 
	WHERE wup.stl_gj + 2 > zeit_tag_ist.gj /* inkl Schließungen im vorigen GJ */
		AND vis.zaehl_grund_id IN ('214','299','300','301','310','311','320','330','340','350','360','814','999') /* definierte Zählgründe */
		AND hwg.abt_id IN (5,6,7,8) /* Abteilung ohne Nebengeschäft */
	GROUP BY ALL
	) 

/* MV_VIS_TAG_FWWS_WG_2 gruppiert -- (ohne WRG_2) */
, monat_fwws AS (
	SELECT vis.mandant_id, vis.nb_id, vis.wup_id
	, zeit_tag_ist.kjmo
	, SUM(vis.anz_artikel_autodispo_dm12) AS auto_dispo
	, SUM(vis.anz_artikel_exc214)         AS minus_best
	, SUM(IFF(vis.dispomerkmal IN ('10','11','14') OR vis.mandant_id <> 1, vis.anz_artikel_exc209, NULL)) AS null_best
	FROM DBP_MSI_VIEW_VIS.MV_VIS_TAG_FWWS_WG_2 vis
	INNER JOIN zeit_tag_ist
		ON zeit_tag_ist.dat = vis.dat
	INNER JOIN wup_2 
		ON wup.wup_id = vis.wup_id AND wup.mandant_id = vis.mandant_id 
	WHERE wup.stl_gj + 2 > zeit_tag_ist.gj /* inkl Schließungen im vorigen GJ */
	GROUP BY ALL
	) 


/* CTE <--> MAIN */ 


/* VTR100 Umsatz netto */
SELECT 100::INTEGER AS VTR_ID 
	, mandant_id
	, nb_id
	, vs_id
	, vkl_id
	, wup_id
	, wrg_id
	, gj
	, kjmo
	, ist_fil AS FILIST
	, NULL AS FILIST2
	, kvj_fil AS FILKVJ
	, NULL AS FILKVJ2
	, plan_fil AS FILPLAN
	, NULL AS FILPLAN2
	, ist_reg AS REGIST
	, NULL AS REGIST2
	, kvj_reg AS REGKVJ
	, NULL AS REGKVJ2
	, ist_land AS LANDIST
	, NULL AS LANDIST2
	, kvj_land AS LANDKVJ
	, NULL AS LANDKVJ2
	/* Rang absteigend = Umsatz netto ∆Plan % */
	, IFF(neo_fg * bus_fg = 1, DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, vs_id, kjmo ORDER BY fil_mo DESC NULLS LAST), NULL) AS FILMO_RANG
	, IFF(neo_fg * stl_fg = 1, DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, vs_id, gj ORDER BY fil_gj DESC NULLS LAST), NULL) AS FILGJ_RANG
	, IFF(vkl_fg * bus_fg = 1, DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, vs_id, kjmo ORDER BY vkl_mo DESC NULLS LAST), NULL) AS VKLMO_RANG
	, IFF(vkl_fg * stl_fg = 1, DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, vs_id, gj ORDER BY vkl_gj DESC NULLS LAST), NULL) AS VKLGJ_RANG
	, IFF(neo_fg * bus_fg = 1, fil_mo, NULL) AS FILMO_WERT
	, IFF(neo_fg * stl_fg = 1, fil_gj, NULL) AS FILGJ_WERT
	, IFF(vkl_fg * bus_fg = 1, vkl_mo, NULL) AS VKLMO_WERT
	, IFF(vkl_fg * stl_fg = 1, vkl_gj, NULL) AS VKLGJ_WERT
FROM ( 
	SELECT vis0.mandant_id, vis0.nb_id, vis0.wup_id, vis0.wrg_id, vis0.vs_id, vis0.vkl_id, vis0.gj, vis0.kjmo
		, vis0.neo_fg, vis0.vkl_fg, vis0.bus_fg, vis0.stl_fg
		, vis0.ums_ist AS ist_fil
		, vis0.ums_kvj AS kvj_fil
		, vis0.ums_plan AS plan_fil
		/* Referenz Region_2/Land_2 */
		, SUM(ist_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vs_id) AS ist_reg
		, SUM(kvj_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vs_id) AS kvj_reg
		, SUM(ist_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo) AS ist_land
		, SUM(kvj_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo) AS kvj_land
		/* Setup Rang Filiale Monat_2 */
		, vis0.neo_fg * ist_fil AS ist_fil_mo
		, vis0.neo_fg * plan_fil AS plan_fil_mo
		/* Setup Rang Filiale GJ */
		, SUM(vis0.neo_fg * vis0.stl_fg * vis0.bus_fg * ist_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.gj, vis0.wup_id) AS ist_fil_gj
		, SUM(vis0.neo_fg * vis0.stl_fg * vis0.bus_fg * plan_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.gj, vis0.wup_id) AS plan_fil_gj
		/* Setup Rang VKL_2 Monat_2 */
		, SUM(vis0.neo_fg * vis0.vkl_fg * ist_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vkl_id) AS ist_vkl_mo
		, SUM(vis0.neo_fg * vis0.vkl_fg * plan_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vkl_id) AS plan_vkl_mo
		/* Setup Rang VKL_2 BJ (BS) */
		, SUM(vis0.neo_fg * vis0.vkl_fg * vis0.stl_fg * vis0.bus_fg * ist_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.gj, vis0.vkl_id) AS ist_vkl_gj
		, SUM(vis0.neo_fg * vis0.vkl_fg * vis0.stl_fg * vis0.bus_fg * plan_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.gj, vis0.vkl_id) AS plan_vkl_gj
		/* Rang absteigend = Umsatz netto IST - Plan % */
		, NULLIFZERO(vis0.neo_fg)               * ((ist_fil_mo - plan_fil_mo) / (NULLIFZERO(plan_fil_mo))) AS fil_mo
		, NULLIFZERO(vis0.neo_fg * vis0.stl_fg) * ((ist_fil_gj - plan_fil_gj) / (NULLIFZERO(plan_fil_gj))) AS fil_gj
		, NULLIFZERO(vis0.vkl_fg)               * ((ist_vkl_mo - plan_vkl_mo) / (NULLIFZERO(plan_vkl_mo))) AS vkl_mo
		, NULLIFZERO(vis0.vkl_fg * vis0.stl_fg) * ((ist_vkl_gj - plan_vkl_gj) / (NULLIFZERO(plan_vkl_gj))) AS vkl_gj
	FROM monat_fakt_wup vis0
) vtr 

UNION ALL
/* VTR110 Umsatz Ultra-Frische */ 
SELECT 110::INTEGER AS VTR_ID 
	, mandant_id
	, nb_id
	, vs_id
	, vkl_id
	, wup_id
	, wrg_id
	, gj
	, kjmo
	, ist_fil AS FILIST
	, NULL AS FILIST2
	, kvj_fil AS FILKVJ
	, NULL AS FILKVJ2
	, NULL AS FILPLAN
	, NULL AS FILPLAN2
	, ist_reg AS REGIST
	, NULL AS REGIST2
	, kvj_reg AS REGKVJ
	, NULL AS REGKVJ2
	, ist_land AS LANDIST
	, NULL AS LANDIST2
	, kvj_land AS LANDKVJ
	, NULL AS LANDKVJ2
	, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL /* ohne Rang */
FROM (
	SELECT vis0.mandant_id, vis0.nb_id, vis0.wup_id, vis0.wrg_id, vis0.vs_id, vis0.vkl_id, vis0.gj, vis0.kjmo
		, vis0.neo_fg, vis0.vkl_fg, vis0.bus_fg, vis0.stl_fg
		, sub1.ums_ulf_ist AS ist_fil
		, sub1.ums_ulf_kvj AS kvj_fil
		/* Referenz Region_2/Land_2 */
		, SUM(ist_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vs_id) AS ist_reg
		, SUM(kvj_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vs_id) AS kvj_reg
		, SUM(ist_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo) AS ist_land
		, SUM(kvj_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo) AS kvj_land
	FROM monat_fakt_wup vis0
	LEFT OUTER JOIN monat_fakt_ware sub1
		ON sub1.wup_id = vis0.wup_id AND sub1.mandant_id = vis0.mandant_id AND sub1.wrg_id = vis0.wrg_id AND sub1.kjmo = vis0.kjmo
) vtr 

UNION ALL 
/* VTR115 Umsatzanteil Ultra-Frische */
SELECT 115::INTEGER AS VTR_ID
	, mandant_id
	, nb_id
	, vs_id
	, vkl_id
	, wup_id
	, wrg_id
	, gj
	, kjmo
	, ist_fil AS FILIST
	, ist_fil2 AS FILIST2
	, kvj_fil AS FILWVJ
	, kvj_fil2 AS FILWVJ2
	, NULL AS FILPLAN
	, NULL AS FILPLAN2
	, ist_reg AS REGIST
	, ist_reg2 AS REGIST2
	, kvj_reg AS REGWVJ
	, kvj_reg2 AS REGWVJ2
	, ist_land AS LANDIST
	, ist_land2 AS LANDIST2 
	, kvj_land AS LANDWVJ
	, kvj_land2 AS LANDWVJ2 
	, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL /* ohne Rang */
FROM (
	SELECT vis0.mandant_id, vis0.nb_id, vis0.wup_id, vis0.wrg_id, vis0.vs_id, vis0.vkl_id, vis0.gj, vis0.kjmo
		, vis0.neo_fg, vis0.vkl_fg, vis0.bus_fg, vis0.stl_fg
		, sub1.ums_ulf_ist  AS ist_fil
		, sub1.ums_ulf_kvj  AS kvj_fil
		, sub1.ums_ware_ist AS ist_fil2
		, sub1.ums_ware_kvj AS kvj_fil2
		/* Referenz Region_2/Land_2 */
		, SUM(ist_fil)  OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vs_id) AS ist_reg
		, SUM(ist_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vs_id) AS ist_reg2
		, SUM(kvj_fil)  OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vs_id) AS kvj_reg
		, SUM(kvj_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vs_id) AS kvj_reg2
		, SUM(ist_fil)  OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo) AS ist_land
		, SUM(ist_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo) AS ist_land2
		, SUM(kvj_fil)  OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo) AS kvj_land
		, SUM(kvj_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo) AS kvj_land2
	FROM monat_fakt_wup vis0
	LEFT OUTER JOIN monat_fakt_ware sub1 
		ON sub1.wup_id = vis0.wup_id AND sub1.mandant_id = vis0.mandant_id AND sub1.wrg_id = vis0.wrg_id AND sub1.kjmo = vis0.kjmo
) vtr

UNION ALL
/* VTR120 Umsatz SA (artbew_2) */ 
SELECT 120::INTEGER AS VTR_ID 
	, mandant_id
	, nb_id
	, vs_id
	, vkl_id
	, wup_id
	, wrg_id
	, gj
	, kjmo
	, ist_fil AS FILIST
	, NULL AS FILIST2
	, kvj_fil AS FILWVJ
	, NULL AS FILWVJ2
	, NULL AS FILPLAN
	, NULL AS FILPLAN2
	, ist_reg  AS REGIST
	, NULL AS REGIST2
	, kvj_reg  AS REGWVJ
	, NULL AS REGWVJ2
	, ist_land AS LANDIST
	, NULL AS LANDIST2
	, kvj_land AS LANDWVJ
	, NULL AS LANDWVJ2
	, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL /* ohne Rang */
FROM ( 
	SELECT vis0.mandant_id, vis0.nb_id, vis0.wup_id, vis0.wrg_id, vis0.vs_id, vis0.vkl_id, vis0.gj, vis0.kjmo
		, vis0.neo_fg, vis0.vkl_fg, vis0.bus_fg, vis0.stl_fg
		, sub1.ums_sa_ist AS ist_fil
		, sub2.ums_sa_kvj AS kvj_fil
		/* Referenz Region_2/Land_2 */
		, SUM(ist_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vs_id) AS ist_reg
		, SUM(kvj_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vs_id) AS kvj_reg
		, SUM(ist_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo) AS ist_land
		, SUM(kvj_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo) AS kvj_land
	FROM monat_fakt_wup vis0
	LEFT OUTER JOIN monat_artbew_ist sub1 
		ON sub1.wup_id = vis0.wup_id AND sub1.mandant_id = vis0.mandant_id AND sub1.wrg_id = vis0.wrg_id AND sub1.kjmo = vis0.kjmo
	LEFT OUTER JOIN monat_artbew_kvj sub2 
		ON sub2.wup_id = vis0.wup_id AND sub2.mandant_id = vis0.mandant_id AND sub2.wrg_id = vis0.wrg_id AND sub2.kjmo = vis0.kjmo 
) vtr

UNION ALL 
/* VTR125 Umsatzanteil SA (artbew_2) */
SELECT 125::INTEGER AS VTR_ID
	, mandant_id
	, nb_id
	, vs_id
	, vkl_id
	, wup_id
	, wrg_id
	, gj
	, kjmo
	, ist_fil AS FILIST
	, ist_fil2 AS FILIST2
	, kvj_fil AS FILWVJ
	, kvj_fil2 AS FILWVJ2
	, NULL AS FILPLAN
	, NULL AS FILPLAN2
	, ist_reg AS REGIST
	, ist_reg2 AS REGIST2
	, kvj_reg AS REGWVJ
	, kvj_reg2 AS REGWVJ2
	, ist_land AS LANDIST
	, ist_land2 AS LANDIST2 
	, kvj_land AS LANDWVJ
	, kvj_land2 AS LANDWVJ2 
	, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL /* ohne Rang */
FROM (
	SELECT vis0.mandant_id, vis0.nb_id, vis0.wup_id, vis0.wrg_id, vis0.vs_id, vis0.vkl_id, vis0.gj, vis0.kjmo
		, vis0.neo_fg, vis0.vkl_fg, vis0.bus_fg, vis0.stl_fg
		, sub1.ums_sa_ist   AS ist_fil
		, sub1.ums_artb_ist AS ist_fil2
		, sub2.ums_sa_kvj   AS kvj_fil
		, sub2.ums_artb_kvj AS kvj_fil2
		/* Referenz Region_2/Land_2 */
		, SUM(ist_fil)  OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vs_id) AS ist_reg
		, SUM(ist_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vs_id) AS ist_reg2
		, SUM(kvj_fil)  OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vs_id) AS kvj_reg
		, SUM(kvj_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vs_id) AS kvj_reg2
		, SUM(ist_fil)  OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo) AS ist_land
		, SUM(ist_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo) AS ist_land2
		, SUM(kvj_fil)  OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo) AS kvj_land
		, SUM(kvj_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo) AS kvj_land2
	FROM monat_fakt_wup vis0
	LEFT OUTER JOIN monat_artbew_ist sub1 
		ON sub1.wup_id = vis0.wup_id AND sub1.mandant_id = vis0.mandant_id AND sub1.wrg_id = vis0.wrg_id AND sub1.kjmo = vis0.kjmo
	LEFT OUTER JOIN monat_artbew_kvj sub2 
		ON sub2.wup_id = vis0.wup_id AND sub2.mandant_id = vis0.mandant_id AND sub2.wrg_id = vis0.wrg_id AND sub2.kjmo = vis0.kjmo 
) vtr

UNION ALL
/* VTR140 Absatz (ohne Pfand) */ 
SELECT 140::INTEGER AS VTR_ID 
	, mandant_id
	, nb_id
	, vs_id
	, vkl_id
	, wup_id
	, wrg_id
	, gj
	, kjmo
	, ist_fil AS FILIST
	, NULL AS FILIST2
	, kvj_fil AS FILWVJ
	, NULL AS FILWVJ2
	, NULL AS FILPLAN
	, NULL AS FILPLAN2
	, ist_reg  AS REGIST
	, NULL AS REGIST2
	, kvj_reg  AS REGWVJ
	, NULL AS REGWVJ2
	, ist_land AS LANDIST
	, NULL AS LANDIST2
	, kvj_land AS LANDWVJ
	, NULL AS LANDWVJ2
	, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL /* ohne Rang */
FROM ( 
	SELECT vis0.mandant_id, vis0.nb_id, vis0.wup_id, vis0.wrg_id, vis0.vs_id, vis0.vkl_id, vis0.gj, vis0.kjmo
		, vis0.neo_fg, vis0.vkl_fg, vis0.bus_fg, vis0.stl_fg
		, sub1.menge_opf_ist AS ist_fil
		, sub1.menge_opf_kvj AS kvj_fil
		/* Referenz Region_2/Land_2 */
		, SUM(ist_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vs_id) AS ist_reg
		, SUM(kvj_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vs_id) AS kvj_reg
		, SUM(ist_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo) AS ist_land
		, SUM(kvj_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo) AS kvj_land
	FROM monat_fakt_wup vis0
	LEFT OUTER JOIN monat_fakt_ware sub1 
		ON sub1.wup_id = vis0.wup_id AND sub1.mandant_id = vis0.mandant_id AND sub1.wrg_id = vis0.wrg_id AND sub1.kjmo = vis0.kjmo
) vtr

UNION ALL
/* VTR160 Kunden */ 
SELECT 160::INTEGER AS VTR_ID
	, mandant_id
	, nb_id
	, vs_id
	, vkl_id
	, wup_id
	, wrg_id
	, gj
	, kjmo
	, ist_fil AS FILIST
	, NULL AS FILIST2
	, kvj_fil AS FILKVJ
	, NULL AS FILKVJ2
	, NULL AS FILPLAN
	, NULL AS FILPLAN2
	, ist_reg AS REGIST
	, NULL AS REGIST2
	, kvj_reg AS REGKVJ
	, NULL AS REGKVJ2
	, ist_land AS LANDIST
	, NULL AS LANDIST2
	, kvj_land AS LANDKVJ
	, NULL AS LANDKVJ2
	, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL /* ohne Rang */
FROM ( 
	SELECT vis0.mandant_id, vis0.nb_id, vis0.wup_id, vis0.wrg_id, vis0.vs_id, vis0.vkl_id, vis0.gj, vis0.kjmo
		, vis0.neo_fg, vis0.vkl_fg, vis0.bus_fg, vis0.stl_fg
		, vis0.knd_ist  AS ist_fil
		, vis0.knd_kvj  AS kvj_fil
		/* Referenz Region_2/Land_2 */
		, SUM(ist_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vs_id) AS ist_reg
		, SUM(kvj_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vs_id) AS kvj_reg
		, SUM(ist_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo) AS ist_land
		, SUM(kvj_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo) AS kvj_land
	FROM monat_fakt_wup vis0
) vtr 

UNION ALL
/* VTR180 Ø-Bon */ 
SELECT 180::INTEGER AS VTR_ID
	, mandant_id
	, nb_id
	, vs_id
	, vkl_id
	, wup_id
	, wrg_id
	, gj
	, kjmo
	, ist_fil AS FILIST
	, ist_fil2 AS FILIST2
	, kvj_fil AS FILKVJ
	, kvj_fil2 AS FILKVJ2
	, NULL AS FILPLAN
	, NULL AS FILPLAN2
	, ist_reg AS REGIST
	, ist_reg2 AS REGIST2
	, kvj_reg AS REGKVJ
	, kvj_reg2 AS REGKVJ2
	, ist_land AS LANDIST
	, ist_land2 AS LANDIST2
	, kvj_land AS LANDKVJ
	, kvj_land2 AS LANDKVJ2
	, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL /* ohne Rang */
FROM ( 
	SELECT vis0.mandant_id, vis0.nb_id, vis0.wup_id, vis0.wrg_id, vis0.vs_id, vis0.vkl_id, vis0.gj, vis0.kjmo
		, vis0.neo_fg, vis0.vkl_fg, vis0.bus_fg, vis0.stl_fg
		, vis0.ums_ist AS ist_fil
		, vis0.knd_ist AS ist_fil2
		, vis0.ums_kvj AS kvj_fil
		, vis0.knd_kvj AS kvj_fil2
		/* Referenz Region_2/Land_2 */
		, SUM(ist_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vs_id) AS ist_reg
		, SUM(ist_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vs_id) AS ist_reg2
		, SUM(kvj_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vs_id) AS kvj_reg
		, SUM(kvj_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vs_id) AS kvj_reg2
		, SUM(ist_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo) AS ist_land
		, SUM(ist_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo) AS ist_land2
		, SUM(kvj_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo) AS kvj_land
		, SUM(kvj_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo) AS kvj_land2
	FROM monat_fakt_wup vis0
) vtr 

UNION ALL
/* VTR200 Nettostunden */ 
SELECT 200::INTEGER AS VTR_ID
	, mandant_id
	, nb_id
	, vs_id
	, vkl_id
	, wup_id
	, wrg_id
	, gj
	, kjmo
	, ist_fil AS FILIST
	, NULL AS FILIST2
	, kvj_fil AS FILKVJ
	, NULL AS FILKVJ2
	, plan_fil AS FILPLAN
	, NULL AS FILPLAN2
	, ist_reg AS REGIST
	, NULL AS REGIST2
	, kvj_reg AS REGKVJ
	, NULL AS REGKVJ2
	, ist_land AS LANDIST
	, NULL AS LANDIST2
	, kvj_land AS LANDKVJ
	, NULL AS LANDKVJ2
	, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL /* ohne Rang */
FROM ( 
	SELECT vis0.mandant_id, vis0.nb_id, vis0.wup_id, vis0.wrg_id, vis0.vs_id, vis0.vkl_id, vis0.gj, vis0.kjmo
		, vis0.neo_fg, vis0.vkl_fg, vis0.bus_fg, vis0.stl_fg
		, vis0.std_ist AS ist_fil
		, vis0.std_kvj AS kvj_fil
		, vis0.std_plan AS plan_fil
		/* Referenz Region_2/Land_2 */
		, SUM(ist_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vs_id) AS ist_reg
		, SUM(kvj_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vs_id) AS kvj_reg
		, SUM(ist_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo) AS ist_land
		, SUM(kvj_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo) AS kvj_land
	FROM monat_fakt_wup vis0
) vtr 

UNION ALL
/* VTR210 Nettoleistung */ 
SELECT 210::INTEGER AS VTR_ID
	, mandant_id
	, nb_id
	, vs_id
	, vkl_id
	, wup_id
	, wrg_id
	, gj
	, kjmo
	, ist_fil AS FILIST
	, ist_fil2 AS FILIST2
	, kvj_fil AS FILKVJ
	, kvj_fil2 AS FILKVJ2
	, plan_fil AS FILPLAN
	, plan_fil2 AS FILPLAN2
	, ist_reg AS REGIST
	, ist_reg2 AS REGIST2
	, kvj_reg AS REGKVJ
	, kvj_reg2 AS REGKVJ2
	, ist_land AS LANDIST
	, ist_land2 AS LANDIST2
	, kvj_land AS LANDKVJ
	, kvj_land2 AS LANDKVJ2
	/* Rang absteigend = Nettoleistung ∆Plan (absolut) */
	, IFF(neo_fg * bus_fg = 1, DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, vs_id, kjmo ORDER BY fil_mo DESC NULLS LAST), NULL) AS FILMO_RANG
	, IFF(neo_fg * stl_fg = 1, DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, vs_id, gj ORDER BY fil_gj DESC NULLS LAST), NULL) AS FILGJ_RANG
	, IFF(vkl_fg * bus_fg = 1, DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, vs_id, kjmo ORDER BY vkl_mo DESC NULLS LAST), NULL) AS VKLMO_RANG
	, IFF(vkl_fg * stl_fg = 1, DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, vs_id, gj ORDER BY vkl_gj DESC NULLS LAST), NULL) AS VKLGJ_RANG
	, IFF(neo_fg * bus_fg = 1, fil_mo, NULL) AS FILMO_WERT
	, IFF(neo_fg * stl_fg = 1, fil_gj, NULL) AS FILGJ_WERT
	, IFF(vkl_fg * bus_fg = 1, vkl_mo, NULL) AS VKLMO_WERT
	, IFF(vkl_fg * stl_fg = 1, vkl_gj, NULL) AS VKLGJ_WERT
FROM ( 
	SELECT vis0.mandant_id, vis0.nb_id, vis0.wup_id, vis0.wrg_id, vis0.vs_id, vis0.vkl_id, vis0.gj, vis0.kjmo
		, vis0.neo_fg, vis0.vkl_fg, vis0.bus_fg, vis0.stl_fg
		, vis0.ums_ist AS ist_fil
		, vis0.std_ist AS ist_fil2
		, vis0.ums_kvj AS kvj_fil
		, vis0.std_kvj AS kvj_fil2
		, vis0.ums_plan AS plan_fil
		, vis0.std_plan AS plan_fil2
		/* Referenz Region_2/Land_2 */
		, SUM(ist_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vs_id) AS ist_reg
		, SUM(ist_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vs_id) AS ist_reg2
		, SUM(kvj_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vs_id) AS kvj_reg
		, SUM(kvj_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vs_id) AS kvj_reg2
		, SUM(ist_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo) AS ist_land
		, SUM(ist_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo) AS ist_land2
		, SUM(kvj_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo) AS kvj_land
		, SUM(kvj_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo) AS kvj_land2
		/* Setup Rang Filiale Monat_2 */
		, vis0.neo_fg * ist_fil AS ist_fil_mo
		, vis0.neo_fg * ist_fil2 AS ist_fil_mo2
		, vis0.neo_fg * plan_fil AS plan_fil_mo
		, vis0.neo_fg * plan_fil2 AS plan_fil_mo2
		/* Setup Rang Filiale GJ */
		, SUM(vis0.neo_fg * vis0.stl_fg * vis0.bus_fg * ist_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.gj, vis0.wup_id) AS ist_fil_gj
		, SUM(vis0.neo_fg * vis0.stl_fg * vis0.bus_fg * ist_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.gj, vis0.wup_id) AS ist_fil_gj2
		, SUM(vis0.neo_fg * vis0.stl_fg * vis0.bus_fg * plan_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.gj, vis0.wup_id) AS plan_fil_gj
		, SUM(vis0.neo_fg * vis0.stl_fg * vis0.bus_fg * plan_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.gj, vis0.wup_id) AS plan_fil_gj2
		/* Setup Rang VKL_2 Monat_2 */
		, SUM(vis0.neo_fg * vis0.vkl_fg * ist_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vkl_id) AS ist_vkl_mo
		, SUM(vis0.neo_fg * vis0.vkl_fg * ist_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vkl_id) AS ist_vkl_mo2
		, SUM(vis0.neo_fg * vis0.vkl_fg * plan_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vkl_id) AS plan_vkl_mo
		, SUM(vis0.neo_fg * vis0.vkl_fg * plan_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vkl_id) AS plan_vkl_mo2
		/* Setup Rang VKL_2 BJ (BS) */
		, SUM(vis0.neo_fg * vis0.vkl_fg * vis0.stl_fg * vis0.bus_fg * ist_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.gj, vis0.vkl_id) AS ist_vkl_gj
		, SUM(vis0.neo_fg * vis0.vkl_fg * vis0.stl_fg * vis0.bus_fg * ist_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.gj, vis0.vkl_id) AS ist_vkl_gj2
		, SUM(vis0.neo_fg * vis0.vkl_fg * vis0.stl_fg * vis0.bus_fg * plan_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.gj, vis0.vkl_id) AS plan_vkl_gj
		, SUM(vis0.neo_fg * vis0.vkl_fg * vis0.stl_fg * vis0.bus_fg * plan_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.gj, vis0.vkl_id) AS plan_vkl_gj2
		/* Rang absteigend = Nettoleistung ∆Plan (absolut) */
		, NULLIFZERO(vis0.neo_fg)               * ((ist_fil_mo / NULLIFZERO(ist_fil_mo2)) - (plan_fil_mo / NULLIFZERO(plan_fil_mo2))) AS fil_mo
		, NULLIFZERO(vis0.neo_fg * vis0.stl_fg) * ((ist_fil_gj / NULLIFZERO(ist_fil_gj2)) - (plan_fil_gj / NULLIFZERO(plan_fil_gj2))) AS fil_gj
		, NULLIFZERO(vis0.vkl_fg)               * ((ist_vkl_mo / NULLIFZERO(ist_vkl_mo2)) - (plan_vkl_mo / NULLIFZERO(plan_vkl_mo2))) AS vkl_mo
		, NULLIFZERO(vis0.vkl_fg * vis0.stl_fg) * ((ist_vkl_gj / NULLIFZERO(ist_vkl_gj2)) - (plan_vkl_gj / NULLIFZERO(plan_vkl_gj2))) AS vkl_gj
	FROM monat_fakt_wup vis0
) vtr 

UNION ALL
/* VTR220 Nettostückleistung */ 
SELECT 220::INTEGER AS VTR_ID
	, mandant_id
	, nb_id
	, vs_id
	, vkl_id
	, wup_id
	, wrg_id
	, gj
	, kjmo
	, ist_fil AS FILIST
	, ist_fil2 AS FILIST2
	, kvj_fil AS FILKVJ
	, kvj_fil2 AS FILKVJ2
	, NULL AS FILPLAN
	, NULL AS FILPLAN2
	, ist_reg AS REGIST
	, ist_reg2 AS REGIST2
	, kvj_reg AS REGKVJ
	, kvj_reg2 AS REGKVJ2
	, ist_land AS LANDIST
	, ist_land2 AS LANDIST2
	, kvj_land AS LANDKVJ
	, kvj_land2 AS LANDKVJ2
	/* ohne Rang */
	, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
FROM ( 
	SELECT vis0.mandant_id, vis0.nb_id, vis0.wup_id, vis0.wrg_id, vis0.vs_id, vis0.vkl_id, vis0.gj, vis0.kjmo
		, vis0.neo_fg, vis0.vkl_fg, vis0.bus_fg, vis0.stl_fg
		, sub1.menge_opf_ist AS ist_fil
		, vis0.std_ist AS ist_fil2
		, sub1.menge_opf_kvj AS kvj_fil
		, vis0.std_kvj AS kvj_fil2
		/* Referenz Region_2/Land_2 */
		, SUM(ist_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vs_id) AS ist_reg
		, SUM(ist_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vs_id) AS ist_reg2
		, SUM(kvj_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vs_id) AS kvj_reg
		, SUM(kvj_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vs_id) AS kvj_reg2
		, SUM(ist_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo) AS ist_land
		, SUM(ist_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo) AS ist_land2
		, SUM(kvj_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo) AS kvj_land
		, SUM(kvj_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo) AS kvj_land2
	FROM monat_fakt_wup vis0
	LEFT OUTER JOIN monat_fakt_ware sub1 
		ON sub1.wup_id = vis0.wup_id AND sub1.mandant_id = vis0.mandant_id AND sub1.wrg_id = vis0.wrg_id AND sub1.kjmo = vis0.kjmo
) vtr 

UNION ALL
/* VTR240 Kassierleistung */ 
SELECT 240::INTEGER AS VTR_ID
	, mandant_id
	, nb_id
	, vs_id
	, vkl_id
	, wup_id
	, wrg_id
	, gj
	, kjmo
	, ist_fil AS FILIST
	, ist_fil2 AS FILIST2
	, kvj_fil AS FILKVJ
	, kvj_fil2 AS FILKVJ2
	, NULL AS FILPLAN
	, NULL AS FILPLAN2
	, ist_reg AS REGIST
	, ist_reg2 AS REGIST2
	, kvj_reg AS REGKVJ
	, kvj_reg2 AS REGKVJ2
	, ist_land AS LANDIST
	, ist_land2 AS LANDIST2
	, kvj_land AS LANDKVJ
	, kvj_land2 AS LANDKVJ2
	/* Rang absteigend = Kassierleistung IST (absolut) */
	, IFF(neo_fg * bus_fg = 1, DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, vs_id, kjmo ORDER BY fil_mo DESC NULLS LAST), NULL) AS FILMO_RANG
	, IFF(neo_fg * stl_fg = 1, DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, vs_id, gj ORDER BY fil_gj DESC NULLS LAST), NULL) AS FILGJ_RANG
	, IFF(vkl_fg * bus_fg = 1, DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, vs_id, kjmo ORDER BY vkl_mo DESC NULLS LAST), NULL) AS VKLMO_RANG
	, IFF(vkl_fg * stl_fg = 1, DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, vs_id, gj ORDER BY vkl_gj DESC NULLS LAST), NULL) AS VKLGJ_RANG
	, IFF(neo_fg * bus_fg = 1, fil_mo, NULL) AS FILMO_WERT
	, IFF(neo_fg * stl_fg = 1, fil_gj, NULL) AS FILGJ_WERT
	, IFF(vkl_fg * bus_fg = 1, vkl_mo, NULL) AS VKLMO_WERT
	, IFF(vkl_fg * stl_fg = 1, vkl_gj, NULL) AS VKLGJ_WERT
FROM ( 
	SELECT vis0.mandant_id, vis0.nb_id, vis0.wup_id, vis0.wrg_id, vis0.vs_id, vis0.vkl_id, vis0.gj, vis0.kjmo
		, vis0.neo_fg, vis0.vkl_fg, vis0.bus_fg, vis0.stl_fg
		, sub1.ums_pos_ist AS ist_fil
		, sub1.kass_std_ist AS ist_fil2
		, sub2.ums_pos_kvj AS kvj_fil
		, sub2.kass_std_kvj AS kvj_fil2
		/* Referenz Region_2/Land_2 */
		, SUM(ist_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vs_id) AS ist_reg
		, SUM(ist_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vs_id) AS ist_reg2
		, SUM(kvj_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vs_id) AS kvj_reg
		, SUM(kvj_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vs_id) AS kvj_reg2
		, SUM(ist_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo) AS ist_land
		, SUM(ist_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo) AS ist_land2
		, SUM(kvj_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo) AS kvj_land
		, SUM(kvj_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo) AS kvj_land2
		/* Setup Rang Filiale Monat_2 */
		, vis0.neo_fg * ist_fil AS ist_fil_mo
		, vis0.neo_fg * ist_fil2 AS ist_fil_mo2
		/* Setup Rang Filiale GJ */
		, SUM(vis0.neo_fg * vis0.stl_fg * vis0.bus_fg * ist_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.gj, vis0.wup_id) AS ist_fil_gj
		, SUM(vis0.neo_fg * vis0.stl_fg * vis0.bus_fg * ist_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.gj, vis0.wup_id) AS ist_fil_gj2
		/* Setup Rang VKL_2 Monat_2 */
		, SUM(vis0.neo_fg * vis0.vkl_fg * ist_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vkl_id) AS ist_vkl_mo
		, SUM(vis0.neo_fg * vis0.vkl_fg * ist_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vkl_id) AS ist_vkl_mo2
		/* Setup Rang VKL_2 BJ (BS) */
		, SUM(vis0.neo_fg * vis0.vkl_fg * vis0.stl_fg * vis0.bus_fg * ist_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.gj, vis0.vkl_id) AS ist_vkl_gj
		, SUM(vis0.neo_fg * vis0.vkl_fg * vis0.stl_fg * vis0.bus_fg * ist_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.gj, vis0.vkl_id) AS ist_vkl_gj2
		/* Rang absteigend = Nettoleistung (Umsatz/Stunden_2) IST-Plan (absolut) */
		, NULLIFZERO(vis0.neo_fg)               * (ist_fil_mo / NULLIFZERO(ist_fil_mo2)) AS fil_mo
		, NULLIFZERO(vis0.neo_fg * vis0.stl_fg) * (ist_fil_gj / NULLIFZERO(ist_fil_gj2)) AS fil_gj
		, NULLIFZERO(vis0.vkl_fg)               * (ist_vkl_mo / NULLIFZERO(ist_vkl_mo2)) AS vkl_mo
		, NULLIFZERO(vis0.vkl_fg * vis0.stl_fg) * (ist_vkl_gj / NULLIFZERO(ist_vkl_gj2)) AS vkl_gj
	FROM monat_fakt_wup vis0
	LEFT OUTER JOIN monat_kasse_ist sub1 
		ON sub1.wup_id = vis0.wup_id AND sub1.mandant_id = vis0.mandant_id AND sub1.wrg_id = vis0.wrg_id AND sub1.kjmo = vis0.kjmo
	LEFT OUTER JOIN monat_kasse_kvj sub2 
		ON sub2.wup_id = vis0.wup_id AND sub2.mandant_id = vis0.mandant_id AND sub2.wrg_id = vis0.wrg_id AND sub2.kjmo = vis0.kjmo
) vtr 

UNION ALL
/* VTR250 Scans/min (KPOS) */ 
SELECT 250::INTEGER AS VTR_ID
	, mandant_id
	, nb_id
	, vs_id
	, vkl_id
	, wup_id
	, wrg_id
	, gj
	, kjmo
	, ist_fil AS FILIST
	, ist_fil2 AS FILIST2
	, kvj_fil AS FILKVJ
	, kvj_fil2 AS FILKVJ2
	, NULL AS FILPLAN
	, NULL AS FILPLAN2
	, ist_reg AS REGIST
	, ist_reg2 AS REGIST2
	, kvj_reg AS REGKVJ
	, kvj_reg2 AS REGKVJ2
	, ist_land AS LANDIST
	, ist_land2 AS LANDIST2
	, kvj_land AS LANDKVJ
	, kvj_land2 AS LANDKVJ2
	/* Rang absteigend = Scans/min IST (absolut) */
	, IFF(neo_fg * bus_fg = 1, DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, vs_id, kjmo ORDER BY fil_mo DESC NULLS LAST), NULL) AS FILMO_RANG
	, IFF(neo_fg * stl_fg = 1, DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, vs_id, gj ORDER BY fil_gj DESC NULLS LAST), NULL) AS FILGJ_RANG
	, IFF(vkl_fg * bus_fg = 1, DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, vs_id, kjmo ORDER BY vkl_mo DESC NULLS LAST), NULL) AS VKLMO_RANG
	, IFF(vkl_fg * stl_fg = 1, DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, vs_id, gj ORDER BY vkl_gj DESC NULLS LAST), NULL) AS VKLGJ_RANG
	, IFF(neo_fg * bus_fg = 1, fil_mo, NULL) AS FILMO_WERT
	, IFF(neo_fg * stl_fg = 1, fil_gj, NULL) AS FILGJ_WERT
	, IFF(vkl_fg * bus_fg = 1, vkl_mo, NULL) AS VKLMO_WERT
	, IFF(vkl_fg * stl_fg = 1, vkl_gj, NULL) AS VKLGJ_WERT
FROM ( 
	SELECT vis0.mandant_id, vis0.nb_id, vis0.wup_id, vis0.wrg_id, vis0.vs_id, vis0.vkl_id, vis0.gj, vis0.kjmo
		, vis0.neo_fg, vis0.vkl_fg, vis0.bus_fg, vis0.stl_fg
		, sub1.scans_ist AS ist_fil
		, sub1.mins_ist AS ist_fil2
		, sub2.scans_kvj AS kvj_fil
		, sub2.mins_kvj AS kvj_fil2
		/* Referenz Region_2/Land_2 */
		, SUM(ist_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vs_id) AS ist_reg
		, SUM(ist_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vs_id) AS ist_reg2
		, SUM(kvj_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vs_id) AS kvj_reg
		, SUM(kvj_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vs_id) AS kvj_reg2
		, SUM(ist_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo) AS ist_land
		, SUM(ist_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo) AS ist_land2
		, SUM(kvj_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo) AS kvj_land
		, SUM(kvj_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo) AS kvj_land2
		/* Setup Rang Filiale Monat_2 */
		, vis0.neo_fg * ist_fil AS ist_fil_mo
		, vis0.neo_fg * ist_fil2 AS ist_fil_mo2
		/* Setup Rang Filiale GJ */
		, SUM(vis0.neo_fg * vis0.stl_fg * vis0.bus_fg * ist_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.gj, vis0.wup_id) AS ist_fil_gj
		, SUM(vis0.neo_fg * vis0.stl_fg * vis0.bus_fg * ist_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.gj, vis0.wup_id) AS ist_fil_gj2
		/* Setup Rang VKL_2 Monat_2 */
		, SUM(vis0.neo_fg * vis0.vkl_fg * ist_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vkl_id) AS ist_vkl_mo
		, SUM(vis0.neo_fg * vis0.vkl_fg * ist_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vkl_id) AS ist_vkl_mo2
		/* Setup Rang VKL_2 BJ (BS) */
		, SUM(vis0.neo_fg * vis0.vkl_fg * vis0.stl_fg * vis0.bus_fg * ist_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.gj, vis0.vkl_id) AS ist_vkl_gj
		, SUM(vis0.neo_fg * vis0.vkl_fg * vis0.stl_fg * vis0.bus_fg * ist_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.gj, vis0.vkl_id) AS ist_vkl_gj2
		/* Rang absteigend = Scans/min IST (absolut) */
		, NULLIFZERO(vis0.neo_fg)               * (ist_fil_mo / NULLIFZERO(ist_fil_mo2)) AS fil_mo
		, NULLIFZERO(vis0.neo_fg * vis0.stl_fg) * (ist_fil_gj / NULLIFZERO(ist_fil_gj2)) AS fil_gj
		, NULLIFZERO(vis0.vkl_fg)               * (ist_vkl_mo / NULLIFZERO(ist_vkl_mo2)) AS vkl_mo
		, NULLIFZERO(vis0.vkl_fg * vis0.stl_fg) * (ist_vkl_gj / NULLIFZERO(ist_vkl_gj2)) AS vkl_gj
	FROM monat_fakt_wup vis0
	LEFT OUTER JOIN woche_ods_bon_ka_ist sub1 
		ON sub1.wup_id = vis0.wup_id AND sub1.mandant_id = vis0.mandant_id AND sub1.kjmo = vis0.kjmo /* ohne WRG_2 */
	LEFT OUTER JOIN woche_ods_bon_ka_kvj sub2 
		ON sub2.wup_id = vis0.wup_id AND sub2.mandant_id = vis0.mandant_id AND sub2.kjmo = vis0.kjmo /* ohne WRG_2 */
) vtr

UNION ALL
/* VTR255 Scans/min (DWH) -- ALT (VIS_TAG_KASSE_2) */ 
SELECT 255::INTEGER AS VTR_ID
	, mandant_id
	, nb_id
	, vs_id
	, vkl_id
	, wup_id
	, wrg_id
	, gj
	, kjmo
	, ist_fil AS FILIST
	, ist_fil2 AS FILIST2
	, kvj_fil AS FILKVJ
	, kvj_fil2 AS FILKVJ2
	, NULL AS FILPLAN
	, NULL AS FILPLAN2
	, ist_reg AS REGIST
	, ist_reg2 AS REGIST2
	, kvj_reg AS REGKVJ
	, kvj_reg2 AS REGKVJ2
	, ist_land AS LANDIST
	, ist_land2 AS LANDIST2
	, kvj_land AS LANDKVJ
	, kvj_land2 AS LANDKVJ2
	/* Rang absteigend = Scans/min IST (absolut) >>>> INAKTIV */
	, IFF(neo_fg * bus_fg = 1, DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, vs_id, kjmo ORDER BY fil_mo DESC NULLS LAST), NULL) AS FILMO_RANG
	, IFF(neo_fg * stl_fg = 1, DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, vs_id, gj ORDER BY fil_gj DESC NULLS LAST), NULL) AS FILGJ_RANG
	, IFF(vkl_fg * bus_fg = 1, DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, vs_id, kjmo ORDER BY vkl_mo DESC NULLS LAST), NULL) AS VKLMO_RANG
	, IFF(vkl_fg * stl_fg = 1, DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, vs_id, gj ORDER BY vkl_gj DESC NULLS LAST), NULL) AS VKLGJ_RANG
	, IFF(neo_fg * bus_fg = 1, fil_mo, NULL) AS FILMO_WERT
	, IFF(neo_fg * stl_fg = 1, fil_gj, NULL) AS FILGJ_WERT
	, IFF(vkl_fg * bus_fg = 1, vkl_mo, NULL) AS VKLMO_WERT
	, IFF(vkl_fg * stl_fg = 1, vkl_gj, NULL) AS VKLGJ_WERT
FROM ( 
	SELECT vis0.mandant_id, vis0.nb_id, vis0.wup_id, vis0.wrg_id, vis0.vs_id, vis0.vkl_id, vis0.gj, vis0.kjmo
		, vis0.neo_fg, vis0.vkl_fg, vis0.bus_fg, vis0.stl_fg
		, sub1.art_pos_ist AS ist_fil
		, sub1.scan_min_ist AS ist_fil2
		, sub2.art_pos_kvj AS kvj_fil
		, sub2.scan_min_kvj AS kvj_fil2
		/* Referenz Region_2/Land_2 */
		, SUM(ist_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vs_id) AS ist_reg
		, SUM(ist_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vs_id) AS ist_reg2
		, SUM(kvj_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vs_id) AS kvj_reg
		, SUM(kvj_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vs_id) AS kvj_reg2
		, SUM(ist_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo) AS ist_land
		, SUM(ist_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo) AS ist_land2
		, SUM(kvj_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo) AS kvj_land
		, SUM(kvj_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo) AS kvj_land2
		/* Setup Rang Filiale Monat_2 */
		, vis0.neo_fg * ist_fil AS ist_fil_mo
		, vis0.neo_fg * ist_fil2 AS ist_fil_mo2
		/* Setup Rang Filiale GJ */
		, SUM(vis0.neo_fg * vis0.stl_fg * vis0.bus_fg * ist_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.gj, vis0.wup_id) AS ist_fil_gj
		, SUM(vis0.neo_fg * vis0.stl_fg * vis0.bus_fg * ist_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.gj, vis0.wup_id) AS ist_fil_gj2
		/* Setup Rang VKL_2 Monat_2 */
		, SUM(vis0.neo_fg * vis0.vkl_fg * ist_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vkl_id) AS ist_vkl_mo
		, SUM(vis0.neo_fg * vis0.vkl_fg * ist_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vkl_id) AS ist_vkl_mo2
		/* Setup Rang VKL_2 BJ (BS) */
		, SUM(vis0.neo_fg * vis0.vkl_fg * vis0.stl_fg * vis0.bus_fg * ist_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.gj, vis0.vkl_id) AS ist_vkl_gj
		, SUM(vis0.neo_fg * vis0.vkl_fg * vis0.stl_fg * vis0.bus_fg * ist_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.gj, vis0.vkl_id) AS ist_vkl_gj2
		/* Rang absteigend = Scans/min IST (absolut)  >>>> INAKTIV */
		, NULLIFZERO(vis0.neo_fg)               * (ist_fil_mo / NULLIFZERO(ist_fil_mo2)) AS fil_mo
		, NULLIFZERO(vis0.neo_fg * vis0.stl_fg) * (ist_fil_gj / NULLIFZERO(ist_fil_gj2)) AS fil_gj
		, NULLIFZERO(vis0.vkl_fg)               * (ist_vkl_mo / NULLIFZERO(ist_vkl_mo2)) AS vkl_mo
		, NULLIFZERO(vis0.vkl_fg * vis0.stl_fg) * (ist_vkl_gj / NULLIFZERO(ist_vkl_gj2)) AS vkl_gj
	FROM monat_fakt_wup vis0
	LEFT OUTER JOIN monat_kasse_ist sub1 
		ON sub1.wup_id = vis0.wup_id AND sub1.mandant_id = vis0.mandant_id AND sub1.wrg_id = vis0.wrg_id AND sub1.kjmo = vis0.kjmo
	LEFT OUTER JOIN monat_kasse_kvj sub2 
		ON sub2.wup_id = vis0.wup_id AND sub2.mandant_id = vis0.mandant_id AND sub2.wrg_id = vis0.wrg_id AND sub2.kjmo = vis0.kjmo
) vtr

UNION ALL
/* VTR270 Personalkosten_2 */ 
SELECT 270::INTEGER AS VTR_ID
	, mandant_id
	, nb_id
	, vs_id
	, vkl_id
	, wup_id
	, wrg_id
	, gj
	, kjmo
	, ist_fil AS FILIST
	, NULL AS FILIST2
	, kvj_fil AS FILKVJ
	, NULL AS FILKVJ2
	, NULL AS FILPLAN /* Kein Plan auf Ebene Filiale */
	, NULL AS FILPLAN2
	, ist_reg AS REGIST
	, NULL AS REGIST2
	, kvj_reg AS REGKVJ
	, NULL AS REGKVJ2
	, ist_land AS LANDIST
	, NULL AS LANDIST2
	, kvj_land AS LANDKVJ
	, NULL AS LANDKVJ2
	/* ohne Rang : Personalkosten_2 */
	, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL 
FROM ( 
	SELECT vis0.mandant_id, vis0.nb_id, vis0.wup_id, vis0.wrg_id, vis0.vs_id, vis0.vkl_id, vis0.gj, vis0.kjmo
		, vis0.neo_fg, vis0.vkl_fg, vis0.bus_fg, vis0.stl_fg
		, vis0.kst_ist AS ist_fil
		, vis0.kst_kvj AS kvj_fil
		, vis0.kst_plan AS plan_fil /* Kein Plan auf Ebene Filiale */
		/* Referenz Region_2/Land_2 */
		, SUM(ist_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vs_id) AS ist_reg
		, SUM(kvj_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vs_id) AS kvj_reg
		, SUM(ist_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo) AS ist_land
		, SUM(kvj_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo) AS kvj_land
	FROM monat_fakt_wup vis0
) vtr 

UNION ALL
/* VTR275 Personalkosten_2 (%) */ 
SELECT 275::INTEGER AS VTR_ID
	, mandant_id
	, nb_id
	, vs_id
	, vkl_id
	, wup_id
	, wrg_id
	, gj
	, kjmo
	, ist_fil AS FILIST
	, ist_fil2 AS FILIST2
	, kvj_fil AS FILKVJ
	, kvj_fil2 AS FILKVJ2
	, NULL AS FILPLAN /* Kein Plan auf Ebene Filiale */
	, NULL AS FILPLAN2
	, ist_reg AS REGIST
	, ist_reg2 AS REGIST2
	, kvj_reg AS REGKVJ
	, kvj_reg2 AS REGKVJ2
	, ist_land AS LANDIST
	, ist_land2 AS LANDIST2
	, kvj_land AS LANDKVJ
	, kvj_land2 AS LANDKVJ2
	/* Rang absteigend = Personalkosten_2 IST% */
	, IFF(neo_fg * bus_fg = 1, DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, vs_id, kjmo ORDER BY fil_mo DESC NULLS LAST), NULL) AS FILMO_RANG
	, IFF(neo_fg * stl_fg = 1, DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, vs_id, gj ORDER BY fil_gj DESC NULLS LAST), NULL) AS FILGJ_RANG
	, IFF(vkl_fg * bus_fg = 1, DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, vs_id, kjmo ORDER BY vkl_mo DESC NULLS LAST), NULL) AS VKLMO_RANG
	, IFF(vkl_fg * stl_fg = 1, DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, vs_id, gj ORDER BY vkl_gj DESC NULLS LAST), NULL) AS VKLGJ_RANG
	, IFF(neo_fg * bus_fg = 1, fil_mo, NULL) AS FILMO_WERT
	, IFF(neo_fg * stl_fg = 1, fil_gj, NULL) AS FILGJ_WERT
	, IFF(vkl_fg * bus_fg = 1, vkl_mo, NULL) AS VKLMO_WERT
	, IFF(vkl_fg * stl_fg = 1, vkl_gj, NULL) AS VKLGJ_WERT
FROM ( 
	SELECT vis0.mandant_id, vis0.nb_id, vis0.wup_id, vis0.wrg_id, vis0.vs_id, vis0.vkl_id, vis0.gj, vis0.kjmo
		, vis0.neo_fg, vis0.vkl_fg, vis0.bus_fg, vis0.stl_fg
		, vis0.kst_ist AS ist_fil
		, vis0.ums_ist AS ist_fil2
		, vis0.kst_kvj AS kvj_fil
		, vis0.ums_kvj AS kvj_fil2
		, vis0.kst_plan AS plan_fil /* Kein Plan auf Ebene Filiale */
		, vis0.ums_plan AS plan_fil2
		/* Referenz Region_2/Land_2 */
		, SUM(ist_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vs_id) AS ist_reg
		, SUM(ist_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vs_id) AS ist_reg2
		, SUM(kvj_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vs_id) AS kvj_reg
		, SUM(kvj_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vs_id) AS kvj_reg2
		, SUM(ist_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo) AS ist_land
		, SUM(ist_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo) AS ist_land2
		, SUM(kvj_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo) AS kvj_land
		, SUM(kvj_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo) AS kvj_land2
		/* Setup Rang Filiale Monat_2 */
		, vis0.neo_fg * ist_fil AS ist_fil_mo
		, vis0.neo_fg * ist_fil2 AS ist_fil_mo2
		/* Setup Rang Filiale GJ */
		, SUM(vis0.neo_fg * vis0.stl_fg * vis0.bus_fg * ist_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.gj, vis0.wup_id) AS ist_fil_gj
		, SUM(vis0.neo_fg * vis0.stl_fg * vis0.bus_fg * ist_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.gj, vis0.wup_id) AS ist_fil_gj2
		/* Setup Rang VKL_2 Monat_2 */
		, SUM(vis0.neo_fg * vis0.vkl_fg * ist_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vkl_id) AS ist_vkl_mo
		, SUM(vis0.neo_fg * vis0.vkl_fg * ist_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vkl_id) AS ist_vkl_mo2
		/* Setup Rang VKL_2 BJ (BS) */
		, SUM(vis0.neo_fg * vis0.vkl_fg * vis0.stl_fg * vis0.bus_fg * ist_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.gj, vis0.vkl_id) AS ist_vkl_gj
		, SUM(vis0.neo_fg * vis0.vkl_fg * vis0.stl_fg * vis0.bus_fg * ist_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.gj, vis0.vkl_id) AS ist_vkl_gj2
		/* Rang absteigend = Personalkosten_2 IST% */
		, NULLIFZERO(vis0.neo_fg)               * (ist_fil_mo / NULLIFZERO(ist_fil_mo2)) AS fil_mo
		, NULLIFZERO(vis0.neo_fg * vis0.stl_fg) * (ist_fil_gj / NULLIFZERO(ist_fil_gj2)) AS fil_gj
		, NULLIFZERO(vis0.vkl_fg)               * (ist_vkl_mo / NULLIFZERO(ist_vkl_mo2)) AS vkl_mo
		, NULLIFZERO(vis0.vkl_fg * vis0.stl_fg) * (ist_vkl_gj / NULLIFZERO(ist_vkl_gj2)) AS vkl_gj
	FROM monat_fakt_wup vis0
) vtr 

UNION ALL
/* VTR300 Abschriften_2 operativ */ 
SELECT 300::INTEGER AS VTR_ID
	, mandant_id
	, nb_id
	, vs_id
	, vkl_id
	, wup_id
	, wrg_id
	, gj
	, kjmo
	, ist_fil AS FILIST
	, NULL AS FILIST2
	, kvj_fil AS FILKVJ
	, NULL AS FILKVJ2
	, NULL AS FILPLAN
	, NULL AS FILPLAN2
	, ist_reg AS REGIST
	, NULL AS REGIST2
	, kvj_reg AS REGKVJ
	, NULL AS REGKVJ2
	, ist_land AS LANDIST
	, NULL AS LANDIST2
	, kvj_land AS LANDKVJ
	, NULL AS LANDKVJ2
	/* ohne Rang */
	, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL 
FROM ( 
	SELECT vis0.mandant_id, vis0.nb_id, vis0.wup_id, vis0.wrg_id, vis0.vs_id, vis0.vkl_id, vis0.gj, vis0.kjmo
		, vis0.neo_fg, vis0.vkl_fg, vis0.bus_fg, vis0.stl_fg
		, sub1.abs_op_ist AS ist_fil
		, sub1.abs_op_kvj AS kvj_fil
		/* Referenz Region_2/Land_2 */
		, SUM(ist_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vs_id) AS ist_reg
		, SUM(kvj_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vs_id) AS kvj_reg
		, SUM(ist_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo) AS ist_land
		, SUM(kvj_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo) AS kvj_land
	FROM monat_fakt_wup vis0
	LEFT OUTER JOIN monat_abschriften sub1 
		ON sub1.wup_id = vis0.wup_id AND sub1.mandant_id = vis0.mandant_id AND sub1.wrg_id = vis0.wrg_id AND sub1.kjmo = vis0.kjmo
) vtr 

UNION ALL
/* VTR310 Abschriften_2 operativ (%) */ 
SELECT 310::INTEGER AS VTR_ID
	, mandant_id
	, nb_id
	, vs_id
	, vkl_id
	, wup_id
	, wrg_id
	, gj
	, kjmo
	, ist_fil AS FILIST
	, ist_fil2 AS FILIST2
	, kvj_fil AS FILKVJ
	, kvj_fil2 AS FILKVJ2
	, plan_fil AS FILPLAN
	, plan_fil2 AS FILPLAN2
	, ist_reg AS REGIST
	, ist_reg2 AS REGIST2
	, kvj_reg AS REGKVJ
	, kvj_reg2 AS REGKVJ2
	, ist_land AS LANDIST
	, ist_land2 AS LANDIST2
	, kvj_land AS LANDKVJ
	, kvj_land2 AS LANDKVJ2
	/* Rang absteigend = Abschriften_2 operativ ∆Plan %p */
	, IFF(neo_fg * bus_fg = 1, DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, vs_id, kjmo ORDER BY fil_mo DESC NULLS LAST), NULL) AS FILMO_RANG
	, IFF(neo_fg * stl_fg = 1, DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, vs_id, gj   ORDER BY fil_gj DESC NULLS LAST), NULL) AS FILGJ_RANG
	, IFF(vkl_fg * bus_fg = 1, DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, vs_id, kjmo ORDER BY vkl_mo DESC NULLS LAST), NULL) AS VKLMO_RANG
	, IFF(vkl_fg * stl_fg = 1, DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, vs_id, gj   ORDER BY vkl_gj DESC NULLS LAST), NULL) AS VKLGJ_RANG
	, IFF(neo_fg * bus_fg = 1, fil_mo * 100, NULL) AS FILMO_WERT
	, IFF(neo_fg * stl_fg = 1, fil_gj * 100, NULL) AS FILGJ_WERT
	, IFF(vkl_fg * bus_fg = 1, vkl_mo * 100, NULL) AS VKLMO_WERT
	, IFF(vkl_fg * stl_fg = 1, vkl_gj * 100, NULL) AS VKLGJ_WERT
FROM ( 
	SELECT vis0.mandant_id, vis0.nb_id, vis0.wup_id, vis0.wrg_id, vis0.vs_id, vis0.vkl_id, vis0.gj, vis0.kjmo
		, vis0.neo_fg, vis0.vkl_fg, vis0.bus_fg, vis0.stl_fg
		, sub1.abs_op_ist AS ist_fil
		, sub1.abs_op_kvj AS kvj_fil
		, sub2.ums_ware_ist AS ist_fil2
		, sub2.ums_ware_kvj AS kvj_fil2
		, sub3.abs_ware_plan AS plan_fil
		, sub3.ums_ware_plan AS plan_fil2
		/* Referenz Region_2/Land_2 */
		, SUM(ist_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vs_id) AS ist_reg
		, SUM(ist_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vs_id) AS ist_reg2
		, SUM(kvj_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vs_id) AS kvj_reg
		, SUM(kvj_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vs_id) AS kvj_reg2
		, SUM(ist_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo) AS ist_land
		, SUM(ist_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo) AS ist_land2
		, SUM(kvj_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo) AS kvj_land
		, SUM(kvj_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo) AS kvj_land2
		/* Setup Rang Filiale Monat_2 */
		, vis0.neo_fg * ist_fil AS ist_fil_mo
		, vis0.neo_fg * ist_fil2 AS ist_fil_mo2
		, vis0.neo_fg * plan_fil AS plan_fil_mo
		, vis0.neo_fg * plan_fil2 AS plan_fil_mo2
		/* Setup Rang Filiale GJ */
		, SUM(vis0.neo_fg * vis0.stl_fg * vis0.bus_fg * ist_fil)   OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.gj, vis0.wup_id) AS ist_fil_gj
		, SUM(vis0.neo_fg * vis0.stl_fg * vis0.bus_fg * ist_fil2)  OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.gj, vis0.wup_id) AS ist_fil_gj2
		, SUM(vis0.neo_fg * vis0.stl_fg * vis0.bus_fg * plan_fil)  OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.gj, vis0.wup_id) AS plan_fil_gj
		, SUM(vis0.neo_fg * vis0.stl_fg * vis0.bus_fg * plan_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.gj, vis0.wup_id) AS plan_fil_gj2
		/* Setup Rang VKL_2 Monat_2 */
		, SUM(vis0.neo_fg * vis0.vkl_fg * ist_fil)   OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vkl_id) AS ist_vkl_mo
		, SUM(vis0.neo_fg * vis0.vkl_fg * ist_fil2)  OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vkl_id) AS ist_vkl_mo2
		, SUM(vis0.neo_fg * vis0.vkl_fg * plan_fil)  OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vkl_id) AS plan_vkl_mo
		, SUM(vis0.neo_fg * vis0.vkl_fg * plan_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vkl_id) AS plan_vkl_mo2
		/* Setup Rang VKL_2 BJ (BS) */
		, SUM(vis0.neo_fg * vis0.vkl_fg * vis0.stl_fg * vis0.bus_fg * ist_fil)   OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.gj, vis0.vkl_id) AS ist_vkl_gj
		, SUM(vis0.neo_fg * vis0.vkl_fg * vis0.stl_fg * vis0.bus_fg * ist_fil2)  OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.gj, vis0.vkl_id) AS ist_vkl_gj2
		, SUM(vis0.neo_fg * vis0.vkl_fg * vis0.stl_fg * vis0.bus_fg * plan_fil)  OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.gj, vis0.vkl_id) AS plan_vkl_gj
		, SUM(vis0.neo_fg * vis0.vkl_fg * vis0.stl_fg * vis0.bus_fg * plan_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.gj, vis0.vkl_id) AS plan_vkl_gj2
		/* Rang absteigend = Abschriften_2 operativ ∆Plan %p */
		, NULLIFZERO(vis0.neo_fg)               * ((ist_fil_mo / NULLIFZERO(ist_fil_mo2)) - (plan_fil_mo / NULLIFZERO(plan_fil_mo2))) AS fil_mo
		, NULLIFZERO(vis0.neo_fg * vis0.stl_fg) * ((ist_fil_gj / NULLIFZERO(ist_fil_gj2)) - (plan_fil_gj / NULLIFZERO(plan_fil_gj2))) AS fil_gj
		, NULLIFZERO(vis0.vkl_fg)               * ((ist_vkl_mo / NULLIFZERO(ist_vkl_mo2)) - (plan_vkl_mo / NULLIFZERO(plan_vkl_mo2))) AS vkl_mo
		, NULLIFZERO(vis0.vkl_fg * vis0.stl_fg) * ((ist_vkl_gj / NULLIFZERO(ist_vkl_gj2)) - (plan_vkl_gj / NULLIFZERO(plan_vkl_gj2))) AS vkl_gj
	FROM monat_fakt_wup vis0
	LEFT OUTER JOIN monat_abschriften sub1 
		ON sub1.wup_id = vis0.wup_id AND sub1.mandant_id = vis0.mandant_id AND sub1.wrg_id = vis0.wrg_id AND sub1.kjmo = vis0.kjmo
	LEFT OUTER JOIN monat_fakt_ware sub2 
		ON sub2.wup_id = vis0.wup_id AND sub2.mandant_id = vis0.mandant_id AND sub2.wrg_id = vis0.wrg_id AND sub2.kjmo = vis0.kjmo
	LEFT OUTER JOIN monat_plan_ware sub3 
		ON sub3.wup_id = vis0.wup_id AND sub3.mandant_id = vis0.mandant_id AND sub3.wrg_id = vis0.wrg_id AND sub3.kjmo = vis0.kjmo
) vtr 

UNION ALL
/* VTR320 Abschriften_2 Ultra Frische (%) */ 
SELECT 320::INTEGER AS VTR_ID
	, mandant_id
	, nb_id
	, vs_id
	, vkl_id
	, wup_id
	, wrg_id
	, gj
	, kjmo
	, ist_fil AS FILIST
	, ist_fil2 AS FILIST2
	, kvj_fil AS FILKVJ
	, kvj_fil2 AS FILKVJ2
	, plan_fil AS FILPLAN
	, plan_fil2 AS FILPLAN2
	, ist_reg AS REGIST
	, ist_reg2 AS REGIST2
	, kvj_reg AS REGKVJ
	, kvj_reg2 AS REGKVJ2
	, ist_land AS LANDIST
	, ist_land2 AS LANDIST2
	, kvj_land AS LANDKVJ
	, kvj_land2 AS LANDKVJ2
	/* ohne Rang */
	, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL 
FROM ( 
	SELECT vis0.mandant_id, vis0.nb_id, vis0.wup_id, vis0.wrg_id, vis0.vs_id, vis0.vkl_id, vis0.gj, vis0.kjmo
		, vis0.neo_fg, vis0.vkl_fg, vis0.bus_fg, vis0.stl_fg
		, sub1.abs_ulf_ist AS ist_fil
		, sub1.abs_ulf_kvj AS kvj_fil
		, sub2.ums_ulf_ist AS ist_fil2
		, sub2.ums_ulf_kvj AS kvj_fil2
		, sub3.ums_ulf_plan AS plan_fil2
		, sub3.abs_ulf_plan AS plan_fil
		/* Referenz Region_2/Land_2 */
		, SUM(ist_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vs_id) AS ist_reg
		, SUM(ist_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vs_id) AS ist_reg2
		, SUM(kvj_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vs_id) AS kvj_reg
		, SUM(kvj_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vs_id) AS kvj_reg2
		, SUM(ist_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo) AS ist_land
		, SUM(ist_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo) AS ist_land2
		, SUM(kvj_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo) AS kvj_land
		, SUM(kvj_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo) AS kvj_land2
	FROM monat_fakt_wup vis0
	LEFT OUTER JOIN monat_abschriften sub1 
		ON sub1.wup_id = vis0.wup_id AND sub1.mandant_id = vis0.mandant_id AND sub1.wrg_id = vis0.wrg_id AND sub1.kjmo = vis0.kjmo
	LEFT OUTER JOIN monat_fakt_ware sub2 
		ON sub2.wup_id = vis0.wup_id AND sub2.mandant_id = vis0.mandant_id AND sub2.wrg_id = vis0.wrg_id AND sub2.kjmo = vis0.kjmo
	LEFT OUTER JOIN monat_plan_ware sub3 
		ON sub3.wup_id = vis0.wup_id AND sub3.mandant_id = vis0.mandant_id AND sub3.wrg_id = vis0.wrg_id AND sub3.kjmo = vis0.kjmo
) vtr 

UNION ALL
/* VTR340 Preisabschriften (%) */ 
SELECT 340::INTEGER AS VTR_ID
	, mandant_id
	, nb_id
	, vs_id
	, vkl_id
	, wup_id
	, wrg_id
	, gj
	, kjmo
	, ist_fil AS FILIST
	, ist_fil2 AS FILIST2
	, kvj_fil AS FILKVJ
	, kvj_fil2 AS FILKVJ2
	, NULL AS FILPLAN
	, NULL AS FILPLAN2
	, ist_reg AS REGIST
	, ist_reg2 AS REGIST2
	, kvj_reg AS REGKVJ
	, kvj_reg2 AS REGKVJ2
	, ist_land AS LANDIST
	, ist_land2 AS LANDIST2
	, kvj_land AS LANDKVJ
	, kvj_land2 AS LANDKVJ2
	/* ohne Rang */
	, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL 
FROM ( 
	SELECT vis0.mandant_id, vis0.nb_id, vis0.wup_id, vis0.wrg_id, vis0.vs_id, vis0.vkl_id, vis0.gj, vis0.kjmo
		, vis0.neo_fg, vis0.vkl_fg, vis0.bus_fg, vis0.stl_fg
		, sub1.abs_pa_ist AS ist_fil
		, sub1.abs_pa_kvj AS kvj_fil
		, sub2.ums_ware_ist AS ist_fil2
		, sub2.ums_ware_kvj AS kvj_fil2
		/* Referenz Region_2/Land_2 */
		, SUM(ist_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vs_id) AS ist_reg
		, SUM(ist_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vs_id) AS ist_reg2
		, SUM(kvj_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vs_id) AS kvj_reg
		, SUM(kvj_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vs_id) AS kvj_reg2
		, SUM(ist_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo) AS ist_land
		, SUM(ist_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo) AS ist_land2
		, SUM(kvj_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo) AS kvj_land
		, SUM(kvj_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo) AS kvj_land2
	FROM monat_fakt_wup vis0
	LEFT OUTER JOIN monat_abschriften sub1 
		ON sub1.wup_id = vis0.wup_id AND sub1.mandant_id = vis0.mandant_id AND sub1.wrg_id = vis0.wrg_id AND sub1.kjmo = vis0.kjmo
	LEFT OUTER JOIN monat_fakt_ware sub2 
		ON sub2.wup_id = vis0.wup_id AND sub2.mandant_id = vis0.mandant_id AND sub2.wrg_id = vis0.wrg_id AND sub2.kjmo = vis0.kjmo
) vtr 

UNION ALL
/* VTR345 Preisabschriften Anteil */ 
SELECT 345::INTEGER AS VTR_ID
	, mandant_id
	, nb_id
	, vs_id
	, vkl_id
	, wup_id
	, wrg_id
	, gj
	, kjmo
	, ist_fil AS FILIST
	, ist_fil2 AS FILIST2
	, kvj_fil AS FILKVJ
	, kvj_fil2 AS FILKVJ2
	, NULL AS FILPLAN
	, NULL AS FILPLAN2
	, ist_reg AS REGIST
	, ist_reg2 AS REGIST2
	, kvj_reg AS REGKVJ
	, kvj_reg2 AS REGKVJ2
	, ist_land AS LANDIST
	, ist_land2 AS LANDIST2
	, kvj_land AS LANDKVJ
	, kvj_land2 AS LANDKVJ2
	/* ohne Rang */
	, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL 
FROM ( 
	SELECT vis0.mandant_id, vis0.nb_id, vis0.wup_id, vis0.wrg_id, vis0.vs_id, vis0.vkl_id, vis0.gj, vis0.kjmo
		, vis0.neo_fg, vis0.vkl_fg, vis0.bus_fg, vis0.stl_fg
		, sub1.abs_pa_ist AS ist_fil
		, sub1.abs_pa_kvj AS kvj_fil
		, sub1.abs_op_ist AS ist_fil2
		, sub1.abs_op_kvj AS kvj_fil2
		/* Referenz Region_2/Land_2 */
		, SUM(ist_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vs_id) AS ist_reg
		, SUM(ist_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vs_id) AS ist_reg2
		, SUM(kvj_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vs_id) AS kvj_reg
		, SUM(kvj_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vs_id) AS kvj_reg2
		, SUM(ist_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo) AS ist_land
		, SUM(ist_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo) AS ist_land2
		, SUM(kvj_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo) AS kvj_land
		, SUM(kvj_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo) AS kvj_land2
	FROM monat_fakt_wup vis0
	LEFT OUTER JOIN monat_abschriften sub1 
		ON sub1.wup_id = vis0.wup_id AND sub1.mandant_id = vis0.mandant_id AND sub1.wrg_id = vis0.wrg_id AND sub1.kjmo = vis0.kjmo
) vtr 

UNION ALL
/* VTR360 Totalabschriften (%) */ 
SELECT 360::INTEGER AS VTR_ID
	, mandant_id
	, nb_id
	, vs_id
	, vkl_id
	, wup_id
	, wrg_id
	, gj
	, kjmo
	, ist_fil AS FILIST
	, ist_fil2 AS FILIST2
	, kvj_fil AS FILKVJ
	, kvj_fil2 AS FILKVJ2
	, NULL AS FILPLAN
	, NULL AS FILPLAN2
	, ist_reg AS REGIST
	, ist_reg2 AS REGIST2
	, kvj_reg AS REGKVJ
	, kvj_reg2 AS REGKVJ2
	, ist_land AS LANDIST
	, ist_land2 AS LANDIST2
	, kvj_land AS LANDKVJ
	, kvj_land2 AS LANDKVJ2
	/* ohne Rang */
	, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL 
FROM ( 
	SELECT vis0.mandant_id, vis0.nb_id, vis0.wup_id, vis0.wrg_id, vis0.vs_id, vis0.vkl_id, vis0.gj, vis0.kjmo
		, vis0.neo_fg, vis0.vkl_fg, vis0.bus_fg, vis0.stl_fg
		, sub1.abs_ta_ist AS ist_fil
		, sub1.abs_ta_kvj AS kvj_fil
		, sub2.ums_ware_ist AS ist_fil2
		, sub2.ums_ware_kvj AS kvj_fil2
		/* Referenz Region_2/Land_2 */
		, SUM(ist_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vs_id) AS ist_reg
		, SUM(ist_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vs_id) AS ist_reg2
		, SUM(kvj_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vs_id) AS kvj_reg
		, SUM(kvj_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vs_id) AS kvj_reg2
		, SUM(ist_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo) AS ist_land
		, SUM(ist_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo) AS ist_land2
		, SUM(kvj_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo) AS kvj_land
		, SUM(kvj_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo) AS kvj_land2
	FROM monat_fakt_wup vis0
	LEFT OUTER JOIN monat_abschriften sub1 
		ON sub1.wup_id = vis0.wup_id AND sub1.mandant_id = vis0.mandant_id AND sub1.wrg_id = vis0.wrg_id AND sub1.kjmo = vis0.kjmo
	LEFT OUTER JOIN monat_fakt_ware sub2 
		ON sub2.wup_id = vis0.wup_id AND sub2.mandant_id = vis0.mandant_id AND sub2.wrg_id = vis0.wrg_id AND sub2.kjmo = vis0.kjmo
) vtr 

UNION ALL
/* VTR365 Totalabschriften Anteil */ 
SELECT 365::INTEGER AS VTR_ID
	, mandant_id
	, nb_id
	, vs_id
	, vkl_id
	, wup_id
	, wrg_id
	, gj
	, kjmo
	, ist_fil AS FILIST
	, ist_fil2 AS FILIST2
	, kvj_fil AS FILKVJ
	, kvj_fil2 AS FILKVJ2
	, NULL AS FILPLAN
	, NULL AS FILPLAN2
	, ist_reg AS REGIST
	, ist_reg2 AS REGIST2
	, kvj_reg AS REGKVJ
	, kvj_reg2 AS REGKVJ2
	, ist_land AS LANDIST
	, ist_land2 AS LANDIST2
	, kvj_land AS LANDKVJ
	, kvj_land2 AS LANDKVJ2
	/* ohne Rang */
	, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL 
FROM ( 
	SELECT vis0.mandant_id, vis0.nb_id, vis0.wup_id, vis0.wrg_id, vis0.vs_id, vis0.vkl_id, vis0.gj, vis0.kjmo
		, vis0.neo_fg, vis0.vkl_fg, vis0.bus_fg, vis0.stl_fg
		, sub1.abs_ta_ist AS ist_fil
		, sub1.abs_ta_kvj AS kvj_fil
		, sub1.abs_op_ist AS ist_fil2
		, sub1.abs_op_kvj AS kvj_fil2
		/* Referenz Region_2/Land_2 */
		, SUM(ist_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vs_id) AS ist_reg
		, SUM(ist_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vs_id) AS ist_reg2
		, SUM(kvj_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vs_id) AS kvj_reg
		, SUM(kvj_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vs_id) AS kvj_reg2
		, SUM(ist_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo) AS ist_land
		, SUM(ist_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo) AS ist_land2
		, SUM(kvj_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo) AS kvj_land
		, SUM(kvj_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo) AS kvj_land2
	FROM monat_fakt_wup vis0
	LEFT OUTER JOIN monat_abschriften sub1 
		ON sub1.wup_id = vis0.wup_id AND sub1.mandant_id = vis0.mandant_id AND sub1.wrg_id = vis0.wrg_id AND sub1.kjmo = vis0.kjmo
) vtr 

UNION ALL
/* VTR410 Inventurdifferenz Ultra-Frische */ 
SELECT 410::INTEGER AS VTR_ID
	, mandant_id
	, nb_id
	, vs_id
	, vkl_id
	, wup_id
	, wrg_id
	, gj
	, kjmo
	, ist_fil AS FILIST
	, ist_fil2 AS FILIST2
	, NULL 
	, NULL 
	, NULL 
	, NULL 
	, ist_reg AS REGIST
	, ist_reg2 AS REGIST2
	, NULL 
	, NULL 
	, ist_land AS LANDIST
	, ist_land2 AS LANDIST2
	, NULL 
	, NULL 
	/* Rang absteigend = Inventurdifferenz Ultra-Frische IST % */
	, IFF(neo_fg * bus_fg = 1, DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, vs_id, kjmo ORDER BY fil_mo DESC NULLS LAST), NULL) AS FILMO_RANG
	, IFF(neo_fg * stl_fg = 1, DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, vs_id, gj ORDER BY fil_gj DESC NULLS LAST), NULL) AS FILGJ_RANG
	, IFF(vkl_fg * bus_fg = 1, DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, vs_id, kjmo ORDER BY vkl_mo DESC NULLS LAST), NULL) AS VKLMO_RANG
	, IFF(vkl_fg * stl_fg = 1, DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, vs_id, gj ORDER BY vkl_gj DESC NULLS LAST), NULL) AS VKLGJ_RANG
	, IFF(neo_fg * bus_fg = 1, fil_mo, NULL) AS FILMO_WERT
	, IFF(neo_fg * stl_fg = 1, fil_gj, NULL) AS FILGJ_WERT
	, IFF(vkl_fg * bus_fg = 1, vkl_mo, NULL) AS VKLMO_WERT
	, IFF(vkl_fg * stl_fg = 1, vkl_gj, NULL) AS VKLGJ_WERT
FROM ( 
	SELECT vis0.mandant_id, vis0.nb_id, vis0.wup_id, vis0.wrg_id, vis0.vs_id, vis0.vkl_id, vis0.gj, vis0.kjmo
		, vis0.neo_fg, vis0.vkl_fg, vis0.bus_fg, vis0.stl_fg
		, sub1.inv_wert_ist AS ist_fil
		, sub1.inv_ums_ist  AS ist_fil2
		/* Referenz Region_2/Land_2 */
		, SUM(ist_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vs_id) AS ist_reg
		, SUM(ist_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vs_id) AS ist_reg2
		, SUM(ist_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo) AS ist_land
		, SUM(ist_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo) AS ist_land2
		/* Setup Rang Filiale Monat_2 */
		, vis0.neo_fg * ist_fil AS ist_fil_mo
		, vis0.neo_fg * ist_fil2 AS ist_fil_mo2
		/* Setup Rang Filiale GJ */
		, SUM(vis0.neo_fg * vis0.stl_fg * vis0.bus_fg * ist_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.gj, vis0.wup_id) AS ist_fil_gj
		, SUM(vis0.neo_fg * vis0.stl_fg * vis0.bus_fg * ist_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.gj, vis0.wup_id) AS ist_fil_gj2
		/* Setup Rang VKL_2 Monat_2 */
		, SUM(vis0.neo_fg * vis0.vkl_fg * ist_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vkl_id) AS ist_vkl_mo
		, SUM(vis0.neo_fg * vis0.vkl_fg * ist_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vkl_id) AS ist_vkl_mo2
		/* Setup Rang VKL_2 BJ (BS) */
		, SUM(vis0.neo_fg * vis0.vkl_fg * vis0.stl_fg * vis0.bus_fg * ist_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.gj, vis0.vkl_id) AS ist_vkl_gj
		, SUM(vis0.neo_fg * vis0.vkl_fg * vis0.stl_fg * vis0.bus_fg * ist_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.gj, vis0.vkl_id) AS ist_vkl_gj2
		/* Rang absteigend = Inventurdifferenz Ultra-Frische IST % */
		, NULLIFZERO(vis0.neo_fg)               * (ist_fil_mo / NULLIFZERO(ist_fil_mo2)) AS fil_mo
		, NULLIFZERO(vis0.neo_fg * vis0.stl_fg) * (ist_fil_gj / NULLIFZERO(ist_fil_gj2)) AS fil_gj
		, NULLIFZERO(vis0.vkl_fg)               * (ist_vkl_mo / NULLIFZERO(ist_vkl_mo2)) AS vkl_mo
		, NULLIFZERO(vis0.vkl_fg * vis0.stl_fg) * (ist_vkl_gj / NULLIFZERO(ist_vkl_gj2)) AS vkl_gj
	FROM monat_fakt_wup vis0
	LEFT OUTER JOIN monat_inventur sub1 
		ON sub1.wup_id = vis0.wup_id AND sub1.mandant_id = vis0.mandant_id AND sub1.wrg_id = vis0.wrg_id AND sub1.kjmo = vis0.kjmo
) vtr 

UNION ALL
/* VTR420 Bestandsentwicklung */
SELECT 420::INTEGER AS VTR_ID
	, mandant_id
	, nb_id
	, vs_id
	, vkl_id
	, wup_id
	, wrg_id
	, gj
	, kjmo
	, ist_fil AS FILIST
	, NULL AS FILIST2
	, NULL AS FILKVJ
	, NULL AS FILKVJ2
	, NULL AS FILPLAN
	, NULL AS FILPLAN2
	, ist_reg AS REGIST
	, NULL AS REGIST2
	, NULL AS REGKVJ
	, NULL AS REGKVJ2
	, ist_land AS LANDIST
	, NULL AS LANDIST2
	, NULL AS LANDKVJ
	, NULL AS LANDKVJ2
	/* ohne Rang */
	, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
FROM ( 
	SELECT vis0.mandant_id, vis0.nb_id, vis0.wup_id, vis0.wrg_id, vis0.vs_id, vis0.vkl_id, vis0.gj, vis0.kjmo
		, vis0.neo_fg, vis0.vkl_fg, vis0.bus_fg, vis0.stl_fg
		, sub1.big_fg
		, sub1.big_best_entw AS ist_fil
		/* Referenz Region_2/Land_2 */
		, SUM(ist_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vs_id) AS ist_reg
		, SUM(ist_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo) AS ist_land
	FROM monat_fakt_wup vis0
	LEFT OUTER JOIN monat_big sub1 
		ON sub1.wup_id = vis0.wup_id AND sub1.mandant_id = vis0.mandant_id AND sub1.wrg_id = vis0.wrg_id AND sub1.kjmo = vis0.kjmo
) vtr 

UNION ALL
/* VTR425 Bestandsentw. zum Umsatz */
SELECT 425::INTEGER AS VTR_ID
	, mandant_id
	, nb_id
	, vs_id
	, vkl_id
	, wup_id
	, wrg_id
	, gj
	, kjmo
	, ist_fil AS FILIST
	, ist_fil2 AS FILIST2
	, NULL AS FILKVJ
	, NULL AS FILKVJ2
	, NULL AS FILPLAN
	, NULL AS FILPLAN2
	, ist_reg AS REGIST
	, ist_reg2 AS REGIST2
	, NULL AS REGKVJ
	, NULL AS REGKVJ2
	, ist_land AS LANDIST
	, ist_land2 AS LANDIST2
	, NULL AS LANDKVJ
	, NULL AS LANDKVJ2
	/* Rang aufsteigend = Bestandsentw. zum Umsatz IST% >> big_fg = Ausblenden leerer Monate */
	, IFF(big_fg * neo_fg * bus_fg = 1, DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, vs_id, kjmo ORDER BY fil_mo ASC NULLS LAST), NULL) AS FILMO_RANG
	, IFF(big_fg * neo_fg * stl_fg = 1, DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, vs_id, gj   ORDER BY fil_gj ASC NULLS LAST), NULL) AS FILGJ_RANG
	, IFF(big_fg * vkl_fg * bus_fg = 1, DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, vs_id, kjmo ORDER BY vkl_mo ASC NULLS LAST), NULL) AS VKLMO_RANG
	, IFF(big_fg * vkl_fg * stl_fg = 1, DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, vs_id, gj   ORDER BY vkl_gj ASC NULLS LAST), NULL) AS VKLGJ_RANG
	, IFF(big_fg * neo_fg * bus_fg = 1, fil_mo, NULL) AS FILMO_WERT
	, IFF(big_fg * neo_fg * stl_fg = 1, fil_gj, NULL) AS FILGJ_WERT
	, IFF(big_fg * vkl_fg * bus_fg = 1, vkl_mo, NULL) AS VKLMO_WERT
	, IFF(big_fg * vkl_fg * stl_fg = 1, vkl_gj, NULL) AS VKLGJ_WERT
FROM ( 
	SELECT vis0.mandant_id, vis0.nb_id, vis0.wup_id, vis0.wrg_id, vis0.vs_id, vis0.vkl_id, vis0.gj, vis0.kjmo
		, vis0.neo_fg, vis0.vkl_fg, vis0.bus_fg, vis0.stl_fg
		, sub1.big_fg
		, sub1.big_best_entw AS ist_fil
		, sub1.big_ums_netto AS ist_fil2
		/* Referenz Region_2/Land_2 */
		, SUM(ist_fil)  OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vs_id) AS ist_reg
		, SUM(ist_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vs_id) AS ist_reg2
		, SUM(ist_fil)  OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo) AS ist_land
		, SUM(ist_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo) AS ist_land2
		/* Setup Rang Filiale Monat_2 */
		, vis0.neo_fg * ist_fil AS ist_fil_mo
		, vis0.neo_fg * ist_fil2 AS ist_fil_mo2
		/* Setup Rang Filiale GJ */
		, SUM(vis0.neo_fg * vis0.stl_fg * vis0.bus_fg * ist_fil)  OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.gj, vis0.wup_id) AS ist_fil_gj
		, SUM(vis0.neo_fg * vis0.stl_fg * vis0.bus_fg * ist_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.gj, vis0.wup_id) AS ist_fil_gj2
		/* Setup Rang VKL_2 Monat_2 */
		, SUM(vis0.neo_fg * vis0.vkl_fg * ist_fil)  OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vkl_id) AS ist_vkl_mo
		, SUM(vis0.neo_fg * vis0.vkl_fg * ist_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vkl_id) AS ist_vkl_mo2
		/* Setup Rang VKL_2 BJ (BS) */
		, SUM(vis0.neo_fg * vis0.vkl_fg * vis0.stl_fg * vis0.bus_fg * ist_fil)  OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.gj, vis0.vkl_id) AS ist_vkl_gj
		, SUM(vis0.neo_fg * vis0.vkl_fg * vis0.stl_fg * vis0.bus_fg * ist_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.gj, vis0.vkl_id) AS ist_vkl_gj2
		/* Rang aufsteigend = Bestandsentw. zum Umsatz % */
		, NULLIFZERO(vis0.neo_fg)               * (ist_fil_mo / NULLIFZERO(ist_fil_mo2)) AS fil_mo
		, NULLIFZERO(vis0.neo_fg * vis0.stl_fg) * (ist_fil_gj / NULLIFZERO(ist_fil_gj2)) AS fil_gj
		, NULLIFZERO(vis0.vkl_fg)               * (ist_vkl_mo / NULLIFZERO(ist_vkl_mo2)) AS vkl_mo
		, NULLIFZERO(vis0.vkl_fg * vis0.stl_fg) * (ist_vkl_gj / NULLIFZERO(ist_vkl_gj2)) AS vkl_gj
	FROM monat_fakt_wup vis0
	LEFT OUTER JOIN monat_big sub1 
		ON sub1.wup_id = vis0.wup_id AND sub1.mandant_id = vis0.mandant_id AND sub1.wrg_id = vis0.wrg_id AND sub1.kjmo = vis0.kjmo
) vtr 

UNION ALL
/* VTR500 Google Bewertung  */ 
SELECT 500::INTEGER AS VTR_ID
	, mandant_id
	, nb_id
	, vs_id
	, vkl_id
	, wup_id
	, wrg_id
	, gj
	, kjmo
	, ist_fil AS FILIST
	, ist_fil2 AS FILIST2
	, kvj_fil AS FILKVJ
	, kvj_fil2 AS FILKVJ2
	, NULL AS FILPLAN
	, NULL AS FILPLAN2
	, ist_reg AS REGIST
	, ist_reg2 AS REGIST2
	, kvj_reg AS REGKVJ
	, kvj_reg2 AS REGKVJ2
	, ist_land AS LANDIST
	, ist_land2 AS LANDIST2
	, kvj_land AS LANDKVJ
	, kvj_land2 AS LANDKVJ2
	/* Rang absteigend = Google Bewertungen IST */
	, IFF(neo_fg * bus_fg = 1, DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, vs_id, kjmo ORDER BY fil_mo DESC NULLS LAST), NULL) AS FILMO_RANG
	, IFF(neo_fg * stl_fg = 1, DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, vs_id, gj ORDER BY fil_gj DESC NULLS LAST), NULL) AS FILGJ_RANG
	, IFF(vkl_fg * bus_fg = 1, DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, vs_id, kjmo ORDER BY vkl_mo DESC NULLS LAST), NULL) AS VKLMO_RANG
	, IFF(vkl_fg * stl_fg = 1, DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, vs_id, gj ORDER BY vkl_gj DESC NULLS LAST), NULL) AS VKLGJ_RANG
	, IFF(neo_fg * bus_fg = 1, fil_mo, NULL) AS FILMO_WERT
	, IFF(neo_fg * stl_fg = 1, fil_gj, NULL) AS FILGJ_WERT
	, IFF(vkl_fg * bus_fg = 1, vkl_mo, NULL) AS VKLMO_WERT
	, IFF(vkl_fg * stl_fg = 1, vkl_gj, NULL) AS VKLGJ_WERT
FROM ( 
	SELECT vis0.mandant_id, vis0.nb_id, vis0.wup_id, vis0.wrg_id, vis0.vs_id, vis0.vkl_id, vis0.gj, vis0.kjmo
		, vis0.neo_fg, vis0.vkl_fg, vis0.bus_fg, vis0.stl_fg
		, sub1.sum_review_ist AS ist_fil
		, sub1.anz_review_ist AS ist_fil2
		, sub2.sum_review_kvj AS kvj_fil
		, sub2.anz_review_kvj AS kvj_fil2
		/* Referenz Region_2/Land_2 */
		, SUM(ist_fil)  OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vs_id) AS ist_reg
		, SUM(ist_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vs_id) AS ist_reg2
		, SUM(kvj_fil)  OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vs_id) AS kvj_reg
		, SUM(kvj_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vs_id) AS kvj_reg2
		, SUM(ist_fil)  OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo) AS ist_land
		, SUM(ist_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo) AS ist_land2
		, SUM(kvj_fil)  OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo) AS kvj_land
		, SUM(kvj_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo) AS kvj_land2
		/* Setup Rang Filiale Monat_2 */
		, vis0.neo_fg * ist_fil AS ist_fil_mo
		, vis0.neo_fg * ist_fil2 AS ist_fil_mo2
		/* Setup Rang Filiale GJ */
		, SUM(vis0.neo_fg * vis0.stl_fg * vis0.bus_fg * ist_fil)  OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.gj, vis0.wup_id) AS ist_fil_gj
		, SUM(vis0.neo_fg * vis0.stl_fg * vis0.bus_fg * ist_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.gj, vis0.wup_id) AS ist_fil_gj2
		/* Setup Rang VKL_2 Monat_2 */
		, SUM(vis0.neo_fg * vis0.vkl_fg * ist_fil)  OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vkl_id) AS ist_vkl_mo
		, SUM(vis0.neo_fg * vis0.vkl_fg * ist_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vkl_id) AS ist_vkl_mo2
		/* Setup Rang VKL_2 BJ (BS) */
		, SUM(vis0.neo_fg * vis0.vkl_fg * vis0.stl_fg * vis0.bus_fg * ist_fil)  OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.gj, vis0.vkl_id) AS ist_vkl_gj
		, SUM(vis0.neo_fg * vis0.vkl_fg * vis0.stl_fg * vis0.bus_fg * ist_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.gj, vis0.vkl_id) AS ist_vkl_gj2
		/* Rang absteigend = Google Sterne IST (Wert) */
		, NULLIFZERO(vis0.neo_fg)               * (ist_fil_mo / NULLIFZERO(ist_fil_mo2)) AS fil_mo
		, NULLIFZERO(vis0.neo_fg * vis0.stl_fg) * (ist_fil_gj / NULLIFZERO(ist_fil_gj2)) AS fil_gj
		, NULLIFZERO(vis0.vkl_fg)               * (ist_vkl_mo / NULLIFZERO(ist_vkl_mo2)) AS vkl_mo
		, NULLIFZERO(vis0.vkl_fg * vis0.stl_fg) * (ist_vkl_gj / NULLIFZERO(ist_vkl_gj2)) AS vkl_gj
	FROM monat_fakt_wup vis0
	LEFT OUTER JOIN monat_google_ist sub1 
		ON sub1.wup_id = vis0.wup_id AND sub1.mandant_id = vis0.mandant_id AND sub1.kjmo = vis0.kjmo /* ohne WRG_2 */
	LEFT OUTER JOIN monat_google_kvj sub2 
		ON sub2.wup_id = vis0.wup_id AND sub2.mandant_id = vis0.mandant_id AND sub2.kjmo = vis0.kjmo /* ohne WRG_2 */
) vtr 

UNION ALL
/* VTR505 K Card Anteil (Rang IST%) */ 
SELECT 505::INTEGER AS VTR_ID
	, mandant_id
	, nb_id
	, vs_id
	, vkl_id
	, wup_id
	, wrg_id
	, gj
	, kjmo
	, ist_fil AS FILIST
	, ist_fil2 AS FILIST2
	, kvj_fil AS FILKVJ
	, kvj_fil2 AS FILKVJ2
	, NULL AS FILPLAN
	, NULL AS FILPLAN2
	, ist_reg AS REGIST
	, ist_reg2 AS REGIST2
	, kvj_reg AS REGKVJ
	, kvj_reg2 AS REGKVJ2
	, ist_land AS LANDIST
	, ist_land2 AS LANDIST2
	, kvj_land AS LANDKVJ
	, kvj_land2 AS LANDKVJ2
	/* Rang absteigend = Kaufland Card Anteil IST % */
	, IFF(neo_fg * bus_fg = 1, DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, vs_id, kjmo ORDER BY fil_mo DESC NULLS LAST), NULL) AS FILMO_RANG
	, IFF(neo_fg * stl_fg = 1, DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, vs_id, gj   ORDER BY fil_gj DESC NULLS LAST), NULL) AS FILGJ_RANG
	, IFF(vkl_fg * bus_fg = 1, DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, vs_id, kjmo ORDER BY vkl_mo DESC NULLS LAST), NULL) AS VKLMO_RANG
	, IFF(vkl_fg * stl_fg = 1, DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, vs_id, gj   ORDER BY vkl_gj DESC NULLS LAST), NULL) AS VKLGJ_RANG
	, IFF(neo_fg * bus_fg = 1, fil_mo, NULL) AS FILMO_WERT
	, IFF(neo_fg * stl_fg = 1, fil_gj, NULL) AS FILGJ_WERT
	, IFF(vkl_fg * bus_fg = 1, vkl_mo, NULL) AS VKLMO_WERT
	, IFF(vkl_fg * stl_fg = 1, vkl_gj, NULL) AS VKLGJ_WERT
FROM ( 
	SELECT vis0.mandant_id, vis0.nb_id, vis0.wup_id, vis0.wrg_id, vis0.vs_id, vis0.vkl_id, vis0.gj, vis0.kjmo
		, vis0.neo_fg, vis0.vkl_fg, vis0.bus_fg, vis0.stl_fg
		, sub1.kcard_ist AS ist_fil 
		, sub1.bon_ist   AS ist_fil2
		, sub2.kcard_kvj AS kvj_fil
		, sub2.bon_kvj   AS kvj_fil2
		/* Referenz Region_2/Land_2 */
		, SUM(ist_fil)  OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vs_id) AS ist_reg
		, SUM(ist_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vs_id) AS ist_reg2
		, SUM(kvj_fil)  OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vs_id) AS kvj_reg
		, SUM(kvj_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vs_id) AS kvj_reg2
		, SUM(ist_fil)  OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo) AS ist_land
		, SUM(ist_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo) AS ist_land2
		, SUM(kvj_fil)  OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo) AS kvj_land
		, SUM(kvj_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo) AS kvj_land2
		/* Setup Rang Filiale Monat_2 */
		, vis0.neo_fg * ist_fil AS ist_fil_mo
		, vis0.neo_fg * ist_fil2 AS ist_fil_mo2
		/* Setup Rang Filiale GJ */
		, SUM(vis0.neo_fg * vis0.stl_fg * vis0.bus_fg * ist_fil)  OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.gj, vis0.wup_id) AS ist_fil_gj
		, SUM(vis0.neo_fg * vis0.stl_fg * vis0.bus_fg * ist_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.gj, vis0.wup_id) AS ist_fil_gj2
		/* Setup Rang VKL_2 Monat_2 */
		, SUM(vis0.neo_fg * vis0.vkl_fg * ist_fil)  OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vkl_id) AS ist_vkl_mo
		, SUM(vis0.neo_fg * vis0.vkl_fg * ist_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vkl_id) AS ist_vkl_mo2
		/* Setup Rang VKL_2 GJ (BS) */
		, SUM(vis0.neo_fg * vis0.vkl_fg * vis0.stl_fg * vis0.bus_fg * ist_fil)  OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.gj, vis0.vkl_id) AS ist_vkl_gj
		, SUM(vis0.neo_fg * vis0.vkl_fg * vis0.stl_fg * vis0.bus_fg * ist_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.gj, vis0.vkl_id) AS ist_vkl_gj2
		/* Rang absteigend = Kaufland Card Anteil IST % */
		, NULLIFZERO(vis0.neo_fg)               * (ist_fil_mo / NULLIFZERO(ist_fil_mo2)) AS fil_mo
		, NULLIFZERO(vis0.neo_fg * vis0.stl_fg) * (ist_fil_gj / NULLIFZERO(ist_fil_gj2)) AS fil_gj
		, NULLIFZERO(vis0.vkl_fg)               * (ist_vkl_mo / NULLIFZERO(ist_vkl_mo2)) AS vkl_mo
		, NULLIFZERO(vis0.vkl_fg * vis0.stl_fg) * (ist_vkl_gj / NULLIFZERO(ist_vkl_gj2)) AS vkl_gj
	FROM monat_fakt_wup vis0
	LEFT OUTER JOIN monat_wcal_ist sub1 
		ON sub1.wup_id = vis0.wup_id AND sub1.mandant_id = vis0.mandant_id AND sub1.kjmo = vis0.kjmo /* ohne WRG_2*/
	LEFT OUTER JOIN monat_wcal_kvj sub2 
		ON sub2.wup_id = vis0.wup_id AND sub2.mandant_id = vis0.mandant_id AND sub2.kjmo = vis0.kjmo /* ohne WRG_2*/
) vtr 

UNION ALL 
/* VTR506 K Card Anteil (Rang ∆VJ %p) */
SELECT 506::INTEGER AS VTR_ID
	, mandant_id
	, nb_id
	, vs_id
	, vkl_id
	, wup_id
	, wrg_id
	, gj
	, kjmo
	, ist_fil AS FILIST
	, ist_fil2 AS FILIST2
	, kvj_fil AS FILKVJ
	, kvj_fil2 AS FILKVJ2
	, NULL AS FILPLAN
	, NULL AS FILPLAN2
	, ist_reg AS REGIST
	, ist_reg2 AS REGIST2
	, kvj_reg AS REGKVJ
	, kvj_reg2 AS REGKVJ2
	, ist_land AS LANDIST
	, ist_land2 AS LANDIST2
	, kvj_land AS LANDKVJ
	, kvj_land2 AS LANDKVJ2
	/* Rang absteigend = Kaufland Card Anteil ∆VJ %p */
	, IFF(neo_fg * bus_fg = 1, DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, vs_id, kjmo ORDER BY fil_mo DESC NULLS LAST), NULL) AS FILMO_RANG
	, IFF(neo_fg * stl_fg = 1, DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, vs_id, gj   ORDER BY fil_gj DESC NULLS LAST), NULL) AS FILGJ_RANG
	, IFF(vkl_fg * bus_fg = 1, DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, vs_id, kjmo ORDER BY vkl_mo DESC NULLS LAST), NULL) AS VKLMO_RANG
	, IFF(vkl_fg * stl_fg = 1, DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, vs_id, gj   ORDER BY vkl_gj DESC NULLS LAST), NULL) AS VKLGJ_RANG
	, IFF(neo_fg * bus_fg = 1, fil_mo * 100, NULL) AS FILMO_WERT
	, IFF(neo_fg * stl_fg = 1, fil_gj * 100, NULL) AS FILGJ_WERT
	, IFF(vkl_fg * bus_fg = 1, vkl_mo * 100, NULL) AS VKLMO_WERT
	, IFF(vkl_fg * stl_fg = 1, vkl_gj * 100, NULL) AS VKLGJ_WERT
FROM ( 
	SELECT vis0.mandant_id, vis0.nb_id, vis0.wup_id, vis0.wrg_id, vis0.vs_id, vis0.vkl_id, vis0.gj, vis0.kjmo
		, vis0.neo_fg, vis0.vkl_fg, vis0.bus_fg, vis0.stl_fg
		, sub1.kcard_ist AS ist_fil 
		, sub1.bon_ist   AS ist_fil2
		, sub2.kcard_kvj AS kvj_fil
		, sub2.bon_kvj   AS kvj_fil2
		/* Referenz Region_2/Land_2 */
		, SUM(ist_fil)  OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vs_id) AS ist_reg
		, SUM(ist_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vs_id) AS ist_reg2
		, SUM(kvj_fil)  OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vs_id) AS kvj_reg
		, SUM(kvj_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vs_id) AS kvj_reg2
		, SUM(ist_fil)  OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo) AS ist_land
		, SUM(ist_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo) AS ist_land2
		, SUM(kvj_fil)  OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo) AS kvj_land
		, SUM(kvj_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo) AS kvj_land2
		/* Setup Rang Filiale Monat_2 */
		, vis0.neo_fg * ist_fil  AS ist_fil_mo
		, vis0.neo_fg * ist_fil2 AS ist_fil_mo2
		, vis0.neo_fg * kvj_fil  AS kvj_fil_mo
		, vis0.neo_fg * kvj_fil2 AS kvj_fil_mo2
		/* Setup Rang Filiale GJ */
		, SUM(vis0.neo_fg * vis0.stl_fg * vis0.bus_fg * ist_fil)  OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.gj, vis0.wup_id) AS ist_fil_gj
		, SUM(vis0.neo_fg * vis0.stl_fg * vis0.bus_fg * ist_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.gj, vis0.wup_id) AS ist_fil_gj2
		, SUM(vis0.neo_fg * vis0.stl_fg * vis0.bus_fg * kvj_fil)  OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.gj, vis0.wup_id) AS kvj_fil_gj
		, SUM(vis0.neo_fg * vis0.stl_fg * vis0.bus_fg * kvj_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.gj, vis0.wup_id) AS kvj_fil_gj2
		/* Setup Rang VKL_2 Monat_2 */
		, SUM(vis0.neo_fg * vis0.vkl_fg * ist_fil)  OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vkl_id) AS ist_vkl_mo
		, SUM(vis0.neo_fg * vis0.vkl_fg * ist_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vkl_id) AS ist_vkl_mo2
		, SUM(vis0.neo_fg * vis0.vkl_fg * kvj_fil)  OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vkl_id) AS kvj_vkl_mo
		, SUM(vis0.neo_fg * vis0.vkl_fg * kvj_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vkl_id) AS kvj_vkl_mo2
		/* Setup Rang VKL_2 GJ (BS) */
		, SUM(vis0.neo_fg * vis0.vkl_fg * vis0.stl_fg * vis0.bus_fg * ist_fil)  OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.gj, vis0.vkl_id) AS ist_vkl_gj
		, SUM(vis0.neo_fg * vis0.vkl_fg * vis0.stl_fg * vis0.bus_fg * ist_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.gj, vis0.vkl_id) AS ist_vkl_gj2
		, SUM(vis0.neo_fg * vis0.vkl_fg * vis0.stl_fg * vis0.bus_fg * kvj_fil)  OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.gj, vis0.vkl_id) AS kvj_vkl_gj
		, SUM(vis0.neo_fg * vis0.vkl_fg * vis0.stl_fg * vis0.bus_fg * kvj_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.gj, vis0.vkl_id) AS kvj_vkl_gj2
		/* Rang absteigend = Kaufland Card Anteil ∆VJ %p */
		, NULLIFZERO(vis0.neo_fg)               * ((ist_fil_mo / NULLIFZERO(ist_fil_mo2)) - (kvj_fil_mo / NULLIFZERO(kvj_fil_mo2))) AS fil_mo
		, NULLIFZERO(vis0.neo_fg * vis0.stl_fg) * ((ist_fil_gj / NULLIFZERO(ist_fil_gj2)) - (kvj_fil_gj / NULLIFZERO(kvj_fil_gj2))) AS fil_gj
		, NULLIFZERO(vis0.vkl_fg)               * ((ist_vkl_mo / NULLIFZERO(ist_vkl_mo2)) - (kvj_vkl_mo / NULLIFZERO(kvj_vkl_mo2))) AS vkl_mo
		, NULLIFZERO(vis0.vkl_fg * vis0.stl_fg) * ((ist_vkl_gj / NULLIFZERO(ist_vkl_gj2)) - (kvj_vkl_gj / NULLIFZERO(kvj_vkl_gj2))) AS vkl_gj
	FROM monat_fakt_wup vis0
	LEFT OUTER JOIN monat_wcal_ist sub1 
		ON sub1.wup_id = vis0.wup_id AND sub1.mandant_id = vis0.mandant_id AND sub1.kjmo = vis0.kjmo /* ohne WRG_2 */
	LEFT OUTER JOIN monat_wcal_kvj sub2 
		ON sub2.wup_id = vis0.wup_id AND sub2.mandant_id = vis0.mandant_id AND sub2.kjmo = vis0.kjmo /* ohne WRG_2*/
) vtr 

UNION ALL
/* VTR510 Warten Kasse */ 
SELECT 510::INTEGER AS VTR_ID
	, mandant_id
	, nb_id
	, vs_id
	, vkl_id
	, wup_id
	, wrg_id
	, gj
	, kjmo
	, ist_fil AS FILIST
	, NULL 
	, kvj_fil AS FILKVJ
	, NULL 
	, NULL 
	, NULL 
	, ist_reg AS REGIST
	, NULL 
	, kvj_reg AS REGKVJ
	, NULL 
	, ist_land AS LANDIST
	, NULL 
	, kvj_land AS LANDKVJ
	, NULL 
	/* Rang aufsteigend = Warten Kasse IST (absolut) */
	, IFF(neo_fg * bus_fg = 1, DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, vs_id, kjmo ORDER BY fil_mo ASC NULLS LAST), NULL) AS FILMO_RANG
	, IFF(neo_fg * stl_fg = 1, DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, vs_id, gj   ORDER BY fil_gj ASC NULLS LAST), NULL) AS FILGJ_RANG
	, IFF(vkl_fg * bus_fg = 1, DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, vs_id, kjmo ORDER BY vkl_mo ASC NULLS LAST), NULL) AS VKLMO_RANG
	, IFF(vkl_fg * stl_fg = 1, DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, vs_id, gj   ORDER BY vkl_gj ASC NULLS LAST), NULL) AS VKLGJ_RANG
	, IFF(neo_fg * bus_fg = 1, fil_mo, NULL) AS FILMO_WERT
	, IFF(neo_fg * stl_fg = 1, fil_gj, NULL) AS FILGJ_WERT
	, IFF(vkl_fg * bus_fg = 1, vkl_mo, NULL) AS VKLMO_WERT
	, IFF(vkl_fg * stl_fg = 1, vkl_gj, NULL) AS VKLGJ_WERT
FROM ( 
	SELECT vis0.mandant_id, vis0.nb_id, vis0.wup_id, vis0.wrg_id, vis0.vs_id, vis0.vkl_id, vis0.gj, vis0.kjmo
		, vis0.neo_fg, vis0.vkl_fg, vis0.bus_fg, vis0.stl_fg
		, sub1.w_kasse_ist AS ist_fil
		, sub2.w_kasse_kvj AS kvj_fil
		/* Referenz Region_2/Land_2 */
		, SUM(ist_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vs_id) AS ist_reg
		, SUM(kvj_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vs_id) AS kvj_reg
		, SUM(ist_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo) AS ist_land
		, SUM(kvj_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo) AS kvj_land
		/* Setup Rang Filiale Monat_2 */
		, vis0.neo_fg * ist_fil AS ist_fil_mo
		/* Setup Rang Filiale GJ */
		, SUM(vis0.neo_fg * vis0.stl_fg * vis0.bus_fg * ist_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.gj, vis0.wup_id) AS ist_fil_gj
		/* Setup Rang VKL_2 Monat_2 */
		, SUM(vis0.neo_fg * vis0.vkl_fg * ist_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vkl_id) AS ist_vkl_mo
		/* Setup Rang VKL_2 BJ (BS) */
		, SUM(vis0.neo_fg * vis0.vkl_fg * vis0.stl_fg * vis0.bus_fg * ist_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.gj, vis0.vkl_id) AS ist_vkl_gj
		/* Rang aufsteigend = Warten Kasse IST (absolut) */
		, NULLIFZERO(vis0.neo_fg)               * (ist_fil_mo) AS fil_mo
		, NULLIFZERO(vis0.neo_fg * vis0.stl_fg) * (ist_fil_gj) AS fil_gj
		, NULLIFZERO(vis0.vkl_fg)               * (ist_vkl_mo) AS vkl_mo
		, NULLIFZERO(vis0.vkl_fg * vis0.stl_fg) * (ist_vkl_gj) AS vkl_gj
	FROM monat_fakt_wup vis0
	LEFT OUTER JOIN monat_rekl_ist sub1 
		ON sub1.wup_id = vis0.wup_id AND sub1.mandant_id = vis0.mandant_id AND sub1.wrg_id = vis0.wrg_id AND sub1.kjmo = vis0.kjmo
	LEFT OUTER JOIN monat_rekl_kvj sub2 
		ON sub2.wup_id = vis0.wup_id AND sub2.mandant_id = vis0.mandant_id AND sub2.wrg_id = vis0.wrg_id AND sub2.kjmo = vis0.kjmo
) vtr 

UNION ALL
/* VTR515 Ø Warten Kasse pro 10000 Kunden */ 
SELECT 515::INTEGER AS VTR_ID
	, mandant_id
	, nb_id
	, vs_id
	, vkl_id
	, wup_id
	, wrg_id
	, gj
	, kjmo
	, ist_fil AS FILIST
	, ist_fil2 AS FILIST2
	, kvj_fil AS FILKVJ
	, kvj_fil2 AS FILKVJ2
	, NULL 
	, NULL 
	, ist_reg AS REGIST
	, ist_reg2 AS REGIST2
	, kvj_reg AS REGKVJ
	, kvj_reg2 AS REGKVJ2
	, ist_land AS LANDIST
	, ist_land2 AS LANDIST2
	, kvj_land AS LANDKVJ
	, kvj_land2 AS LANDKVJ2
	/* ohne Rang */
	, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
FROM ( 
	SELECT vis0.mandant_id, vis0.nb_id, vis0.wup_id, vis0.wrg_id, vis0.vs_id, vis0.vkl_id, vis0.gj, vis0.kjmo
		, vis0.neo_fg, vis0.vkl_fg, vis0.bus_fg, vis0.stl_fg
		, vis0.knd_10t_ist AS ist_fil2
		, vis0.knd_10t_kvj AS kvj_fil2
		, sub1.w_kasse_ist AS ist_fil
		, sub2.w_kasse_kvj AS kvj_fil
		/* Referenz Region_2/Land_2 */
		, SUM(ist_fil)  OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vs_id) AS ist_reg
		, SUM(ist_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vs_id) AS ist_reg2
		, SUM(kvj_fil)  OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vs_id) AS kvj_reg
		, SUM(kvj_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vs_id) AS kvj_reg2
		, SUM(ist_fil)  OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo) AS ist_land
		, SUM(ist_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo) AS ist_land2
		, SUM(kvj_fil)  OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo) AS kvj_land
		, SUM(kvj_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo) AS kvj_land2
	FROM monat_fakt_wup vis0
	LEFT OUTER JOIN monat_rekl_ist sub1 
		ON sub1.wup_id = vis0.wup_id AND sub1.mandant_id = vis0.mandant_id AND sub1.wrg_id = vis0.wrg_id AND sub1.kjmo = vis0.kjmo
	LEFT OUTER JOIN monat_rekl_kvj sub2 
		ON sub2.wup_id = vis0.wup_id AND sub2.mandant_id = vis0.mandant_id AND sub2.wrg_id = vis0.wrg_id AND sub2.kjmo = vis0.kjmo
) vtr 

UNION ALL
/* VTR520 Warten Theke */ 
SELECT 520::INTEGER AS VTR_ID
	, mandant_id
	, nb_id
	, vs_id
	, vkl_id
	, wup_id
	, wrg_id
	, gj
	, kjmo
	, ist_fil AS FILIST
	, NULL 
	, kvj_fil AS FILKVJ
	, NULL 
	, NULL 
	, NULL 
	, ist_reg AS REGIST
	, NULL 
	, kvj_reg AS REGKVJ
	, NULL 
	, ist_land AS LANDIST
	, NULL 
	, kvj_land AS LANDKVJ
	, NULL 
	/* Rang aufsteigend = Warten Theke IST (absolut) */
	, IFF(neo_fg * bus_fg = 1, DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, vs_id, kjmo ORDER BY fil_mo ASC NULLS LAST), NULL) AS FILMO_RANG
	, IFF(neo_fg * stl_fg = 1, DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, vs_id, gj   ORDER BY fil_gj ASC NULLS LAST), NULL) AS FILGJ_RANG
	, IFF(vkl_fg * bus_fg = 1, DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, vs_id, kjmo ORDER BY vkl_mo ASC NULLS LAST), NULL) AS VKLMO_RANG
	, IFF(vkl_fg * stl_fg = 1, DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, vs_id, gj   ORDER BY vkl_gj ASC NULLS LAST), NULL) AS VKLGJ_RANG
	, IFF(neo_fg * bus_fg = 1, fil_mo, NULL) AS FILMO_WERT
	, IFF(neo_fg * stl_fg = 1, fil_gj, NULL) AS FILGJ_WERT
	, IFF(vkl_fg * bus_fg = 1, vkl_mo, NULL) AS VKLMO_WERT
	, IFF(vkl_fg * stl_fg = 1, vkl_gj, NULL) AS VKLGJ_WERT
FROM ( 
	SELECT vis0.mandant_id, vis0.nb_id, vis0.wup_id, vis0.wrg_id, vis0.vs_id, vis0.vkl_id, vis0.gj, vis0.kjmo
		, vis0.neo_fg, vis0.vkl_fg, vis0.bus_fg, vis0.stl_fg
		, sub1.w_theke_ist AS ist_fil
		, sub2.w_theke_kvj AS kvj_fil
		/* Referenz Region_2/Land_2 */
		, SUM(ist_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vs_id) AS ist_reg
		, SUM(kvj_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vs_id) AS kvj_reg
		, SUM(ist_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo) AS ist_land
		, SUM(kvj_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo) AS kvj_land
		/* Setup Rang Filiale Monat_2 */
		, vis0.neo_fg * ist_fil AS ist_fil_mo
		/* Setup Rang Filiale GJ */
		, SUM(vis0.neo_fg * vis0.stl_fg * vis0.bus_fg * ist_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.gj, vis0.wup_id) AS ist_fil_gj
		/* Setup Rang VKL_2 Monat_2 */
		, SUM(vis0.neo_fg * vis0.vkl_fg * ist_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vkl_id) AS ist_vkl_mo
		/* Setup Rang VKL_2 BJ (BS) */
		, SUM(vis0.neo_fg * vis0.vkl_fg * vis0.stl_fg * vis0.bus_fg * ist_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.gj, vis0.vkl_id) AS ist_vkl_gj
		/* Rang aufsteigend = Warten Kasse IST (absolut) */
		, NULLIFZERO(vis0.neo_fg)               * (ist_fil_mo) AS fil_mo
		, NULLIFZERO(vis0.neo_fg * vis0.stl_fg) * (ist_fil_gj) AS fil_gj
		, NULLIFZERO(vis0.vkl_fg)               * (ist_vkl_mo) AS vkl_mo
		, NULLIFZERO(vis0.vkl_fg * vis0.stl_fg) * (ist_vkl_gj) AS vkl_gj
	FROM monat_fakt_wup vis0
	LEFT OUTER JOIN monat_rekl_ist sub1 
		ON sub1.wup_id = vis0.wup_id AND sub1.mandant_id = vis0.mandant_id AND sub1.wrg_id = vis0.wrg_id AND sub1.kjmo = vis0.kjmo
	LEFT OUTER JOIN monat_rekl_kvj sub2 
		ON sub2.wup_id = vis0.wup_id AND sub2.mandant_id = vis0.mandant_id AND sub2.wrg_id = vis0.wrg_id AND sub2.kjmo = vis0.kjmo
) vtr 

UNION ALL
/* VTR525 Ø Warten Theke pro 10000 Kunden */ 
SELECT 525::INTEGER AS VTR_ID
	, mandant_id
	, nb_id
	, vs_id
	, vkl_id
	, wup_id
	, wrg_id
	, gj
	, kjmo
	, ist_fil AS FILIST
	, ist_fil2 AS FILIST2
	, kvj_fil AS FILKVJ
	, kvj_fil2 AS FILKVJ2
	, NULL 
	, NULL 
	, ist_reg AS REGIST
	, ist_reg2 AS REGIST2
	, kvj_reg AS REGKVJ
	, kvj_reg2 AS REGKVJ2
	, ist_land AS LANDIST
	, ist_land2 AS LANDIST2
	, kvj_land AS LANDKVJ
	, kvj_land2 AS LANDKVJ2
	/* ohne Rang */
	, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
FROM ( 
	SELECT vis0.mandant_id, vis0.nb_id, vis0.wup_id, vis0.wrg_id, vis0.vs_id, vis0.vkl_id, vis0.gj, vis0.kjmo
		, vis0.neo_fg, vis0.vkl_fg, vis0.bus_fg, vis0.stl_fg
		, vis0.knd_10t_ist AS ist_fil2
		, vis0.knd_10t_kvj AS kvj_fil2
		, sub1.w_theke_ist AS ist_fil
		, sub2.w_theke_kvj AS kvj_fil
		/* Referenz Region_2/Land_2 */
		, SUM(ist_fil)  OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vs_id) AS ist_reg
		, SUM(ist_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vs_id) AS ist_reg2
		, SUM(kvj_fil)  OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vs_id) AS kvj_reg
		, SUM(kvj_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vs_id) AS kvj_reg2
		, SUM(ist_fil)  OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo) AS ist_land
		, SUM(ist_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo) AS ist_land2
		, SUM(kvj_fil)  OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo) AS kvj_land
		, SUM(kvj_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo) AS kvj_land2
	FROM monat_fakt_wup vis0
	LEFT OUTER JOIN monat_rekl_ist sub1 
		ON sub1.wup_id = vis0.wup_id AND sub1.mandant_id = vis0.mandant_id AND sub1.wrg_id = vis0.wrg_id AND sub1.kjmo = vis0.kjmo
	LEFT OUTER JOIN monat_rekl_kvj sub2 
		ON sub2.wup_id = vis0.wup_id AND sub2.mandant_id = vis0.mandant_id AND sub2.wrg_id = vis0.wrg_id AND sub2.kjmo = vis0.kjmo
) vtr 

UNION ALL
/* VTR530 Mangel MHD */ 
SELECT 530::INTEGER AS VTR_ID
	, mandant_id
	, nb_id
	, vs_id
	, vkl_id
	, wup_id
	, wrg_id
	, gj
	, kjmo
	, ist_fil AS FILIST
	, NULL 
	, kvj_fil AS FILKVJ
	, NULL 
	, NULL 
	, NULL 
	, ist_reg AS REGIST
	, NULL 
	, kvj_reg AS REGKVJ
	, NULL 
	, ist_land AS LANDIST
	, NULL 
	, kvj_land AS LANDKVJ
	, NULL 
	/* Rang aufsteigend = Mangel MHD IST (absolut) */
	, IFF(neo_fg * bus_fg = 1, DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, vs_id, kjmo ORDER BY fil_mo ASC NULLS LAST), NULL) AS FILMO_RANG
	, IFF(neo_fg * stl_fg = 1, DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, vs_id, gj   ORDER BY fil_gj ASC NULLS LAST), NULL) AS FILGJ_RANG
	, IFF(vkl_fg * bus_fg = 1, DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, vs_id, kjmo ORDER BY vkl_mo ASC NULLS LAST), NULL) AS VKLMO_RANG
	, IFF(vkl_fg * stl_fg = 1, DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, vs_id, gj   ORDER BY vkl_gj ASC NULLS LAST), NULL) AS VKLGJ_RANG
	, IFF(neo_fg * bus_fg = 1, fil_mo, NULL) AS FILMO_WERT
	, IFF(neo_fg * stl_fg = 1, fil_gj, NULL) AS FILGJ_WERT
	, IFF(vkl_fg * bus_fg = 1, vkl_mo, NULL) AS VKLMO_WERT
	, IFF(vkl_fg * stl_fg = 1, vkl_gj, NULL) AS VKLGJ_WERT
FROM ( 
	SELECT vis0.mandant_id, vis0.nb_id, vis0.wup_id, vis0.wrg_id, vis0.vs_id, vis0.vkl_id, vis0.gj, vis0.kjmo
		, vis0.neo_fg, vis0.vkl_fg, vis0.bus_fg, vis0.stl_fg
		, sub1.anz_mhd_ist AS ist_fil
		, sub2.anz_mhd_kvj AS kvj_fil
		/* Referenz Region_2/Land_2 */
		, SUM(ist_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vs_id) AS ist_reg
		, SUM(kvj_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vs_id) AS kvj_reg
		, SUM(ist_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo) AS ist_land
		, SUM(kvj_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo) AS kvj_land
		/* Setup Rang Filiale Monat_2 */
		, vis0.neo_fg * ist_fil AS ist_fil_mo
		/* Setup Rang Filiale GJ */
		, SUM(vis0.neo_fg * vis0.stl_fg * vis0.bus_fg * ist_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.gj, vis0.wup_id) AS ist_fil_gj
		/* Setup Rang VKL_2 Monat_2 */
		, SUM(vis0.neo_fg * vis0.vkl_fg * ist_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vkl_id) AS ist_vkl_mo
		/* Setup Rang VKL_2 BJ (BS) */
		, SUM(vis0.neo_fg * vis0.vkl_fg * vis0.stl_fg * vis0.bus_fg * ist_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.gj, vis0.vkl_id) AS ist_vkl_gj
		/* Rang aufsteigend = Mangel MHD IST (absolut) */
		, NULLIFZERO(vis0.neo_fg)               * (ist_fil_mo) AS fil_mo
		, NULLIFZERO(vis0.neo_fg * vis0.stl_fg) * (ist_fil_gj) AS fil_gj
		, NULLIFZERO(vis0.vkl_fg)               * (ist_vkl_mo) AS vkl_mo
		, NULLIFZERO(vis0.vkl_fg * vis0.stl_fg) * (ist_vkl_gj) AS vkl_gj
	FROM monat_fakt_wup vis0
	LEFT OUTER JOIN monat_rekl_ist sub1 
		ON sub1.wup_id = vis0.wup_id AND sub1.mandant_id = vis0.mandant_id AND sub1.wrg_id = vis0.wrg_id AND sub1.kjmo = vis0.kjmo
	LEFT OUTER JOIN monat_rekl_kvj sub2 
		ON sub2.wup_id = vis0.wup_id AND sub2.mandant_id = vis0.mandant_id AND sub2.wrg_id = vis0.wrg_id AND sub2.kjmo = vis0.kjmo
) vtr 

UNION ALL
/* VTR535 Ø Mangel MHD pro 10000 Kunden */ 
SELECT 535::INTEGER AS VTR_ID
	, mandant_id
	, nb_id
	, vs_id
	, vkl_id
	, wup_id
	, wrg_id
	, gj
	, kjmo
	, ist_fil AS FILIST
	, ist_fil2 AS FILIST2
	, kvj_fil AS FILKVJ
	, kvj_fil2 AS FILKVJ2
	, NULL 
	, NULL 
	, ist_reg AS REGIST
	, ist_reg2 AS REGIST2
	, kvj_reg AS REGKVJ
	, kvj_reg2 AS REGKVJ2
	, ist_land AS LANDIST
	, ist_land2 AS LANDIST2
	, kvj_land AS LANDKVJ
	, kvj_land2 AS LANDKVJ2
	/* ohne Rang */
	, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
FROM ( 
	SELECT vis0.mandant_id, vis0.nb_id, vis0.wup_id, vis0.wrg_id, vis0.vs_id, vis0.vkl_id, vis0.gj, vis0.kjmo
		, vis0.neo_fg, vis0.vkl_fg, vis0.bus_fg, vis0.stl_fg
		, vis0.knd_10t_ist AS ist_fil2
		, vis0.knd_10t_kvj AS kvj_fil2
		, sub1.anz_mhd_ist AS ist_fil
		, sub2.anz_mhd_kvj AS kvj_fil
		/* Referenz Region_2/Land_2 */
		, SUM(ist_fil)  OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vs_id) AS ist_reg
		, SUM(ist_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vs_id) AS ist_reg2
		, SUM(kvj_fil)  OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vs_id) AS kvj_reg
		, SUM(kvj_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vs_id) AS kvj_reg2
		, SUM(ist_fil)  OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo) AS ist_land
		, SUM(ist_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo) AS ist_land2
		, SUM(kvj_fil)  OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo) AS kvj_land
		, SUM(kvj_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo) AS kvj_land2
	FROM monat_fakt_wup vis0
	LEFT OUTER JOIN monat_rekl_ist sub1 
		ON sub1.wup_id = vis0.wup_id AND sub1.mandant_id = vis0.mandant_id AND sub1.wrg_id = vis0.wrg_id AND sub1.kjmo = vis0.kjmo
	LEFT OUTER JOIN monat_rekl_kvj sub2 
		ON sub2.wup_id = vis0.wup_id AND sub2.mandant_id = vis0.mandant_id AND sub2.wrg_id = vis0.wrg_id AND sub2.kjmo = vis0.kjmo
) vtr 

UNION ALL
/* VTR540 Preisauszeichnung */ 
SELECT 540::INTEGER AS VTR_ID
	, mandant_id
	, nb_id
	, vs_id
	, vkl_id
	, wup_id
	, wrg_id
	, gj
	, kjmo
	, ist_fil AS FILIST
	, NULL 
	, kvj_fil AS FILKVJ
	, NULL 
	, NULL 
	, NULL 
	, ist_reg AS REGIST
	, NULL 
	, kvj_reg AS REGKVJ
	, NULL 
	, ist_land AS LANDIST
	, NULL 
	, kvj_land AS LANDKVJ
	, NULL 
	/* Rang aufsteigend = Preisauszeichnung IST (absolut) */
	, IFF(neo_fg * bus_fg = 1, DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, vs_id, kjmo ORDER BY fil_mo ASC NULLS LAST), NULL) AS FILMO_RANG
	, IFF(neo_fg * stl_fg = 1, DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, vs_id, gj   ORDER BY fil_gj ASC NULLS LAST), NULL) AS FILGJ_RANG
	, IFF(vkl_fg * bus_fg = 1, DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, vs_id, kjmo ORDER BY vkl_mo ASC NULLS LAST), NULL) AS VKLMO_RANG
	, IFF(vkl_fg * stl_fg = 1, DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, vs_id, gj   ORDER BY vkl_gj ASC NULLS LAST), NULL) AS VKLGJ_RANG
	, IFF(neo_fg * bus_fg = 1, fil_mo, NULL) AS FILMO_WERT
	, IFF(neo_fg * stl_fg = 1, fil_gj, NULL) AS FILGJ_WERT
	, IFF(vkl_fg * bus_fg = 1, vkl_mo, NULL) AS VKLMO_WERT
	, IFF(vkl_fg * stl_fg = 1, vkl_gj, NULL) AS VKLGJ_WERT
FROM ( 
	SELECT vis0.mandant_id, vis0.nb_id, vis0.wup_id, vis0.wrg_id, vis0.vs_id, vis0.vkl_id, vis0.gj, vis0.kjmo
		, vis0.neo_fg, vis0.vkl_fg, vis0.bus_fg, vis0.stl_fg
		, sub1.f_preis_ist AS ist_fil
		, sub2.f_preis_kvj AS kvj_fil
		/* Referenz Region_2/Land_2 */
		, SUM(ist_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vs_id) AS ist_reg
		, SUM(kvj_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vs_id) AS kvj_reg
		, SUM(ist_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo) AS ist_land
		, SUM(kvj_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo) AS kvj_land
		/* Setup Rang Filiale Monat_2 */
		, vis0.neo_fg * ist_fil AS ist_fil_mo
		/* Setup Rang Filiale GJ */
		, SUM(vis0.neo_fg * vis0.stl_fg * vis0.bus_fg * ist_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.gj, vis0.wup_id) AS ist_fil_gj
		/* Setup Rang VKL_2 Monat_2 */
		, SUM(vis0.neo_fg * vis0.vkl_fg * ist_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vkl_id) AS ist_vkl_mo
		/* Setup Rang VKL_2 BJ (BS) */
		, SUM(vis0.neo_fg * vis0.vkl_fg * vis0.stl_fg * vis0.bus_fg * ist_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.gj, vis0.vkl_id) AS ist_vkl_gj
		/* Rang aufsteigend = Preisauszeichnung IST (absolut) */
		, NULLIFZERO(vis0.neo_fg)               * (ist_fil_mo) AS fil_mo
		, NULLIFZERO(vis0.neo_fg * vis0.stl_fg) * (ist_fil_gj) AS fil_gj
		, NULLIFZERO(vis0.vkl_fg)               * (ist_vkl_mo) AS vkl_mo
		, NULLIFZERO(vis0.vkl_fg * vis0.stl_fg) * (ist_vkl_gj) AS vkl_gj
	FROM monat_fakt_wup vis0
	LEFT OUTER JOIN monat_rekl_ist sub1 
		ON sub1.wup_id = vis0.wup_id AND sub1.mandant_id = vis0.mandant_id AND sub1.wrg_id = vis0.wrg_id AND sub1.kjmo = vis0.kjmo
	LEFT OUTER JOIN monat_rekl_kvj sub2 
		ON sub2.wup_id = vis0.wup_id AND sub2.mandant_id = vis0.mandant_id AND sub2.wrg_id = vis0.wrg_id AND sub2.kjmo = vis0.kjmo
) vtr 

UNION ALL
/* VTR545 Ø Preisauszeichnung pro 10000 Kunden */ 
SELECT 545::INTEGER AS VTR_ID
	, mandant_id
	, nb_id
	, vs_id
	, vkl_id
	, wup_id
	, wrg_id
	, gj
	, kjmo
	, ist_fil AS FILIST
	, ist_fil2 AS FILIST2
	, kvj_fil AS FILKVJ
	, kvj_fil2 AS FILKVJ2
	, NULL 
	, NULL 
	, ist_reg AS REGIST
	, ist_reg2 AS REGIST2
	, kvj_reg AS REGKVJ
	, kvj_reg2 AS REGKVJ2
	, ist_land AS LANDIST
	, ist_land2 AS LANDIST2
	, kvj_land AS LANDKVJ
	, kvj_land2 AS LANDKVJ2
	/* ohne Rang */
	, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
FROM ( 
	SELECT vis0.mandant_id, vis0.nb_id, vis0.wup_id, vis0.wrg_id, vis0.vs_id, vis0.vkl_id, vis0.gj, vis0.kjmo
		, vis0.neo_fg, vis0.vkl_fg, vis0.bus_fg, vis0.stl_fg
		, vis0.knd_10t_ist AS ist_fil2
		, vis0.knd_10t_kvj AS kvj_fil2
		, sub1.f_preis_ist AS ist_fil
		, sub2.f_preis_kvj AS kvj_fil
		/* Referenz Region_2/Land_2 */
		, SUM(ist_fil)  OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vs_id) AS ist_reg
		, SUM(ist_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vs_id) AS ist_reg2
		, SUM(kvj_fil)  OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vs_id) AS kvj_reg
		, SUM(kvj_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vs_id) AS kvj_reg2
		, SUM(ist_fil)  OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo) AS ist_land
		, SUM(ist_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo) AS ist_land2
		, SUM(kvj_fil)  OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo) AS kvj_land
		, SUM(kvj_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo) AS kvj_land2
	FROM monat_fakt_wup vis0
	LEFT OUTER JOIN monat_rekl_ist sub1 
		ON sub1.wup_id = vis0.wup_id AND sub1.mandant_id = vis0.mandant_id AND sub1.wrg_id = vis0.wrg_id AND sub1.kjmo = vis0.kjmo
	LEFT OUTER JOIN monat_rekl_kvj sub2 
		ON sub2.wup_id = vis0.wup_id AND sub2.mandant_id = vis0.mandant_id AND sub2.wrg_id = vis0.wrg_id AND sub2.kjmo = vis0.kjmo
) vtr 

UNION ALL
/* VTR550 Kassierfehler */ 
SELECT 550::INTEGER AS VTR_ID
	, mandant_id
	, nb_id
	, vs_id
	, vkl_id
	, wup_id
	, wrg_id
	, gj
	, kjmo
	, ist_fil AS FILIST
	, NULL 
	, kvj_fil AS FILKVJ
	, NULL 
	, NULL 
	, NULL 
	, ist_reg AS REGIST
	, NULL 
	, kvj_reg AS REGKVJ
	, NULL 
	, ist_land AS LANDIST
	, NULL 
	, kvj_land AS LANDKVJ
	, NULL 
	/* Rang aufsteigend = Kassierfehler IST (absolut) */
	, IFF(neo_fg * bus_fg = 1, DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, vs_id, kjmo ORDER BY fil_mo ASC NULLS LAST), NULL) AS FILMO_RANG
	, IFF(neo_fg * stl_fg = 1, DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, vs_id, gj   ORDER BY fil_gj ASC NULLS LAST), NULL) AS FILGJ_RANG
	, IFF(vkl_fg * bus_fg = 1, DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, vs_id, kjmo ORDER BY vkl_mo ASC NULLS LAST), NULL) AS VKLMO_RANG
	, IFF(vkl_fg * stl_fg = 1, DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, vs_id, gj   ORDER BY vkl_gj ASC NULLS LAST), NULL) AS VKLGJ_RANG
	, IFF(neo_fg * bus_fg = 1, fil_mo, NULL) AS FILMO_WERT
	, IFF(neo_fg * stl_fg = 1, fil_gj, NULL) AS FILGJ_WERT
	, IFF(vkl_fg * bus_fg = 1, vkl_mo, NULL) AS VKLMO_WERT
	, IFF(vkl_fg * stl_fg = 1, vkl_gj, NULL) AS VKLGJ_WERT
FROM ( 
	SELECT vis0.mandant_id, vis0.nb_id, vis0.wup_id, vis0.wrg_id, vis0.vs_id, vis0.vkl_id, vis0.gj, vis0.kjmo
		, vis0.neo_fg, vis0.vkl_fg, vis0.bus_fg, vis0.stl_fg
		, sub1.f_kasse_ist AS ist_fil
		, sub2.f_kasse_kvj AS kvj_fil
		/* Referenz Region_2/Land_2 */
		, SUM(ist_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vs_id) AS ist_reg
		, SUM(kvj_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vs_id) AS kvj_reg
		, SUM(ist_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo) AS ist_land
		, SUM(kvj_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo) AS kvj_land
		/* Setup Rang Filiale Monat_2 */
		, vis0.neo_fg * ist_fil AS ist_fil_mo
		/* Setup Rang Filiale GJ */
		, SUM(vis0.neo_fg * vis0.stl_fg * vis0.bus_fg * ist_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.gj, vis0.wup_id) AS ist_fil_gj
		/* Setup Rang VKL_2 Monat_2 */
		, SUM(vis0.neo_fg * vis0.vkl_fg * ist_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vkl_id) AS ist_vkl_mo
		/* Setup Rang VKL_2 BJ (BS) */
		, SUM(vis0.neo_fg * vis0.vkl_fg * vis0.stl_fg * vis0.bus_fg * ist_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.gj, vis0.vkl_id) AS ist_vkl_gj
		/* Rang aufsteigend = Kassierfehler IST (absolut) */
		, NULLIFZERO(vis0.neo_fg)               * (ist_fil_mo) AS fil_mo
		, NULLIFZERO(vis0.neo_fg * vis0.stl_fg) * (ist_fil_gj) AS fil_gj
		, NULLIFZERO(vis0.vkl_fg)               * (ist_vkl_mo) AS vkl_mo
		, NULLIFZERO(vis0.vkl_fg * vis0.stl_fg) * (ist_vkl_gj) AS vkl_gj
	FROM monat_fakt_wup vis0
	LEFT OUTER JOIN monat_rekl_ist sub1 
		ON sub1.wup_id = vis0.wup_id AND sub1.mandant_id = vis0.mandant_id AND sub1.wrg_id = vis0.wrg_id AND sub1.kjmo = vis0.kjmo
	LEFT OUTER JOIN monat_rekl_kvj sub2 
		ON sub2.wup_id = vis0.wup_id AND sub2.mandant_id = vis0.mandant_id AND sub2.wrg_id = vis0.wrg_id AND sub2.kjmo = vis0.kjmo
) vtr 

UNION ALL
/* VTR555 Ø Kassierfehler pro 100000 Scans */ 
SELECT 555::INTEGER AS VTR_ID
	, mandant_id
	, nb_id
	, vs_id
	, vkl_id
	, wup_id
	, wrg_id
	, gj
	, kjmo
	, ist_fil AS FILIST
	, ist_fil2 AS FILIST2
	, kvj_fil AS FILKVJ
	, kvj_fil2 AS FILKVJ2
	, NULL 
	, NULL 
	, ist_reg AS REGIST
	, ist_reg2 AS REGIST2
	, kvj_reg AS REGKVJ
	, kvj_reg2 AS REGKVJ2
	, ist_land AS LANDIST
	, ist_land2 AS LANDIST2
	, kvj_land AS LANDKVJ
	, kvj_land2 AS LANDKVJ2
	/* ohne Rang */
	, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
FROM ( 
	SELECT vis0.mandant_id, vis0.nb_id, vis0.wup_id, vis0.wrg_id, vis0.vs_id, vis0.vkl_id, vis0.gj, vis0.kjmo
		, vis0.neo_fg, vis0.vkl_fg, vis0.bus_fg, vis0.stl_fg
		, sub1.f_kasse_ist  AS ist_fil
		, sub2.f_kasse_kvj  AS kvj_fil
		, sub3.art_100t_ist AS ist_fil2
		, sub4.art_100t_kvj AS kvj_fil2
		/* Referenz Region_2/Land_2 */
		, SUM(ist_fil)  OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vs_id) AS ist_reg
		, SUM(ist_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vs_id) AS ist_reg2
		, SUM(kvj_fil)  OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vs_id) AS kvj_reg
		, SUM(kvj_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vs_id) AS kvj_reg2
		, SUM(ist_fil)  OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo) AS ist_land
		, SUM(ist_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo) AS ist_land2
		, SUM(kvj_fil)  OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo) AS kvj_land
		, SUM(kvj_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo) AS kvj_land2
	FROM monat_fakt_wup vis0
	LEFT OUTER JOIN monat_rekl_ist sub1 
		ON sub1.wup_id = vis0.wup_id AND sub1.mandant_id = vis0.mandant_id AND sub1.wrg_id = vis0.wrg_id AND sub1.kjmo = vis0.kjmo
	LEFT OUTER JOIN monat_rekl_kvj sub2 
		ON sub2.wup_id = vis0.wup_id AND sub2.mandant_id = vis0.mandant_id AND sub2.wrg_id = vis0.wrg_id AND sub2.kjmo = vis0.kjmo
	LEFT OUTER JOIN monat_kasse_ist sub3
		ON sub3.wup_id = vis0.wup_id AND sub3.mandant_id = vis0.mandant_id AND sub3.wrg_id = vis0.wrg_id AND sub3.kjmo = vis0.kjmo
	LEFT OUTER JOIN monat_kasse_kvj sub4
		ON sub4.wup_id = vis0.wup_id AND sub4.mandant_id = vis0.mandant_id AND sub4.wrg_id = vis0.wrg_id AND sub4.kjmo = vis0.kjmo
) vtr 

UNION ALL
/* VTR710 Übernahmequote */ 
SELECT 710::INTEGER AS VTR_ID
	, mandant_id
	, nb_id
	, vs_id
	, vkl_id
	, wup_id
	, wrg_id
	, gj
	, kjmo
	, ist_fil AS FILIST
	, ist_fil2 AS FILIST2
	, NULL AS FILKVJ
	, NULL AS FILKVJ2
	, NULL AS FILPLAN
	, NULL AS FILPLAN2
	, ist_reg AS REGIST
	, ist_reg2 AS REGIST2
	, NULL AS REGKVJ
	, NULL AS REGKVJ2
	, ist_land AS LANDIST
	, ist_land2 AS LANDIST2
	, NULL AS LANDKVJ
	, NULL AS LANDKVJ2
	/* Rang absteigend = Übernahmequote IST % */
	, IFF(neo_fg * bus_fg = 1, DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, vs_id, kjmo ORDER BY fil_mo DESC NULLS LAST), NULL) AS FILMO_RANG
	, IFF(neo_fg * stl_fg = 1, DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, vs_id, gj ORDER BY fil_gj DESC NULLS LAST), NULL) AS FILGJ_RANG
	, IFF(vkl_fg * bus_fg = 1, DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, vs_id, kjmo ORDER BY vkl_mo DESC NULLS LAST), NULL) AS VKLMO_RANG
	, IFF(vkl_fg * stl_fg = 1, DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, vs_id, gj ORDER BY vkl_gj DESC NULLS LAST), NULL) AS VKLGJ_RANG
	, IFF(neo_fg * bus_fg = 1, fil_mo, NULL) AS FILMO_WERT
	, IFF(neo_fg * stl_fg = 1, fil_gj, NULL) AS FILGJ_WERT
	, IFF(vkl_fg * bus_fg = 1, vkl_mo, NULL) AS VKLMO_WERT
	, IFF(vkl_fg * stl_fg = 1, vkl_gj, NULL) AS VKLGJ_WERT
FROM ( 
	SELECT vis0.mandant_id, vis0.nb_id, vis0.wup_id, vis0.wrg_id, vis0.vs_id, vis0.vkl_id, vis0.gj, vis0.kjmo
		, vis0.neo_fg, vis0.vkl_fg, vis0.bus_fg, vis0.stl_fg
		, (sub1.best_vor - sub1.best_kor) AS ist_fil
		, (sub1.best_vor + sub1.best_man) AS ist_fil2
		/* Referenz Region_2/Land_2 */
		, SUM(ist_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vs_id) AS ist_reg
		, SUM(ist_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vs_id) AS ist_reg2
		, SUM(ist_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo) AS ist_land
		, SUM(ist_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo) AS ist_land2
		/* Setup Rang Filiale Monat_2 */
		, vis0.neo_fg * ist_fil AS ist_fil_mo
		, vis0.neo_fg * ist_fil2 AS ist_fil_mo2
		/* Setup Rang Filiale GJ */
		, SUM(vis0.neo_fg * vis0.stl_fg * vis0.bus_fg * ist_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.gj, vis0.wup_id) AS ist_fil_gj
		, SUM(vis0.neo_fg * vis0.stl_fg * vis0.bus_fg * ist_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.gj, vis0.wup_id) AS ist_fil_gj2
		/* Setup Rang VKL_2 Monat_2 */
		, SUM(vis0.neo_fg * vis0.vkl_fg * ist_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vkl_id) AS ist_vkl_mo
		, SUM(vis0.neo_fg * vis0.vkl_fg * ist_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vkl_id) AS ist_vkl_mo2
		/* Setup Rang VKL_2 BJ (BS) */
		, SUM(vis0.neo_fg * vis0.vkl_fg * vis0.stl_fg * vis0.bus_fg * ist_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.gj, vis0.vkl_id) AS ist_vkl_gj
		, SUM(vis0.neo_fg * vis0.vkl_fg * vis0.stl_fg * vis0.bus_fg * ist_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.gj, vis0.vkl_id) AS ist_vkl_gj2
		/* Rang absteigend = Übernahmequote IST % */
		, NULLIFZERO(vis0.neo_fg)               * (ist_fil_mo / NULLIFZERO(ist_fil_mo2)) AS fil_mo
		, NULLIFZERO(vis0.neo_fg * vis0.stl_fg) * (ist_fil_gj / NULLIFZERO(ist_fil_gj2)) AS fil_gj
		, NULLIFZERO(vis0.vkl_fg)               * (ist_vkl_mo / NULLIFZERO(ist_vkl_mo2)) AS vkl_mo
		, NULLIFZERO(vis0.vkl_fg * vis0.stl_fg) * (ist_vkl_gj / NULLIFZERO(ist_vkl_gj2)) AS vkl_gj
	FROM monat_fakt_wup vis0
	LEFT OUTER JOIN monat_bestvor sub1 
		ON sub1.wup_id = vis0.wup_id AND sub1.mandant_id = vis0.mandant_id AND sub1.kjmo = vis0.kjmo /* ohne WRG_2*/
) vtr 

UNION ALL
/* VTR730 Zählaufträge (Gesamt) */ 
SELECT 730::INTEGER AS VTR_ID
	, mandant_id
	, nb_id
	, vs_id
	, vkl_id
	, wup_id
	, wrg_id
	, gj
	, kjmo
	, ist_fil AS FILIST
	, NULL AS FILIST2
	, NULL AS FILKVJ
	, NULL AS FILKVJ2
	, NULL AS FILPLAN
	, NULL AS FILPLAN2
	, ist_reg AS REGIST
	, NULL AS REGIST2
	, NULL AS REGKVJ
	, NULL AS REGKVJ2
	, ist_land AS LANDIST
	, NULL AS LANDIST2
	, NULL AS LANDKVJ
	, NULL AS LANDKVJ2
	/* ohne Rang */
	, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
FROM ( 
	SELECT vis0.mandant_id, vis0.nb_id, vis0.wup_id, vis0.wrg_id, vis0.vs_id, vis0.vkl_id, vis0.gj, vis0.kjmo
		, vis0.neo_fg, vis0.vkl_fg, vis0.bus_fg, vis0.stl_fg
		, sub1.auftrag AS ist_fil
		/* Referenz Region_2/Land_2 */
		, SUM(ist_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vs_id) AS ist_reg
		, SUM(ist_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo) AS ist_land
	FROM monat_fakt_wup vis0
	LEFT OUTER JOIN monat_zaehl_auftrag sub1 
		ON sub1.wup_id = vis0.wup_id AND sub1.mandant_id = vis0.mandant_id AND sub1.kjmo = vis0.kjmo /* ohne WRG_2*/
) vtr 

UNION ALL
/* VTR732 Zählungen durchgeführt */ 
SELECT 732::INTEGER AS VTR_ID
	, mandant_id
	, nb_id
	, vs_id
	, vkl_id
	, wup_id
	, wrg_id
	, gj
	, kjmo
	, ist_fil AS FILIST
	, NULL AS FILIST2
	, NULL AS FILKVJ
	, NULL AS FILKVJ2
	, NULL AS FILPLAN
	, NULL AS FILPLAN2
	, ist_reg AS REGIST
	, NULL AS REGIST2
	, NULL AS REGKVJ
	, NULL AS REGKVJ2
	, ist_land AS LANDIST
	, NULL AS LANDIST2
	, NULL AS LANDKVJ
	, NULL AS LANDKVJ2
	/* ohne Rang */
	, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
FROM ( 
	SELECT vis0.mandant_id, vis0.nb_id, vis0.wup_id, vis0.wrg_id, vis0.vs_id, vis0.vkl_id, vis0.gj, vis0.kjmo
		, vis0.neo_fg, vis0.vkl_fg, vis0.bus_fg, vis0.stl_fg
		, sub1.gezaehlt AS ist_fil
		/* Referenz Region_2/Land_2 */
		, SUM(ist_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vs_id) AS ist_reg
		, SUM(ist_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo) AS ist_land
	FROM monat_fakt_wup vis0
	LEFT OUTER JOIN monat_zaehl_auftrag sub1 
		ON sub1.wup_id = vis0.wup_id AND sub1.mandant_id = vis0.mandant_id AND sub1.kjmo = vis0.kjmo /* ohne WRG_2*/
) vtr 

UNION ALL
/* VTR735 Zählaufträge bearbeitet (%) */ 
SELECT 735::INTEGER AS VTR_ID
	, mandant_id
	, nb_id
	, vs_id
	, vkl_id
	, wup_id
	, wrg_id
	, gj
	, kjmo
	, ist_fil AS FILIST
	, ist_fil2 AS FILIST2
	, NULL AS FILKVJ
	, NULL AS FILKVJ2
	, NULL AS FILPLAN
	, NULL AS FILPLAN2
	, ist_reg AS REGIST
	, ist_reg2 AS REGIST2
	, NULL AS REGKVJ
	, NULL AS REGKVJ2
	, ist_land AS LANDIST
	, ist_land2 AS LANDIST2
	, NULL AS LANDKVJ
	, NULL AS LANDKVJ2
	/* ohne Rang */
	, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
FROM ( 
	SELECT vis0.mandant_id, vis0.nb_id, vis0.wup_id, vis0.wrg_id, vis0.vs_id, vis0.vkl_id, vis0.gj, vis0.kjmo
		, vis0.neo_fg, vis0.vkl_fg, vis0.bus_fg, vis0.stl_fg
		, sub1.gezaehlt AS ist_fil
		, sub1.auftrag  AS ist_fil2
		/* Referenz Region_2/Land_2 */
		, SUM(ist_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vs_id) AS ist_reg
		, SUM(ist_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vs_id) AS ist_reg2
		, SUM(ist_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo) AS ist_land
		, SUM(ist_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo) AS ist_land2
	FROM monat_fakt_wup vis0
	LEFT OUTER JOIN monat_zaehl_auftrag sub1 
		ON sub1.wup_id = vis0.wup_id AND sub1.mandant_id = vis0.mandant_id AND sub1.kjmo = vis0.kjmo /* ohne WRG_2*/
) vtr 

UNION ALL
/* VTR750 Nullbestandsquote */
SELECT 750::INTEGER AS VTR_ID
	, mandant_id
	, nb_id
	, vs_id
	, vkl_id
	, wup_id
	, wrg_id
	, gj
	, kjmo
	, ist_fil AS FILIST
	, ist_fil2 AS FILIST2
	, NULL AS FILKVJ
	, NULL AS FILKVJ2
	, NULL AS FILPLAN
	, NULL AS FILPLAN2
	, ist_reg AS REGIST
	, ist_reg2 AS REGIST2
	, NULL AS REGKVJ
	, NULL AS REGKVJ2
	, ist_land AS LANDIST
	, ist_land2 AS LANDIST2
	, NULL AS LANDKVJ
	, NULL AS LANDKVJ2
	/* ohne Rang */
	, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
FROM ( 
	SELECT vis0.mandant_id, vis0.nb_id, vis0.wup_id, vis0.wrg_id, vis0.vs_id, vis0.vkl_id, vis0.gj, vis0.kjmo
		, vis0.neo_fg, vis0.vkl_fg, vis0.bus_fg, vis0.stl_fg
		, sub1.null_best  AS ist_fil
		, sub1.auto_dispo AS ist_fil2
		/* Referenz Region_2/Land_2 */
		, SUM(ist_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vs_id) AS ist_reg
		, SUM(ist_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vs_id) AS ist_reg2
		, SUM(ist_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo) AS ist_land
		, SUM(ist_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo) AS ist_land2
	FROM monat_fakt_wup vis0
	LEFT OUTER JOIN monat_fwws sub1 
		ON sub1.wup_id = vis0.wup_id AND sub1.mandant_id = vis0.mandant_id AND sub1.kjmo = vis0.kjmo /* ohne WRG_2*/
) vtr 

UNION ALL
/* VTR752 Minusbestandsquote */ 
SELECT 752::INTEGER AS VTR_ID
	, mandant_id
	, nb_id
	, vs_id
	, vkl_id
	, wup_id
	, wrg_id
	, gj
	, kjmo
	, ist_fil AS FILIST
	, ist_fil2 AS FILIST2
	, NULL AS FILKVJ
	, NULL AS FILKVJ2
	, NULL AS FILPLAN
	, NULL AS FILPLAN2
	, ist_reg AS REGIST
	, ist_reg2 AS REGIST2
	, NULL AS REGKVJ
	, NULL AS REGKVJ2
	, ist_land AS LANDIST
	, ist_land2 AS LANDIST2
	, NULL AS LANDKVJ
	, NULL AS LANDKVJ2
	/* ohne Rang */
	, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
FROM ( 
	SELECT vis0.mandant_id, vis0.nb_id, vis0.wup_id, vis0.wrg_id, vis0.vs_id, vis0.vkl_id, vis0.gj, vis0.kjmo
		, vis0.neo_fg, vis0.vkl_fg, vis0.bus_fg, vis0.stl_fg
		, sub1.minus_best AS ist_fil
		, sub1.auto_dispo AS ist_fil2
		/* Referenz Region_2/Land_2 */
		, SUM(ist_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vs_id) AS ist_reg
		, SUM(ist_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vs_id) AS ist_reg2
		, SUM(ist_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo) AS ist_land
		, SUM(ist_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo) AS ist_land2
	FROM monat_fakt_wup vis0
	LEFT OUTER JOIN monat_fwws sub1 
		ON sub1.wup_id = vis0.wup_id AND sub1.mandant_id = vis0.mandant_id AND sub1.kjmo = vis0.kjmo /* ohne WRG_2*/
) vtr 

UNION ALL
/* VTR755 Null-/Minusquote */ 
SELECT 755::INTEGER AS VTR_ID
	, mandant_id
	, nb_id
	, vs_id
	, vkl_id
	, wup_id
	, wrg_id
	, gj
	, kjmo
	, ist_fil AS FILIST
	, ist_fil2 AS FILIST2
	, NULL AS FILKVJ
	, NULL AS FILKVJ2
	, NULL AS FILPLAN
	, NULL AS FILPLAN2
	, ist_reg AS REGIST
	, ist_reg2 AS REGIST2
	, NULL AS REGKVJ
	, NULL AS REGKVJ2
	, ist_land AS LANDIST
	, ist_land2 AS LANDIST2
	, NULL AS LANDKVJ
	, NULL AS LANDKVJ2
	/* Rang aufsteigend = Null-/Minusquote IST % */
	, IFF(neo_fg * bus_fg = 1, DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, vs_id, kjmo ORDER BY fil_mo ASC NULLS LAST), NULL) AS FILMO_RANG
	, IFF(neo_fg * stl_fg = 1, DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, vs_id, gj   ORDER BY fil_gj ASC NULLS LAST), NULL) AS FILGJ_RANG
	, IFF(vkl_fg * bus_fg = 1, DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, vs_id, kjmo ORDER BY vkl_mo ASC NULLS LAST), NULL) AS VKLMO_RANG
	, IFF(vkl_fg * stl_fg = 1, DENSE_RANK() OVER (PARTITION BY mandant_id, wrg_id, vs_id, gj   ORDER BY vkl_gj ASC NULLS LAST), NULL) AS VKLGJ_RANG
	, IFF(neo_fg * bus_fg = 1, fil_mo, NULL) AS FILMO_WERT
	, IFF(neo_fg * stl_fg = 1, fil_gj, NULL) AS FILGJ_WERT
	, IFF(vkl_fg * bus_fg = 1, vkl_mo, NULL) AS VKLMO_WERT
	, IFF(vkl_fg * stl_fg = 1, vkl_gj, NULL) AS VKLGJ_WERT
FROM ( 
	SELECT vis0.mandant_id, vis0.nb_id, vis0.wup_id, vis0.wrg_id, vis0.vs_id, vis0.vkl_id, vis0.gj, vis0.kjmo
		, vis0.neo_fg, vis0.vkl_fg, vis0.bus_fg, vis0.stl_fg
		, sub1.null_best + sub1.minus_best AS ist_fil
		, sub1.auto_dispo                  AS ist_fil2
		/* Referenz Region_2/Land_2 */
		, SUM(ist_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vs_id) AS ist_reg
		, SUM(ist_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vs_id) AS ist_reg2
		, SUM(ist_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo) AS ist_land
		, SUM(ist_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo) AS ist_land2
		/* Setup Rang Filiale Monat_2 */
		, vis0.neo_fg * ist_fil AS ist_fil_mo
		, vis0.neo_fg * ist_fil2 AS ist_fil_mo2
		/* Setup Rang Filiale GJ */
		, SUM(vis0.neo_fg * vis0.stl_fg * vis0.bus_fg * ist_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.gj, vis0.wup_id) AS ist_fil_gj
		, SUM(vis0.neo_fg * vis0.stl_fg * vis0.bus_fg * ist_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.gj, vis0.wup_id) AS ist_fil_gj2
		/* Setup Rang VKL_2 Monat_2 */
		, SUM(vis0.neo_fg * vis0.vkl_fg * ist_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vkl_id) AS ist_vkl_mo
		, SUM(vis0.neo_fg * vis0.vkl_fg * ist_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.kjmo, vis0.vkl_id) AS ist_vkl_mo2
		/* Setup Rang VKL_2 BJ (BS) */
		, SUM(vis0.neo_fg * vis0.vkl_fg * vis0.stl_fg * vis0.bus_fg * ist_fil) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.gj, vis0.vkl_id) AS ist_vkl_gj
		, SUM(vis0.neo_fg * vis0.vkl_fg * vis0.stl_fg * vis0.bus_fg * ist_fil2) OVER (PARTITION BY vis0.mandant_id, vis0.wrg_id, vis0.gj, vis0.vkl_id) AS ist_vkl_gj2
		/* Rang aufteigend = Null-/Minusquote IST % * */
		, NULLIFZERO(vis0.neo_fg)               * (ist_fil_mo / NULLIFZERO(ist_fil_mo2)) AS fil_mo
		, NULLIFZERO(vis0.neo_fg * vis0.stl_fg) * (ist_fil_gj / NULLIFZERO(ist_fil_gj2)) AS fil_gj
		, NULLIFZERO(vis0.vkl_fg)               * (ist_vkl_mo / NULLIFZERO(ist_vkl_mo2)) AS vkl_mo
		, NULLIFZERO(vis0.vkl_fg * vis0.stl_fg) * (ist_vkl_gj / NULLIFZERO(ist_vkl_gj2)) AS vkl_gj
	FROM monat_fakt_wup vis0
	LEFT OUTER JOIN monat_fwws sub1 
		ON sub1.wup_id = vis0.wup_id AND sub1.mandant_id = vis0.mandant_id AND sub1.kjmo = vis0.kjmo /* ohne WRG_2*/
) vtr
;