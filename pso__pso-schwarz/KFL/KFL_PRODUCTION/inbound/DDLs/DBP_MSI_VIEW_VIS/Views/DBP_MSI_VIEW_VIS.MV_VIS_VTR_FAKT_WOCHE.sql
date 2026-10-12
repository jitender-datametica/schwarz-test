CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_VIS_VTR_FAKT_WOCHE(
	VTR_ID,
	MANDANT_ID,
	NB_ID,
	VS_ID,
	WUP_ID,
	WRG_ID,
	KJWO,
	FILIST,
	FILIST2,
	FILWVJ,
	FILWVJ2,
	FILPLAN,
	FILPLAN2,
	REGIST,
	REGIST2,
	REGWVJ,
	REGWVJ2,
	LANDIST,
	LANDIST2,
	LANDWVJ,
	LANDWVJ2
) AS 
 
/*
	FAKT DENORM : VT Ranking Woche 
	Filiale IST/VJ (Plan) - Referenz Region/Land - nur Details (ohne Ranking) pro Woche 
	2024-11-18 ssch0611 : Initial. Komplett CTE [AP0237182] 
	2024-12-02 ssch0611 : Filter woche_zaehl_auftrag + Finetuning [AP0237182] 
	2025-02-10 ssch0611 : Metrik Reihenfolge an Monat angepasst. [AP0237182]
	2025-02-24 ssch0611 : Finetuning [AP0237182]
	2025-04-01 ssch0611 : Umstellung Scans/min (KPOS) [AP0264011]
*/ 


/* CTE */


WITH 
/* Filter Zeit : 12 Wochen */
zeit_woche AS ( 
	SELECT zeit.kjwo
		, zeit.kjwo_vj
		, zeit.wo_dat_von
		, zeit.wo_dat_bis
		, zeit.akt_wo_komplett
		, zeit.akt_wo 
	FROM DBP_DATA.WOCHE zeit
	WHERE zeit.akt_wo_komplett BETWEEN -11 AND 0 /* 12 WO */ 
	)

/* Filter Zeit : 12 Wochen + Join Tag */
, zeit_tag AS ( 
	SELECT zeit.dat
		, zeit.kjwo
		, zeit.wo_dat_von
		, zeit.wo_dat_bis
		, zeit.akt_wo_komplett
		, zeit.akt_wo 
	FROM DBP_DATA.TAG zeit
	INNER JOIN zeit_woche 
		ON zeit.kjwo = zeit_woche.kjwo
	)
/* Standard Filter VTC : Filiale + definierte NB. Datum Eröffnung fix. ohne Filter Schließung */
, wup AS ( 
	SELECT wup.mandant_id
		, wup.nb_id
		, wup.vs_id
		, wup.wup_id
		, wup.aktuell_wup_id
		, COALESCE(wup.dat_eroeffnung_alt, wup.dat_eroeffnung) AS neo_dat
		, dat_bis AS stl_dat
	FROM DBP_DATA.WUP wup 
	WHERE (wup.nb_id = 0 OR wup.wup_id IN (0,2,22,28,43,46,124,8980,8987,8991,100000,100002,100022,100028,100043,100046,100124)) /* Filialen + definierte ZF */
		AND wup.dat_eroeffnung < '2090-12-31' /* fix */
	)

/* MV_VIS_TAG_FAKT_WUP gruppiert = Basis */
, woche_fakt_wup AS ( 
	SELECT vis.mandant_id, vis.nb_id, wup.vs_id, vis.wup_id, vis.wrg_id
		, zeit.kjwo
		, SUM(vis.ums_netto)      AS ums_ist
		, SUM(vis.ums_netto_wvj)  AS ums_wvj
		, SUM(vis.ums_netto_plan) AS ums_plan
		, SUM(vis.anz_kunde)      AS knd_ist
		, SUM(vis.anz_kunde_wvj)  AS knd_wvj
		, (knd_ist / 10000)       AS knd_10t_ist
		, (knd_wvj / 10000)       AS knd_10t_wvj
	FROM DBP_MSI_VIEW_VIS.MV_VIS_TAG_FAKT_WUP vis
	INNER JOIN zeit_tag zeit 
		ON zeit.dat = vis.dat
	INNER JOIN wup 
		ON wup.wup_id = vis.wup_id AND wup.mandant_id = vis.mandant_id 
	GROUP BY ALL
	)

/* MV_VIS_MONAT_FAKT_WG gruppiert */
, woche_fakt_ware AS (
	SELECT vis.mandant_id, vis.nb_id, wup.vs_id, vis.wup_id, vis.wrg_id
		, zeit.kjwo
		, SUM(vis.ums_netto)     AS ums_ist
		, SUM(vis.ums_netto_wvj) AS ums_wvj
		, SUM(vis.menge)         AS mng_ist
		, SUM(vis.menge_wvj)     AS mng_wvj
		, SUM(IFF(vis.abt_id = 5, vis.ums_netto, 0))     AS ums_uf_ist
		, SUM(IFF(vis.abt_id = 5, vis.ums_netto_wvj, 0)) AS ums_uf_wvj
		, SUM(IFF(wg.owg_id <> 1092, vis.menge, 0))      AS mng_opf_ist
		, SUM(IFF(wg.owg_id <> 1092, vis.menge_wvj, 0))  AS mng_opf_wvj
	FROM DBP_MSI_VIEW_VIS.MV_VIS_TAG_FAKT_WG vis
	INNER JOIN DBP_MSI_VIEW_VIS.MV_WG_INT wg
		ON wg.wg_id = vis.wg_id
	INNER JOIN zeit_tag zeit 
		ON zeit.dat = vis.dat
	INNER JOIN wup 
		ON wup.wup_id = vis.wup_id AND wup.mandant_id = vis.mandant_id 
	GROUP BY ALL
	)

/* MV_ARTBEW_WO_SUM IST gemappt + gruppiert - IST */
, woche_artbew_ist AS (
	SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id
		, zeit.kjwo
		, SUM(vis.umsatz_netto) AS ums_artb_ist
		, SUM(IFF(vis.bewart_id = 1002, vis.umsatz_netto, 0)) AS ums_sa_ist
		, SUM(IFF(vis.bewart_id = 1001, vis.umsatz_netto, 0)) AS ums_af_ist /* Reserve */
	FROM DBP_MSI_VIEW_VIS.MV_ARTBEW_WO_SUM vis
	INNER JOIN DBP_DATA.WOCHE_KJ_KL zeit1
		ON zeit1.kjwo_kl = vis.kjwo_kl /* Mapping KL_Woche (AIS) auf Kalenderwoche */
	INNER JOIN zeit_woche zeit
		ON zeit.kjwo = zeit1.kjwo 
	INNER JOIN wup 
		ON wup.wup_id = vis.wup_id AND wup.mandant_id = vis.mandant_id 
	GROUP BY ALL
	)

/* MV_ARTBEW_WO_SUM gemappt + gruppiert - WVJ */
, woche_artbew_wvj AS (
	SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id
		, zeit.kjwo
		, SUM(vis.umsatz_netto) AS ums_artb_wvj
		, SUM(IFF(vis.bewart_id = 1002, vis.umsatz_netto, 0)) AS ums_sa_wvj
		, SUM(IFF(vis.bewart_id = 1001, vis.umsatz_netto, 0)) AS ums_af_wvj /* Reserve */
	FROM DBP_MSI_VIEW_VIS.MV_ARTBEW_WO_SUM vis
	INNER JOIN DBP_DATA.WOCHE_KJ_KL zeit1
		ON zeit1.kjwo_kl = vis.kjwo_kl /* Mapping KL_Woche (AIS) auf Kalenderwoche */
	INNER JOIN zeit_woche zeit
		ON zeit.kjwo_vj = zeit1.kjwo /* Transformation auf kjwo_vj */
	INNER JOIN wup 
		ON wup.wup_id = vis.wup_id AND wup.mandant_id = vis.mandant_id 
	GROUP BY ALL
	)

/* MV_WUP_STUNDEN_TAG gruppiert - IST */
, woche_stunden_ist AS (
	SELECT vis.mandant_id, vis.nb_id, wup.vs_id, vis.wup_id, vis.wrg_id
		, zeit.kjwo
		, SUM(ums_netto) AS wst_ums_ist
		, SUM(IFF(ums_netto_plan_man <> 0, ums_netto_plan_man, ums_netto_plan)) AS wst_ums_plan /* Umsatz Plan Eingabe HL (bzw. KER) */
		, SUM(ZEROIFNULL(stunden_markt) + ZEROIFNULL(stunden_sonstige) 
			+ ZEROIFNULL(stunden_co_ist) + ZEROIFNULL(stunden_co1_iks) + ZEROIFNULL(stunden_co2_ea) 
			+ ZEROIFNULL(stunden_co3_anue) + ZEROIFNULL(stunden_co4_reinigung) + ZEROIFNULL(stunden_co5_sonstige)
			) AS nettostd_ist /* Nettostunden IST */
		, SUM(ZEROIFNULL(stunden_sonstige_plan) + ZEROIFNULL(stunden_co_plan) 
			+ ZEROIFNULL(stunden_co4_reinigung) + ZEROIFNULL(stunden_co5_sonstige)
			+ CASE 
				WHEN vis.akt_wo < 1 AND (stunden_plan_pep) <> 0           THEN ZEROIFNULL(stunden_plan_pep) 
				WHEN vis.akt_wo = 1 AND DAYOFWEEK(CURRENT_DATE) IN (1, 7) THEN ZEROIFNULL(stunden_plan_pep)
				ELSE ZEROIFNULL(stunden_plan) END 
				) AS nettostd_plan /* Nettostunden Plan PEP (bzw. Eingabe HL) */
	FROM DBP_MSI_VIEW_VIS.MV_WUP_STUNDEN_TAG vis
	INNER JOIN zeit_tag zeit 
		ON zeit.dat = vis.dat
	INNER JOIN wup 
		ON wup.wup_id = vis.wup_id AND wup.mandant_id = vis.mandant_id 
	GROUP BY ALL
	)

/* MV_WUP_STUNDEN_TAG gruppiert - WVJ*/ 
, woche_stunden_wvj AS ( 
	SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, wup.vs_id
		, zeit.kjwo
		, SUM(ums_netto) AS wst_ums_wvj
		, SUM(ZEROIFNULL(stunden_markt) + ZEROIFNULL(stunden_sonstige) 
			+ ZEROIFNULL(stunden_co_ist) + ZEROIFNULL(stunden_co1_iks) + ZEROIFNULL(stunden_co2_ea) 
			+ ZEROIFNULL(stunden_co3_anue) + ZEROIFNULL(stunden_co4_reinigung) + ZEROIFNULL(stunden_co5_sonstige)
			) AS nettostd_wvj /* Nettostunden WVJ */
	FROM DBP_MSI_VIEW_VIS.MV_WUP_STUNDEN_TAG vis
	INNER JOIN zeit_tag zeit 
		ON zeit.dat = (vis.dat + 364) /* Transformation WVJ*/
	INNER JOIN wup 
		ON wup.wup_id = vis.wup_id AND wup.mandant_id = vis.mandant_id 
	GROUP BY ALL
	)

/* VIS_TAG_KASSE/KASSE_TYP_PER umgerechnet, gemapped, aggregiert - IST */
, woche_kasse_ist AS (
	SELECT vis.mandant_id, vis.nb_id
		, krs.nach_wrg_id    AS wrg_id
		, wup.aktuell_wup_id AS wup_id
		, zeit.kjwo
		, SUM(vis.umsatz_netto * krs.umrechnungskurs) AS ums_kass_ist
		, SUM(vis.anz_kunden)                         AS knd_kass_ist
		, SUM(vis.anz_artikel)                        AS art_kass_ist
		, SUM(IFF(ktp.kasse_typ_id = 1 , vis.umsatz_netto * krs.umrechnungskurs, 0)) AS ums_pos_ist
		, SUM(IFF(ktp.kasse_typ_id = 1 , vis.anz_kunden                        , 0)) AS knd_pos_ist
		, SUM(IFF(ktp.kasse_typ_id = 1 , vis.anz_artikel                       , 0)) AS art_pos_ist
		, SUM(IFF(ktp.kasse_typ_id <> 1, vis.umsatz_netto * krs.umrechnungskurs, 0)) AS ums_sco_ist
		, SUM(IFF(ktp.kasse_typ_id <> 1, vis.anz_kunden                        , 0)) AS knd_sco_ist
		, SUM(IFF(ktp.kasse_typ_id <> 1, vis.anz_artikel                       , 0)) AS art_sco_ist
		, SUM(IFF(ktp.kasse_typ_id = 1 , vis.anz_artikel    / 100000.00        , 0)) AS art_100t_ist
		, SUM(IFF(ktp.kasse_typ_id = 1 , vis.registrierzeit /   60.0000        , 0)) AS scan_min_ist
		, SUM(IFF(ktp.kasse_typ_id = 1 , vis.kassierzeit    / 3600.0000        , 0)) AS kass_std_ist
	FROM DBP_VIEW.V_VIS_TAG_KASSE vis
	INNER JOIN (
		SELECT ktp.mandant_id, ktp.wup_id, zeit.dat, ktp.kasse_nr, ktp.kasse_typ_id
		FROM DBP_VIEW.V_KASSE_TYP_PER ktp
		INNER JOIN zeit_tag zeit
			ON zeit.dat BETWEEN ktp.dat_von AND ktp.dat_bis
		AND ktp.kasse_typ_id  IN (1,8,9,10,11) /* Kassentyp : 1 = normal/POS, 8,9 = SCO, 10,11 = Paystation */
	) ktp
	ON ktp.mandant_id = vis.mandant_id AND ktp.wup_id = vis.wup_id AND ktp.kasse_nr = vis.kasse_nr
		AND ktp.dat = vis.dat
	INNER JOIN ( 
		SELECT krs1.von_wrg_id, krs1.nach_wrg_id, krs1.umrechnungskurs 
		FROM DBP_DATA.KURS krs1 
		WHERE krs1.kurstyp_id = 3 AND krs1.dat_bis = '9999-12-31' 
			AND krs1.von_wrg_id NOT IN ('AUD', 'DEM', 'SIT') 
		UNION ALL 
		SELECT krs2.von_wrg_id, krs2.von_wrg_id, 1.0000 
		FROM DBP_DATA.KURS krs2 
		WHERE krs2.kurstyp_id = 3 AND krs2.dat_bis = '9999-12-31'  
			AND krs2.von_wrg_id NOT IN ('AUD', 'DEM', 'SIT', 'EUR')  
	) krs
	ON krs.von_wrg_id = vis.wrg_id
	INNER JOIN wup
		ON wup.mandant_id= vis.mandant_id AND wup.wup_id= vis.wup_id
	INNER JOIN zeit_tag zeit
		ON zeit.dat = vis.dat
	GROUP BY ALL
	)

/* VIS_TAG_KASSE/KASSE_TYP_PER umgerechnet, gemapped, aggregiert */
, woche_kasse_wvj AS ( 
	SELECT vis.mandant_id, vis.nb_id
	, krs.nach_wrg_id    AS wrg_id
	, wup.aktuell_wup_id AS wup_id
	, zeit.kjwo
	, SUM(vis.umsatz_netto * krs.umrechnungskurs) AS ums_kass_wvj
	, SUM(vis.anz_kunden)                         AS knd_kass_wvj
	, SUM(vis.anz_artikel)                        AS art_kass_wvj
	, SUM(IFF(ktp.kasse_typ_id = 1 , vis.umsatz_netto * krs.umrechnungskurs, 0)) AS ums_pos_wvj
	, SUM(IFF(ktp.kasse_typ_id = 1 , vis.anz_kunden                        , 0)) AS knd_pos_wvj
	, SUM(IFF(ktp.kasse_typ_id = 1 , vis.anz_artikel                       , 0)) AS art_pos_wvj
	, SUM(IFF(ktp.kasse_typ_id <> 1, vis.umsatz_netto * krs.umrechnungskurs, 0)) AS ums_sco_wvj
	, SUM(IFF(ktp.kasse_typ_id <> 1, vis.anz_kunden                        , 0)) AS knd_sco_wvj
	, SUM(IFF(ktp.kasse_typ_id <> 1, vis.anz_artikel                       , 0)) AS art_sco_wvj
	, SUM(IFF(ktp.kasse_typ_id = 1 , vis.anz_artikel / 100000.00           , 0)) AS art_100t_wvj
	, SUM(IFF(ktp.kasse_typ_id = 1 , vis.registrierzeit / 60.0000          , 0)) AS scan_min_wvj
	, SUM(IFF(ktp.kasse_typ_id = 1 , vis.kassierzeit / 3600.0000           , 0)) AS kass_std_wvj
	FROM DBP_VIEW.V_VIS_TAG_KASSE vis
	INNER JOIN (
		SELECT ktp.mandant_id, ktp.wup_id, zeit.dat, ktp.kasse_nr, ktp.kasse_typ_id
		FROM DBP_VIEW.V_KASSE_TYP_PER ktp
		INNER JOIN zeit_tag zeit
		ON zeit.dat BETWEEN ktp.dat_von AND ktp.dat_bis
			AND ktp.kasse_typ_id  IN (1,8,9,10,11) /* Kassentyp : 1 = normal/POS, 8,9 = SCO, 10,11 = Paystation */
	) ktp
	ON ktp.mandant_id = vis.mandant_id AND ktp.wup_id = vis.wup_id AND ktp.kasse_nr = vis.kasse_nr
	AND ktp.dat = (vis.dat + 364) /* Transformation auf kjwo_vj */
	INNER JOIN ( 
		SELECT krs1.von_wrg_id, krs1.nach_wrg_id, krs1.umrechnungskurs 
		FROM DBP_DATA.KURS krs1 
		WHERE krs1.kurstyp_id = 3 AND krs1.dat_bis = '9999-12-31' 
			AND krs1.von_wrg_id NOT IN ('AUD', 'DEM', 'SIT') 
		UNION ALL 
		SELECT krs2.von_wrg_id, krs2.von_wrg_id, 1.0000 
		FROM DBP_DATA.KURS krs2 
		WHERE krs2.kurstyp_id = 3 AND krs2.dat_bis = '9999-12-31'  
			AND krs2.von_wrg_id NOT IN ('AUD', 'DEM', 'SIT', 'EUR')  
	) krs
	ON krs.von_wrg_id = vis.wrg_id
	INNER JOIN wup
	ON wup.mandant_id= vis.mandant_id AND wup.wup_id= vis.wup_id
	INNER JOIN zeit_tag zeit
	ON zeit.dat = (vis.dat + 364) /* Transformation auf kjwo_vj */
	GROUP BY ALL
	)

/* MV_ODS_BON_KASSENABSCHLUSS aggregiert (ohne WRG) */
, woche_ods_bon_ka_ist AS (
	SELECT vis.mandant_id, vis.wup_id, zeit.kjwo
	, SUM(vis.anz_scans)         AS scans_ist
	, SUM(vis.sum_scan_sek / 60) AS mins_ist
	FROM DBP_MSI_VIEW_VIS.MV_ODS_BON_KASSENABSCHLUSS vis
	INNER JOIN zeit_tag zeit
	ON zeit.dat = vis.dat
	INNER JOIN wup
	ON wup.mandant_id= vis.mandant_id AND wup.wup_id= vis.wup_id
	GROUP BY ALL
	)

/* MV_ODS_BON_KASSENABSCHLUSS aggregiert (ohne WRG) */
, woche_ods_bon_ka_wvj AS ( 
	SELECT vis.mandant_id, vis.wup_id
		, zeit.kjwo
		, SUM(vis.anz_scans)         AS scans_wvj
		, SUM(vis.sum_scan_sek / 60) AS mins_wvj
	FROM DBP_MSI_VIEW_VIS.MV_ODS_BON_KASSENABSCHLUSS vis
	INNER JOIN zeit_tag zeit
	ON zeit.dat = (vis.dat + 364) /* Transformation auf kjwo_vj */
	INNER JOIN wup
	ON wup.mandant_id= vis.mandant_id AND wup.wup_id= vis.wup_id
	GROUP BY ALL
	)

/* MV_VIS_TAG_ABSCHRIFTEN_WG gruppiert */
, woche_abschriften_ware AS ( 
SELECT vis.mandant_id, vis.wup_id, vis.wrg_id, wup.vs_id, zeit.kjwo
	, SUM(CASE 
		WHEN vis.mandant_id IN (6)         AND vis.abschriftart_id = 2  THEN 1 
		WHEN vis.mandant_id IN (3)         AND vis.abschriftart_id = 11 THEN 1 
		WHEN vis.mandant_id IN (2,4,5,7,8) AND vis.abschriftart_id = 7  THEN 1 
		WHEN vis.mandant_id IN (2,5)       AND vis.abschriftart_id = 10 THEN 1 
		WHEN vis.mandant_id NOT IN (1)     AND vis.abschriftart_id = 20 THEN 1 
		ELSE -1 END * vis.abschrift_netto) AS abs_op_ist
	, SUM(CASE 
		WHEN vis.mandant_id IN (6)         AND vis.abschriftart_id = 2  THEN 1 
		WHEN vis.mandant_id IN (3)         AND vis.abschriftart_id = 11 THEN 1 
		WHEN vis.mandant_id IN (2,4,5,7,8) AND vis.abschriftart_id = 7  THEN 1 
		WHEN vis.mandant_id IN (2,5)       AND vis.abschriftart_id = 10 THEN 1 
		WHEN vis.mandant_id NOT IN (1)     AND vis.abschriftart_id = 20 THEN 1 
		ELSE -1 END * abschrift_netto_wvj) AS abs_op_wvj 
	, SUM(CASE 
		WHEN vis.abt_id = 5 THEN CASE 
			WHEN vis.mandant_id IN (6)         AND vis.abschriftart_id = 2  THEN 1 
			WHEN vis.mandant_id IN (3)         AND vis.abschriftart_id = 11 THEN 1 
			WHEN vis.mandant_id IN (2,4,5,7,8) AND vis.abschriftart_id = 7  THEN 1 
			WHEN vis.mandant_id IN (2,5)       AND vis.abschriftart_id = 10 THEN 1 
			WHEN vis.mandant_id NOT IN (1)     AND vis.abschriftart_id = 20 THEN 1 
			ELSE -1 END 
		ELSE 0 END * abschrift_netto) AS abs_uf_ist
	, SUM(CASE 
		WHEN vis.abt_id = 5 THEN CASE 
			WHEN vis.mandant_id IN (6)         AND vis.abschriftart_id = 2  THEN 1 
			WHEN vis.mandant_id IN (3)         AND vis.abschriftart_id = 11 THEN 1 
			WHEN vis.mandant_id IN (2,4,5,7,8) AND vis.abschriftart_id = 7  THEN 1 
			WHEN vis.mandant_id IN (2,5)       AND vis.abschriftart_id = 10 THEN 1 
			WHEN vis.mandant_id NOT IN (1)     AND vis.abschriftart_id = 20 THEN 1 
			ELSE -1 END 
		ELSE 0 END * abschrift_netto_wvj) AS abs_uf_wvj
	, SUM(CASE 
		WHEN abs_thema.abschriftart_thema_int_id = 1 THEN CASE 
			WHEN vis.mandant_id IN (6)         AND vis.abschriftart_id = 2  THEN 1 
			WHEN vis.mandant_id IN (3)         AND vis.abschriftart_id = 11 THEN 1 
			WHEN vis.mandant_id IN (2,4,5,7,8) AND vis.abschriftart_id = 7  THEN 1 
			WHEN vis.mandant_id IN (2,5)       AND vis.abschriftart_id = 10 THEN 1 
			WHEN vis.mandant_id NOT IN (1)     AND vis.abschriftart_id = 20 THEN 1 
			ELSE -1 END 
		ELSE 0 END * abschrift_netto) AS abs_ta_ist
	, SUM(CASE 
		WHEN abs_thema.abschriftart_thema_int_id = 1 THEN CASE 
			WHEN vis.mandant_id IN (6)         AND vis.abschriftart_id = 2  THEN 1 
			WHEN vis.mandant_id IN (3)         AND vis.abschriftart_id = 11 THEN 1 
			WHEN vis.mandant_id IN (2,4,5,7,8) AND vis.abschriftart_id = 7  THEN 1 
			WHEN vis.mandant_id IN (2,5)       AND vis.abschriftart_id = 10 THEN 1 
			WHEN vis.mandant_id NOT IN (1)     AND vis.abschriftart_id = 20 THEN 1 
			ELSE -1 END 
		ELSE 0 END * abschrift_netto_wvj) AS abs_ta_wvj
	, SUM(CASE 
		WHEN abs_thema.abschriftart_thema_int_id = 4 THEN CASE 
			WHEN vis.mandant_id IN (6)         AND vis.abschriftart_id = 2  THEN 1 
			WHEN vis.mandant_id IN (3)         AND vis.abschriftart_id = 11 THEN 1 
			WHEN vis.mandant_id IN (2,4,5,7,8) AND vis.abschriftart_id = 7  THEN 1 
			WHEN vis.mandant_id IN (2,5)       AND vis.abschriftart_id = 10 THEN 1 
			WHEN vis.mandant_id NOT IN (1)     AND vis.abschriftart_id = 20 THEN 1 
			ELSE -1 END 
		ELSE 0 END * abschrift_netto) AS abs_pa_ist
	, SUM(CASE 
		WHEN abs_thema.abschriftart_thema_int_id = 4 THEN CASE 
			WHEN vis.mandant_id IN (6)         AND vis.abschriftart_id = 2  THEN 1 
			WHEN vis.mandant_id IN (3)         AND vis.abschriftart_id = 11 THEN 1 
			WHEN vis.mandant_id IN (2,4,5,7,8) AND vis.abschriftart_id = 7  THEN 1 
			WHEN vis.mandant_id IN (2,5)       AND vis.abschriftart_id = 10 THEN 1 
			WHEN vis.mandant_id NOT IN (1)     AND vis.abschriftart_id = 20 THEN 1 
			ELSE -1 END
		ELSE 0 END * abschrift_netto_wvj) AS abs_pa_wvj
	FROM DBP_MSI_VIEW_VIS.MV_VIS_TAG_ABSCHRIFTEN_WG	vis
	INNER JOIN DBP_MSI_VIEW_VIS.MV_ABSCHRIFTART_INT_ZU abs_art
	ON abs_art.abschriftart_id = vis.abschriftart_id AND abs_art.mandant_id = vis.mandant_id 
	INNER JOIN DBP_MSI_VIEW_VIS.MV_ABSCHRIFTART_INT_THEMA_ZU abs_thema
	ON abs_thema.abschriftart_int_id = abs_art.abschriftart_int_id
	AND abs_thema.abschriftart_thema_int_id IN (1, 4) /* Total- und Preisabschriften */
	INNER JOIN zeit_tag zeit 
	ON zeit.dat = vis.dat
	INNER JOIN wup 
	ON wup.wup_id = vis.wup_id AND wup.mandant_id = vis.mandant_id 
	GROUP BY ALL
	)

/* MV_VIS_TAG_REKL_ART aggregiert - IST */
, woche_rekl_ist AS (
	SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id
		, zeit.kjwo
		, SUM(IFF(reklamationsgrund_id IN(12,19), 1            , 0)) AS f_preis_ist
		, SUM(IFF(reklamationsgrund_id IN(13,14), 1            , 0)) AS f_kasse_ist
		, SUM(IFF(reklamationsgrund_id = 91     , vk_menge_kuga, 0)) AS w_theke_ist
		, SUM(IFF(reklamationsgrund_id = 92     , vk_menge_kuga, 0)) AS w_kasse_ist
		, SUM(IFF(reklamationsgrund_id = 93     , vk_menge_kuga, 0)) AS anz_mhd_ist
	FROM DBP_MSI_VIEW_VIS.MV_VIS_TAG_REKL_ART vis
	INNER JOIN zeit_tag zeit
	ON zeit.dat = vis.dat
	INNER JOIN wup 
	ON wup.wup_id = vis.wup_id AND wup.mandant_id = vis.mandant_id 
	WHERE vis.reklamationsgrund_id IN (12,13,14,19,91,92,93) /* Definierte Gründe, ohne Pfand */
	AND (vis.mandant_id, vis.art_id) IN (SELECT mandant_id, art_id FROM DBP_MSI_VIEW_VIS.MV_ART_WG_ZU WHERE wg_id NOT IN (980)) 
	GROUP BY ALL
	)

/* MV_VIS_TAG_REKL_ART aggregiert - WVJ */
, woche_rekl_wvj AS ( 
	SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id
		, zeit.kjwo
		, SUM(IFF(reklamationsgrund_id IN(12,19), 1            , 0)) AS f_preis_wvj
		, SUM(IFF(reklamationsgrund_id IN(13,14), 1            , 0)) AS f_kasse_wvj
		, SUM(IFF(reklamationsgrund_id = 91     , vk_menge_kuga, 0)) AS w_theke_wvj
		, SUM(IFF(reklamationsgrund_id = 92     , vk_menge_kuga, 0)) AS w_kasse_wvj
		, SUM(IFF(reklamationsgrund_id = 93     , vk_menge_kuga, 0)) AS anz_mhd_wvj
	FROM DBP_MSI_VIEW_VIS.MV_VIS_TAG_REKL_ART vis
	INNER JOIN zeit_tag zeit
	ON zeit.dat = (vis.dat + 364) /* Transformation auf kjwo_vj */
	INNER JOIN wup 
	ON wup.wup_id = vis.wup_id AND wup.mandant_id = vis.mandant_id 
	WHERE vis.reklamationsgrund_id IN (12,13,14,19,91,92,93) /* Definierte Gründe, ohne Pfand */
		AND (vis.mandant_id, vis.art_id) IN (SELECT mandant_id, art_id FROM DBP_MSI_VIEW_VIS.MV_ART_WG_ZU WHERE wg_id NOT IN (980)) 
	GROUP BY ALL
	) 

/* WUPCAL gemappt, aggregiert (ohne WRG) - IST */
, woche_wcal_ist AS ( 
	SELECT wcal.mandant_id, wcal.nb_id
	, wup.aktuell_wup_id AS wup_id /* Mapping */
	, zeit.kjwo
	, SUM(bonanzahl_sug)                 AS bon_ist 
	, SUM(bonanzahl_kundenkarte)         AS bon_kk 
	, SUM(bonanzahl_kundenkarte_payback) AS bon_pb 
	, bon_kk - ZEROIFNULL(bon_pb)        AS kcard_ist 
	FROM DBP_DATA.WUPCAL wcal
	INNER JOIN zeit_tag zeit
	ON zeit.dat = wcal.dat
	INNER JOIN wup
	ON wcal.mandant_id = wup.mandant_id AND wcal.wup_id = wup.wup_id
	GROUP BY ALL
	)

/* WUPCAL gemappt, aggregiert (ohne WRG) - WVJ */
, woche_wcal_wvj AS (
	SELECT wcal.mandant_id, wcal.nb_id
	, wup.aktuell_wup_id AS wup_id /* Mapping */
	, zeit.kjwo
	, SUM(bonanzahl_sug)                 AS bon_wvj 
	, SUM(bonanzahl_kundenkarte)         AS bon_kk 
	, SUM(bonanzahl_kundenkarte_payback) AS bon_pb 
	, bon_kk - ZEROIFNULL(bon_pb)        AS kcard_wvj 
	FROM DBP_DATA.WUPCAL wcal
	INNER JOIN zeit_tag zeit
	ON zeit.dat = (wcal.dat + 364) /* Transformation auf kjwo_vj */
	INNER JOIN wup
	ON wcal.mandant_id = wup.mandant_id AND wcal.wup_id = wup.wup_id
	GROUP BY ALL
	)

/* MV_VIS_BSCH_BESTVOR_DET aggregiert (ohne wrg) */
, woche_bestvor_wup AS (
	SELECT vis.mandant_id, vis.nb_id, vis.wup_id
	, zeit.kjwo
	, SUM(CASE WHEN vis.status NOT IN ('0B','0N')  THEN 1 ELSE 0 END) AS best_vor /* Bestellvorschläge */
	, SUM(CASE WHEN vis.status IN ('0B')           THEN 1 ELSE 0 END) AS best_man /* manuelle Bestellungen*/
	, SUM(CASE WHEN vis.status IN ('V0','V-','V+') THEN 1 ELSE 0 END) AS best_kor /* korrigierte Bestellungen*/
	FROM DBP_MSI_VIEW_VIS.MV_BSCH_BESTVOR_DET vis
	INNER JOIN zeit_tag zeit
	ON zeit.dat = vis.dat_plan
	INNER JOIN DBP_MSI_VIEW_VIS.MV_ART_WG_ZU art
	ON art.art_id = vis.art_id AND art.mandant_id = vis.mandant_id
	INNER JOIN DBP_MSI_VIEW_VIS.MV_WG_INT wg
	ON wg.wg_id = art.wg_id
	INNER JOIN DBP_MSI_VIEW_VIS.MV_OWG_INT owg
	ON owg.owg_id = wg.owg_id
	INNER JOIN DBP_MSI_VIEW_VIS.MV_HWG_INT hwg
	ON hwg.hwg_id = owg.hwg_id
	INNER JOIN wup
	ON wup.wup_id = vis.wup_id AND wup.mandant_id = vis.mandant_id 
	WHERE vis.status NOT IN ('0N') /* weitere Filter/Logik siehe mv_view! */
	AND hwg.abt_id IN (5,6,7,8)    /* Abteilung ohne Nebengeschäft */
	GROUP BY ALL
	)

/* MV_VIS_ZAEHL_AUFTRAG gruppiert (ohne wrg) */
, woche_zaehl_auftrag AS (
	SELECT vis.mandant_id, vis.nb_id, vis.wup_id
		, zeit.kjwo
		, SUM(CASE WHEN vis.dat_auftrag IS NOT NULL THEN 1 ELSE 0 END) AS auftrag
		, SUM(CASE WHEN vis.dat_zaehl   IS NOT NULL THEN 1 ELSE 0 END) AS gezaehlt
	FROM DBP_MSI_VIEW_VIS.MV_VIS_ZAEHL_AUFTRAG vis
	INNER JOIN DBP_MSI_VIEW_VIS.MV_ART_WG_ZU art
	ON art.art_id = vis.art_id AND art.mandant_id = vis.mandant_id
	INNER JOIN DBP_MSI_VIEW_VIS.MV_WG_INT wg
	ON wg.wg_id = art.wg_id
	INNER JOIN DBP_MSI_VIEW_VIS.MV_OWG_INT owg
	ON owg.owg_id = wg.owg_id
	INNER JOIN DBP_MSI_VIEW_VIS.MV_HWG_INT hwg
	ON hwg.hwg_id = owg.hwg_id
	INNER JOIN zeit_tag zeit 
	ON zeit.dat = vis.dat_auftrag /* dat = dat_auftrag */
	INNER JOIN wup 
	ON wup.wup_id = vis.wup_id AND wup.mandant_id = vis.mandant_id 
	WHERE vis.zaehl_grund_id IN ('214','299','300','301','310','311','320','330','340','350','360','814','999') /* definierte Zählgründe */
		AND hwg.abt_id IN (5,6,7,8) /* Abteilung ohne Nebengeschäft */
	GROUP BY ALL
	)

/* MV_VIS_TAG_FWWS_WG gruppiert (ohne wrg)*/
, woche_fwws_wg AS (
	SELECT vis.mandant_id, vis.nb_id, vis.wup_id, wup.vs_id
		, zeit.kjwo
		, SUM(vis.anz_artikel_autodispo_dm12) AS auto_dispo
		, SUM(vis.anz_artikel_exc214)         AS minus_best
		, SUM(CASE WHEN vis.dispomerkmal IN ('10', '11', '14') OR vis.mandant_id <> 1 THEN vis.anz_artikel_exc209 ELSE NULL END) AS null_best
	FROM DBP_MSI_VIEW_VIS.MV_VIS_TAG_FWWS_WG vis
	INNER JOIN zeit_tag zeit 
	ON zeit.dat = vis.dat
	INNER JOIN wup 
	ON wup.wup_id = vis.wup_id AND wup.mandant_id = vis.mandant_id 
	GROUP BY ALL
	)


/* CTE <-->  MAIN */ 


/* VTR100 Umsatz netto */
SELECT 100::INTEGER AS VTR_ID 
, mandant_id
, nb_id
, vs_id
, wup_id
, wrg_id
, kjwo 
, ist_fil  AS FILIST
, NULL AS FILIST2 
, wvj_fil  AS FILWVJ
, NULL AS FILWVJ2 
, plan_fil AS FILPLAN
, NULL AS FILPLAN2 
, ist_reg  AS REGIST
, NULL AS REGIST2 
, wvj_reg  AS REGWVJ
, NULL AS REGWVJ2 
, ist_land AS LANDIST
, NULL AS LANDIST2 
, wvj_land AS LANDWVJ
, NULL AS LANDWVJ2 
FROM (
	SELECT sub.mandant_id, sub.nb_id, sub.wup_id, sub.wrg_id, sub.vs_id
	, sub.kjwo
	, sub.ums_ist  AS ist_fil
	, sub.ums_plan AS plan_fil
	, sub.ums_wvj  AS wvj_fil
	/* Referenz Region */
	, SUM(ist_fil) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo, sub.vs_id) AS ist_reg
	, SUM(wvj_fil) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo, sub.vs_id) AS wvj_reg
	/* Referenz Land */
	, SUM(ist_fil) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo) AS ist_land
	, SUM(wvj_fil) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo) AS wvj_land
	FROM woche_fakt_wup sub
) vtr

UNION ALL
/* VTR110 Umsatz Abteilung Ultra-Frische */
SELECT 110::INTEGER AS VTR_ID
, mandant_id
, nb_id
, vs_id
, wup_id
, wrg_id
, kjwo 
, ist_fil  AS FILIST,  NULL AS FILIST2 
, wvj_fil  AS FILWVJ,  NULL AS FILWVJ2 
, NULL     AS FILPLAN, NULL AS FILPLAN2 
, ist_reg  AS REGIST,  NULL AS REGIST2 
, wvj_reg  AS REGWVJ,  NULL AS REGWVJ2 
, ist_land AS LANDIST, NULL AS LANDIST2 
, wvj_land AS LANDWVJ, NULL AS LANDWVJ2 
FROM (
	SELECT sub.mandant_id, sub.nb_id, sub.wup_id, sub.wrg_id, sub.vs_id
	, sub.kjwo
	, sub1.ums_uf_ist AS ist_fil
	, sub1.ums_uf_wvj AS wvj_fil
	/* Referenz Region */
	, SUM(ist_fil) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo, sub.vs_id) AS ist_reg
	, SUM(wvj_fil) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo, sub.vs_id) AS wvj_reg
	/* Referenz Land */
	, SUM(ist_fil) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo) AS ist_land
	, SUM(wvj_fil) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo) AS wvj_land
	FROM woche_fakt_wup sub
	LEFT OUTER JOIN woche_fakt_ware sub1
	ON sub1.wup_id = sub.wup_id AND sub1.mandant_id = sub.mandant_id AND sub1.wrg_id = sub.wrg_id 
	AND sub1.kjwo = sub.kjwo
) vtr
 
UNION ALL
/* VTR115 Umsatzanteil Ultra-Frische (Ware) */
SELECT 115::INTEGER AS VTR_ID
, mandant_id
, nb_id
, vs_id
, wup_id
, wrg_id
, kjwo 
, ist_fil  AS FILIST,  ist_fil2  AS FILIST2 
, wvj_fil  AS FILWVJ,  wvj_fil2  AS FILWVJ2 
, NULL     AS FILPLAN, NULL      AS FILPLAN2 
, ist_reg  AS REGIST,  ist_reg2  AS REGIST2 
, wvj_reg  AS REGWVJ,  wvj_reg2  AS REGWVJ2 
, ist_land AS LANDIST, ist_land2 AS LANDIST2 
, wvj_land AS LANDWVJ, wvj_land2 AS LANDWVJ2 
FROM (
	SELECT sub.mandant_id, sub.nb_id, sub.wup_id, sub.wrg_id, sub.vs_id
	, sub.kjwo
	, sub1.ums_uf_ist AS ist_fil
	, sub1.ums_ist    AS ist_fil2
	, sub1.ums_uf_wvj AS wvj_fil
	, sub1.ums_wvj    AS wvj_fil2
	/* Referenz Region */
	, SUM(ist_fil)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo, sub.vs_id) AS ist_reg
	, SUM(ist_fil2) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo, sub.vs_id) AS ist_reg2
	, SUM(wvj_fil)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo, sub.vs_id) AS wvj_reg
	, SUM(wvj_fil2) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo, sub.vs_id) AS wvj_reg2
	/* Referenz Land */
	, SUM(ist_fil)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo) AS ist_land
	, SUM(ist_fil2) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo) AS ist_land2
	, SUM(wvj_fil)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo) AS wvj_land
	, SUM(wvj_fil2) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo) AS wvj_land2
	FROM woche_fakt_wup sub
	LEFT OUTER JOIN woche_fakt_ware sub1
	ON sub1.wup_id = sub.wup_id AND sub1.mandant_id = sub.mandant_id AND sub1.wrg_id = sub.wrg_id 
	AND sub1.kjwo = sub.kjwo
) vtr   

UNION ALL
/* VTR120 Umsatz SA (artbew) */
SELECT 120::INTEGER AS VTR_ID
, mandant_id
, nb_id
, vs_id
, wup_id
, wrg_id
, kjwo 
, ist_fil  AS FILIST,  NULL AS FILIST2 
, wvj_fil  AS FILWVJ,  NULL AS FILWVJ2 
, NULL     AS FILPLAN, NULL AS FILPLAN2
, ist_reg  AS REGIST,  NULL AS REGIST2 
, wvj_reg  AS REGWVJ,  NULL AS REGWVJ2 
, ist_land AS LANDIST, NULL AS LANDIST2 
, wvj_land AS LANDWVJ, NULL AS LANDWVJ2 
FROM (
	SELECT sub.mandant_id, sub.nb_id, sub.wup_id, sub.wrg_id, sub.vs_id
	, sub.kjwo
	, sub1.ums_sa_ist AS ist_fil
	, sub2.ums_sa_wvj AS wvj_fil
	/* Referenz Region */
	, SUM(ist_fil) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo, sub.vs_id) AS ist_reg
	, SUM(wvj_fil) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo, sub.vs_id) AS wvj_reg
	/* Referenz Land */
	, SUM(ist_fil) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo) AS ist_land
	, SUM(wvj_fil) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo) AS wvj_land
	FROM woche_fakt_wup sub
	LEFT OUTER JOIN woche_artbew_ist sub1 
	ON sub1.wup_id = sub.wup_id AND sub1.mandant_id = sub.mandant_id
	AND sub1.wrg_id = sub.wrg_id AND sub1.kjwo = sub.kjwo
	LEFT OUTER JOIN woche_artbew_wvj sub2 
	ON sub2.wup_id = sub.wup_id AND sub2.mandant_id = sub.mandant_id
	AND sub2.wrg_id = sub.wrg_id AND sub2.kjwo = sub.kjwo 
) vtr

UNION ALL
/* VTR125 Umsatzanteil SA (artbew) */
SELECT 125::INTEGER AS VTR_ID
, mandant_id
, nb_id
, vs_id
, wup_id
, wrg_id
, kjwo 
, ist_fil  AS FILIST,  ist_fil2  AS FILIST2 
, wvj_fil  AS FILWVJ,  wvj_fil2  AS FILWVJ2 
, NULL     AS FILPLAN, NULL AS FILPLAN2 /* kein plan */
, ist_reg  AS REGIST,  ist_reg2  AS REGIST2 
, wvj_reg  AS REGWVJ,  wvj_reg2  AS REGWVJ2 
, ist_land AS LANDIST, ist_land2 AS LANDIST2 
, wvj_land AS LANDWVJ, wvj_land2 AS LANDWVJ2 
FROM (
	SELECT sub.mandant_id, sub.nb_id, sub.wup_id, sub.wrg_id, sub.vs_id
	, sub.kjwo
	, sub1.ums_sa_ist   AS ist_fil
	, sub1.ums_artb_ist AS ist_fil2
	, sub2.ums_sa_wvj   AS wvj_fil
	, sub2.ums_artb_wvj AS wvj_fil2
	/* Referenz Region */
	, SUM(ist_fil)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo, sub.vs_id) AS ist_reg
	, SUM(ist_fil2) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo, sub.vs_id) AS ist_reg2
	, SUM(wvj_fil)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo, sub.vs_id) AS wvj_reg
	, SUM(wvj_fil2) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo, sub.vs_id) AS wvj_reg2
	/* Referenz Land */
	, SUM(ist_fil)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo) AS ist_land
	, SUM(ist_fil2) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo) AS ist_land2
	, SUM(wvj_fil)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo) AS wvj_land
	, SUM(wvj_fil2) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo) AS wvj_land2
	FROM woche_fakt_wup sub
	LEFT OUTER JOIN woche_artbew_ist sub1 
	ON sub1.wup_id = sub.wup_id AND sub1.mandant_id = sub.mandant_id
	AND sub1.wrg_id = sub.wrg_id AND sub1.kjwo = sub.kjwo
	LEFT OUTER JOIN woche_artbew_wvj sub2 
	ON sub2.wup_id = sub.wup_id AND sub2.mandant_id = sub.mandant_id
	AND sub2.wrg_id = sub.wrg_id AND sub2.kjwo = sub.kjwo 
) vtr 

UNION ALL
/* VTR140 Absatz (ohne Pfand) */
SELECT 140::INTEGER AS VTR_ID
, mandant_id
, nb_id
, vs_id
, wup_id
, wrg_id
, kjwo 
, ist_fil  AS FILIST,  NULL AS FILIST2 
, wvj_fil  AS FILWVJ,  NULL AS FILWVJ2 
, NULL     AS FILPLAN, NULL AS FILPLAN2 
, ist_reg  AS REGIST,  NULL AS REGIST2 
, wvj_reg  AS REGWVJ,  NULL AS REGWVJ2 
, ist_land AS LANDIST, NULL AS LANDIST2 
, wvj_land AS LANDWVJ, NULL AS LANDWVJ2 
FROM (
	SELECT sub.mandant_id, sub.nb_id, sub.wup_id, sub.wrg_id, sub.vs_id
	, sub.kjwo
	, sub1.mng_opf_ist AS ist_fil
	, sub1.mng_opf_wvj AS wvj_fil
	/* Referenz Region */
	, SUM(ist_fil) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo, sub.vs_id) AS ist_reg
	, SUM(wvj_fil) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo, sub.vs_id) AS wvj_reg
	/* Referenz Land */
	, SUM(ist_fil) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo) AS ist_land
	, SUM(wvj_fil) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo) AS wvj_land
	FROM woche_fakt_wup sub
	LEFT OUTER JOIN woche_fakt_ware sub1
	ON sub1.wup_id = sub.wup_id AND sub1.mandant_id = sub.mandant_id AND sub1.wrg_id = sub.wrg_id 
	AND sub1.kjwo = sub.kjwo
) vtr  

UNION ALL
/* VTR160 Kunden */
SELECT 160::INTEGER AS VTR_ID
, mandant_id
, nb_id
, vs_id
, wup_id
, wrg_id
, kjwo 
, ist_fil  AS FILIST,  NULL AS FILIST2 
, wvj_fil  AS FILWVJ,  NULL AS FILWVJ2 
, NULL     AS FILPLAN, NULL AS FILPLAN2 
, ist_reg  AS REGIST,  NULL AS REGIST2 
, wvj_reg  AS REGWVJ,  NULL AS REGWVJ2 
, ist_land AS LANDIST, NULL AS LANDIST2 
, wvj_land AS LANDWVJ, NULL AS LANDWVJ2 
FROM (
	SELECT sub.mandant_id, sub.nb_id, sub.wup_id, sub.wrg_id, sub.vs_id, sub.kjwo
	, sub.knd_ist AS ist_fil
	, sub.knd_wvj AS wvj_fil
	/* Referenz Region */
	, SUM(ist_fil) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo, sub.vs_id) AS ist_reg
	, SUM(wvj_fil) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo, sub.vs_id) AS wvj_reg
	/* Referenz Land */
	, SUM(ist_fil) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo) AS ist_land
	, SUM(wvj_fil) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo) AS wvj_land
	FROM woche_fakt_wup sub
) vtr 

UNION ALL
/* VTR180 Ø-Bon */
SELECT 180::INTEGER AS VTR_ID
, mandant_id
, nb_id
, vs_id
, wup_id
, wrg_id
, kjwo 
, ist_fil  AS FILIST,  ist_fil2  AS FILIST2 
, wvj_fil  AS FILWVJ,  wvj_fil2  AS FILWVJ2 
, NULL     AS FILPLAN, NULL      AS FILPLAN2
, ist_reg  AS REGIST,  ist_reg2  AS REGIST2 
, wvj_reg  AS REGWVJ,  wvj_reg2  AS REGWVJ2 
, ist_land AS LANDIST, ist_land2 AS LANDIST2 
, wvj_land AS LANDWVJ, wvj_land2 AS LANDWVJ2 
FROM ( /* VTR180 Ø-Bon */
	SELECT sub.mandant_id, sub.nb_id, sub.wup_id, sub.wrg_id, sub.vs_id, sub.kjwo
	, sub.ums_ist  AS ist_fil 
	, sub.knd_ist  AS ist_fil2 
	, sub.ums_wvj  AS wvj_fil 
	, sub.knd_wvj  AS wvj_fil2 
	/* Referenz Region */
	, SUM(ist_fil)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo, sub.vs_id) AS ist_reg
	, SUM(ist_fil2) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo, sub.vs_id) AS ist_reg2
	, SUM(wvj_fil)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo, sub.vs_id) AS wvj_reg
	, SUM(wvj_fil2) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo, sub.vs_id) AS wvj_reg2
	/* Referenz Land */
	, SUM(ist_fil)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo) AS ist_land
	, SUM(ist_fil2) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo) AS ist_land2
	, SUM(wvj_fil)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo) AS wvj_land
	, SUM(wvj_fil2) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo) AS wvj_land2
	FROM woche_fakt_wup sub
) vtr 

UNION ALL
/* VTR200 Nettostunden */
SELECT 200::INTEGER AS VTR_ID
, mandant_id
, nb_id
, vs_id
, wup_id
, wrg_id
, kjwo 
, ist_fil  AS FILIST,  NULL AS FILIST2 
, wvj_fil  AS FILWVJ,  NULL AS FILWVJ2 
, plan_fil AS FILPLAN, NULL AS FILPLAN2 
, ist_reg  AS REGIST,  NULL AS REGIST2 
, wvj_reg  AS REGWVJ,  NULL AS REGWVJ2 
, ist_land AS LANDIST, NULL AS LANDIST2 
, wvj_land AS LANDWVJ, NULL AS LANDWVJ2 
FROM (
	SELECT sub.mandant_id, sub.nb_id, sub.wup_id, sub.wrg_id, sub.vs_id, sub.kjwo
	, sub1.nettostd_ist  AS ist_fil
	, sub1.nettostd_plan AS plan_fil
	, sub2.nettostd_wvj  AS wvj_fil
	/* Referenz Region */
	, SUM(ist_fil) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo, sub.vs_id) AS ist_reg
	, SUM(wvj_fil) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo, sub.vs_id) AS wvj_reg
	/* Referenz Land */
	, SUM(ist_fil) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo) AS ist_land
	, SUM(wvj_fil) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo) AS wvj_land
	FROM woche_fakt_wup sub
	LEFT OUTER JOIN woche_stunden_ist sub1
	ON sub1.wup_id = sub.wup_id AND sub1.mandant_id = sub.mandant_id AND sub1.wrg_id = sub.wrg_id 
	AND sub1.kjwo = sub.kjwo
	LEFT OUTER JOIN woche_stunden_wvj sub2 
	ON sub2.wup_id = sub.wup_id AND sub2.mandant_id = sub.mandant_id AND sub2.wrg_id = sub.wrg_id 
	AND sub2.kjwo = sub.kjwo 
) vtr 

UNION ALL
/* VTR210 Nettoleistung */
SELECT  210::INTEGER AS VTR_ID
, mandant_id
, nb_id
, vs_id
, wup_id
, wrg_id
, kjwo 
, ist_fil  AS FILIST,  ist_fil2  AS FILIST2 
, wvj_fil  AS FILWVJ,  wvj_fil2  AS FILWVJ2 
, plan_fil AS FILPLAN, plan_fil2 AS FILPLAN2 
, ist_reg  AS REGIST,  ist_reg2  AS REGIST2 
, wvj_reg  AS REGWVJ,  wvj_reg2  AS REGWVJ2 
, ist_land AS LANDIST, ist_land2 AS LANDIST2 
, wvj_land AS LANDWVJ, wvj_land2 AS LANDWVJ2 
FROM (
	SELECT sub.mandant_id, sub.nb_id, sub.wup_id, sub.wrg_id, sub.vs_id, sub.kjwo
	, sub1.wst_ums_ist   AS ist_fil 
	, sub1.nettostd_ist  AS ist_fil2 
	, sub1.wst_ums_plan  AS plan_fil
	, sub1.nettostd_plan AS plan_fil2
	, sub2.wst_ums_wvj   AS wvj_fil 
	, sub2.nettostd_wvj  AS wvj_fil2 
	/* Referenz Region */
	, SUM(ist_fil)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo, sub.vs_id) AS ist_reg
	, SUM(ist_fil2) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo, sub.vs_id) AS ist_reg2
	, SUM(wvj_fil)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo, sub.vs_id) AS wvj_reg
	, SUM(wvj_fil2) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo, sub.vs_id) AS wvj_reg2
	/* Referenz Land */
	, SUM(ist_fil)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo) AS ist_land
	, SUM(ist_fil2) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo) AS ist_land2
	, SUM(wvj_fil)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo) AS wvj_land
	, SUM(wvj_fil2) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo) AS wvj_land2
	FROM woche_fakt_wup sub
	LEFT OUTER JOIN woche_stunden_ist sub1
	ON sub1.wup_id = sub.wup_id AND sub1.mandant_id = sub.mandant_id AND sub1.wrg_id = sub.wrg_id 
	AND sub1.kjwo = sub.kjwo
	LEFT OUTER JOIN woche_stunden_wvj sub2 
	ON sub2.wup_id = sub.wup_id AND sub2.mandant_id = sub.mandant_id AND sub2.wrg_id = sub.wrg_id 
	AND sub2.kjwo = sub.kjwo 
) vtr 
 
UNION ALL 
SELECT 220::INTEGER AS VTR_ID /* VTR220 Nettostückleistung (ohne Pfand)*/ 
, mandant_id
, nb_id
, vs_id
, wup_id
, wrg_id
, kjwo 
, ist_fil  AS FILIST,  ist_fil2  AS FILIST2 
, wvj_fil  AS FILWVJ,  wvj_fil2  AS FILWVJ2 
, NULL     AS FILPLAN, NULL      AS FILPLAN2
, ist_reg  AS REGIST,  ist_reg2  AS REGIST2 
, wvj_reg  AS REGWVJ,  wvj_reg2  AS REGWVJ2 
, ist_land AS LANDIST, ist_land2 AS LANDIST2 
, wvj_land AS LANDWVJ, wvj_land2 AS LANDWVJ2 
FROM ( /* VTR220 Nettostückleistung (ohne Pfand) */
	SELECT sub.mandant_id, sub.nb_id, sub.wup_id, sub.wrg_id, sub.vs_id, sub.kjwo
	, sub0.mng_opf_ist   AS ist_fil 
	, sub1.nettostd_ist  AS ist_fil2 
	, sub0.mng_opf_wvj   AS wvj_fil 
	, sub2.nettostd_wvj  AS wvj_fil2 
	/* Referenz Region */
	, SUM(ist_fil)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo, sub.vs_id) AS ist_reg
	, SUM(ist_fil2) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo, sub.vs_id) AS ist_reg2
	, SUM(wvj_fil)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo, sub.vs_id) AS wvj_reg
	, SUM(wvj_fil2) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo, sub.vs_id) AS wvj_reg2
	/* Referenz Land */
	, SUM(ist_fil)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo) AS ist_land
	, SUM(ist_fil2) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo) AS ist_land2
	, SUM(wvj_fil)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo) AS wvj_land
	, SUM(wvj_fil2) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo) AS wvj_land2
	FROM woche_fakt_wup sub
	LEFT OUTER JOIN woche_fakt_ware sub0 
	ON sub0.wup_id = sub.wup_id AND sub0.mandant_id = sub.mandant_id AND sub0.wrg_id = sub.wrg_id 
	AND sub0.kjwo = sub.kjwo
	LEFT OUTER JOIN woche_stunden_ist sub1
	ON sub1.wup_id = sub.wup_id AND sub1.mandant_id = sub.mandant_id AND sub1.wrg_id = sub.wrg_id 
	AND sub1.kjwo = sub.kjwo
	LEFT OUTER JOIN woche_stunden_wvj sub2 
	ON sub2.wup_id = sub.wup_id AND sub2.mandant_id = sub.mandant_id AND sub2.wrg_id = sub.wrg_id 
	AND sub2.kjwo = sub.kjwo 
) vtr 
 
UNION ALL 
SELECT 240::INTEGER  AS VTR_ID /* VTR240 Kassierleistung */ 
, mandant_id
, nb_id
, vs_id
, wup_id
, wrg_id
, kjwo 
, ist_fil  AS FILIST,  ist_fil2  AS FILIST2 
, wvj_fil  AS FILWVJ,  wvj_fil2  AS FILWVJ2 
, NULL     AS FILPLAN, NULL      AS FILPLAN2 
, ist_reg  AS REGIST,  ist_reg2  AS REGIST2 
, wvj_reg  AS REGWVJ,  wvj_reg2  AS REGWVJ2 
, ist_land AS LANDIST, ist_land2 AS LANDIST2 
, wvj_land AS LANDWVJ, wvj_land2 AS LANDWVJ2 
FROM ( /* VTR240 Kassierleistung */
	SELECT sub.mandant_id, sub.nb_id, sub.wup_id, sub.wrg_id, sub.vs_id, sub.kjwo
	, sub1.ums_pos_ist  AS ist_fil
	, sub1.kass_std_ist AS ist_fil2
	, sub2.ums_pos_wvj  AS wvj_fil
	, sub2.kass_std_wvj AS wvj_fil2
	/* Referenz Region */
	, SUM(ist_fil)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo, sub.vs_id) AS ist_reg
	, SUM(ist_fil2) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo, sub.vs_id) AS ist_reg2
	, SUM(wvj_fil)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo, sub.vs_id) AS wvj_reg
	, SUM(wvj_fil2) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo, sub.vs_id) AS wvj_reg2
	/* Referenz Land */
	, SUM(ist_fil)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo) AS ist_land
	, SUM(ist_fil2) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo) AS ist_land2
	, SUM(wvj_fil)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo) AS wvj_land
	, SUM(wvj_fil2) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo) AS wvj_land2
	FROM woche_fakt_wup sub
	LEFT OUTER JOIN woche_kasse_ist sub1
	ON sub1.mandant_id = sub.mandant_id AND sub1.wup_id = sub.wup_id AND sub1.wrg_id = sub.wrg_id 
	AND sub1.kjwo = sub.kjwo
	LEFT OUTER JOIN woche_kasse_wvj sub2
	ON sub2.mandant_id = sub.mandant_id AND sub2.wup_id = sub.wup_id AND sub2.wrg_id = sub.wrg_id 
	AND sub2.kjwo = sub.kjwo
) vtr 

UNION ALL 
/* VTR250 Scans pro Minute -- KPOS (ODS_BON_KASSENABSCHLUSS) */ 
SELECT 250::INTEGER  AS VTR_ID 
, mandant_id
, nb_id
, vs_id
, wup_id
, wrg_id
, kjwo 
, ist_fil  AS FILIST,  ist_fil2  AS FILIST2 
, wvj_fil  AS FILWVJ,  wvj_fil2  AS FILWVJ2 
, NULL     AS FILPLAN, NULL      AS FILPLAN2 
, ist_reg  AS REGIST,  ist_reg2  AS REGIST2 
, wvj_reg  AS REGWVJ,  wvj_reg2  AS REGWVJ2 
, ist_land AS LANDIST, ist_land2 AS LANDIST2 
, wvj_land AS LANDWVJ, wvj_land2 AS LANDWVJ2 
FROM (
	SELECT sub.mandant_id, sub.nb_id, sub.wup_id, sub.wrg_id, sub.vs_id, sub.kjwo
	, sub1.scans_ist AS ist_fil
	, sub1.mins_ist  AS ist_fil2
	, sub2.scans_wvj AS wvj_fil
	, sub2.mins_wvj  AS wvj_fil2
	/* Referenz Region */
	, SUM(ist_fil)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo, sub.vs_id) AS ist_reg
	, SUM(ist_fil2) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo, sub.vs_id) AS ist_reg2
	, SUM(wvj_fil)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo, sub.vs_id) AS wvj_reg
	, SUM(wvj_fil2) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo, sub.vs_id) AS wvj_reg2
	/* Referenz Land */
	, SUM(ist_fil)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo) AS ist_land
	, SUM(ist_fil2) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo) AS ist_land2
	, SUM(wvj_fil)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo) AS wvj_land
	, SUM(wvj_fil2) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo) AS wvj_land2
	FROM woche_fakt_wup sub
	LEFT OUTER JOIN woche_ods_bon_ka_ist sub1
	ON sub1.mandant_id = sub.mandant_id AND sub1.wup_id = sub.wup_id
	AND sub1.kjwo = sub.kjwo
	LEFT OUTER JOIN woche_ods_bon_ka_wvj sub2
	ON sub2.mandant_id = sub.mandant_id AND sub2.wup_id = sub.wup_id 
	AND sub2.kjwo = sub.kjwo
) vtr 

UNION ALL 
/* VTR255 Scans pro Minute (DWH) -- ALT (VIS_TAG_KASSE) */ 
SELECT 255::INTEGER  AS VTR_ID 
, mandant_id
, nb_id
, vs_id
, wup_id
, wrg_id
, kjwo 
, ist_fil  AS FILIST,  ist_fil2  AS FILIST2 
, wvj_fil  AS FILWVJ,  wvj_fil2  AS FILWVJ2 
, NULL     AS FILPLAN, NULL      AS FILPLAN2 
, ist_reg  AS REGIST,  ist_reg2  AS REGIST2 
, wvj_reg  AS REGWVJ,  wvj_reg2  AS REGWVJ2 
, ist_land AS LANDIST, ist_land2 AS LANDIST2 
, wvj_land AS LANDWVJ, wvj_land2 AS LANDWVJ2 
FROM (
	SELECT sub.mandant_id, sub.nb_id, sub.wup_id, sub.wrg_id, sub.vs_id, sub.kjwo
	, sub1.art_pos_ist  AS ist_fil
	, sub1.scan_min_ist AS ist_fil2
	, sub2.art_pos_wvj  AS wvj_fil
	, sub2.scan_min_wvj AS wvj_fil2
	/* Referenz Region */
	, SUM(ist_fil)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo, sub.vs_id) AS ist_reg
	, SUM(ist_fil2) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo, sub.vs_id) AS ist_reg2
	, SUM(wvj_fil)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo, sub.vs_id) AS wvj_reg
	, SUM(wvj_fil2) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo, sub.vs_id) AS wvj_reg2
	/* Referenz Land */
	, SUM(ist_fil)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo) AS ist_land
	, SUM(ist_fil2) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo) AS ist_land2
	, SUM(wvj_fil)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo) AS wvj_land
	, SUM(wvj_fil2) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo) AS wvj_land2
	FROM woche_fakt_wup sub
	LEFT OUTER JOIN woche_kasse_ist sub1
	ON sub1.mandant_id = sub.mandant_id AND sub1.wup_id = sub.wup_id AND sub1.wrg_id = sub.wrg_id 
	AND sub1.kjwo = sub.kjwo
	LEFT OUTER JOIN woche_kasse_wvj sub2
	ON sub2.mandant_id = sub.mandant_id AND sub2.wup_id = sub.wup_id AND sub2.wrg_id = sub.wrg_id 
	AND sub2.kjwo = sub.kjwo
) vtr

/* VTR270 Personalkosten  >> keine Werte pro Woche */

/* VTR275 Personalkosten (%) - keine Werte pro Woche */ 

UNION ALL 
SELECT 300::INTEGER AS VTR_ID /* VTR300 Abschriften operativ */ 
, mandant_id
, nb_id
, vs_id
, wup_id
, wrg_id
, kjwo 
, ist_fil  AS FILIST,  NULL AS FILIST2 
, wvj_fil  AS FILWVJ,  NULL AS FILWVJ2 
, NULL     AS FILPLAN, NULL AS FILPLAN2 
, ist_reg  AS REGIST,  NULL AS REGIST2 
, wvj_reg  AS REGWVJ,  NULL AS REGWVJ2 
, ist_land AS LANDIST, NULL AS LANDIST2 
, wvj_land AS LANDWVJ, NULL AS LANDWVJ2 
FROM ( /* VTR300 Abschriften operativ */
	SELECT sub.mandant_id, sub.nb_id, sub.wup_id, sub.wrg_id, sub.vs_id, sub.kjwo
	, sub1.abs_op_ist AS ist_fil
	, sub1.abs_op_wvj AS wvj_fil
	/* Referenz Region */
	, SUM(ist_fil)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo, sub.vs_id) AS ist_reg
	, SUM(wvj_fil)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo, sub.vs_id) AS wvj_reg
	/* Referenz Land */
	, SUM(ist_fil)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo) AS ist_land
	, SUM(wvj_fil)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo) AS wvj_land
	FROM woche_fakt_wup sub
	LEFT OUTER JOIN woche_abschriften_ware sub1
	ON sub1.wup_id = sub.wup_id AND sub1.mandant_id = sub.mandant_id
	AND sub1.wrg_id = sub.wrg_id AND sub1.kjwo = sub.kjwo
) vtr 

UNION ALL 
SELECT 310::INTEGER AS VTR_ID /* VTR310 Abschriften operativ (%) */
, mandant_id
, nb_id
, vs_id
, wup_id
, wrg_id
, kjwo 
, ist_fil  AS FILIST,  ist_fil2  AS FILIST2 
, wvj_fil  AS FILWVJ,  wvj_fil2  AS FILWVJ2 
, NULL     AS FILPLAN, NULL      AS FILPLAN2 /* kein Plan Woche */
, ist_reg  AS REGIST,  ist_reg2  AS REGIST2 
, wvj_reg  AS REGWVJ,  wvj_reg2  AS REGWVJ2 
, ist_land AS LANDIST, ist_land2 AS LANDIST2 
, wvj_land AS LANDWVJ, wvj_land2 AS LANDWVJ2 
FROM ( /* VTR310 Abschriften operativ (%) */
	SELECT sub.mandant_id, sub.nb_id, sub.wup_id, sub.wrg_id, sub.vs_id, sub.kjwo
	, sub1.abs_op_ist AS ist_fil
	, sub.ums_ist     AS ist_fil2
	, sub1.abs_op_wvj AS wvj_fil
	, sub.ums_wvj     AS wvj_fil2
	/* Referenz Region */
	, SUM(ist_fil)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo, sub.vs_id) AS ist_reg
	, SUM(ist_fil2) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo, sub.vs_id) AS ist_reg2
	, SUM(wvj_fil)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo, sub.vs_id) AS wvj_reg
	, SUM(wvj_fil2) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo, sub.vs_id) AS wvj_reg2
	/* Referenz Land */
	, SUM(ist_fil)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo) AS ist_land
	, SUM(ist_fil2) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo) AS ist_land2
	, SUM(wvj_fil)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo) AS wvj_land
	, SUM(wvj_fil2) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo) AS wvj_land2
	FROM woche_fakt_wup sub
	LEFT OUTER JOIN woche_abschriften_ware sub1
	ON sub1.wup_id = sub.wup_id AND sub1.mandant_id = sub.mandant_id
	AND sub1.wrg_id = sub.wrg_id AND sub1.kjwo = sub.kjwo
) vtr 
 
UNION ALL 
SELECT 340::INTEGER AS VTR_ID /* VTR340 Preisabschriften (%) */ 
, mandant_id
, nb_id
, vs_id
, wup_id
, wrg_id
, kjwo 
, ist_fil  AS FILIST,  ist_fil2  AS FILIST2 
, wvj_fil  AS FILWVJ,  wvj_fil2  AS FILWVJ2 
, NULL     AS FILPLAN, NULL      AS FILPLAN2
, ist_reg  AS REGIST,  ist_reg2  AS REGIST2 
, wvj_reg  AS REGWVJ,  wvj_reg2  AS REGWVJ2 
, ist_land AS LANDIST, ist_land2 AS LANDIST2 
, wvj_land AS LANDWVJ, wvj_land2 AS LANDWVJ2 
FROM ( /* VTR340 Preisabschriften (%) */ 
	SELECT sub.mandant_id, sub.nb_id, sub.wup_id, sub.wrg_id, sub.vs_id, sub.kjwo
	, sub1.abs_pa_ist AS ist_fil
	, sub.ums_ist     AS ist_fil2
	, sub1.abs_pa_wvj AS wvj_fil
	, sub.ums_wvj     AS wvj_fil2
	/* Referenz Region */
	, SUM(ist_fil)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo, sub.vs_id) AS ist_reg
	, SUM(ist_fil2) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo, sub.vs_id) AS ist_reg2
	, SUM(wvj_fil)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo, sub.vs_id) AS wvj_reg
	, SUM(wvj_fil2) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo, sub.vs_id) AS wvj_reg2
	/* Referenz Land */
	, SUM(ist_fil)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo) AS ist_land
	, SUM(ist_fil2) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo) AS ist_land2
	, SUM(wvj_fil)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo) AS wvj_land
	, SUM(wvj_fil2) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo) AS wvj_land2
	FROM woche_fakt_wup sub
	LEFT OUTER JOIN woche_abschriften_ware sub1
	ON sub1.wup_id = sub.wup_id AND sub1.mandant_id = sub.mandant_id
	AND sub1.wrg_id = sub.wrg_id AND sub1.kjwo = sub.kjwo
) vtr 
 
UNION ALL 
SELECT 345::INTEGER AS VTR_ID  /* VTR345 Preisabschriften Anteil */ 
, mandant_id
, nb_id
, vs_id
, wup_id
, wrg_id
, kjwo 
, ist_fil  AS FILIST,  ist_fil2  AS FILIST2 
, wvj_fil  AS FILWVJ,  wvj_fil2  AS FILWVJ2 
, NULL     AS FILPLAN, NULL      AS FILPLAN2
, ist_reg  AS REGIST,  ist_reg2  AS REGIST2 
, wvj_reg  AS REGWVJ,  wvj_reg2  AS REGWVJ2 
, ist_land AS LANDIST, ist_land2 AS LANDIST2 
, wvj_land AS LANDWVJ, wvj_land2 AS LANDWVJ2 
FROM ( /* VTR345 Preisabschriften (%) */ 
	SELECT sub.mandant_id, sub.nb_id, sub.wup_id, sub.wrg_id, sub.vs_id, sub.kjwo
	, sub1.abs_pa_ist AS ist_fil
	, sub1.abs_op_ist AS ist_fil2
	, sub1.abs_pa_wvj AS wvj_fil
	, sub1.abs_op_wvj AS wvj_fil2
	/* Referenz Region */
	, SUM(ist_fil)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo, sub.vs_id) AS ist_reg
	, SUM(ist_fil2) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo, sub.vs_id) AS ist_reg2
	, SUM(wvj_fil)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo, sub.vs_id) AS wvj_reg
	, SUM(wvj_fil2) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo, sub.vs_id) AS wvj_reg2
	/* Referenz Land */
	, SUM(ist_fil)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo) AS ist_land
	, SUM(ist_fil2) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo) AS ist_land2
	, SUM(wvj_fil)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo) AS wvj_land
	, SUM(wvj_fil2) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo) AS wvj_land2
	FROM woche_fakt_wup sub
	LEFT OUTER JOIN woche_abschriften_ware sub1
	ON sub1.wup_id = sub.wup_id AND sub1.mandant_id = sub.mandant_id
	AND sub1.wrg_id = sub.wrg_id AND sub1.kjwo = sub.kjwo
) vtr 
 
UNION ALL 
SELECT 360::INTEGER AS VTR_ID /* VTR360 Preisabschriften (%) */ 
, mandant_id
, nb_id
, vs_id
, wup_id
, wrg_id
, kjwo 
, ist_fil  AS FILIST,  ist_fil2  AS FILIST2 
, wvj_fil  AS FILWVJ,  wvj_fil2  AS FILWVJ2 
, NULL     AS FILPLAN, NULL      AS FILPLAN2
, ist_reg  AS REGIST,  ist_reg2  AS REGIST2 
, wvj_reg  AS REGWVJ,  wvj_reg2  AS REGWVJ2 
, ist_land AS LANDIST, ist_land2 AS LANDIST2 
, wvj_land AS LANDWVJ, wvj_land2 AS LANDWVJ2 
FROM ( /* VTR360 Preisabschriften (%) */ 
	SELECT sub.mandant_id, sub.nb_id, sub.wup_id, sub.wrg_id, sub.vs_id, sub.kjwo
	, sub1.abs_ta_ist AS ist_fil
	, sub.ums_ist     AS ist_fil2
	, sub1.abs_ta_wvj AS wvj_fil
	, sub.ums_wvj     AS wvj_fil2
	/* Referenz Region */
	, SUM(ist_fil)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo, sub.vs_id) AS ist_reg
	, SUM(ist_fil2) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo, sub.vs_id) AS ist_reg2
	, SUM(wvj_fil)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo, sub.vs_id) AS wvj_reg
	, SUM(wvj_fil2) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo, sub.vs_id) AS wvj_reg2
	/* Referenz Land */
	, SUM(ist_fil)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo) AS ist_land
	, SUM(ist_fil2) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo) AS ist_land2
	, SUM(wvj_fil)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo) AS wvj_land
	, SUM(wvj_fil2) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo) AS wvj_land2
	FROM woche_fakt_wup sub
	LEFT OUTER JOIN woche_abschriften_ware sub1
	ON sub1.wup_id = sub.wup_id AND sub1.mandant_id = sub.mandant_id
	AND sub1.wrg_id = sub.wrg_id AND sub1.kjwo = sub.kjwo
) vtr 
 
UNION ALL 
SELECT 365::INTEGER AS VTR_ID  /* VTR365 Preisabschriften Anteil */ 
, mandant_id
, nb_id
, vs_id
, wup_id
, wrg_id
, kjwo 
, ist_fil  AS FILIST,  ist_fil2  AS FILIST2 
, wvj_fil  AS FILWVJ,  wvj_fil2  AS FILWVJ2 
, NULL     AS FILPLAN, NULL      AS FILPLAN2
, ist_reg  AS REGIST,  ist_reg2  AS REGIST2 
, wvj_reg  AS REGWVJ,  wvj_reg2  AS REGWVJ2 
, ist_land AS LANDIST, ist_land2 AS LANDIST2 
, wvj_land AS LANDWVJ, wvj_land2 AS LANDWVJ2 
FROM ( /* VTR365 Preisabschriften (%) */ 
	SELECT sub.mandant_id, sub.nb_id, sub.wup_id, sub.wrg_id, sub.vs_id, sub.kjwo
	, sub1.abs_ta_ist AS ist_fil
	, sub1.abs_op_ist AS ist_fil2
	, sub1.abs_ta_wvj AS wvj_fil
	, sub1.abs_op_wvj AS wvj_fil2
	/* Referenz Region */
	, SUM(ist_fil)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo, sub.vs_id) AS ist_reg
	, SUM(ist_fil2) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo, sub.vs_id) AS ist_reg2
	, SUM(wvj_fil)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo, sub.vs_id) AS wvj_reg
	, SUM(wvj_fil2) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo, sub.vs_id) AS wvj_reg2
	/* Referenz Land */
	, SUM(ist_fil)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo) AS ist_land
	, SUM(ist_fil2) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo) AS ist_land2
	, SUM(wvj_fil)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo) AS wvj_land
	, SUM(wvj_fil2) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo) AS wvj_land2
	FROM woche_fakt_wup sub
	LEFT OUTER JOIN woche_abschriften_ware sub1
	ON sub1.wup_id = sub.wup_id AND sub1.mandant_id = sub.mandant_id
	AND sub1.wrg_id = sub.wrg_id AND sub1.kjwo = sub.kjwo
) vtr 

/* VTR410 Inventurdifferenz Ultra-Frische >> keine Werte pro Woche */

/* VTR420 Bestandsentwicklung >> keine Werte pro Woche */

/* VTR425 Bestandsentw. zum Umsatz >> keine Werte pro Woche */

/* VTR500 Google Bewertung >> keine Werte pro Woche */

UNION ALL 
/* VTR505 Kaufland Card Anteil -- VTR506 K-Card nicht benötigt */ 
SELECT 505 ::INTEGER  AS VTR_ID 
, mandant_id
, nb_id
, vs_id
, wup_id
, wrg_id
, kjwo 
, ist_fil  AS FILIST,  ist_fil2  AS FILIST2 
, wvj_fil  AS FILWVJ,  wvj_fil2  AS FILWVJ2 
, NULL     AS FILPLAN, NULL      AS FILPLAN2
, ist_reg  AS REGIST,  ist_reg2  AS REGIST2 
, wvj_reg  AS REGWVJ,  wvj_reg2  AS REGWVJ2 
, ist_land AS LANDIST, ist_land2 AS LANDIST2 
, wvj_land AS LANDWVJ, wvj_land2 AS LANDWVJ2 
FROM ( /* VTR630 K-Card Anteil */ 
	SELECT sub.mandant_id, sub.nb_id, sub.wup_id, sub.wrg_id, sub.vs_id, sub.kjwo
	, sub1.kcard_ist AS ist_fil 
	, sub1.bon_ist   AS ist_fil2
	, sub2.kcard_wvj AS wvj_fil
	, sub2.bon_wvj   AS wvj_fil2
	/* Referenz Region */
	, SUM(ist_fil)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo, sub.vs_id) AS ist_reg
	, SUM(ist_fil2) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo, sub.vs_id) AS ist_reg2
	, SUM(wvj_fil)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo, sub.vs_id) AS wvj_reg
	, SUM(wvj_fil2) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo, sub.vs_id) AS wvj_reg2
	/* Referenz Land */
	, SUM(ist_fil)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo) AS ist_land
	, SUM(ist_fil2) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo) AS ist_land2
	, SUM(wvj_fil)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo) AS wvj_land
	, SUM(wvj_fil2) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo) AS wvj_land2
	FROM woche_fakt_wup sub
	LEFT OUTER JOIN woche_wcal_ist sub1
	ON sub1.mandant_id = sub.mandant_id AND sub1.wup_id = sub.wup_id
	AND sub1.kjwo = sub.kjwo
	LEFT OUTER JOIN woche_wcal_wvj sub2
	ON sub2.mandant_id = sub.mandant_id AND sub2.wup_id = sub.wup_id
	AND sub2.kjwo = sub.kjwo
) vtr 

UNION ALL /* VTR510 Warten Kasse */
SELECT 510::INTEGER  AS VTR_ID
, mandant_id
, nb_id
, vs_id
, wup_id
, wrg_id
, kjwo 
, ist_fil  AS FILIST,  NULL AS FILIST2 
, wvj_fil  AS FILWVJ,  NULL AS FILWVJ2 
, NULL     AS FILPLAN, NULL AS FILPLAN2
, ist_reg  AS REGIST,  NULL AS REGIST2 
, wvj_reg  AS REGWVJ,  NULL AS REGWVJ2 
, ist_land AS LANDIST, NULL AS LANDIST2 
, wvj_land AS LANDWVJ, NULL AS LANDWVJ2 
FROM ( /* VTR510 Warten Kasse */
	SELECT sub.mandant_id, sub.nb_id, sub.wup_id, sub.wrg_id, sub.vs_id, sub.kjwo
	, sub1.w_kasse_ist AS ist_fil
	, sub2.w_kasse_wvj AS wvj_fil
	/* Referenz Region */
	, SUM(ist_fil) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo, sub.vs_id) AS ist_reg
	, SUM(wvj_fil) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo, sub.vs_id) AS wvj_reg
	/* Referenz Land */
	, SUM(ist_fil) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo) AS ist_land
	, SUM(wvj_fil) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo) AS wvj_land
	FROM woche_fakt_wup sub
	LEFT OUTER JOIN woche_rekl_ist sub1
	ON sub1.mandant_id = sub.mandant_id AND sub1.wup_id = sub.wup_id
	AND sub1.wrg_id = sub.wrg_id AND sub1.kjwo = sub.kjwo
	LEFT OUTER JOIN woche_rekl_wvj sub2
	ON sub2.mandant_id = sub.mandant_id AND sub2.wup_id = sub.wup_id
	AND sub2.wrg_id = sub.wrg_id AND sub2.kjwo = sub.kjwo
) vtr 
 
UNION ALL 
SELECT 515::INTEGER  AS VTR_ID /* 515 Warten Kasse pro 10T Kunden */ 
, mandant_id
, nb_id
, vs_id
, wup_id
, wrg_id
, kjwo 
, ist_fil  AS FILIST,  ist_fil2  AS FILIST2 
, wvj_fil  AS FILWVJ,  wvj_fil2  AS FILWVJ2 
, NULL     AS FILPLAN, NULL      AS FILPLAN2 
, ist_reg  AS REGIST,  ist_reg2  AS REGIST2 
, wvj_reg  AS REGWVJ,  wvj_reg2  AS REGWVJ2 
, ist_land AS LANDIST, ist_land2 AS LANDIST2 
, wvj_land AS LANDWVJ, wvj_land2 AS LANDWVJ2 
FROM ( /* VTR515 Warten Kasse pro 10T Kunden */
	SELECT sub.mandant_id, sub.nb_id, sub.wup_id, sub.wrg_id, sub.vs_id, sub.kjwo
	, sub1.w_kasse_ist AS ist_fil
	, sub.knd_10t_ist  AS ist_fil2
	, sub2.w_kasse_wvj AS wvj_fil
	, sub.knd_10t_wvj  AS wvj_fil2
	/* Referenz Region */
	, SUM(ist_fil)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo, sub.vs_id) AS ist_reg
	, SUM(ist_fil2) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo, sub.vs_id) AS ist_reg2
	, SUM(wvj_fil)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo, sub.vs_id) AS wvj_reg
	, SUM(wvj_fil2) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo, sub.vs_id) AS wvj_reg2
	/* Referenz Land */
	, SUM(ist_fil)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo) AS ist_land
	, SUM(ist_fil2) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo) AS ist_land2
	, SUM(wvj_fil)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo) AS wvj_land
	, SUM(wvj_fil2) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo) AS wvj_land2
	FROM woche_fakt_wup sub
	LEFT OUTER JOIN woche_rekl_ist sub1
	ON sub1.mandant_id = sub.mandant_id AND sub1.wup_id = sub.wup_id
	AND sub1.wrg_id = sub.wrg_id AND sub1.kjwo = sub.kjwo
	LEFT OUTER JOIN woche_rekl_wvj sub2
	ON sub2.mandant_id = sub.mandant_id AND sub2.wup_id = sub.wup_id
	AND sub2.wrg_id = sub.wrg_id AND sub2.kjwo = sub.kjwo
) vtr 
 
UNION ALL 
SELECT 520::INTEGER  AS VTR_ID /* 520 Warten Theke */ 
, mandant_id
, nb_id
, vs_id
, wup_id
, wrg_id
, kjwo 
, ist_fil  AS FILIST,  NULL AS FILIST2 
, wvj_fil  AS FILWVJ,  NULL AS FILWVJ2 
, NULL     AS FILPLAN, NULL AS FILPLAN2
, ist_reg  AS REGIST,  NULL AS REGIST2 
, wvj_reg  AS REGWVJ,  NULL AS REGWVJ2 
, ist_land AS LANDIST, NULL AS LANDIST2 
, wvj_land AS LANDWVJ, NULL AS LANDWVJ2 
FROM ( /* VTR520 Warten Theke */
	SELECT sub.mandant_id, sub.nb_id, sub.wup_id, sub.wrg_id, sub.vs_id, sub.kjwo
	, sub1.w_theke_ist AS ist_fil
	, sub2.w_theke_wvj AS wvj_fil
	/* Referenz Region */
	, SUM(ist_fil) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo, sub.vs_id) AS ist_reg
	, SUM(wvj_fil) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo, sub.vs_id) AS wvj_reg
	/* Referenz Land */
	, SUM(ist_fil) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo) AS ist_land
	, SUM(wvj_fil) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo) AS wvj_land
	FROM woche_fakt_wup sub
	LEFT OUTER JOIN woche_rekl_ist sub1
	ON sub1.mandant_id = sub.mandant_id AND sub1.wup_id = sub.wup_id
	AND sub1.wrg_id = sub.wrg_id AND sub1.kjwo = sub.kjwo
	LEFT OUTER JOIN woche_rekl_wvj sub2
	ON sub2.mandant_id = sub.mandant_id AND sub2.wup_id = sub.wup_id
	AND sub2.wrg_id = sub.wrg_id AND sub2.kjwo = sub.kjwo
) vtr 
 
UNION ALL 
SELECT 525::INTEGER  AS VTR_ID /* 525 Warten Theke pro 10T Kunden */ 
, mandant_id
, nb_id
, vs_id
, wup_id
, wrg_id
, kjwo 
, ist_fil  AS FILIST,  ist_fil2  AS FILIST2 
, wvj_fil  AS FILWVJ,  wvj_fil2  AS FILWVJ2 
, NULL     AS FILPLAN, NULL      AS FILPLAN2 
, ist_reg  AS REGIST,  ist_reg2  AS REGIST2 
, wvj_reg  AS REGWVJ,  wvj_reg2  AS REGWVJ2 
, ist_land AS LANDIST, ist_land2 AS LANDIST2 
, wvj_land AS LANDWVJ, wvj_land2 AS LANDWVJ2 
FROM ( /* VTR525 Warten Theke pro 10T Kunden */
	SELECT sub.mandant_id, sub.nb_id, sub.wup_id, sub.wrg_id, sub.vs_id, sub.kjwo
	, sub1.w_theke_ist AS ist_fil
	, sub.knd_10t_ist  AS ist_fil2
	, sub2.w_theke_wvj AS wvj_fil
	, sub.knd_10t_wvj  AS wvj_fil2
	/* Referenz Region */
	, SUM(ist_fil)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo, sub.vs_id) AS ist_reg
	, SUM(ist_fil2) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo, sub.vs_id) AS ist_reg2
	, SUM(wvj_fil)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo, sub.vs_id) AS wvj_reg
	, SUM(wvj_fil2) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo, sub.vs_id) AS wvj_reg2
	/* Referenz Land */
	, SUM(ist_fil)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo) AS ist_land
	, SUM(ist_fil2) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo) AS ist_land2
	, SUM(wvj_fil)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo) AS wvj_land
	, SUM(wvj_fil2) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo) AS wvj_land2
	FROM woche_fakt_wup sub
	LEFT OUTER JOIN woche_rekl_ist sub1
	ON sub1.mandant_id = sub.mandant_id AND sub1.wup_id = sub.wup_id
	AND sub1.wrg_id = sub.wrg_id AND sub1.kjwo = sub.kjwo
	LEFT OUTER JOIN woche_rekl_wvj sub2
	ON sub2.mandant_id = sub.mandant_id AND sub2.wup_id = sub.wup_id
	AND sub2.wrg_id = sub.wrg_id AND sub2.kjwo = sub.kjwo
) vtr 
 
UNION ALL 
SELECT 530::INTEGER  AS VTR_ID /* 510 Mangel MHD */ 
, mandant_id
, nb_id
, vs_id
, wup_id
, wrg_id
, kjwo 
, ist_fil  AS FILIST,  NULL AS FILIST2 
, wvj_fil  AS FILWVJ,  NULL AS FILWVJ2 
, NULL     AS FILPLAN, NULL AS FILPLAN2
, ist_reg  AS REGIST,  NULL AS REGIST2 
, wvj_reg  AS REGWVJ,  NULL AS REGWVJ2 
, ist_land AS LANDIST, NULL AS LANDIST2 
, wvj_land AS LANDWVJ, NULL AS LANDWVJ2 
FROM ( /* VTR530 Mangel MHD */
	SELECT sub.mandant_id, sub.nb_id, sub.wup_id, sub.wrg_id, sub.vs_id, sub.kjwo
	, sub1.anz_mhd_ist AS ist_fil
	, sub2.anz_mhd_wvj AS wvj_fil
	/* Referenz Region */
	, SUM(ist_fil) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo, sub.vs_id) AS ist_reg
	, SUM(wvj_fil) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo, sub.vs_id) AS wvj_reg
	/* Referenz Land */
	, SUM(ist_fil) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo) AS ist_land
	, SUM(wvj_fil) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo) AS wvj_land
	FROM woche_fakt_wup sub
	LEFT OUTER JOIN woche_rekl_ist sub1
	ON sub1.mandant_id = sub.mandant_id AND sub1.wup_id = sub.wup_id
	AND sub1.wrg_id = sub.wrg_id AND sub1.kjwo = sub.kjwo
	LEFT OUTER JOIN woche_rekl_wvj sub2
	ON sub2.mandant_id = sub.mandant_id AND sub2.wup_id = sub.wup_id
	AND sub2.wrg_id = sub.wrg_id AND sub2.kjwo = sub.kjwo
) vtr 
 
UNION ALL 
SELECT 535::INTEGER  AS VTR_ID /* 535 Mangel MHD pro 10T Kunden */ 
, mandant_id
, nb_id
, vs_id
, wup_id
, wrg_id
, kjwo 
, ist_fil  AS FILIST,  ist_fil2  AS FILIST2 
, wvj_fil  AS FILWVJ,  wvj_fil2  AS FILWVJ2 
, NULL     AS FILPLAN, NULL      AS FILPLAN2 
, ist_reg  AS REGIST,  ist_reg2  AS REGIST2 
, wvj_reg  AS REGWVJ,  wvj_reg2  AS REGWVJ2 
, ist_land AS LANDIST, ist_land2 AS LANDIST2 
, wvj_land AS LANDWVJ, wvj_land2 AS LANDWVJ2 
FROM ( /* VTR535 Mangel MHD pro 10T Kunden */
	SELECT sub.mandant_id, sub.nb_id, sub.wup_id, sub.wrg_id, sub.vs_id, sub.kjwo
	, sub1.anz_mhd_ist AS ist_fil
	, sub.knd_10t_ist  AS ist_fil2
	, sub2.anz_mhd_wvj AS wvj_fil
	, sub.knd_10t_wvj  AS wvj_fil2
	/* Referenz Region */
	, SUM(ist_fil)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo, sub.vs_id) AS ist_reg
	, SUM(ist_fil2) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo, sub.vs_id) AS ist_reg2
	, SUM(wvj_fil)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo, sub.vs_id) AS wvj_reg
	, SUM(wvj_fil2) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo, sub.vs_id) AS wvj_reg2
	/* Referenz Land */
	, SUM(ist_fil)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo) AS ist_land
	, SUM(ist_fil2) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo) AS ist_land2
	, SUM(wvj_fil)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo) AS wvj_land
	, SUM(wvj_fil2) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo) AS wvj_land2
	FROM woche_fakt_wup sub
	LEFT OUTER JOIN woche_rekl_ist sub1
	ON sub1.mandant_id = sub.mandant_id AND sub1.wup_id = sub.wup_id
	AND sub1.wrg_id = sub.wrg_id AND sub1.kjwo = sub.kjwo
	LEFT OUTER JOIN woche_rekl_wvj sub2
	ON sub2.mandant_id = sub.mandant_id AND sub2.wup_id = sub.wup_id
	AND sub2.wrg_id = sub.wrg_id AND sub2.kjwo = sub.kjwo
) vtr 
 
UNION ALL 
SELECT 540::INTEGER  AS VTR_ID /* 540 Preisfehler */ 
, mandant_id
, nb_id
, vs_id
, wup_id
, wrg_id
, kjwo 
, ist_fil  AS FILIST,  NULL AS FILIST2 
, wvj_fil  AS FILWVJ,  NULL AS FILWVJ2 
, NULL     AS FILPLAN, NULL AS FILPLAN2
, ist_reg  AS REGIST,  NULL AS REGIST2 
, wvj_reg  AS REGWVJ,  NULL AS REGWVJ2 
, ist_land AS LANDIST, NULL AS LANDIST2 
, wvj_land AS LANDWVJ, NULL AS LANDWVJ2 
FROM ( /* VTR540 Preisfehler */
	SELECT sub.mandant_id, sub.nb_id, sub.wup_id, sub.wrg_id, sub.vs_id, sub.kjwo
	, sub1.f_preis_ist AS ist_fil
	, sub2.f_preis_wvj AS wvj_fil
	/* Referenz Region */
	, SUM(ist_fil) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo, sub.vs_id) AS ist_reg
	, SUM(wvj_fil) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo, sub.vs_id) AS wvj_reg
	/* Referenz Land */
	, SUM(ist_fil) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo) AS ist_land
	, SUM(wvj_fil) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo) AS wvj_land
	FROM woche_fakt_wup sub
	LEFT OUTER JOIN woche_rekl_ist sub1
	ON sub1.mandant_id = sub.mandant_id AND sub1.wup_id = sub.wup_id
	AND sub1.wrg_id = sub.wrg_id AND sub1.kjwo = sub.kjwo
	LEFT OUTER JOIN woche_rekl_wvj sub2
	ON sub2.mandant_id = sub.mandant_id AND sub2.wup_id = sub.wup_id
	AND sub2.wrg_id = sub.wrg_id AND sub2.kjwo = sub.kjwo
) vtr 
 
UNION ALL 
SELECT 545::INTEGER  AS VTR_ID /* 545 Preisfehler pro 10T Kunden */ 
, mandant_id
, nb_id
, vs_id
, wup_id
, wrg_id
, kjwo 
, ist_fil  AS FILIST,  ist_fil2  AS FILIST2 
, wvj_fil  AS FILWVJ,  wvj_fil2  AS FILWVJ2 
, NULL     AS FILPLAN, NULL      AS FILPLAN2 
, ist_reg  AS REGIST,  ist_reg2  AS REGIST2 
, wvj_reg  AS REGWVJ,  wvj_reg2  AS REGWVJ2 
, ist_land AS LANDIST, ist_land2 AS LANDIST2 
, wvj_land AS LANDWVJ, wvj_land2 AS LANDWVJ2 
FROM ( /* VTR545 Preisfehler pro 10T Kunden */
	SELECT sub.mandant_id, sub.nb_id, sub.wup_id, sub.wrg_id, sub.vs_id, sub.kjwo
	, sub1.f_preis_ist AS ist_fil
	, sub.knd_10t_ist  AS ist_fil2
	, sub2.f_preis_wvj AS wvj_fil
	, sub.knd_10t_wvj  AS wvj_fil2
	/* Referenz Region */
	, SUM(ist_fil)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo, sub.vs_id) AS ist_reg
	, SUM(ist_fil2) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo, sub.vs_id) AS ist_reg2
	, SUM(wvj_fil)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo, sub.vs_id) AS wvj_reg
	, SUM(wvj_fil2) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo, sub.vs_id) AS wvj_reg2
	/* Referenz Land */
	, SUM(ist_fil)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo) AS ist_land
	, SUM(ist_fil2) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo) AS ist_land2
	, SUM(wvj_fil)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo) AS wvj_land
	, SUM(wvj_fil2) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo) AS wvj_land2
	FROM woche_fakt_wup sub
	LEFT OUTER JOIN woche_rekl_ist sub1
	ON sub1.mandant_id = sub.mandant_id AND sub1.wup_id = sub.wup_id
	AND sub1.wrg_id = sub.wrg_id AND sub1.kjwo = sub.kjwo
	LEFT OUTER JOIN woche_rekl_wvj sub2
	ON sub2.mandant_id = sub.mandant_id AND sub2.wup_id = sub.wup_id
	AND sub2.wrg_id = sub.wrg_id AND sub2.kjwo = sub.kjwo
) vtr 
 
UNION ALL 
SELECT 550::INTEGER  AS VTR_ID /* 550 Kassierfehler */ 
, mandant_id
, nb_id
, vs_id
, wup_id
, wrg_id
, kjwo 
, ist_fil  AS FILIST,  NULL AS FILIST2 
, wvj_fil  AS FILWVJ,  NULL AS FILWVJ2 
, NULL     AS FILPLAN, NULL AS FILPLAN2
, ist_reg  AS REGIST,  NULL AS REGIST2 
, wvj_reg  AS REGWVJ,  NULL AS REGWVJ2 
, ist_land AS LANDIST, NULL AS LANDIST2 
, wvj_land AS LANDWVJ, NULL AS LANDWVJ2 
FROM ( /* VTR550 Kassierfehler */
	SELECT sub.mandant_id, sub.nb_id, sub.wup_id, sub.wrg_id, sub.vs_id, sub.kjwo
	, sub1.f_kasse_ist AS ist_fil
	, sub2.f_kasse_wvj AS wvj_fil
	/* Referenz Region */
	, SUM(ist_fil) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo, sub.vs_id) AS ist_reg
	, SUM(wvj_fil) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo, sub.vs_id) AS wvj_reg
	/* Referenz Land */
	, SUM(ist_fil) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo) AS ist_land
	, SUM(wvj_fil) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo) AS wvj_land
	FROM woche_fakt_wup sub
	LEFT OUTER JOIN woche_rekl_ist sub1
	ON sub1.mandant_id = sub.mandant_id AND sub1.wup_id = sub.wup_id
	AND sub1.wrg_id = sub.wrg_id AND sub1.kjwo = sub.kjwo
	LEFT OUTER JOIN woche_rekl_wvj sub2
	ON sub2.mandant_id = sub.mandant_id AND sub2.wup_id = sub.wup_id
	AND sub2.wrg_id = sub.wrg_id AND sub2.kjwo = sub.kjwo
) vtr 
 
UNION ALL 
SELECT 555::INTEGER  AS VTR_ID /* 555 Kassierfehler pro 100000 Scanzeilen */ 
, mandant_id
, nb_id
, vs_id
, wup_id
, wrg_id
, kjwo 
, ist_fil  AS FILIST,  ist_fil2  AS FILIST2 
, wvj_fil  AS FILWVJ,  wvj_fil2  AS FILWVJ2 
, NULL     AS FILPLAN, NULL      AS FILPLAN2 
, ist_reg  AS REGIST,  ist_reg2  AS REGIST2 
, wvj_reg  AS REGWVJ,  wvj_reg2  AS REGWVJ2 
, ist_land AS LANDIST, ist_land2 AS LANDIST2 
, wvj_land AS LANDWVJ, wvj_land2 AS LANDWVJ2 
FROM ( /* VTR555 Kassierfehler pro 100T Scanzeilen */
	SELECT sub.mandant_id, sub.nb_id, sub.wup_id, sub.wrg_id, sub.vs_id, sub.kjwo
	, sub1.f_kasse_ist  AS ist_fil
	, sub3.art_100t_ist AS ist_fil2
	, sub2.f_kasse_wvj  AS wvj_fil
	, sub4.art_100t_wvj AS wvj_fil2
	/* Referenz Region */
	, SUM(ist_fil)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo, sub.vs_id) AS ist_reg
	, SUM(ist_fil2) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo, sub.vs_id) AS ist_reg2
	, SUM(wvj_fil)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo, sub.vs_id) AS wvj_reg
	, SUM(wvj_fil2) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo, sub.vs_id) AS wvj_reg2
	/* Referenz Land */
	, SUM(ist_fil)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo) AS ist_land
	, SUM(ist_fil2) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo) AS ist_land2
	, SUM(wvj_fil)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo) AS wvj_land
	, SUM(wvj_fil2) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo) AS wvj_land2
	FROM woche_fakt_wup sub
	LEFT OUTER JOIN woche_rekl_ist sub1
	ON sub1.mandant_id = sub.mandant_id AND sub1.wup_id = sub.wup_id
	AND sub1.wrg_id = sub.wrg_id AND sub1.kjwo = sub.kjwo
	LEFT OUTER JOIN woche_rekl_wvj sub2
	ON sub2.mandant_id = sub.mandant_id AND sub2.wup_id = sub.wup_id
	AND sub2.wrg_id = sub.wrg_id AND sub2.kjwo = sub.kjwo
	LEFT OUTER JOIN woche_kasse_ist sub3
	ON sub3.mandant_id = sub.mandant_id AND sub3.wup_id = sub.wup_id
	AND sub3.wrg_id = sub.wrg_id AND sub3.kjwo = sub.kjwo
	LEFT OUTER JOIN woche_kasse_wvj sub4
	ON sub4.mandant_id = sub.mandant_id AND sub4.wup_id = sub.wup_id
	AND sub4.wrg_id = sub.wrg_id AND sub4.kjwo = sub.kjwo
) vtr 

UNION ALL 
SELECT 710::INTEGER AS VTR_ID /* VTR710 Übernahmequote Autodispo */
, mandant_id
, nb_id
, vs_id
, wup_id
, wrg_id
, kjwo 
, ist_fil  AS FILIST,  ist_fil2  AS FILIST2 
, NULL     AS FILWVJ,  NULL      AS FILWVJ2  /* kein vj */
, NULL     AS FILPLAN, NULL      AS FILPLAN2 
, ist_reg  AS REGIST,  ist_reg2  AS REGIST2 
, NULL     AS REGWVJ,  NULL      AS REGWVJ2  /* kein vj */
, ist_land AS LANDIST, ist_land2 AS LANDIST2 
, NULL     AS LANDWVJ, NULL      AS LANDWVJ2 /* kein vj */
FROM ( /* VTR710 Übernahmequote Autodispo */
	SELECT sub.mandant_id, sub.nb_id, sub.wup_id, sub.wrg_id, sub.vs_id, sub.kjwo
	/* Übernahmequote Autodispo = (best_vor - best_kor) / best_vor + best_man */ 
	, (sub1.best_vor - sub1.best_kor) AS ist_fil
	, (sub1.best_vor + sub1.best_man) AS ist_fil2
	/* Referenz Region */
	, SUM(ist_fil)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo, sub.vs_id) AS ist_reg
	, SUM(ist_fil2) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo, sub.vs_id) AS ist_reg2
	/* Referenz Land */
	, SUM(ist_fil)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo) AS ist_land
	, SUM(ist_fil2) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo) AS ist_land2
	FROM woche_fakt_wup sub
	LEFT OUTER JOIN woche_bestvor_wup sub1 
	ON sub1.wup_id = sub.wup_id AND sub1.mandant_id = sub.mandant_id
	AND sub1.kjwo = sub.kjwo
) vtr  
 
UNION ALL 
SELECT 730::INTEGER AS VTR_ID /* 730 Zählaufträge Anzahl */
, mandant_id
, nb_id
, vs_id
, wup_id
, wrg_id
, kjwo 
, ist_fil  AS FILIST,  NULL AS FILIST2 
, NULL     AS FILWVJ,  NULL AS FILWVJ2  /* kein vj */
, NULL     AS FILPLAN, NULL AS FILPLAN2 
, ist_reg  AS REGIST,  NULL AS REGIST2 
, NULL     AS REGWVJ,  NULL AS REGWVJ2  /* kein vj */
, ist_land AS LANDIST, NULL AS LANDIST2 
, NULL     AS LANDWVJ, NULL AS LANDWVJ2 /* kein vj */
FROM ( /* VTR730 Zählaufträge Anzahl */
	SELECT sub.mandant_id, sub.nb_id, sub.wup_id, sub.wrg_id, sub.vs_id, sub.kjwo
	, sub1.auftrag AS ist_fil
	/* Referenz Region */
	, SUM(ist_fil) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo, sub.vs_id) AS ist_reg
	/* Referenz Land */
	, SUM(ist_fil) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo) AS ist_land
	FROM woche_fakt_wup sub
	LEFT OUTER JOIN woche_zaehl_auftrag sub1 
	ON sub1.wup_id = sub.wup_id AND sub1.mandant_id = sub.mandant_id
	AND sub1.kjwo = sub.kjwo
) vtr 
 
UNION ALL 
SELECT 732::INTEGER AS VTR_ID /* VTR732 Zählungen durchgeführt */
, mandant_id
, nb_id
, vs_id
, wup_id
, wrg_id
, kjwo 
, ist_fil  AS FILIST,  NULL AS FILIST2 
, NULL     AS FILWVJ,  NULL AS FILWVJ2  /* kein vj */
, NULL     AS FILPLAN, NULL AS FILPLAN2 
, ist_reg  AS REGIST,  NULL AS REGIST2 
, NULL     AS REGWVJ,  NULL AS REGWVJ2  /* kein vj */
, ist_land AS LANDIST, NULL AS LANDIST2 
, NULL     AS LANDWVJ, NULL AS LANDWVJ2 /* kein vj */
FROM ( /* VTR732 Zählungen durchgeführt */
	SELECT sub.mandant_id, sub.nb_id, sub.wup_id, sub.wrg_id, sub.vs_id, sub.kjwo
	, sub1.gezaehlt AS ist_fil
	/* Referenz Region */
	, SUM(ist_fil) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo, sub.vs_id) AS ist_reg
	/* Referenz Land */
	, SUM(ist_fil) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo) AS ist_land
	FROM woche_fakt_wup sub
	LEFT OUTER JOIN woche_zaehl_auftrag sub1 
	ON sub1.wup_id = sub.wup_id AND sub1.mandant_id = sub.mandant_id
	AND sub1.kjwo = sub.kjwo
) vtr  

UNION ALL
/* 735 Zählaufträge bearbeitet (%) */
SELECT 735::INTEGER AS VTR_ID
, mandant_id
, nb_id
, vs_id
, wup_id
, wrg_id
, kjwo
, ist_fil  AS FILIST
, ist_fil2 AS FILIST2
, NULL, NULL, NULL, NULL
, ist_reg  AS REGIST
, ist_reg2 AS REGIST2 
, NULL, NULL
, ist_land  AS LANDIST
, ist_land2 AS LANDIST2 
, NULL, NULL
FROM ( /* 735 Zählaufträge bearbeitet (%) */
	SELECT sub.mandant_id, sub.nb_id, sub.wup_id, sub.wrg_id, sub.vs_id, sub.kjwo
	, sub1.gezaehlt AS ist_fil
	, sub1.auftrag  AS ist_fil2
	/* Referenz Region */
	, SUM(ist_fil)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo, sub.vs_id) AS ist_reg
	, SUM(ist_fil2) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo, sub.vs_id) AS ist_reg2
	/* Referenz Land */
	, SUM(ist_fil)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo) AS ist_land
	, SUM(ist_fil2) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo) AS ist_land2
	FROM woche_fakt_wup sub
	LEFT OUTER JOIN woche_zaehl_auftrag sub1 
	ON sub1.wup_id = sub.wup_id AND sub1.mandant_id = sub.mandant_id
	AND sub1.kjwo = sub.kjwo
) vtr

UNION ALL
/* VTR750 Nullbestandsquote */
SELECT 750::INTEGER AS VTR_ID
, mandant_id
, nb_id
, vs_id
, wup_id
, wrg_id
, kjwo 
, ist_fil  AS FILIST
, ist_fil2 AS FILIST2 
, NULL, NULL, NULL, NULL
, ist_reg  AS REGIST
, ist_reg2 AS REGIST2 
, NULL, NULL
, ist_land  AS LANDIST
, ist_land2 AS LANDIST2 
, NULL, NULL
FROM ( /* VTR750 Nullbestandsquote */
	SELECT sub.mandant_id, sub.nb_id, sub.wup_id, sub.wrg_id, sub.vs_id, sub.kjwo
	, sub1.null_best AS ist_fil
	, sub1.auto_dispo AS ist_fil2
	/* Referenz Region */
	, SUM(ist_fil)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo, sub.vs_id) AS ist_reg
	, SUM(ist_fil2) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo, sub.vs_id) AS ist_reg2
	/* Referenz Land */
	, SUM(ist_fil)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo) AS ist_land
	, SUM(ist_fil2) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo) AS ist_land2
	FROM woche_fakt_wup sub
	LEFT OUTER JOIN woche_fwws_wg sub1 
	ON sub1.wup_id = sub.wup_id AND sub1.mandant_id = sub.mandant_id
	AND sub1.kjwo = sub.kjwo
) vtr 
 
UNION ALL 
/* VTR752 Minusbestandsquote */ 
SELECT 752::INTEGER AS VTR_ID 
, mandant_id
, nb_id
, vs_id
, wup_id
, wrg_id
, kjwo 
, ist_fil  AS FILIST
, ist_fil2 AS FILIST2 
, NULL, NULL, NULL, NULL
, ist_reg  AS REGIST
, ist_reg2 AS REGIST2 
, NULL, NULL
, ist_land  AS LANDIST
, ist_land2 AS LANDIST2 
, NULL, NULL
FROM ( /* VTR752 Minusbestandsquote */ 
	SELECT sub.mandant_id, sub.nb_id, sub.wup_id, sub.wrg_id, sub.vs_id, sub.kjwo
	, sub1.minus_best AS ist_fil
	, sub1.auto_dispo AS ist_fil2
	/* Referenz Region */
	, SUM(ist_fil)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo, sub.vs_id) AS ist_reg
	, SUM(ist_fil2) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo, sub.vs_id) AS ist_reg2
	/* Referenz Land */
	, SUM(ist_fil)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo) AS ist_land
	, SUM(ist_fil2) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo) AS ist_land2
	FROM woche_fakt_wup sub
	LEFT OUTER JOIN woche_fwws_wg sub1 
	ON sub1.wup_id = sub.wup_id AND sub1.mandant_id = sub.mandant_id
	AND sub1.kjwo = sub.kjwo
) vtr

UNION ALL
/* VTR755 Null-/Minusquote */
SELECT 755::INTEGER AS VTR_ID
, mandant_id
, nb_id
, vs_id
, wup_id
, wrg_id
, kjwo 
, ist_fil  AS FILIST
, ist_fil2 AS FILIST2
, NULL, NULL, NULL, NULL
, ist_reg  AS REGIST
, ist_reg2 AS REGIST2
, NULL, NULL
, ist_land  AS LANDIST
, ist_land2 AS LANDIST2
, NULL, NULL
FROM ( /* VTR755 Null-/Minusquote */ 
	SELECT sub.mandant_id, sub.nb_id, sub.wup_id, sub.wrg_id, sub.vs_id
	, sub.kjwo
	, sub1.null_best + sub1.minus_best AS ist_fil
	, sub1.auto_dispo                  AS ist_fil2
	/* Referenz Region */
	, SUM(ist_fil)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo, sub.vs_id) AS ist_reg
	, SUM(ist_fil2) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo, sub.vs_id) AS ist_reg2
	/* Referenz Land */
	, SUM(ist_fil)  OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo) AS ist_land
	, SUM(ist_fil2) OVER (PARTITION BY sub.mandant_id, sub.wrg_id, sub.kjwo) AS ist_land2
	FROM woche_fakt_wup sub
	LEFT OUTER JOIN woche_fwws_wg sub1 
	ON sub1.wup_id = sub.wup_id AND sub1.mandant_id = sub.mandant_id
	AND sub1.kjwo = sub.kjwo
) vtr
;