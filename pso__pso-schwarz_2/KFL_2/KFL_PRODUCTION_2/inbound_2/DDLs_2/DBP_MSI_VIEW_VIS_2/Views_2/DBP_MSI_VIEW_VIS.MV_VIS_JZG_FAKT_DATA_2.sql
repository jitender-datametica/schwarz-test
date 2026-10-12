CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_VIS_JZG_FAKT_DATA_2 (
	METRIK_ID,
	TYP_ID,
	LEVEL_ID,
	MANDANT_ID,
	NB_ID,
	WUP_ID,
	WRG_ID,
	GJ,
	PLAN_GJ1,
	PLAN_GJ2,
	PLAN_VJ1,
	PLAN_VJ2,
	WERT_VJ1,
	WERT_VJ2,
	ZIEL_VJ1,
	ZIEL_VJ2,
	PLAN_GJ,
	PLAN_VJ,
	WERT_VJ,
	ZIEL_VJ,
	CHECK_VJ,
	KOMM_VJ,
	DELTA,
	ABW,
	DELTA_Z,
	ABW_Z
) AS

/*
	FAKT DENORM : JZG - Jahreszielgespräch Wert/Plan VJ / Ziel VJ / Plan GJ
	2025-01-27 ssch0611 : Review 2025. Neue Metriken. VJ Ziel/Kommentare [AP0244672]
	2025-02-06 ssch0611 : Ergänzung Zentralfilialen. Fix Join Personal [AP0244672]
	2025-02-12 ssch0611 : Fix Personalkosten_2 + Filter Schließungen (2GJ) [AP0244672]
	2025-02-17 ssch0611 : Fix vis_main Join [AP0244672]
	2025-03-31 ssch0611 : Final GJ2025. Umstellung Scans/min (KPOS) [AP0264011]
*/


/* CTE */


WITH 
/* Zeit_2 auf Monatsebene aktuelles GJ (inkl. VJ) */
  zeit_2 AS ( 
	SELECT gj
		, kjmo
		, mo_kj
		, gj - 1 AS gj_vj
		, kjmo_vj
	FROM DBP_VIEW.V_MONAT_2
	WHERE akt_gj = 0
	)

/* Zeit_2 auf Tagesebene VJ (separat wegen Schaltjahr) */
, zeit_tag_vj AS ( 
	SELECT gj + 1 AS gj /* Anzeige */
		, gj AS gj_vj
		, kjmo AS kjmo_vj /* für Transformation */
		, mo_kj
		, dat AS dat_vj
	FROM DBP_VIEW.V_TAG_2
	WHERE akt_gj = - 1
	)

/* Standard VTC : Filiale + definierte ZF. Mapping NEÖ + Filter */
, wup_2 AS ( 
	SELECT wup.mandant_id, wup.nb_id, wup.wup_id
		, wup.aktuell_wup_id
		, wup.dat_eroeffnung
		, wup.dat_bis
		, COALESCE(wup.dat_eroeffnung_alt, wup.dat_eroeffnung) AS neo_dat /* Eröffnungsdatum (inkl Mapping Altfiliale) */
		, wup.dat_bis AS stl_dat
		, EXTRACT(YEAR FROM neo_dat) - IFF(EXTRACT(MONTH FROM neo_dat) < 3, 1, 0) AS neo_gj /* GJ der Eröffnung */
		, EXTRACT(YEAR FROM stl_dat) - IFF(EXTRACT(MONTH FROM stl_dat) < 3, 1, 0) AS stl_gj /* GJ der Schließung */
	FROM DBP_VIEW.V_WUP_2 wup_2
	WHERE (wup.nb_id = 0 OR wup.wup_id IN (0, 2, 22, 28, 43, 46, 124, 8980, 8987, 8991, 100000, 100002, 100022, 100028, 100043, 100046, 100124)) /* Filialen + definierte ZF */
	AND wup.dat_eroeffnung < '2090-12-31' /* fix */
	)

/* Mapping Ware + Level */
, ware AS ( 
	SELECT abt.abt_id, hwg.hwg_id, owg.owg_id
		, CASE WHEN abt.abt_id = 4 THEN 9999999 /* Nebengeschäft ABT_2 */
			WHEN abt.abt_id = 5 THEN (abt.abt_id * 1000000 + ABS(hwg.hwg_id) * 10000 + ABS(owg.owg_id)) /* Ultra Frische OWG */
			WHEN abt.abt_id = 6 THEN (abt.abt_id * 1000000 + ABS(hwg.hwg_id) * 10000) /* Food Frische HWG */
			ELSE abt.abt_id * 1000000 /* Food + Nonfood ABT_2 */
			END::INTEGER AS level_owg
		, CASE WHEN abt.abt_id = 4 THEN 9999999 /* Nebengeschäft ABT_2 */
			WHEN abt.abt_id IN (5, 6) THEN (abt.abt_id * 1000000 + ABS(hwg.hwg_id) * 10000) /* Ultra Frische OWG */
			ELSE abt.abt_id * 1000000 /* Food + Nonfood ABT_2 */
			END::INTEGER AS level_hwg
		, CASE abt.abt_id WHEN 4 THEN 9999999 /* Nebengeschäft ABT_2 */
			ELSE abt.abt_id * 1000000 /* Food + Nonfood ABT_2 */
			END::INTEGER AS level_abt
	FROM dbp_msi_view_vis.mv_owg_int_2 owg
	INNER JOIN DBP_MSI_VIEW_VIS.MV_HWG_INT_2 hwg
		ON hwg.hwg_id = owg.hwg_id
	INNER JOIN DBP_MSI_VIEW_VIS.MV_ABT_INT_2 abt_2
		ON abt.abt_id = hwg.abt_id
	WHERE abt.abt_id IN (4, 5, 6, 7, 8) /* relevante Abteilungen */
	)

/* MV_VIS_JZG_ZIEL_WERT_2 -- VJ */
, ziel AS ( 
		SELECT jzg.mandant_id, jzg.nb_id, jzg.wup_id, jzg.wrg_id
		, jzg.metrik_id AS metrik_id
		, jzg.typ_id AS typ_id
		, jzg.level_id AS level_id
		, jzg.zielwert_eingabe AS zielwert_vj
		, jzg.kommentar_eingabe AS kommentar_vj
	FROM DBP_MSI_VIEW_VIS.MV_VIS_JZG_FAKT_EINGABE_2 jzg
	INNER JOIN wup_2
		ON wup.wup_id = jzg.wup_id AND wup.mandant_id = jzg.mandant_id
	INNER JOIN DBP_VIEW.V_JAHR_GJ_2 jahr
		ON jahr.gj = jzg.gj AND jahr.akt_gj = -1 /* Transformation VJ */
	)

/* Basis : MV_VIS_MONAT_FAKT_WUP_2 gemappt, aggregiert -- GJ/VJ */
, vis_main AS ( 
	SELECT vis_gj.mandant_id, vis_gj.nb_id
		, wup.aktuell_wup_id AS wup_id 
		, vis_gj.wrg_id
		, 0::INTEGER AS zero
		, zeit.gj /* Anzeige akt. GJ */
		, SUM(vis_gj.ums_netto_plan) AS ums_plan_gj
		, SUM(vis_gj.pers_std_plan) AS std_plan_gj
		, SUM(vis_vj.ums_netto)      AS ums_netto_vj
		, SUM(vis_vj.anz_kunde)      AS anz_kunde_vj
		, SUM(vis_vj.pers_std)       AS std_netto_vj
		, SUM(vis_vj.pers_kosten)    AS pk_wert_vj
		, SUM(vis_vj.ums_netto_plan) AS ums_plan_vj
		, SUM(vis_vj.pers_std_plan)  AS std_plan_vj
		, MAX(ziel.zielwert_vj)      AS ums_ziel_vj
		, ums_ziel_vj / NULLIFZERO(ums_plan_vj) AS faktor_vj
		, MAX(kommentar_vj) AS ums_komm_vj
	FROM DBP_MSI_DATA.VIS_MONAT_UMS_KUNDE_PERS_WUP_2 vis_gj       /* Umgliederungen haben mehrere Zeilen in mv_view! */
	INNER JOIN DBP_MSI_DATA.VIS_MONAT_UMS_KUNDE_PERS_WUP_2 vis_vj /* Daher join nur über WUP_ID in Tabelle */
		ON vis_vj.mandant_id = vis_gj.mandant_id AND vis_vj.wup_id = vis_gj.wup_id AND vis_vj.wrg_id = vis_gj.wrg_id /* Transformation VJ */
		AND vis_vj.kjmo = (vis_gj.kjmo - 100) 
	INNER JOIN zeit_2
		ON zeit.kjmo = vis_gj.kjmo
	INNER JOIN wup_2
		ON wup.wup_id = vis_gj.wup_id AND wup.mandant_id = vis_gj.mandant_id
	LEFT JOIN ziel
		ON ziel.mandant_id = vis_gj.mandant_id AND ziel.wup_id = vis_gj.wup_id AND ziel.wrg_id = vis_gj.wrg_id /* Umsatz Zielwert + Kommentar VJ */
		AND ziel.metrik_id = 10 AND ziel.typ_id = 0 AND ziel.level_id = 0 
	WHERE wup.stl_gj + 2 > zeit.gj /* inkl Schließungen im vorigen GJ */
		AND wup.neo_gj <= zeit.gj /* inkl (künftige) NEÖ im akt. GJ */
	GROUP BY ALL
	)

, vis_wg AS ( /* MV_VIS_MONAT_FAKT_WG_2 -- Basisabfrage gruppiert */
	SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id
		, zeit.gj /* Anzeige akt. GJ */
		, ware.abt_id
		, ware.hwg_id
		, ware.owg_id
		, ware.level_abt
		, ware.level_hwg
		, ware.level_owg
		, SUM(vis.ums_netto) AS ums_netto /* Dummy_2 akt. GJ*/
		, SUM(vis.ums_netto_kvj) AS ums_netto_kvj
		, SUM(vis.menge_kvj) AS menge_kvj
	FROM DBP_MSI_VIEW_VIS.MV_VIS_MONAT_FAKT_WG_2 vis
	INNER JOIN DBP_MSI_VIEW_VIS.MV_WG_INT_2 wg
		ON wg.wg_id = vis.wg_id
	INNER JOIN ware
		ON ware.owg_id = wg.owg_id
	INNER JOIN zeit_2
		ON zeit.kjmo = vis.kjmo
	INNER JOIN wup_2
		ON wup.wup_id = vis.wup_id AND wup.mandant_id = vis.mandant_id
	WHERE wup.stl_gj + 2 > zeit.gj /* inkl Schließungen im vorigen GJ */
		AND wup.neo_gj <= zeit.gj /* inkl (künftige) NEÖ im GJ */
	GROUP BY ALL
	)

, vis_fil AS ( /* MV_VIS_MONAT_FAKT_WG_2 aggregiert -- Filiale VJ */
	SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id
		, vis.gj
		, SUM(vis.ums_netto) AS ums_ware
		, SUM(vis.ums_netto_kvj) AS ums_ware_vj
		, SUM(vis.menge_kvj) AS mng_ware_vj
	FROM vis_wg vis
	GROUP BY ALL
	)

, vis_abt AS ( /* MV_VIS_MONAT_FAKT_WG_2 aggregiert -- Abteilung VJ */
	SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id
		, vis.gj
		, vis.abt_id
		, vis.level_abt AS level_id
		, SUM(vis.ums_netto) AS ums_ware
		, SUM(vis.ums_netto_kvj) AS ums_ware_vj
		, SUM(vis.menge_kvj) AS mng_ware_vj
	FROM vis_wg vis
	GROUP BY ALL
	)

, vis_hwg AS ( /* MV_VIS_MONAT_FAKT_WG_2 aggregiert -- HWG Frische VJ */
	SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id
		, vis.gj
		, vis.abt_id
		, vis.hwg_id
		, vis.level_hwg AS level_id
		, SUM(vis.ums_netto) AS ums_ware
		, SUM(vis.ums_netto_kvj) AS ums_ware_vj
		, SUM(vis.menge_kvj) AS mng_ware_vj
	FROM vis_wg vis
	WHERE vis.abt_id IN (5, 6) /* HWG Frische */
	GROUP BY ALL
	)

, vis_owg AS ( /* MV_VIS_MONAT_FAKT_WG_2 aggregiert - OWG Ultra Frische VJ */
	SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id
		, vis.gj /* Anzeige akt. GJ */
		, vis.abt_id
		, vis.hwg_id
		, vis.owg_id
		, vis.level_owg AS level_id
		, SUM(vis.ums_netto) AS ums_ware
		, SUM(vis.ums_netto_kvj) AS ums_ware_vj
		, SUM(vis.menge_kvj) AS mng_ware_vj
	FROM vis_wg vis
	WHERE vis.abt_id = 5 /* OWG Ultra Frische */
	GROUP BY ALL
	)

, vis_plan AS ( /* MV_WUP_PLAN_KJMO_OWG_2 -- Basisabfrage gruppiert */
	SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id
		, zeit.gj /* Anzeige akt. GJ */
		, ware.abt_id
		, ware.hwg_id
		, ware.owg_id
		, ware.level_abt
		, ware.level_hwg
		, ware.level_owg
		, SUM(vis.umsatz_netto_plan) AS ums_plan_gj
		, SUM(vis.abschriften_netto_operativ_plan) AS abs_plan_gj
		, SUM(vis_vj.umsatz_netto_plan) AS ums_plan_vj
		, SUM(vis_vj.abschriften_netto_operativ_plan) AS abs_plan_vj
		, MAX(ziel.zielwert_vj) AS abs_eing_vj /* ursprüngliche Eingabe Abschrift Ziel%*/
		, (ums_plan_vj * abs_eing_vj) AS abs_kalk_vj /* kalkulierte Abschrift Ziel (absolut) */
	FROM DBP_MSI_VIEW_VIS.MV_WUP_PLAN_KJMO_OWG_2 vis
	LEFT JOIN DBP_MSI_VIEW_VIS.MV_WUP_PLAN_KJMO_OWG_2 vis_vj
		ON vis_vj.mandant_id = vis.mandant_id AND vis_vj.wup_id = vis.wup_id AND vis_vj.wrg_id = vis.wrg_id AND vis_vj.owg_id = vis.owg_id AND vis_vj.kjmo = (vis.kjmo - 100) /* Transformation VJ */
	INNER JOIN ware
		ON ware.owg_id = vis.owg_id
	INNER JOIN zeit_2
		ON zeit.kjmo = vis.kjmo
	INNER JOIN wup_2
		ON wup.wup_id = vis.wup_id AND wup.mandant_id = vis.mandant_id
	LEFT JOIN ziel
		ON ziel.mandant_id = vis.mandant_id AND ziel.wup_id = vis.wup_id AND ziel.wrg_id = vis.wrg_id /* Abschriften_2 Eingabe/Zielwert Helper VJ */
		AND ziel.metrik_id = 40 AND ziel.level_id = ware.level_owg 
	WHERE wup.stl_gj + 2 > zeit.gj /* inkl Schließungen im vorigen GJ */
		AND wup.neo_gj <= zeit.gj /* inkl (künftige) NEÖ im GJ */
	GROUP BY ALL
	)

, vis_fil_plan AS ( /* MV_WUP_PLAN_KJMO_OWG_2 aggregiert -- Filiale Plan GJ/VJ */
	SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id
		, vis.gj /* Anzeige akt. GJ */
		, 0::INTEGER AS level_id
		, SUM(vis.ums_plan_gj) AS ums_plan_gj
		, SUM(vis.abs_plan_gj) AS abs_plan_gj
		, SUM(vis.ums_plan_vj) AS ums_plan_vj
		, SUM(vis.abs_plan_vj) AS abs_plan_vj
		, NULL AS abs_eing_vj /* keine Eigabe auf Ebene Filiale */
		, SUM(vis.abs_kalk_vj) AS abs_kalk_vj
	FROM vis_plan vis
	GROUP BY ALL
	)

, vis_abt_plan AS ( /* MV_WUP_PLAN_KJMO_OWG_2 aggregiert -- Abteilung Plan GJ/VJ */
	SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id
		, vis.gj /* Anzeige akt. GJ */
		, vis.abt_id
		, vis.level_abt AS level_id
		, SUM(vis.ums_plan_gj) AS ums_plan_gj
		, SUM(vis.abs_plan_gj) AS abs_plan_gj
		, SUM(vis.ums_plan_vj) AS ums_plan_vj
		, SUM(vis.abs_plan_vj) AS abs_plan_vj
		, MAX(IFF(vis.abt_id IN (4, 7, 8), vis.abs_eing_vj, NULL)) AS abs_eing_vj
		, SUM(vis.abs_kalk_vj) AS abs_kalk_vj
	FROM vis_plan vis
	GROUP BY ALL
	)

, vis_hwg_plan AS ( /* MV_WUP_PLAN_KJMO_OWG_2 aggregiert -- HWG Frische Plan GJ/VJ */
	SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id
		, vis.gj /* Anzeige akt. GJ */
		, vis.abt_id
		, vis.hwg_id
		, vis.level_hwg AS level_id
		, SUM(vis.ums_plan_gj) AS ums_plan_gj
		, SUM(vis.abs_plan_gj) AS abs_plan_gj
		, SUM(vis.ums_plan_vj) AS ums_plan_vj
		, SUM(vis.abs_plan_vj) AS abs_plan_vj
		, MAX(IFF(vis.abt_id = 6, vis.abs_eing_vj, NULL)) AS abs_eing_vj
		, SUM(vis.abs_kalk_vj) AS abs_kalk_vj
	FROM vis_plan vis
	WHERE vis.abt_id IN (5, 6) /* HWG Frische */
	GROUP BY ALL
	)

, vis_owg_plan AS ( /* MV_WUP_PLAN_KJMO_OWG_2 gefiltert, aggregiert - Plan GJ + VJ */
	SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id
		, vis.gj /* Anzeige akt. GJ */
		, vis.abt_id
		, vis.hwg_id
		, vis.owg_id
		, vis.level_owg AS level_id
		, SUM(vis.ums_plan_gj) AS ums_plan_gj
		, SUM(vis.abs_plan_gj) AS abs_plan_gj
		, SUM(vis.ums_plan_vj) AS ums_plan_vj
		, SUM(vis.abs_plan_vj) AS abs_plan_vj
		, MAX(vis.abs_eing_vj) AS abs_eing_vj
		, SUM(vis.abs_kalk_vj) AS abs_kalk_vj
	FROM vis_plan vis
	WHERE vis.abt_id = 5 /* OWG Ultra Frische */
	GROUP BY ALL
	)
, vis_abschriften AS ( /* MV_VIS_TAG_ABSCHRIFTEN_WG_2 -- Basisabfrage aggregiert OWG */
	SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id
		, zeit_tag_vj.gj /* Anzeige akt. GJ */
		, ware.abt_id
		, ware.hwg_id
		, ware.owg_id
		, ware.level_abt
		, ware.level_hwg
		, ware.level_owg
		, SUM(CASE WHEN vis.mandant_id = 6 AND vis.abschriftart_id = 2 THEN 1 WHEN vis.mandant_id = 3 AND vis.abschriftart_id = 11 THEN 1 WHEN vis.mandant_id IN (2, 4, 5, 7, 8) AND vis.abschriftart_id = 7 THEN 1 WHEN vis.mandant_id IN (2, 5) AND vis.abschriftart_id = 10 THEN 1 WHEN vis.mandant_id NOT IN (1) AND vis.abschriftart_id = 20 THEN 1 ELSE - 1 END * vis.abschrift_netto) AS abs_netto_vj
	FROM DBP_MSI_VIEW_VIS.MV_VIS_TAG_ABSCHRIFTEN_WG_2 vis
	INNER JOIN DBP_MSI_VIEW_VIS.MV_WG_INT_2 wg
		ON wg.wg_id = vis.wg_id
	INNER JOIN ware
		ON ware.owg_id = wg.owg_id
	JOIN DBP_MSI_VIEW_VIS.MV_ABSCHRIFTART_INT_ZU_2 aaz
		ON aaz.abschriftart_id = vis.abschriftart_id AND aaz.mandant_id = vis.mandant_id
	JOIN DBP_MSI_VIEW_VIS.MV_ABSCHRIFTART_INT_THEMA_ZU_2 atz
		ON atz.abschriftart_int_id = aaz.abschriftart_int_id
	JOIN zeit_tag_vj 
		ON zeit_tag_vj.dat_vj = vis.dat /* Transformation VJ */
	INNER JOIN wup_2
		ON wup.wup_id = vis.wup_id AND wup.mandant_id = vis.mandant_id
	WHERE wup.stl_gj + 2 > zeit_tag_vj.gj /* inkl Schließungen im vorigen GJ */
		AND wup.neo_gj <= zeit_tag_vj.gj /* inkl (künftige) NEÖ im GJ */
		AND atz.abschriftart_thema_int_id IN (1, 4) /* Abschriften_2 operativ */
	GROUP BY ALL
	)

, vis_fil_abs AS ( /* MV_VIS_TAG_ABSCHRIFTEN_WG_2 aggregiert -- Filiale VJ */
	SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id
		, vis.gj  /* Anzeige akt. GJ */
		, 0::INTEGER AS level_id
		, SUM(vis.abs_netto_vj) AS abs_netto_vj
	FROM vis_abschriften vis
	GROUP BY ALL
	)

, vis_abt_abs AS ( /* MV_VIS_TAG_ABSCHRIFTEN_WG_2 aggregiert -- Abteilung VJ */
	SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id
		, vis.gj  /* Anzeige akt. GJ */
		, vis.abt_id
		, vis.level_abt AS level_id
		, SUM(vis.abs_netto_vj) AS abs_netto_vj
		, MAX(ziel.kommentar_vj) AS kommentar_vj
	FROM vis_abschriften vis
	LEFT JOIN ziel
		ON ziel.mandant_id = vis.mandant_id AND ziel.wup_id = vis.wup_id AND ziel.wrg_id = vis.wrg_id AND ziel.metrik_id = 40 AND ziel.typ_id = 1 AND ziel.level_id = vis.level_abt /* Abschriften_2 Kommentar VJ */
	GROUP BY ALL
	)

, vis_hwg_abs AS ( /* MV_VIS_TAG_ABSCHRIFTEN_WG_2 aggregiert -- OWG VJ */
	SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id
		, vis.gj /* Anzeige akt. GJ */
		, vis.abt_id
		, vis.hwg_id
		, vis.level_hwg AS level_id
		, SUM(vis.abs_netto_vj) AS abs_netto_vj
		, MAX(ziel.kommentar_vj) AS kommentar_vj
	FROM vis_abschriften vis
	LEFT JOIN ziel
		ON ziel.mandant_id = vis.mandant_id AND ziel.wup_id = vis.wup_id AND ziel.wrg_id = vis.wrg_id AND ziel.metrik_id = 40 AND ziel.typ_id = 2 AND ziel.level_id = vis.level_hwg /* Abschriften_2 Kommentar VJ */
	WHERE vis.abt_id IN (5, 6) /* HWG Frische */
	GROUP BY ALL
	)

, vis_owg_abs AS ( /* MV_VIS_TAG_ABSCHRIFTEN_WG_2 aggregiert -- OWG VJ */
	SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id
		, vis.gj /* Anzeige akt. GJ */
		, vis.abt_id
		, vis.hwg_id
		, vis.owg_id
		, vis.level_owg AS level_id
		, SUM(vis.abs_netto_vj) AS abs_netto_vj
		, MAX(ziel.kommentar_vj) AS kommentar_vj
	FROM vis_abschriften vis
	LEFT JOIN ziel
		ON ziel.mandant_id = vis.mandant_id AND ziel.wup_id = vis.wup_id AND ziel.wrg_id = vis.wrg_id AND ziel.metrik_id = 40 AND ziel.typ_id = 3 AND ziel.level_id = vis.level_owg /* Abschriften_2 Kommentar VJ */
	WHERE vis.abt_id = 5 /* OWG Ultra Frische */
	GROUP BY ALL
	)

, vis_abt_inv_plan AS ( /* MV_WUP_PLAN_KJMO_OWG_2 gruppiert -- Ziel Inventur_2 Abteilung */
	SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id
		, vis.gj /* Anzeige akt. GJ */
		, vis.abt_id
		, vis.level_abt AS level_id
		, SUM(vis.ums_plan_gj) AS ums_plan_gj
		, SUM(vis.ums_plan_vj) AS ums_plan_vj
		, MAX(ziel.kommentar_vj) AS kommentar_vj
		, MAX(ziel.zielwert_vj) AS inv_eing_vj /* ursprüngliche Eingabe Inventur_2 Ziel%*/
		, SUM(vis.ums_plan_vj) * MAX(ziel.zielwert_vj) AS inv_kalk_vj /* kalkulierte Inventur_2 Ziel (absolut) */
	FROM vis_plan vis
	LEFT JOIN ziel
		ON ziel.mandant_id = vis.mandant_id AND ziel.wup_id = vis.wup_id AND ziel.wrg_id = vis.wrg_id AND ziel.metrik_id = 46 AND ziel.level_id = vis.level_abt /* Inventur_2 Eingabe/Zielwert Helper VJ */
	GROUP BY ALL
	)

, vis_fil_inv_plan AS ( /* MV_WUP_PLAN_KJMO_OWG_2 gruppiert - Ziel Inventur_2 Filiale */
	SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id
		, vis.gj /* Anzeige akt. GJ */
		, SUM(vis.ums_plan_gj) AS ums_plan_gj
		, SUM(vis.ums_plan_vj) AS ums_plan_vj
		, NULL AS kommentar_vj
		, NULL AS inv_eing_vj
		, SUM(inv_kalk_vj) AS inv_kalk_vj /* kalkulierte Inventur_2 Ziel (absolut) */
	FROM vis_abt_inv_plan vis
	GROUP BY ALL
	)

, vis_abt_inv AS ( /* V_HFM_INVENTUR_TERMIN_OWG_WUP_ZU_2 gemapped, berechnet - Basis */
	SELECT vis.mandant_id, vis.nb_id
		, wup.aktuell_wup_id AS wup_id
		, krs.nach_wrg_id AS wrg_id
		, zeit_tag_vj.gj /* Anzeige akt. GJ */
		, ware.abt_id
		, ware.level_abt AS level_id
		, SUM(vis.inventur_wert_vk_netto * krs.umrechnungskurs) AS inv_wert_vj
		, SUM(vis.umsatz_vk_netto_sum * krs.umrechnungskurs) AS inv_ums_vj
	FROM DBP_VIEW.V_HFM_INVENTUR_TERMIN_OWG_WUP_ZU_2 vis
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
	INNER JOIN ware
		ON ware.owg_id = vis.owg_id
	INNER JOIN zeit_tag_vj 
		ON zeit_tag_vj.dat_vj = vis.dat_plan_zaehlung /* Transformation VJ */
	INNER JOIN wup_2
		ON wup.wup_id = vis.wup_id AND wup.mandant_id = vis.mandant_id
	WHERE wup.stl_gj + 2 > zeit_tag_vj.gj /* inkl Schließungen im vorigen GJ */
		AND wup.neo_gj <= zeit_tag_vj.gj /* inkl (künftige) NEÖ im GJ */
		AND vis.inventurart_int_id = 8 /* Historie GJ */
	GROUP BY ALL
	)

, vis_fil_inv AS ( /* MV_VIS_MONAT_HFM_INVENTUR_2 gruppiert -- Inventur_2 Filiale */
	SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id
		, vis.gj  /* Anzeige akt. GJ */
		, SUM(vis.inv_wert_vj) AS inv_wert_vj
		, SUM(vis.inv_ums_vj) AS inv_ums_vj
	FROM vis_abt_inv vis
	GROUP BY ALL
	)

, vis_kasse AS ( /* V_VIS_TAG_KASSE_2/V_KASSE_TYP_PER_2 gemapped, berechnet, aggregiert */
	SELECT vis.mandant_id
		, vis.nb_id
		, krs.nach_wrg_id AS wrg_id
		, wup.aktuell_wup_id AS wup_id
		, zeit_tag_vj.gj AS gj /* Anzeige akt. GJ */
		, SUM(vis.umsatz_netto * krs.umrechnungskurs) AS kass_ums_vj
		, SUM(vis.anz_kunden) AS kass_bon_vj /* Kunden */
		, SUM(vis.anz_artikel) AS kass_art_vj /* Scanzeilen */
		, SUM(vis.umsatz_netto_kscan * krs.umrechnungskurs) AS kscan_ums_vj
		, SUM(vis.anz_bon_kscan) AS kscan_bon_vj /* Bons/Kunden */
		, SUM(vis.anz_zeilen_kscan) AS kscan_art_vj /* Scanzeilen */
		, SUM(IFF(ktp.kasse_typ_id = 1, vis.umsatz_netto * krs.umrechnungskurs, 0)) AS pos_ums_vj
		, SUM(IFF(ktp.kasse_typ_id = 1, vis.anz_kunden, 0)) AS pos_knd_vj /* Bons/Kunden */
		, SUM(IFF(ktp.kasse_typ_id = 1, vis.anz_artikel, 0)) AS pos_art_vj /* Scanzeilen */
		, SUM(IFF(ktp.kasse_typ_id <> 1, vis.umsatz_netto * krs.umrechnungskurs, 0)) AS sco_ums_vj
		, SUM(IFF(ktp.kasse_typ_id <> 1, vis.anz_kunden, 0)) AS sco_bon_vj /* Bons/Kunden */
		, SUM(IFF(ktp.kasse_typ_id <> 1, vis.anz_artikel, 0)) AS sco_art_vj /* Scanzeilen */
		, SUM(IFF(ktp.kasse_typ_id = 1, vis.anz_artikel / 100000.00, NULL)) AS pos_art100t_vj
		, SUM(IFF(ktp.kasse_typ_id = 1, vis.registrierzeit / 60.0000, NULL)) AS pos_scan_m_vj
		, SUM(IFF(ktp.kasse_typ_id = 1, vis.kassierzeit / 3600.0000, NULL)) AS pos_kstd_vj
	FROM DBP_VIEW.V_VIS_TAG_KASSE_2 vis
	INNER JOIN (
		SELECT ktp.mandant_id
			, ktp.wup_id
			, zeit_tag_vj.dat_vj
			, ktp.kasse_nr
			, ktp.kasse_typ_id
		FROM DBP_VIEW.V_KASSE_TYP_PER_2 ktp
		INNER JOIN zeit_tag_vj
			ON zeit_tag_vj.dat_vj BETWEEN ktp.dat_von AND ktp.dat_bis /* Transformation VJ */
		WHERE ktp.kasse_typ_id IN (1, 8, 9, 10, 11) /* Kassentyp : 1 = normal/POS, 8,9 = SCO, 10,11 = Paystation */
		) ktp
		ON ktp.mandant_id = vis.mandant_id AND ktp.wup_id = vis.wup_id AND ktp.kasse_nr = vis.kasse_nr AND ktp.dat_vj = vis.dat
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
	INNER JOIN zeit_tag_vj 
		ON zeit_tag_vj.dat_vj = vis.dat /* Transformation VJ */
	INNER JOIN wup_2
		ON wup.wup_id = vis.wup_id AND wup.mandant_id = vis.mandant_id
	WHERE wup.stl_gj + 2 > zeit_tag_vj.gj /* inkl Schließungen im vorigen GJ */
		AND wup.neo_gj <= zeit_tag_vj.gj /* inkl (künftige) NEÖ im GJ */
	GROUP BY ALL
	)

, vis_ods_ka AS ( /* V_ODS_BON_KASSENABSCHLUSS_2 (ohne WRG_2) gemappt, aggregiert */
	SELECT vis.mandant_id
		, wup.aktuell_wup_id AS wup_id
		, zeit_tag_vj.gj AS gj /* Anzeige akt. GJ */
		, SUM(vis.anz_scans) AS scan_anz_vj
		, SUM(vis.sum_scan_sek / 60) AS scan_min_vj
	FROM DBP_V_ODS.V_ODS_BON_KASSENABSCHLUSS_2 vis
	INNER JOIN zeit_tag_vj 
		ON zeit_tag_vj.dat_vj = vis.bon_dat /* Transformation VJ */
	INNER JOIN wup_2
		ON wup.wup_id = vis.wup_id AND wup.mandant_id = vis.mandant_id
	WHERE wup.stl_gj + 2 > zeit_tag_vj.gj /* inkl Schließungen im vorigen GJ */
		AND wup.neo_gj <= zeit_tag_vj.gj /* inkl (künftige) NEÖ im GJ */
	GROUP BY ALL
	)

, vis_wcal AS ( /* WUPCAL_2 gemappt, aggregiert (ohne WRG_2)*/
	SELECT vis.mandant_id, vis.nb_id
		, wup.aktuell_wup_id AS wup_id
		, zeit_tag_vj.gj /* Anzeige akt. GJ */
		, SUM(vis.bonanzahl_sug) AS bon_vj
		, SUM(vis.bonanzahl_kundenkarte) AS kundkart
		, SUM(vis.bonanzahl_kundenkarte_payback) AS payback
		, kundkart - ZEROIFNULL(payback) AS kcard_vj
	FROM DBP_VIEW.V_WUPCAL_2 vis
	INNER JOIN zeit_tag_vj 
		ON zeit_tag_vj.dat_vj = vis.dat
	INNER JOIN wup_2
		ON wup.mandant_id = vis.mandant_id AND wup.wup_id = vis.wup_id
	WHERE wup.stl_gj + 2 > zeit_tag_vj.gj /* inkl Schließungen im vorigen GJ */
		AND wup.neo_gj <= zeit_tag_vj.gj /* inkl (künftige) NEÖ im GJ */
	GROUP BY ALL
	)

, vis_rekl AS ( /* MV_VIS_TAG_REKL_ART_2 aggregiert*/
	SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id
		, zeit_tag_vj.gj /* Anzeige akt. GJ */
		, SUM(IFF(vis.reklamationsgrund_id IN (12, 19),1 ,0)) AS fehler_preis_vj
		, SUM(IFF(vis.reklamationsgrund_id IN (13, 14),1 ,0)) AS fehler_kasse_vj
		, SUM(IFF(vis.reklamationsgrund_id = 91, vis.vk_menge_kuga, NULL)) AS warten_theke_vj
		, SUM(IFF(vis.reklamationsgrund_id = 92, vis.vk_menge_kuga, NULL)) AS warten_kasse_vj
		, SUM(IFF(vis.reklamationsgrund_id = 93, vis.vk_menge_kuga, NULL)) AS mangel_mhd_vj /* ohne Filter HR */
	FROM DBP_MSI_VIEW_VIS.MV_VIS_TAG_REKL_ART_2 vis
	INNER JOIN zeit_tag_vj 
		ON zeit_tag_vj.dat_vj = vis.dat /* Transformation VJ */
	INNER JOIN wup_2
		ON wup.wup_id = vis.wup_id AND wup.mandant_id = vis.mandant_id
	WHERE wup.stl_gj + 2 > zeit_tag_vj.gj /* inkl Schließungen im vorigen GJ */
		AND wup.neo_gj <= zeit_tag_vj.gj /* inkl (künftige) NEÖ im GJ */
		AND vis.reklamationsgrund_id IN (12, 13, 14, 19, 91, 92, 93) /* Definierte Gründe, ohne Pfand */
		AND (vis.mandant_id, vis.art_id) IN (
			SELECT mandant_id, art_id
			FROM DBP_MSI_VIEW_VIS.MV_ART_WG_ZU_2
			WHERE wg_id NOT IN (980)
			)
	GROUP BY ALL
	)

, vis_kurzcheck AS ( /* V_KMR_KURZCHECK + V_AMX_KURZCHECK - OHNE DE - gefiltert, gemapped, aggregiert */
	SELECT kmr.mandant_id, kmr.nb_id, kmr.wup_id
		, zeit_tag_vj.gj /* Anzeige akt. GJ */
		, SUM(kmr.ergebnis_ok) AS kmr_ok_vj /* Anzahl OK */
		, SUM(kmr.ergebnis_nok) AS kmr_nok_vj /* Anzahl Nicht OK */
		, SUM(kmr.ergebnis_anz) AS kmr_anz_vj /* NOK% = kmr_gesamt_nok / kmr_gesamt_anz */
	FROM ( /* KMR Kurzcheck Filialbewertung Gesamt -- Neue Version ab 2024-08 */
		SELECT wup.mandant_id
			, wup.nb_id
			, wup.aktuell_wup_id AS wup_id
			, kmr_prf.dat_pruef_zeitraum_bis AS dat
			, IFF(kmr_frg.ergebnis_num = 1, 1 ,0) AS ergebnis_nok /* Pruefung/Frage Nicht OK */
			, IFF(kmr_frg.ergebnis_num >= 0, 1 ,0) AS ergebnis_anz /* Pruefung durchgeführt / Frage beantwortet */
			, IFF(kmr_frg.ergebnis_num = 0, 1 ,0) AS ergebnis_ok /* Pruefung/Frage OK */
		FROM DBP_VIEW.V_KMR_FRAGE_2 kmr_frg
		INNER JOIN DBP_VIEW.V_KMR_PRUEFPROGRAMM_KAPITEL_2 kmr_kap
			ON kmr_kap.kapitel_id = kmr_frg.kapitel_id AND kmr_kap.amx_system_id = kmr_frg.amx_system_id
		INNER JOIN DBP_VIEW.V_KMR_PRUEFUNG_2 kmr_prf
			ON kmr_prf.pruefung_id = kmr_kap.pruefung_id AND kmr_prf.amx_system_id = kmr_kap.amx_system_id
		INNER JOIN DBP_VIEW.V_KMR_L_PRUEFUNG_KLASSE_2 kmr_lpk
			ON kmr_lpk.pruefung_klasse_id = kmr_prf.pruefung_klasse_id AND kmr_lpk.amx_system_id = kmr_prf.amx_system_id
		INNER JOIN DBP_VIEW.V_KMR_L_PRUEFUNG_STATUS_2 kmr_lps
			ON kmr_lps.pruefung_status_id = kmr_prf.pruefung_status_id AND kmr_lps.amx_system_id = kmr_prf.amx_system_id
		INNER JOIN DBP_VIEW.V_KMR_L_ORGANISATIONSEINHEIT_2 kmr_loe
			ON kmr_loe.orga_einheit_id = kmr_prf.gepr_oe_id AND kmr_loe.amx_system_id = kmr_prf.amx_system_id
		INNER JOIN dbp_view.v_wup_2 wup_2
			ON wup.wup_id = kmr_loe.wup_id AND wup.mandant_id = kmr_loe.mandant_id
		INNER JOIN DBP_VIEW.V_KMR_L_PRUEFPROZESS_2 kmr_lpp
			ON kmr_lpp.gepr_prozess_id = kmr_kap.gepr_prozess_id AND kmr_lpp.amx_system_id = kmr_kap.amx_system_id
		WHERE kmr_frg.amx_system_id = 1 /* One Audimex */
			AND kmr_prf.pruefung_klasse_id IN (100003) /* Kurzcheck */
			AND kmr_prf.pruefung_status_id IN (100005, 100041) /* Bericht versandt, Bericht versandt* */
			/* Filter auf Kategorie/Bereich, funktioniert nur mit Try auf Textfeld ohne Fehler */
			AND TRY_TO_NUMBER(SUBSTR(kmr_frg.sort_nr, 12, 4)) = 0 /* Filialbewertung Gesamt */
			AND wup.mandant_id <> 1 /* ohne DE */
		UNION ALL /* AMX Kurzcheck Filialbewertung Gesamt -- Alte Version bis 2024-07 */
		SELECT wup.mandant_id
			, wup.nb_id
			, wup.aktuell_wup_id AS wup_id
			, amx_prf.dat_ende AS dat
			, IFF(amx_frg.antwort_wert IN (1, 4), 1 ,0) antwort_nok
			, IFF(amx_frg.antwort_wert IN (0), 1 ,0) antwort_ok
			, IFF(amx_frg.antwort_wert IN (0, 1, 4), 1 ,0) antwort_ges
		FROM (
			/* Fragen mit relevanten Antworten (0, 1, 4) */
			SELECT amx_frage_id
				, pruef_kapitel_id
				, antwort_wert
				, amx_frage_katalog_id
			FROM dbp_view.v_amx_frage_2
			WHERE amx_system_id = 1 AND antwort_wert IN (0, 1, 4) /* System = One Audimex */
			) amx_frg
		INNER JOIN (
			/* Fragenkatalog für Filialbewertung Gesamtbewerttung */
			SELECT amx_frage_katalog_id
				, hauptbereich_id
				, teilbereich_id
				, amx_handlung_typ_id
			FROM dbp_view.v_amx_frage_katalog_2
			WHERE amx_system_id = 1 /* System = One Audimex */
				AND hauptbereich_id = 597230 /* Filialbewertung */
				AND teilbereich_id = 597253 /* Gesambewertung */
				AND amx_handlung_typ_id IN (1, 50000) /* Bewertungsfrage, Zählfrage */
				AND SUBSTR(frage_nr, 6, 25) NOT IN (
					/* Relevante Fragen (nur für Cockpit) */
					SELECT platzhalter_string
					FROM dbp_view.v_amx_filter_benutzeroberflaeche_2
					WHERE amx_system_id = 1 AND amx_filter_typ_id = 3
					)
			) amx_kat
			ON amx_kat.amx_frage_katalog_id = amx_frg.amx_frage_katalog_id
		INNER JOIN (
			/* Prüfkapitel */
			SELECT pruef_kapitel_id
				, pruefung_id
			FROM dbp_view.v_amx_pruef_kapitel_2
			WHERE amx_system_id = 1 /* System = One Audimex */
			) amx_kap
			ON amx_frg.pruef_kapitel_id = amx_kap.pruef_kapitel_id
		INNER JOIN (
			/* Bussiness Prozess gefiltert : Audimex One - K Kurzcheck */
			SELECT business_process_id
				, pruefung_id
			FROM dbp_view.v_amx_b_process_pruefung_zu_2
			WHERE amx_system_id = 1 /* System 1 = One Audimex */
				AND business_process_id = 544687 /* Prozess = K_Kurzcheck */
			) amx_bpp
			ON amx_bpp.pruefung_id = amx_kap.pruefung_id
		INNER JOIN (
			/* Prüfung gefiltert */
			SELECT mandant_id
				, wup_id
				, pruefung_id
				, dat_ende
			FROM dbp_view.v_amx_pruefung_2
			WHERE amx_system_id = 1 /* System = One Audimex */
				AND zustand_id IN (100003, 100004, 100005, 1001, 100025, 100041) /* Relevante Zustände */
			) amx_prf
			ON amx_prf.pruefung_id = amx_kap.pruefung_id
		INNER JOIN DBP_DATA.WUP_2 wup_2
			ON wup.wup_id = amx_prf.wup_id AND wup.mandant_id = amx_prf.mandant_id
		WHERE wup.mandant_id <> 1
		) kmr
	INNER JOIN zeit_tag_vj
		ON zeit_tag_vj.dat_vj = kmr.dat /* Transformation VJ */
	INNER JOIN wup_2
		ON wup.wup_id = kmr.wup_id AND wup.mandant_id = kmr.mandant_id
	WHERE wup.stl_gj + 2 > zeit_tag_vj.gj /* inkl Schließungen im vorigen GJ */
		AND wup.neo_gj <= zeit_tag_vj.gj /* inkl (künftige) NEÖ im GJ */
	GROUP BY ALL
	)

, vis_ruq AS ( /* MV_VIS_MONAT_SHR_WUP_URLAUB_2 gefiltert, aggregiert */
	SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id
		, zeit.gj /* Anzeige akt. GJ */
		, SUM(vis.tage_urlaub_anspruch_akt_kj) AS ans_vj
		, SUM(vis.tage_urlaub_abgeltung_kj_kum) AS abg_vj
		, SUM(vis.tage_urlaub_rest_vj_kj) AS rst_vj
		, SUM(vis.tage_urlaub_genommen_kj_kum) AS gen_vj
	FROM DBP_MSI_VIEW_VIS.MV_VIS_MONAT_SHR_WUP_URLAUB_2 vis
	JOIN zeit_2
		ON zeit.kjmo_vj = vis.kjmo AND zeit.mo_kj = 12 /* Transformation KVJ Dezember */
	INNER JOIN wup_2
		ON wup.wup_id = vis.wup_id AND wup.mandant_id = vis.mandant_id
	WHERE wup.stl_gj + 2 > zeit.gj /* inkl Schließungen im vorigen GJ */
		AND wup.neo_gj <= zeit.gj /* inkl (künftige) NEÖ im GJ */
	GROUP BY ALL
	)

, vis_shr AS ( /* MV_VIS_MONAT_SHR_WUP_2 gefiltert, aggregiert */
	SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id
		, zeit.gj /* Anzeige akt. GJ */
		/* Werte GJ aufg. */
		, SUM(vis.STUNDEN_ZUSCHLAG_FEIERTAG) AS std_ftag
		, SUM(vis.STUNDEN_ZUSCHLAG_MEHR) AS std_mehr
		, SUM(vis.STUNDEN_ZUSCHLAG_SPAET_NACHT) AS std_spaet
		, SUM(vis.STUNDEN_ZUSCHLAG_WOCHENENDE) AS std_we
		, SUM(vis.TAGE_KRANK) AS std_krank
		, SUM(vis.TAGE_ARBEIT_SOLL) AS std_soll
		/* Werte Stand Februar */
		, SUM(IFF(zeit.mo_kj = 2, vis.KOPF_AUSTRITTE_ROL, 0)) AS aus_roll
		, SUM(IFF(zeit.mo_kj = 2, vis.KOPF_FLUKTUATION_ROL, 0)) AS kopf_roll
		, SUM(IFF(zeit.mo_kj = 2, vis.KOPF_FILIALE, 0)) AS kopf_fil /* Gesamte Filiale */
		, SUM(IFF(zeit.mo_kj = 2, vis.KOPF_MA, 0)) AS kopf_ma /* Mitarbeiter Ebene */
		, SUM(IFF(zeit.mo_kj = 2, vis.STUNDEN_VERTRAG_MA, 0)) AS std_vtg
		, SUM(IFF(zeit.mo_kj = 2, vis.VZK_MA, 0)) AS vzk_ma
		, SUM(IFF(zeit.mo_kj = 2, vis.KOPF_TEILZEIT, 0)) AS tzk_ma
	FROM DBP_MSI_VIEW_VIS.MV_VIS_MONAT_SHR_WUP_2 vis
	JOIN zeit_2
		ON zeit.kjmo_vj = vis.kjmo
	INNER JOIN wup_2
		ON wup.wup_id = vis.wup_id AND wup.mandant_id = vis.mandant_id
	WHERE wup.stl_gj + 2 > zeit.gj /* inkl Schließungen im vorigen GJ */
		AND wup.neo_gj <= zeit.gj /* inkl (künftige) NEÖ im GJ */
	GROUP BY ALL
	)


/* CTE <--> MAIN */


/* JZG 10-0-0 Umsatz Filiale */
SELECT 10::INTEGER AS METRIK_ID
	, vis0.zero AS TYP_ID
	, vis0.zero AS LEVEL_ID
	, vis0.mandant_id
	, vis0.nb_id
	, vis0.wup_id
	, vis0.wrg_id
	, vis0.gj
	, vis0.ums_plan_gj AS PLAN_GJ1
	, NULL AS PLAN_GJ2
	, vis0.ums_plan_vj AS PLAN_VJ1
	, NULL AS PLAN_VJ2
	, vis0.ums_netto_vj AS WERT_VJ1
	, NULL AS WERT_VJ2
	, vis0.ums_ziel_vj AS ZIEL_VJ1
	, NULL AS ZIEL_VJ2
	, PLAN_GJ1 AS PLAN_GJ
	, PLAN_VJ1 AS PLAN_VJ
	, WERT_VJ1 AS WERT_VJ
	, ZIEL_VJ1 AS ZIEL_VJ
	, vis0.faktor_vj AS CHECK_VJ /* Umsatz Eingabe VJ / Umsatz Plan VJ*/
	, vis0.ums_komm_vj AS KOMM_VJ
	, WERT_VJ - PLAN_VJ AS DELTA /* absolut */
	, DELTA / NULLIFZERO(PLAN_VJ) AS ABW
	, WERT_VJ - ZIEL_VJ AS DELTA_Z /* absolut */
	, DELTA_Z / NULLIFZERO(ZIEL_VJ) AS ABW_Z
FROM vis_main vis0

UNION ALL
/* JZG 10-1-x Umsatz Abteilung */
SELECT 10::INTEGER AS METRIK_ID
	, 1::INTEGER AS TYP_ID
	, sub1.level_id
	, vis0.mandant_id
	, vis0.nb_id
	, vis0.wup_id
	, vis0.wrg_id
	, vis0.gj
	, sub2.ums_plan_gj AS PLAN_GJ1
	, NULL AS PLAN_GJ2
	, sub2.ums_plan_vj AS PLAN_VJ1
	, NULL AS PLAN_VJ2
	, sub1.ums_ware_vj AS WERT_VJ1
	, NULL AS WERT_VJ2
	, sub2.ums_plan_vj * vis0.faktor_vj AS ZIEL_VJ1 /* Ziel berechnet */
	, NULL AS ZIEL_VJ2
	, PLAN_GJ1 AS PLAN_GJ
	, PLAN_VJ1 AS PLAN_VJ
	, WERT_VJ1 AS WERT_VJ
	, ZIEL_VJ1 AS ZIEL_VJ
	, vis0.faktor_vj AS CHECK_VJ /* Umsatz Eingabe VJ / Umsatz Plan VJ*/
	, NULL AS KOMM_VJ
	, WERT_VJ - PLAN_VJ AS DELTA
	, DELTA / NULLIFZERO(PLAN_VJ) AS ABW
	, WERT_VJ - ZIEL_VJ AS DELTA_Z /* absolut */
	, DELTA_Z / NULLIFZERO(ZIEL_VJ) AS ABW_Z
FROM vis_main vis0
INNER JOIN vis_abt sub1
	ON sub1.mandant_id = vis0.mandant_id AND sub1.wup_id = vis0.wup_id AND sub1.wrg_id = vis0.wrg_id
INNER JOIN vis_abt_plan sub2
	ON sub2.mandant_id = vis0.mandant_id AND sub2.wup_id = vis0.wup_id AND sub2.wrg_id = vis0.wrg_id AND sub2.abt_id = sub1.abt_id

UNION ALL
/* JZG 10-2-5x/6x Umsatz HWG (Frische) */
SELECT 10::INTEGER AS METRIK_ID
	, 2::INTEGER AS TYP_ID
	, sub1.level_id
	, vis0.mandant_id
	, vis0.nb_id
	, vis0.wup_id
	, vis0.wrg_id
	, vis0.gj
	, sub2.ums_plan_gj AS PLAN_GJ1
	, NULL AS PLAN_GJ2
	, sub2.ums_plan_vj AS PLAN_VJ1
	, NULL AS PLAN_VJ2
	, sub1.ums_ware_vj AS WERT_VJ1
	, NULL AS WERT_VJ2
	, sub2.ums_plan_vj * vis0.faktor_vj AS ZIEL_VJ1 /* Ziel berechnet */
	, NULL AS ZIEL_VJ2
	, PLAN_GJ1 AS PLAN_GJ
	, PLAN_VJ1 AS PLAN_VJ
	, WERT_VJ1 AS WERT_VJ
	, ZIEL_VJ1 AS ZIEL_VJ
	, vis0.faktor_vj AS CHECK_VJ /* Umsatz Eingabe VJ / Umsatz Plan VJ*/
	, NULL AS KOMM_VJ
	, WERT_VJ - PLAN_VJ AS DELTA
	, DELTA / NULLIFZERO(PLAN_VJ) AS ABW
	, WERT_VJ - ZIEL_VJ AS DELTA_Z /* absolut */
	, DELTA_Z / NULLIFZERO(ZIEL_VJ) AS ABW_Z
FROM vis_main vis0
INNER JOIN vis_hwg sub1
	ON sub1.mandant_id = vis0.mandant_id AND sub1.wup_id = vis0.wup_id AND sub1.wrg_id = vis0.wrg_id
INNER JOIN vis_hwg_plan sub2
	ON sub2.mandant_id = vis0.mandant_id AND sub2.wup_id = vis0.wup_id AND sub2.wrg_id = vis0.wrg_id AND sub2.hwg_id = sub1.hwg_id

UNION ALL
/* JZG 10-3-5xx Umsatz OWG (Ultra Frische) */
SELECT 10::INTEGER AS METRIK_ID
	, 3::INTEGER AS TYP_ID
	, sub1.level_id
	, vis0.mandant_id
	, vis0.nb_id
	, vis0.wup_id
	, vis0.wrg_id
	, vis0.gj
	, sub2.ums_plan_gj AS PLAN_GJ1
	, NULL AS PLAN_GJ2
	, sub2.ums_plan_vj AS PLAN_VJ1
	, NULL AS PLAN_VJ2
	, sub1.ums_ware_vj AS WERT_VJ1
	, NULL AS WERT_VJ2
	, sub2.ums_plan_vj * vis0.faktor_vj AS ZIEL_VJ1 /* Ziel berechnet */
	, NULL AS ZIEL_VJ2
	, PLAN_GJ1 AS PLAN_GJ
	, PLAN_VJ1 AS PLAN_VJ
	, WERT_VJ1 AS WERT_VJ
	, ZIEL_VJ1 AS ZIEL_VJ
	, vis0.faktor_vj AS CHECK_VJ /* Umsatz Eingabe VJ / Umsatz Plan VJ*/
	, NULL AS KOMM_VJ
	, WERT_VJ - PLAN_VJ AS DELTA
	, DELTA / NULLIFZERO(PLAN_VJ) AS ABW
	, WERT_VJ - ZIEL_VJ AS DELTA_Z /* absolut */
	, DELTA_Z / NULLIFZERO(ZIEL_VJ) AS ABW_Z
FROM vis_main vis0
INNER JOIN vis_owg sub1
	ON sub1.mandant_id = vis0.mandant_id AND sub1.wup_id = vis0.wup_id AND sub1.wrg_id = vis0.wrg_id
INNER JOIN vis_owg_plan sub2
	ON sub2.mandant_id = vis0.mandant_id AND sub2.wup_id = vis0.wup_id AND sub2.wrg_id = vis0.wrg_id AND sub2.owg_id = sub1.owg_id

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
	, NULL
	, NULL
	, NULL
	, NULL
	, vis0.anz_kunde_vj AS WERT_VJ1
	, NULL AS WERT_VJ2
	, ziel.zielwert_vj AS ZIEL_VJ1
	, NULL AS ZIEL_VJ2
	, NULL
	, NULL
	, WERT_VJ1 AS WERT_VJ
	, ZIEL_VJ1 AS ZIEL_VJ
	, NULL AS CHECK_VJ
	, ziel.kommentar_vj AS KOMM_VJ
	, NULL
	, NULL
	, WERT_VJ - ZIEL_VJ AS DELTA_Z /* absolut */
	, DELTA_Z / NULLIFZERO(ZIEL_VJ) AS ABW_Z
FROM vis_main vis0
LEFT JOIN ziel
	ON ziel.mandant_id = vis0.mandant_id AND ziel.wup_id = vis0.wup_id AND ziel.wrg_id = vis0.wrg_id /* Kunden Zielwert + Kommentar VJ */
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
	, NULL
	, NULL
	, NULL
	, NULL
	, vis0.ums_netto_vj AS WERT_VJ1
	, vis0.anz_kunde_vj AS WERT_VJ2
	, vis0.ums_ziel_vj AS ZIEL_VJ1
	, ziel.zielwert_vj AS ZIEL_VJ2
	, NULL
	, NULL
	, WERT_VJ1 / NULLIFZERO(WERT_VJ2) AS WERT_VJ
	, ZIEL_VJ1 / NULLIFZERO(ZIEL_VJ2) AS ZIEL_VJ
	, NULL
	, NULL
	, NULL
	, NULL
	, WERT_VJ - ZIEL_VJ AS DELTA_Z /* absolut */
	, DELTA_Z / NULLIFZERO(ZIEL_VJ) AS ABW_Z 
FROM vis_main vis0
LEFT JOIN ziel
	ON ziel.mandant_id = vis0.mandant_id AND ziel.wup_id = vis0.wup_id AND ziel.wrg_id = vis0.wrg_id /* Kunden Zielwert VJ */
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
	, vis0.ums_plan_gj AS PLAN_GJ1
	, vis0.std_plan_gj AS PLAN_GJ2
	, vis0.ums_plan_vj AS PLAN_VJ1
	, vis0.std_plan_vj AS PLAN_VJ2
	, vis0.ums_netto_vj AS WERT_VJ1
	, vis0.std_netto_vj AS WERT_VJ2
	, vis0.ums_ziel_vj AS ZIEL_VJ1
	, ziel.zielwert_vj AS ZIEL_VJ2
	, PLAN_GJ1 / NULLIFZERO(PLAN_GJ2) AS PLAN_GJ
	, PLAN_VJ1 / NULLIFZERO(PLAN_VJ2) AS PLAN_VJ
	, WERT_VJ1 / NULLIFZERO(WERT_VJ2) AS WERT_VJ
	, ZIEL_VJ1 / NULLIFZERO(ZIEL_VJ2) AS ZIEL_VJ
	, NULL
	, NULL
	, (WERT_VJ - PLAN_VJ) * 100 AS DELTA /* %pkt */
	, DELTA / NULLIFZERO(PLAN_VJ) AS ABW
	, (WERT_VJ - ZIEL_VJ) * 100 AS DELTA_Z /* %pkt */
	, DELTA_Z / NULLIFZERO(ZIEL_VJ) AS ABW_Z
FROM vis_main vis0
LEFT JOIN ziel
	ON ziel.mandant_id = vis0.mandant_id AND ziel.wup_id = vis0.wup_id AND ziel.wrg_id = vis0.wrg_id /* Stunden_2 Zielwert VJ */
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
	, vis0.std_plan_gj AS PLAN_GJ1
	, NULL AS PLAN_GJ2
	, vis0.std_plan_vj AS PLAN_VJ1
	, NULL AS PLAN_VJ2
	, vis0.std_netto_vj AS WERT_VJ1
	, NULL AS WERT_VJ2
	, ziel.zielwert_vj AS ZIEL_VJ1
	, NULL AS ZIEL_VJ2
	, PLAN_GJ1 AS PLAN_GJ
	, PLAN_VJ1 AS PLAN_VJ
	, WERT_VJ1 AS WERT_VJ
	, ZIEL_VJ1 AS ZIEL_VJ
	, NULL AS CHECK_VJ
	, ziel.kommentar_vj AS KOMM_VJ
	, WERT_VJ - PLAN_VJ AS DELTA /* absolut */
	, DELTA / NULLIFZERO(PLAN_VJ) AS ABW
	, WERT_VJ - ZIEL_VJ AS DELTA_Z /* absolut */
	, DELTA_Z / NULLIFZERO(ZIEL_VJ) AS ABW_Z
FROM vis_main vis0
LEFT JOIN ziel
	ON ziel.mandant_id = vis0.mandant_id AND ziel.wup_id = vis0.wup_id AND ziel.wrg_id = vis0.wrg_id /* Nettostunden Zielwert + Kommentar VJ */
	AND ziel.metrik_id = 24 AND ziel.typ_id = 0 AND ziel.level_id = 0

UNION ALL
/* JZG 30-0-0 Kassierleistung */
SELECT 30::INTEGER AS METRIK_ID
	, vis0.zero AS TYP_ID
	, vis0.zero AS LEVEL_ID
	, vis0.mandant_id
	, vis0.nb_id
	, vis0.wup_id
	, vis0.wrg_id
	, vis0.gj
	, NULL
	, NULL
	, NULL
	, NULL
	, sub1.pos_ums_vj AS WERT_VJ1
	, sub1.pos_kstd_vj AS WERT_VJ2
	, ziel.zielwert_vj AS ZIEL_VJ1
	, NULL
	, NULL
	, NULL
	, WERT_VJ1 / NULLIFZERO(WERT_VJ2) AS WERT_VJ
	, ZIEL_VJ1 AS ZIEL_VJ /* Quote, keine Aggregation */
	, NULL AS CHECK_VJ
	, ziel.kommentar_vj AS KOMM_VJ
	, NULL
	, NULL
	, WERT_VJ - ZIEL_VJ AS DELTA_Z /* absolut */
	, DELTA_Z / NULLIFZERO(WERT_VJ) AS ABW_Z
FROM vis_main vis0
LEFT JOIN vis_kasse sub1
	ON sub1.mandant_id = vis0.mandant_id AND sub1.wup_id = vis0.wup_id AND sub1.wrg_id = vis0.wrg_id
LEFT JOIN ziel
	ON ziel.mandant_id = vis0.mandant_id AND ziel.wup_id = vis0.wup_id AND ziel.wrg_id = vis0.wrg_id /* Kassierleistung Zielwert + Kommentar VJ */
	AND ziel.metrik_id = 30 AND ziel.typ_id = 0 AND ziel.level_id = 0

UNION ALL
/* JZG 32-0-0 Scans/min - KPOS */
SELECT 32::INTEGER AS METRIK_ID
	, vis0.zero AS TYP_ID
	, vis0.zero AS LEVEL_ID
	, vis0.mandant_id
	, vis0.nb_id
	, vis0.wup_id
	, vis0.wrg_id
	, vis0.gj
	, NULL
	, NULL
	, NULL
	, NULL
	, sub1.scan_anz_vj AS WERT_VJ1
	, sub1.scan_min_vj AS WERT_VJ2
	, ziel.zielwert_vj AS ZIEL_VJ1
	, NULL
	, NULL
	, NULL
	, WERT_VJ1 / NULLIFZERO(WERT_VJ2) AS WERT_VJ
	, ZIEL_VJ1 AS ZIEL_VJ /* Quote, keine Aggregation */
	, NULL AS CHECK_VJ
	, ziel.kommentar_vj AS KOMM_VJ
	, NULL
	, NULL
	, WERT_VJ - ZIEL_VJ AS DELTA_Z /* absolut */
	, DELTA_Z / NULLIFZERO(WERT_VJ) AS ABW_Z
FROM vis_main vis0
LEFT JOIN vis_ods_ka sub1
	ON sub1.mandant_id = vis0.mandant_id AND sub1.wup_id = vis0.wup_id /* keine WRG_2 */
LEFT JOIN ziel
	ON ziel.mandant_id = vis0.mandant_id AND ziel.wup_id = vis0.wup_id AND ziel.wrg_id = vis0.wrg_id /* Scans/min Zielwert + Kommentar VJ */
	AND ziel.metrik_id = 32 AND ziel.typ_id = 0 AND ziel.level_id = 0

UNION ALL /* JZG 33-0-0 Scans/min (DWH) - alte Definition */
SELECT 33::INTEGER AS METRIK_ID
	, vis0.zero AS TYP_ID
	, vis0.zero AS LEVEL_ID
	, vis0.mandant_id
	, vis0.nb_id
	, vis0.wup_id
	, vis0.wrg_id
	, vis0.gj
	, NULL
	, NULL
	, NULL
	, NULL
	, sub1.pos_art_vj AS WERT_VJ1
	, sub1.pos_scan_m_vj AS WERT_VJ2
	, ziel.zielwert_vj AS ZIEL_VJ1
	, NULL
	, NULL
	, NULL
	, WERT_VJ1 / NULLIFZERO(WERT_VJ2) AS WERT_VJ
	, ZIEL_VJ1 AS ZIEL_VJ /* Quote, keine Aggregation */
	, NULL AS CHECK_VJ
	, ziel.kommentar_vj AS KOMM_VJ
	, NULL
	, NULL
	, WERT_VJ - ZIEL_VJ AS DELTA_Z /* absolut */
	, DELTA_Z / NULLIFZERO(WERT_VJ) AS ABW_Z
FROM vis_main vis0
LEFT JOIN vis_kasse sub1
	ON sub1.mandant_id = vis0.mandant_id AND sub1.wup_id = vis0.wup_id AND sub1.wrg_id = vis0.wrg_id
LEFT JOIN ziel
	ON ziel.mandant_id = vis0.mandant_id AND ziel.wup_id = vis0.wup_id AND ziel.wrg_id = vis0.wrg_id /* Scans/min Zielwert + Kommentar VJ */
	AND ziel.metrik_id = 32 AND ziel.typ_id = 0 AND ziel.level_id = 0

UNION ALL
/* JZG 34-0-0 SCO Nutzungsquote Umsatz */
SELECT 34::INTEGER AS METRIK_ID
	, vis0.zero AS TYP_ID
	, vis0.zero AS LEVEL_ID
	, vis0.mandant_id
	, vis0.nb_id
	, vis0.wup_id
	, vis0.wrg_id
	, vis0.gj
	, NULL
	, NULL
	, NULL
	, NULL
	, sub1.sco_ums_vj AS WERT_VJ1
	, sub1.kass_ums_vj AS WERT_VJ2
	, ziel.zielwert_vj AS ZIEL_VJ1
	, NULL
	, NULL
	, NULL
	, WERT_VJ1 / NULLIFZERO(WERT_VJ2) AS WERT_VJ
	, ZIEL_VJ1 AS ZIEL_VJ /* %-Wert, keine Aggregation */
	, NULL AS CHECK_VJ
	, ziel.kommentar_vj AS KOMM_VJ
	, NULL
	, NULL
	, (WERT_VJ - ZIEL_VJ) * 100 AS DELTA_Z /* %pkt */
	, DELTA_Z / NULLIFZERO(WERT_VJ) AS ABW_Z
FROM vis_main vis0
LEFT JOIN vis_kasse sub1
	ON sub1.mandant_id = vis0.mandant_id AND sub1.wup_id = vis0.wup_id AND sub1.wrg_id = vis0.wrg_id
LEFT JOIN ziel
	ON ziel.mandant_id = vis0.mandant_id AND ziel.wup_id = vis0.wup_id AND ziel.wrg_id = vis0.wrg_id /* SCO Nutzungsquote Umsatz Zielwert + Kommentar VJ */
	AND ziel.metrik_id = 34 AND ziel.typ_id = 0 AND ziel.level_id = 0

UNION ALL
/* JZG 36-0-0 SCO Nutzungsquote Kunden */
SELECT 36::INTEGER AS METRIK_ID
	, vis0.zero AS TYP_ID
	, vis0.zero AS LEVEL_ID
	, vis0.mandant_id
	, vis0.nb_id
	, vis0.wup_id
	, vis0.wrg_id
	, vis0.gj
	, NULL
	, NULL
	, NULL
	, NULL
	, sub1.sco_bon_vj AS WERT_VJ1
	, sub1.kass_bon_vj AS WERT_VJ2
	, ziel.zielwert_vj AS ZIEL_VJ1
	, NULL
	, NULL
	, NULL
	, WERT_VJ1 / NULLIFZERO(WERT_VJ2) AS WERT_VJ
	, ZIEL_VJ1 AS ZIEL_VJ /* %-Wert, keine Aggregation */
	, NULL AS CHECK_VJ
	, ziel.kommentar_vj AS KOMM_VJ
	, NULL
	, NULL
	, (WERT_VJ - ZIEL_VJ) * 100 AS DELTA_Z /* %pkt */
	, DELTA_Z / NULLIFZERO(WERT_VJ) AS ABW_Z
FROM vis_main vis0
LEFT JOIN vis_kasse sub1
	ON sub1.mandant_id = vis0.mandant_id AND sub1.wup_id = vis0.wup_id AND sub1.wrg_id = vis0.wrg_id
LEFT JOIN ziel
	ON ziel.mandant_id = vis0.mandant_id AND ziel.wup_id = vis0.wup_id AND ziel.wrg_id = vis0.wrg_id /* SCO Nutzungsquote Kunden Zielwert + Kommentar VJ */
	AND ziel.metrik_id = 36 AND ziel.typ_id = 0 AND ziel.level_id = 0

UNION ALL
/* JZG 37-0-0 K-Scan Nutzungsquote (Kunden) */
SELECT 37::INTEGER AS METRIK_ID
	, vis0.zero AS TYP_ID
	, vis0.zero AS LEVEL_ID
	, vis0.mandant_id
	, vis0.nb_id
	, vis0.wup_id
	, vis0.wrg_id
	, vis0.gj
	, NULL
	, NULL
	, NULL
	, NULL
	, sub1.kscan_bon_vj AS WERT_VJ1
	, sub1.kass_bon_vj AS WERT_VJ2
	, ziel.zielwert_vj AS ZIEL_VJ1
	, NULL
	, NULL
	, NULL
	, WERT_VJ1 / NULLIFZERO(WERT_VJ2) AS WERT_VJ
	, ZIEL_VJ1 AS ZIEL_VJ /* %-Wert, keine Aggregation */
	, NULL AS CHECK_VJ
	, ziel.kommentar_vj AS KOMM_VJ
	, NULL
	, NULL
	, (WERT_VJ - ZIEL_VJ) * 100 AS DELTA_Z /* %pkt */
	, DELTA_Z / NULLIFZERO(WERT_VJ) AS ABW_Z
FROM vis_main vis0
LEFT JOIN vis_kasse sub1
	ON sub1.mandant_id = vis0.mandant_id AND sub1.wup_id = vis0.wup_id AND sub1.wrg_id = vis0.wrg_id
LEFT JOIN ziel
	ON ziel.mandant_id = vis0.mandant_id AND ziel.wup_id = vis0.wup_id AND ziel.wrg_id = vis0.wrg_id /* K-Scan Zielwert + Kommentar VJ */
	AND ziel.metrik_id = 37 AND ziel.typ_id = 0 AND ziel.level_id = 0

UNION ALL
/* JZG 39-0-0 Kaufland Card Anteil */
SELECT 39::INTEGER AS METRIK_ID
	, vis0.zero AS TYP_ID
	, vis0.zero AS LEVEL_ID
	, vis0.mandant_id
	, vis0.nb_id
	, vis0.wup_id
	, vis0.wrg_id
	, vis0.gj
	, NULL
	, NULL
	, NULL
	, NULL
	, sub1.kcard_vj AS WERT_VJ1
	, sub1.bon_vj AS WERT_VJ2
	, ziel.zielwert_vj AS ZIEL_VJ1
	, NULL
	, NULL
	, NULL
	, WERT_VJ1 / NULLIFZERO(WERT_VJ2) AS WERT_VJ
	, ZIEL_VJ1 AS ZIEL_VJ /* %-Wert, keine Aggregation */
	, NULL AS CHECK_VJ
	, ziel.kommentar_vj AS KOMM_VJ
	, NULL
	, NULL
	, (WERT_VJ - ZIEL_VJ) * 100 AS DELTA_Z /* %pkt */
	, DELTA_Z / NULLIFZERO(WERT_VJ) AS ABW_Z
FROM vis_main vis0
LEFT JOIN vis_wcal sub1
	ON sub1.mandant_id = vis0.mandant_id AND sub1.wup_id = vis0.wup_id  /* keine WRG_2 */
LEFT JOIN ziel
	ON ziel.mandant_id = vis0.mandant_id AND ziel.wup_id = vis0.wup_id AND ziel.wrg_id = vis0.wrg_id /* K-Card Zielwert + Kommentar VJ */
	AND ziel.metrik_id = 39 AND ziel.typ_id = 0 AND ziel.level_id = 0

UNION ALL
/* JZG 40-0-0 Abschriften_2 Filiale */
SELECT 40::INTEGER AS METRIK_ID
	, vis0.zero AS TYP_ID
	, vis0.zero AS LEVEL_ID
	, vis0.mandant_id
	, vis0.nb_id
	, vis0.wup_id
	, vis0.wrg_id
	, vis0.gj
	, sub1.abs_plan_gj AS PLAN_GJ1
	, sub1.ums_plan_gj AS PLAN_GJ2
	, sub1.abs_plan_vj AS PLAN_VJ1
	, sub1.ums_plan_vj AS PLAN_VJ2
	, sub2.abs_netto_vj AS WERT_VJ1
	, sub3.ums_ware_vj AS WERT_VJ2
	, sub1.abs_kalk_vj * vis0.faktor_vj AS ZIEL_VJ1
	, sub1.ums_plan_vj * vis0.faktor_vj AS ZIEL_VJ2
	, PLAN_GJ1 / NULLIFZERO(PLAN_GJ2) AS PLAN_GJ
	, PLAN_VJ1 / NULLIFZERO(PLAN_VJ2) AS PLAN_VJ
	, WERT_VJ1 / NULLIFZERO(WERT_VJ2) AS WERT_VJ
	, ZIEL_VJ1 / NULLIFZERO(ZIEL_VJ2) AS ZIEL_VJ
	, NULL AS CHECK_VJ
	, NULL AS KOMM_VJ
	, (WERT_VJ - PLAN_VJ) * 100 AS DELTA /* %pkt */
	, DELTA / NULLIFZERO(PLAN_VJ) AS ABW
	, (WERT_VJ - ZIEL_VJ) * 100 AS DELTA_Z /* %pkt */
	, DELTA_Z / NULLIFZERO(ZIEL_VJ) AS ABW_Z
FROM vis_main vis0
LEFT JOIN vis_fil_plan sub1
	ON sub1.mandant_id = vis0.mandant_id AND sub1.wup_id = vis0.wup_id AND sub1.wrg_id = vis0.wrg_id
LEFT JOIN vis_fil_abs sub2
	ON sub2.mandant_id = vis0.mandant_id AND sub2.wup_id = vis0.wup_id AND sub2.wrg_id = vis0.wrg_id
LEFT JOIN vis_fil sub3
	ON sub3.mandant_id = vis0.mandant_id AND sub3.wup_id = vis0.wup_id AND sub3.wrg_id = vis0.wrg_id

UNION ALL
/* JZG 40-1-x Abschriften_2 Abteilung */
SELECT 40::INTEGER AS METRIK_ID
	, 1::INTEGER AS TYP_ID
	, sub1.level_id AS LEVEL_ID
	, vis0.mandant_id
	, vis0.nb_id
	, vis0.wup_id
	, vis0.wrg_id
	, vis0.gj
	, sub1.abs_plan_gj AS PLAN_GJ1
	, sub1.ums_plan_gj AS PLAN_GJ2
	, sub1.abs_plan_vj AS PLAN_VJ1
	, sub1.ums_plan_vj AS PLAN_VJ2
	, sub2.abs_netto_vj AS WERT_VJ1
	, sub3.ums_ware_vj AS WERT_VJ2
	, sub1.abs_kalk_vj * vis0.faktor_vj AS ZIEL_VJ1
	, sub1.ums_plan_vj * vis0.faktor_vj AS ZIEL_VJ2
	, PLAN_GJ1 / NULLIFZERO(PLAN_GJ2) AS PLAN_GJ
	, PLAN_VJ1 / NULLIFZERO(PLAN_VJ2) AS PLAN_VJ
	, WERT_VJ1 / NULLIFZERO(WERT_VJ2) AS WERT_VJ
	, ZIEL_VJ1 / NULLIFZERO(ZIEL_VJ2) AS ZIEL_VJ
	, sub1.abs_eing_vj AS CHECK_VJ /* Original Eingabe (ohne Frische) */
	, sub2.kommentar_vj AS KOMM_VJ
	, (WERT_VJ - ZIEL_VJ) * 100 AS DELTA /* %pkt */
	, DELTA / NULLIFZERO(PLAN_VJ) AS ABW
	, (WERT_VJ - ZIEL_VJ) * 100 AS DELTA_Z /* %pkt */
	, DELTA_Z / NULLIFZERO(ZIEL_VJ) AS ABW_Z
FROM vis_main vis0
LEFT JOIN vis_abt_plan sub1
	ON sub1.mandant_id = vis0.mandant_id AND sub1.wup_id = vis0.wup_id AND sub1.wrg_id = vis0.wrg_id
LEFT JOIN vis_abt_abs sub2
	ON sub2.mandant_id = vis0.mandant_id AND sub2.wup_id = vis0.wup_id AND sub2.wrg_id = vis0.wrg_id AND sub2.abt_id = sub1.abt_id
LEFT JOIN vis_abt sub3
	ON sub3.mandant_id = vis0.mandant_id AND sub3.wup_id = vis0.wup_id AND sub3.wrg_id = vis0.wrg_id AND sub3.abt_id = sub1.abt_id

UNION ALL
/* JZG 40-2-x Abschriften_2 HWG */
SELECT 40::INTEGER AS METRIK_ID
	, 2::INTEGER AS TYP_ID
	, sub1.level_id AS LEVEL_ID
	, vis0.mandant_id
	, vis0.nb_id
	, vis0.wup_id
	, vis0.wrg_id
	, vis0.gj
	, sub1.abs_plan_gj AS PLAN_GJ1
	, sub1.ums_plan_gj AS PLAN_GJ2
	, sub1.abs_plan_vj AS PLAN_VJ1
	, sub1.ums_plan_vj AS PLAN_VJ2
	, sub2.abs_netto_vj AS WERT_VJ1
	, sub3.ums_ware_vj AS WERT_VJ2
	, sub1.abs_kalk_vj * vis0.faktor_vj AS ZIEL_VJ1
	, sub1.ums_plan_vj * vis0.faktor_vj AS ZIEL_VJ2
	, PLAN_GJ1 / NULLIFZERO(PLAN_GJ2) AS PLAN_GJ
	, PLAN_VJ1 / NULLIFZERO(PLAN_VJ2) AS PLAN_VJ
	, WERT_VJ1 / NULLIFZERO(WERT_VJ2) AS WERT_VJ
	, ZIEL_VJ1 / NULLIFZERO(ZIEL_VJ2) AS ZIEL_VJ
	, sub1.abs_eing_vj AS CHECK_VJ /* Original Eingabe (nur Food Frische) */
	, sub2.kommentar_vj AS KOMM_VJ
	, (WERT_VJ - ZIEL_VJ) * 100 AS DELTA /* %pkt */
	, DELTA / NULLIFZERO(PLAN_VJ) AS ABW
	, (WERT_VJ - ZIEL_VJ) * 100 AS DELTA_Z /* %pkt */
	, DELTA_Z / NULLIFZERO(ZIEL_VJ) AS ABW_Z
FROM vis_main vis0
LEFT JOIN vis_hwg_plan sub1
	ON sub1.mandant_id = vis0.mandant_id AND sub1.wup_id = vis0.wup_id AND sub1.wrg_id = vis0.wrg_id
LEFT JOIN vis_hwg_abs sub2
	ON sub2.mandant_id = vis0.mandant_id AND sub2.wup_id = vis0.wup_id AND sub2.wrg_id = vis0.wrg_id AND sub2.hwg_id = sub1.hwg_id
LEFT JOIN vis_hwg sub3
	ON sub3.mandant_id = vis0.mandant_id AND sub3.wup_id = vis0.wup_id AND sub3.wrg_id = vis0.wrg_id AND sub3.hwg_id = sub1.hwg_id

UNION ALL
/* JZG 40-3-x Abschriften_2 OWG */
SELECT 40::INTEGER AS METRIK_ID
	, 3::INTEGER AS TYP_ID
	, sub1.level_id AS LEVEL_ID
	, vis0.mandant_id
	, vis0.nb_id
	, vis0.wup_id
	, vis0.wrg_id
	, vis0.gj
	, sub1.abs_plan_gj AS PLAN_GJ1
	, sub1.ums_plan_gj AS PLAN_GJ2
	, sub1.abs_plan_vj AS PLAN_VJ1
	, sub1.ums_plan_vj AS PLAN_VJ2
	, sub2.abs_netto_vj AS WERT_VJ1
	, sub3.ums_ware_vj AS WERT_VJ2
	, sub1.abs_kalk_vj * vis0.faktor_vj AS ZIEL_VJ1
	, sub1.ums_plan_vj * vis0.faktor_vj AS ZIEL_VJ2
	, PLAN_GJ1 / NULLIFZERO(PLAN_GJ2) AS PLAN_GJ
	, PLAN_VJ1 / NULLIFZERO(PLAN_VJ2) AS PLAN_VJ
	, WERT_VJ1 / NULLIFZERO(WERT_VJ2) AS WERT_VJ
	, ZIEL_VJ1 / NULLIFZERO(ZIEL_VJ2) AS ZIEL_VJ
	, sub1.abs_eing_vj AS CHECK_VJ /* Original Eingabe (nur Ultra Frische) */
	, sub2.kommentar_vj AS KOMM_VJ
	, (WERT_VJ - ZIEL_VJ) * 100 AS DELTA /* %pkt */
	, DELTA / NULLIFZERO(PLAN_VJ) AS ABW
	, (WERT_VJ - ZIEL_VJ) * 100 AS DELTA_Z /* %pkt */
	, DELTA_Z / NULLIFZERO(ZIEL_VJ) AS ABW_Z
FROM vis_main vis0
LEFT JOIN vis_owg_plan sub1
	ON sub1.mandant_id = vis0.mandant_id AND sub1.wup_id = vis0.wup_id AND sub1.wrg_id = vis0.wrg_id
LEFT JOIN vis_owg_abs sub2
	ON sub2.mandant_id = vis0.mandant_id AND sub2.wup_id = vis0.wup_id AND sub2.wrg_id = vis0.wrg_id AND sub2.owg_id = sub1.owg_id
LEFT JOIN vis_owg sub3
	ON sub3.mandant_id = vis0.mandant_id AND sub3.wup_id = vis0.wup_id AND sub3.wrg_id = vis0.wrg_id AND sub3.owg_id = sub1.owg_id

UNION ALL
/* JZG 46-0-x Inventur_2 Filiale */
SELECT 46::INTEGER AS METRIK_ID
	, vis0.zero AS TYP_ID
	, vis0.zero AS LEVEL_ID
	, vis0.mandant_id
	, vis0.nb_id
	, vis0.wup_id
	, vis0.wrg_id
	, vis0.gj
	, NULL
	, NULL
	, NULL
	, NULL
	, sub2.inv_wert_vj AS WERT_VJ1
	, sub2.inv_ums_vj AS WERT_VJ2
	, sub1.inv_kalk_vj * vis0.faktor_vj AS ZIEL_VJ1
	, sub1.ums_plan_vj * vis0.faktor_vj AS ZIEL_VJ2
	, NULL
	, NULL
	, WERT_VJ1 / NULLIFZERO(WERT_VJ2) AS WERT_VJ
	, ZIEL_VJ1 / NULLIFZERO(ZIEL_VJ2) AS ZIEL_VJ
	, NULL
	, NULL
	, NULL
	, NULL
	, (WERT_VJ - ZIEL_VJ) * 100 AS DELTA_Z /* %pkt */
	, DELTA_Z / NULLIFZERO(ZIEL_VJ) AS ABW_Z
FROM vis_main vis0
LEFT JOIN vis_fil_inv_plan sub1
	ON sub1.mandant_id = vis0.mandant_id AND sub1.wup_id = vis0.wup_id AND sub1.wrg_id = vis0.wrg_id
LEFT JOIN vis_fil_inv sub2
	ON sub2.mandant_id = vis0.mandant_id AND sub2.wup_id = vis0.wup_id AND sub2.wrg_id = vis0.wrg_id

UNION ALL
/* JZG 46-1-x Inventur_2 Abteilung */
SELECT 46::INTEGER AS METRIK_ID
	, 1::INTEGER AS TYP_ID
	, sub1.level_id AS LEVEL_ID
	, vis0.mandant_id
	, vis0.nb_id
	, vis0.wup_id
	, vis0.wrg_id
	, vis0.gj
	, NULL
	, NULL
	, NULL
	, NULL
	, sub2.inv_wert_vj AS WERT_VJ1
	, sub2.inv_ums_vj AS WERT_VJ2
	, sub1.inv_kalk_vj * vis0.faktor_vj AS ZIEL_VJ1
	, sub1.ums_plan_vj * vis0.faktor_vj AS ZIEL_VJ2
	, NULL
	, NULL
	, WERT_VJ1 / NULLIFZERO(WERT_VJ2) AS WERT_VJ
	, ZIEL_VJ1 / NULLIFZERO(ZIEL_VJ2) AS ZIEL_VJ
	, sub1.inv_eing_vj AS CHECK_VJ /* Original Eingabe */
	, sub1.kommentar_vj AS KOMM_VJ
	, NULL
	, NULL
	, (WERT_VJ - ZIEL_VJ) * 100 AS DELTA_Z /* %pkt */
	, DELTA_Z / NULLIFZERO(ZIEL_VJ) AS ABW_Z
FROM vis_main vis0
LEFT JOIN vis_abt_inv_plan sub1
	ON sub1.mandant_id = vis0.mandant_id AND sub1.wup_id = vis0.wup_id AND sub1.wrg_id = vis0.wrg_id
LEFT JOIN vis_abt_inv sub2
	ON sub2.mandant_id = vis0.mandant_id AND sub2.wup_id = vis0.wup_id AND sub2.wrg_id = vis0.wrg_id AND sub2.abt_id = sub1.abt_id

UNION ALL
/* JZG 50-0-0 Kurzcheck Filialbewertung Gesamt (ohne DE) */
SELECT 50::INTEGER AS METRIK_ID
	, vis0.zero AS TYP_ID
	, vis0.zero AS LEVEL_ID
	, vis0.mandant_id
	, vis0.nb_id
	, vis0.wup_id
	, vis0.wrg_id
	, vis0.gj
	, NULL
	, NULL
	, NULL
	, NULL
	, sub1.kmr_nok_vj AS WERT_VJ1
	, sub1.kmr_anz_vj AS WERT_VJ2
	, ziel.zielwert_vj AS ZIEL_VJ1
	, NULL AS ZIEL_VJ2
	, NULL
	, NULL
	, WERT_VJ1 / NULLIFZERO(WERT_VJ2) AS WERT_VJ
	, ZIEL_VJ1 AS ZIEL_VJ /* %-Wert, keine Aggregation */
	, NULL AS CHECK_VJ
	, ziel.kommentar_vj AS KOMM_VJ
	, NULL
	, NULL
	, (WERT_VJ - ZIEL_VJ) * 100 AS DELTA_Z /* %pkt */
	, DELTA_Z / NULLIFZERO(WERT_VJ) AS ABW_Z
FROM vis_main vis0
LEFT JOIN vis_kurzcheck sub1
	ON sub1.mandant_id = vis0.mandant_id AND sub1.wup_id = vis0.wup_id /* keine WRG_2 */
LEFT JOIN ziel
	ON ziel.mandant_id = vis0.mandant_id AND ziel.wup_id = vis0.wup_id AND ziel.wrg_id = vis0.wrg_id /* Kurzcheck Zielwert + Kommentar VJ */
	AND ziel.metrik_id = 50 AND ziel.typ_id = 0 AND ziel.level_id = 0

/* JZG 52 Filialbewertung gelöscht */

UNION ALL
/* JZG 54-0-0 Kundengarantie Warten Kasse */
SELECT 54::INTEGER AS METRIK_ID
	, vis0.zero AS TYP_ID
	, vis0.zero AS LEVEL_ID
	, vis0.mandant_id
	, vis0.nb_id
	, vis0.wup_id
	, vis0.wrg_id
	, vis0.gj
	, NULL
	, NULL
	, NULL
	, NULL
	, sub1.warten_kasse_vj AS WERT_VJ1
	, NULL AS WERT_VJ2
	, ziel.zielwert_vj AS ZIEL_VJ1
	, NULL AS ZIEL_VJ2
	, NULL
	, NULL
	, WERT_VJ1 AS WERT_VJ
	, ZIEL_VJ1 AS ZIEL_VJ /* %-Wert, keine Aggregation */
	, NULL AS CHECK_VJ
	, ziel.kommentar_vj AS KOMM_VJ
	, NULL
	, NULL
	, WERT_VJ - ZIEL_VJ AS DELTA_Z /* absolut */
	, DELTA_Z / NULLIFZERO(WERT_VJ) AS ABW_Z
FROM vis_main vis0
LEFT JOIN vis_rekl sub1
	ON sub1.mandant_id = vis0.mandant_id AND sub1.wup_id = vis0.wup_id AND sub1.wrg_id = vis0.wrg_id
LEFT JOIN ziel
	ON ziel.mandant_id = vis0.mandant_id AND ziel.wup_id = vis0.wup_id AND ziel.wrg_id = vis0.wrg_id /* Warten Kasse Zielwert + Kommentar VJ */
	AND ziel.metrik_id = 54 AND ziel.typ_id = 0 AND ziel.level_id = 0

UNION ALL
/* JZG 55-0-0 Warten Kasse pro 10000 Kunden */
SELECT 55::INTEGER AS METRIK_ID
	, vis0.zero AS TYP_ID
	, vis0.zero AS LEVEL_ID
	, vis0.mandant_id
	, vis0.nb_id
	, vis0.wup_id
	, vis0.wrg_id
	, vis0.gj
	, NULL
	, NULL
	, NULL
	, NULL
	, sub1.warten_kasse_vj AS WERT_VJ1
	, vis0.anz_kunde_vj / 10000 AS WERT_VJ2
	, NULL
	, NULL
	, NULL
	, NULL
	, WERT_VJ1 / NULLIFZERO(WERT_VJ2) AS WERT_VJ
	, NULL
	, NULL
	, NULL
	, NULL
	, NULL
	, NULL
	, NULL
FROM vis_main vis0
LEFT JOIN vis_rekl sub1
	ON sub1.mandant_id = vis0.mandant_id AND sub1.wup_id = vis0.wup_id AND sub1.wrg_id = vis0.wrg_id

UNION ALL
/* JZG 56-0-0 Kundengarantie Warten Theke */
SELECT 56::INTEGER AS METRIK_ID
	, vis0.zero AS TYP_ID
	, vis0.zero AS LEVEL_ID
	, vis0.mandant_id
	, vis0.nb_id
	, vis0.wup_id
	, vis0.wrg_id
	, vis0.gj
	, NULL
	, NULL
	, NULL
	, NULL
	, sub1.warten_theke_vj AS WERT_VJ1
	, NULL AS WERT_VJ2
	, ziel.zielwert_vj AS ZIEL_VJ1
	, NULL AS ZIEL_VJ2
	, NULL
	, NULL
	, WERT_VJ1 AS WERT_VJ
	, ZIEL_VJ1 AS ZIEL_VJ /* %-Wert, keine Aggregation */
	, NULL AS CHECK_VJ
	, ziel.kommentar_vj AS KOMM_VJ
	, NULL
	, NULL
	, WERT_VJ - ZIEL_VJ AS DELTA_Z /* absolut */
	, DELTA_Z / NULLIFZERO(WERT_VJ) AS ABW_Z
FROM vis_main vis0
LEFT JOIN vis_rekl sub1
	ON sub1.mandant_id = vis0.mandant_id AND sub1.wup_id = vis0.wup_id AND sub1.wrg_id = vis0.wrg_id
LEFT JOIN ziel
	ON ziel.mandant_id = vis0.mandant_id AND ziel.wup_id = vis0.wup_id AND ziel.wrg_id = vis0.wrg_id /* Warten Theke Zielwert + Kommentar VJ */
	AND ziel.metrik_id = 56 AND ziel.typ_id = 0 AND ziel.level_id = 0

UNION ALL
/* JZG 57-0-0 Warten Theke pro 10000 Kunden */
SELECT 57::INTEGER AS METRIK_ID
	, vis0.zero AS TYP_ID
	, vis0.zero AS LEVEL_ID
	, vis0.mandant_id
	, vis0.nb_id
	, vis0.wup_id
	, vis0.wrg_id
	, vis0.gj
	, NULL
	, NULL
	, NULL
	, NULL
	, sub1.warten_theke_vj AS WERT_VJ1
	, vis0.anz_kunde_vj / 10000 AS WERT_VJ2
	, NULL
	, NULL
	, NULL
	, NULL
	, WERT_VJ1 / NULLIFZERO(WERT_VJ2) AS WERT_VJ
	, NULL
	, NULL
	, NULL
	, NULL
	, NULL
	, NULL
	, NULL
FROM vis_main vis0
LEFT JOIN vis_rekl sub1
	ON sub1.mandant_id = vis0.mandant_id AND sub1.wup_id = vis0.wup_id AND sub1.wrg_id = vis0.wrg_id

UNION ALL
/* JZG 58-0-0 Kundengarantie Mangel MHD */
SELECT 58::INTEGER AS METRIK_ID
	, vis0.zero AS TYP_ID
	, vis0.zero AS LEVEL_ID
	, vis0.mandant_id
	, vis0.nb_id
	, vis0.wup_id
	, vis0.wrg_id
	, vis0.gj
	, NULL
	, NULL
	, NULL
	, NULL
	, sub1.mangel_mhd_vj AS WERT_VJ1
	, NULL AS WERT_VJ2
	, ziel.zielwert_vj AS ZIEL_VJ1
	, NULL AS ZIEL_VJ2
	, NULL
	, NULL
	, WERT_VJ1 AS WERT_VJ
	, ZIEL_VJ1 AS ZIEL_VJ /* %-Wert, keine Aggregation */
	, NULL AS CHECK_VJ
	, ziel.kommentar_vj AS KOMM_VJ
	, NULL
	, NULL
	, WERT_VJ - ZIEL_VJ AS DELTA_Z /* absolut */
	, DELTA_Z / NULLIFZERO(WERT_VJ) AS ABW_Z
FROM vis_main vis0
LEFT JOIN vis_rekl sub1
	ON sub1.mandant_id = vis0.mandant_id AND sub1.wup_id = vis0.wup_id AND sub1.wrg_id = vis0.wrg_id
LEFT JOIN ziel
	ON ziel.mandant_id = vis0.mandant_id AND ziel.wup_id = vis0.wup_id AND ziel.wrg_id = vis0.wrg_id /* Mangel MHD Zielwert + Kommentar VJ */
	AND ziel.metrik_id = 58 AND ziel.typ_id = 0 AND ziel.level_id = 0

UNION ALL
/* JZG 59-0-0 Mangel MHD pro 10000 Kunden */
SELECT 59::INTEGER AS METRIK_ID
	, vis0.zero AS TYP_ID
	, vis0.zero AS LEVEL_ID
	, vis0.mandant_id
	, vis0.nb_id
	, vis0.wup_id
	, vis0.wrg_id
	, vis0.gj
	, NULL
	, NULL
	, NULL
	, NULL
	, sub1.mangel_mhd_vj AS WERT_VJ1
	, vis0.anz_kunde_vj / 10000 AS WERT_VJ2
	, NULL
	, NULL
	, NULL
	, NULL
	, WERT_VJ1 / NULLIFZERO(WERT_VJ2) AS WERT_VJ
	, NULL
	, NULL
	, NULL
	, NULL
	, NULL
	, NULL
	, NULL
FROM vis_main vis0
LEFT JOIN vis_rekl sub1
	ON sub1.mandant_id = vis0.mandant_id AND sub1.wup_id = vis0.wup_id AND sub1.wrg_id = vis0.wrg_id

UNION ALL
/* JZG 60-0-0 Kundengarantie Preisauszeichnung Fehler */
SELECT 60::INTEGER AS METRIK_ID
	, vis0.zero AS TYP_ID
	, vis0.zero AS LEVEL_ID
	, vis0.mandant_id
	, vis0.nb_id
	, vis0.wup_id
	, vis0.wrg_id
	, vis0.gj
	, NULL
	, NULL
	, NULL
	, NULL
	, sub1.fehler_preis_vj AS WERT_VJ1
	, NULL AS WERT_VJ2
	, ziel.zielwert_vj AS ZIEL_VJ1
	, NULL AS ZIEL_VJ2
	, NULL
	, NULL
	, WERT_VJ1 AS WERT_VJ
	, ZIEL_VJ1 AS ZIEL_VJ /* %-Wert, keine Aggregation */
	, NULL AS CHECK_VJ
	, ziel.kommentar_vj AS KOMM_VJ
	, NULL
	, NULL
	, WERT_VJ - ZIEL_VJ AS DELTA_Z /* absolut */
	, DELTA_Z / NULLIFZERO(WERT_VJ) AS ABW_Z
FROM vis_main vis0
LEFT JOIN vis_rekl sub1
	ON sub1.mandant_id = vis0.mandant_id AND sub1.wup_id = vis0.wup_id AND sub1.wrg_id = vis0.wrg_id
LEFT JOIN ziel
	ON ziel.mandant_id = vis0.mandant_id AND ziel.wup_id = vis0.wup_id AND ziel.wrg_id = vis0.wrg_id /* Warten Kasse Zielwert + Kommentar VJ */
	AND ziel.metrik_id = 60 AND ziel.typ_id = 0 AND ziel.level_id = 0

UNION ALL
/* JZG 61-0-0 Preisauszeichnung Fehler pro 10000 Kunden */
SELECT 61::INTEGER AS METRIK_ID
	, vis0.zero AS TYP_ID
	, vis0.zero AS LEVEL_ID
	, vis0.mandant_id
	, vis0.nb_id
	, vis0.wup_id
	, vis0.wrg_id
	, vis0.gj
	, NULL
	, NULL
	, NULL
	, NULL
	, sub1.fehler_preis_vj AS WERT_VJ1
	, vis0.anz_kunde_vj / 10000 AS WERT_VJ2
	, NULL
	, NULL
	, NULL
	, NULL
	, WERT_VJ1 / NULLIFZERO(WERT_VJ2) AS WERT_VJ
	, NULL
	, NULL
	, NULL
	, NULL
	, NULL
	, NULL
	, NULL
FROM vis_main vis0
LEFT JOIN vis_rekl sub1
	ON sub1.mandant_id = vis0.mandant_id AND sub1.wup_id = vis0.wup_id AND sub1.wrg_id = vis0.wrg_id

UNION ALL
/* JZG 62-0-0 Kundengarantie Kassierfehler */
SELECT 62::INTEGER AS METRIK_ID
	, vis0.zero AS TYP_ID
	, vis0.zero AS LEVEL_ID
	, vis0.mandant_id
	, vis0.nb_id
	, vis0.wup_id
	, vis0.wrg_id
	, vis0.gj
	, NULL
	, NULL
	, NULL
	, NULL
	, sub1.fehler_kasse_vj AS WERT_VJ1
	, NULL AS WERT_VJ2
	, ziel.zielwert_vj AS ZIEL_VJ1
	, NULL AS ZIEL_VJ2
	, NULL
	, NULL
	, WERT_VJ1 AS WERT_VJ
	, ZIEL_VJ1 AS ZIEL_VJ /* %-Wert, keine Aggregation */
	, NULL AS CHECK_VJ
	, ziel.kommentar_vj AS KOMM_VJ
	, NULL
	, NULL
	, WERT_VJ - ZIEL_VJ AS DELTA_Z /* absolut */
	, DELTA_Z / NULLIFZERO(WERT_VJ) AS ABW_Z
FROM vis_main vis0
LEFT JOIN vis_rekl sub1
	ON sub1.mandant_id = vis0.mandant_id AND sub1.wup_id = vis0.wup_id AND sub1.wrg_id = vis0.wrg_id
LEFT JOIN ziel
	ON ziel.mandant_id = vis0.mandant_id AND ziel.wup_id = vis0.wup_id AND ziel.wrg_id = vis0.wrg_id /* Warten Kasse Zielwert + Kommentar VJ */
	AND ziel.metrik_id = 62 AND ziel.typ_id = 0 AND ziel.level_id = 0

UNION ALL
/* JZG 63-0-0 Kassierfehler pro 100000 Scanzeilen */
SELECT 63::INTEGER AS METRIK_ID
	, vis0.zero AS TYP_ID
	, vis0.zero AS LEVEL_ID
	, vis0.mandant_id
	, vis0.nb_id
	, vis0.wup_id
	, vis0.wrg_id
	, vis0.gj
	, NULL
	, NULL
	, NULL
	, NULL
	, sub1.fehler_kasse_vj AS WERT_VJ1
	, sub2.pos_art100t_vj AS WERT_VJ2
	, NULL
	, NULL
	, NULL
	, NULL
	, WERT_VJ1 / NULLIFZERO(WERT_VJ2) AS WERT_VJ
	, NULL
	, NULL
	, NULL
	, NULL
	, NULL
	, NULL
	, NULL
FROM vis_main vis0
LEFT JOIN vis_rekl sub1
	ON sub1.mandant_id = vis0.mandant_id AND sub1.wup_id = vis0.wup_id AND sub1.wrg_id = vis0.wrg_id
LEFT JOIN vis_kasse sub2
	ON sub2.mandant_id = vis0.mandant_id AND sub2.wup_id = vis0.wup_id AND sub2.wrg_id = vis0.wrg_id

UNION ALL
/* JZG 70-0-0 Personalkosten_2 (%) */
SELECT 70::INTEGER AS METRIK_ID
	, vis0.zero AS TYP_ID
	, vis0.zero AS LEVEL_ID
	, vis0.mandant_id
	, vis0.nb_id
	, vis0.wup_id
	, vis0.wrg_id
	, vis0.gj
	, NULL
	, NULL
	, NULL
	, NULL
	, vis0.pk_wert_vj AS WERT_VJ1
	, vis0.ums_netto_vj AS WERT_VJ2
	, vis0.ums_ziel_vj * ziel.zielwert_vj AS ZIEL_VJ1 /* berechnet PK (absolut) */
	, vis0.ums_ziel_vj AS ZIEL_VJ2
	, NULL
	, NULL
	, WERT_VJ1 / NULLIFZERO(WERT_VJ2) AS WERT_VJ
	, ZIEL_VJ1 / NULLIFZERO(ZIEL_VJ2) AS ZIEL_VJ
	, ziel.zielwert_vj AS CHECK_VJ /* Original Eingabe PK% */
	, ziel.kommentar_vj AS KOMM_VJ
	, NULL
	, NULL
	, (WERT_VJ - ZIEL_VJ) * 100 AS DELTA_Z /* %pkt */
	, DELTA_Z / NULLIFZERO(ZIEL_VJ) AS ABW_Z
FROM vis_main vis0
LEFT JOIN ziel
	ON ziel.mandant_id = vis0.mandant_id AND ziel.wup_id = vis0.wup_id AND ziel.wrg_id = vis0.wrg_id /* PK Zielwert + Kommentar VJ */
	AND ziel.metrik_id = 70 AND ziel.typ_id = 0 AND ziel.level_id = 0

UNION ALL
/* JZG 72-0-0 Nachtzuschläge (%) */
SELECT 72::INTEGER AS METRIK_ID
	, vis0.zero AS TYP_ID
	, vis0.zero AS LEVEL_ID
	, vis0.mandant_id
	, vis0.nb_id
	, vis0.wup_id
	, vis0.wrg_id
	, vis0.gj
	, NULL
	, NULL
	, NULL
	, NULL
	, sub1.std_spaet AS WERT_VJ1
	, vis0.std_netto_vj AS WERT_VJ2
	, NULL
	, NULL
	, NULL
	, NULL
	, WERT_VJ1 / NULLIFZERO(WERT_VJ2) AS WERT_VJ
	, NULL
	, NULL
	, NULL
	, NULL
	, NULL
	, NULL
	, NULL
FROM vis_main vis0
LEFT JOIN vis_shr sub1
	ON sub1.mandant_id = vis0.mandant_id AND sub1.wup_id = vis0.wup_id AND sub1.wrg_id = vis0.wrg_id

UNION ALL
/* JZG 73-0-0 Wochenendzuschläge (%) */
SELECT 73::INTEGER AS METRIK_ID
	, vis0.zero AS TYP_ID
	, vis0.zero AS LEVEL_ID
	, vis0.mandant_id
	, vis0.nb_id
	, vis0.wup_id
	, vis0.wrg_id
	, vis0.gj
	, NULL
	, NULL
	, NULL
	, NULL
	, sub1.std_we AS WERT_VJ1
	, vis0.std_netto_vj AS WERT_VJ2
	, NULL
	, NULL
	, NULL
	, NULL
	, WERT_VJ1 / NULLIFZERO(WERT_VJ2) AS WERT_VJ
	, NULL
	, NULL
	, NULL
	, NULL
	, NULL
	, NULL
	, NULL
FROM vis_main vis0
LEFT JOIN vis_shr sub1
	ON sub1.mandant_id = vis0.mandant_id AND sub1.wup_id = vis0.wup_id AND sub1.wrg_id = vis0.wrg_id

UNION ALL
/* JZG 74-0-0 Feiertagszuschläge (%) */
SELECT 74::INTEGER AS METRIK_ID
	, vis0.zero AS TYP_ID
	, vis0.zero AS LEVEL_ID
	, vis0.mandant_id
	, vis0.nb_id
	, vis0.wup_id
	, vis0.wrg_id
	, vis0.gj
	, NULL
	, NULL
	, NULL
	, NULL
	, sub1.std_ftag AS WERT_VJ1
	, vis0.std_netto_vj AS WERT_VJ2
	, NULL
	, NULL
	, NULL
	, NULL
	, WERT_VJ1 / NULLIFZERO(WERT_VJ2) AS WERT_VJ
	, NULL
	, NULL
	, NULL
	, NULL
	, NULL
	, NULL
	, NULL
FROM vis_main vis0
LEFT JOIN vis_shr sub1
	ON sub1.mandant_id = vis0.mandant_id AND sub1.wup_id = vis0.wup_id AND sub1.wrg_id = vis0.wrg_id

UNION ALL
/* JZG 75-0-0 Mehrstundenzuschläge (%) */
SELECT 75::INTEGER AS METRIK_ID
	, vis0.zero AS TYP_ID
	, vis0.zero AS LEVEL_ID
	, vis0.mandant_id
	, vis0.nb_id
	, vis0.wup_id
	, vis0.wrg_id
	, vis0.gj
	, NULL
	, NULL
	, NULL
	, NULL
	, sub1.std_mehr AS WERT_VJ1
	, vis0.std_netto_vj AS WERT_VJ2
	, NULL
	, NULL
	, NULL
	, NULL
	, WERT_VJ1 / NULLIFZERO(WERT_VJ2) AS WERT_VJ
	, NULL
	, NULL
	, NULL
	, NULL
	, NULL
	, NULL
	, NULL
FROM vis_main vis0
LEFT JOIN vis_shr sub1
	ON sub1.mandant_id = vis0.mandant_id AND sub1.wup_id = vis0.wup_id AND sub1.wrg_id = vis0.wrg_id

UNION ALL
/* JZG 76-0-0 Resturlaub */
SELECT 76::INTEGER AS METRIK_ID
	, vis0.zero AS TYP_ID
	, vis0.zero AS LEVEL_ID
	, vis0.mandant_id
	, vis0.nb_id
	, vis0.wup_id
	, vis0.wrg_id
	, vis0.gj
	, NULL
	, NULL
	, NULL
	, NULL
	, (sub1.ans_vj + sub1.rst_vj) - (sub1.abg_vj + sub1.gen_vj) AS WERT_VJ1
	, sub1.ans_vj AS WERT_VJ2
	, ziel.zielwert_vj AS ZIEL_VJ1
	, NULL
	, NULL
	, NULL
	, WERT_VJ1 / NULLIFZERO(WERT_VJ2) AS WERT_VJ
	, ZIEL_VJ1 AS ZIEL_VJ /* %-Wert, keine Aggregation */
	, NULL AS CHECK_VJ
	, ziel.kommentar_vj AS KOMM_VJ
	, NULL
	, NULL
	, (WERT_VJ - ZIEL_VJ) * 100 AS DELTA_Z /* %pkt */
	, DELTA_Z / NULLIFZERO(WERT_VJ) AS ABW_Z
FROM vis_main vis0
LEFT JOIN vis_ruq sub1
	ON sub1.mandant_id = vis0.mandant_id AND sub1.wup_id = vis0.wup_id AND sub1.wrg_id = vis0.wrg_id
LEFT JOIN ziel
	ON ziel.mandant_id = vis0.mandant_id AND ziel.wup_id = vis0.wup_id AND ziel.wrg_id = vis0.wrg_id /* Resturlaub Zielwert + Kommentar VJ */
	AND ziel.metrik_id = 76 AND ziel.typ_id = 0 AND ziel.level_id = 0

UNION ALL
/* JZG 77-0-0 Krankenstand (%) */
SELECT 77::INTEGER AS METRIK_ID
	, vis0.zero AS TYP_ID
	, vis0.zero AS LEVEL_ID
	, vis0.mandant_id
	, vis0.nb_id
	, vis0.wup_id
	, vis0.wrg_id
	, vis0.gj
	, NULL
	, NULL
	, NULL
	, NULL
	, sub1.std_krank AS WERT_VJ1
	, sub1.std_soll AS WERT_VJ2
	, NULL
	, NULL
	, NULL
	, NULL
	, WERT_VJ1 / NULLIFZERO(WERT_VJ2) AS WERT_VJ
	, NULL
	, NULL
	, NULL
	, NULL
	, NULL
	, NULL
	, NULL
FROM vis_main vis0
LEFT JOIN vis_shr sub1
	ON sub1.mandant_id = vis0.mandant_id AND sub1.wup_id = vis0.wup_id AND sub1.wrg_id = vis0.wrg_id

UNION ALL
/* JZG 78-0-0 Fluktuation rollierend */
SELECT 78::INTEGER AS METRIK_ID
	, vis0.zero AS TYP_ID
	, vis0.zero AS LEVEL_ID
	, vis0.mandant_id
	, vis0.nb_id
	, vis0.wup_id
	, vis0.wrg_id
	, vis0.gj
	, NULL
	, NULL
	, NULL
	, NULL
	, sub1.aus_roll AS WERT_VJ1
	, sub1.kopf_roll AS WERT_VJ2
	, ziel.zielwert_vj AS ZIEL_VJ1
	, NULL
	, NULL
	, NULL
	, WERT_VJ1 / NULLIFZERO(WERT_VJ2) AS WERT_VJ
	, ZIEL_VJ1 AS ZIEL_VJ /* %-Wert, keine Aggregation */
	, NULL AS CHECK_VJ
	, ziel.kommentar_vj AS KOMM_VJ
	, NULL
	, NULL
	, (WERT_VJ - ZIEL_VJ) * 100 AS DELTA_Z /* %pkt */
	, DELTA_Z / NULLIFZERO(WERT_VJ) AS ABW_Z
FROM vis_main vis0
LEFT JOIN vis_shr sub1
	ON sub1.mandant_id = vis0.mandant_id AND sub1.wup_id = vis0.wup_id AND sub1.wrg_id = vis0.wrg_id
LEFT JOIN ziel
	ON ziel.mandant_id = vis0.mandant_id AND ziel.wup_id = vis0.wup_id AND ziel.wrg_id = vis0.wrg_id /* Fluktuation Zielwert + Kommentar VJ */
	AND ziel.metrik_id = 78 AND ziel.typ_id = 0 AND ziel.level_id = 0

UNION ALL
/* JZG 80-0-0 Köpfe Gesamt */
SELECT 80::INTEGER AS METRIK_ID
	, vis0.zero AS TYP_ID
	, vis0.zero AS LEVEL_ID
	, vis0.mandant_id
	, vis0.nb_id
	, vis0.wup_id
	, vis0.wrg_id
	, vis0.gj
	, NULL
	, NULL
	, NULL
	, NULL
	, sub1.kopf_fil AS WERT_VJ1
	, NULL AS WERT_VJ2
	, NULL
	, NULL
	, NULL
	, NULL
	, WERT_VJ1 AS WERT_VJ
	, NULL
	, NULL
	, NULL
	, NULL
	, NULL
	, NULL
	, NULL
FROM vis_main vis0
LEFT JOIN vis_shr sub1
	ON sub1.mandant_id = vis0.mandant_id AND sub1.wup_id = vis0.wup_id AND sub1.wrg_id = vis0.wrg_id

UNION ALL
/* JZG 81-0-0 Anzahl Mitarbeiter */
SELECT 81::INTEGER AS METRIK_ID
	, vis0.zero AS TYP_ID
	, vis0.zero AS LEVEL_ID
	, vis0.mandant_id
	, vis0.nb_id
	, vis0.wup_id
	, vis0.wrg_id
	, vis0.gj
	, NULL
	, NULL
	, NULL
	, NULL
	, sub1.kopf_ma AS WERT_VJ1
	, NULL AS WERT_VJ2
	, NULL
	, NULL
	, NULL
	, NULL
	, WERT_VJ1 AS WERT_VJ
	, NULL
	, NULL
	, NULL
	, NULL
	, NULL
	, NULL
	, NULL
FROM vis_main vis0
LEFT JOIN vis_shr sub1
	ON sub1.mandant_id = vis0.mandant_id AND sub1.wup_id = vis0.wup_id AND sub1.wrg_id = vis0.wrg_id

UNION ALL
/* JZG 82-0-0 Anzahl VZK */
SELECT 82::INTEGER AS METRIK_ID
	, vis0.zero AS TYP_ID
	, vis0.zero AS LEVEL_ID
	, vis0.mandant_id
	, vis0.nb_id
	, vis0.wup_id
	, vis0.wrg_id
	, vis0.gj
	, NULL
	, NULL
	, NULL
	, NULL
	, sub1.vzk_ma AS WERT_VJ1
	, NULL AS WERT_VJ2
	, NULL
	, NULL
	, NULL
	, NULL
	, WERT_VJ1 AS WERT_VJ
	, NULL
	, NULL
	, NULL
	, NULL
	, NULL
	, NULL
	, NULL
FROM vis_main vis0
LEFT JOIN vis_shr sub1
	ON sub1.mandant_id = vis0.mandant_id AND sub1.wup_id = vis0.wup_id AND sub1.wrg_id = vis0.wrg_id

UNION ALL
/* JZG 84-0-0 Anzahl Vertragsstunden */
SELECT 84::INTEGER AS METRIK_ID
	, vis0.zero AS TYP_ID
	, vis0.zero AS LEVEL_ID
	, vis0.mandant_id
	, vis0.nb_id
	, vis0.wup_id
	, vis0.wrg_id
	, vis0.gj
	, NULL
	, NULL
	, NULL
	, NULL
	, sub1.std_vtg AS WERT_VJ1
	, NULL AS WERT_VJ2
	, ziel.zielwert_vj AS ZIEL_VJ1
	, NULL
	, NULL
	, NULL
	, WERT_VJ1 / NULLIFZERO(WERT_VJ2) AS WERT_VJ
	, ZIEL_VJ1 AS ZIEL_VJ /* %-Wert, keine Aggregation */
	, NULL AS CHECK_VJ
	, ziel.kommentar_vj AS KOMM_VJ
	, NULL
	, NULL
	, WERT_VJ - ZIEL_VJ AS DELTA_Z /* absolut */
	, DELTA_Z / NULLIFZERO(WERT_VJ) AS ABW_Z
FROM vis_main vis0
LEFT JOIN vis_shr sub1
	ON sub1.mandant_id = vis0.mandant_id AND sub1.wup_id = vis0.wup_id AND sub1.wrg_id = vis0.wrg_id
LEFT JOIN ziel
	ON ziel.mandant_id = vis0.mandant_id AND ziel.wup_id = vis0.wup_id AND ziel.wrg_id = vis0.wrg_id /* Anzahl Vertragsstunden Zielwert + Kommentar VJ */
	AND ziel.metrik_id = 84 AND ziel.typ_id = 0 AND ziel.level_id = 0

UNION ALL
/* JZG 86-0-0 Ø Vertragsstunden */
SELECT 86::INTEGER AS METRIK_ID
	, vis0.zero AS TYP_ID
	, vis0.zero AS LEVEL_ID
	, vis0.mandant_id
	, vis0.nb_id
	, vis0.wup_id
	, vis0.wrg_id
	, vis0.gj
	, NULL
	, NULL
	, NULL
	, NULL
	, sub1.std_vtg AS WERT_VJ1
	, sub1.kopf_ma AS WERT_VJ2
	, NULL
	, NULL
	, NULL
	, NULL
	, WERT_VJ1 / NULLIFZERO(WERT_VJ2) AS WERT_VJ
	, NULL
	, NULL
	, NULL
	, NULL
	, NULL
	, NULL
	, NULL
FROM vis_main vis0
LEFT JOIN vis_shr sub1
	ON sub1.mandant_id = vis0.mandant_id AND sub1.wup_id = vis0.wup_id AND sub1.wrg_id = vis0.wrg_id

UNION ALL
/* JZG 88-0-0 Anteil TZK */
SELECT 88::INTEGER AS METRIK_ID
	, vis0.zero AS TYP_ID
	, vis0.zero AS LEVEL_ID
	, vis0.mandant_id
	, vis0.nb_id
	, vis0.wup_id
	, vis0.wrg_id
	, vis0.gj
	, NULL
	, NULL
	, NULL
	, NULL
	, sub1.tzk_ma AS WERT_VJ1
	, sub1.kopf_ma AS WERT_VJ2
	, ziel.zielwert_vj AS ZIEL_VJ1
	, NULL
	, NULL
	, NULL
	, WERT_VJ1 / NULLIFZERO(WERT_VJ2) AS WERT_VJ
	, ZIEL_VJ1 AS ZIEL_VJ /* %-Wert, keine Aggregation */
	, NULL AS CHECK_VJ
	, ziel.kommentar_vj AS KOMM_VJ
	, NULL
	, NULL
	, (WERT_VJ - ZIEL_VJ) * 100 AS DELTA_Z /* %pkt */
	, DELTA_Z / NULLIFZERO(WERT_VJ) AS ABW_Z
FROM vis_main vis0
LEFT JOIN vis_shr sub1
	ON sub1.mandant_id = vis0.mandant_id AND sub1.wup_id = vis0.wup_id AND sub1.wrg_id = vis0.wrg_id
LEFT JOIN ziel
	ON ziel.mandant_id = vis0.mandant_id AND ziel.wup_id = vis0.wup_id AND ziel.wrg_id = vis0.wrg_id /* Anteil TZK Zielwert + Kommentar VJ */
	AND ziel.metrik_id = 88 AND ziel.typ_id = 0 AND ziel.level_id = 0

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
	, NULL
	, NULL
	, NULL
	, NULL
	, NULL
	, NULL
	, NULL
	, NULL
	, NULL
	, NULL
	, NULL
	, NULL
	, NULL
	, ziel.kommentar_vj AS KOMM_VJ
	, NULL
	, NULL
	, NULL
	, NULL
FROM vis_main vis0
LEFT JOIN ziel
	ON ziel.mandant_id = vis0.mandant_id AND ziel.wup_id = vis0.wup_id AND ziel.wrg_id = vis0.wrg_id /* TOP Kommentar VJ */
	AND ziel.metrik_id = 91 AND ziel.typ_id = 0 AND ziel.level_id = 0

UNION ALL
/* JZG 92-0-0 TOP2 Kommentar */
SELECT 92::INTEGER METRIK_ID
	, vis0.zero AS TYP_ID
	, vis0.zero AS LEVEL_ID
	, vis0.mandant_id
	, vis0.nb_id
	, vis0.wup_id
	, vis0.wrg_id
	, vis0.gj
	, NULL
	, NULL
	, NULL
	, NULL
	, NULL
	, NULL
	, NULL
	, NULL
	, NULL
	, NULL
	, NULL
	, NULL
	, NULL
	, ziel.kommentar_vj AS KOMM_VJ
	, NULL
	, NULL
	, NULL
	, NULL
FROM vis_main vis0
LEFT JOIN ziel
	ON ziel.mandant_id = vis0.mandant_id AND ziel.wup_id = vis0.wup_id AND ziel.wrg_id = vis0.wrg_id /* TOP Kommentar VJ */
	AND ziel.metrik_id = 92 AND ziel.typ_id = 0 AND ziel.level_id = 0

UNION ALL
/* JZG 93-0-0 TOP3 Kommentar */
SELECT 93::INTEGER METRIK_ID
	, vis0.zero AS TYP_ID
	, vis0.zero AS LEVEL_ID
	, vis0.mandant_id
	, vis0.nb_id
	, vis0.wup_id
	, vis0.wrg_id
	, vis0.gj
	, NULL
	, NULL
	, NULL
	, NULL
	, NULL
	, NULL
	, NULL
	, NULL
	, NULL
	, NULL
	, NULL
	, NULL
	, NULL
	, ziel.kommentar_vj AS KOMM_VJ
	, NULL
	, NULL
	, NULL
	, NULL
FROM vis_main vis0
LEFT JOIN ziel
	ON ziel.mandant_id = vis0.mandant_id AND ziel.wup_id = vis0.wup_id AND ziel.wrg_id = vis0.wrg_id /* TOP Kommentar VJ */
	AND ziel.metrik_id = 93 AND ziel.typ_id = 0 AND ziel.level_id = 0

UNION ALL
/* JZG 94-0-0 TOP4 Kommentar */
SELECT 94::INTEGER METRIK_ID
	, vis0.zero AS TYP_ID
	, vis0.zero AS LEVEL_ID
	, vis0.mandant_id
	, vis0.nb_id
	, vis0.wup_id
	, vis0.wrg_id
	, vis0.gj
	, NULL
	, NULL
	, NULL
	, NULL
	, NULL
	, NULL
	, NULL
	, NULL
	, NULL
	, NULL
	, NULL
	, NULL
	, NULL
	, ziel.kommentar_vj AS KOMM_VJ
	, NULL
	, NULL
	, NULL
	, NULL
FROM vis_main vis0
LEFT JOIN ziel
	ON ziel.mandant_id = vis0.mandant_id AND ziel.wup_id = vis0.wup_id AND ziel.wrg_id = vis0.wrg_id /* TOP Kommentar VJ */
	AND ziel.metrik_id = 94 AND ziel.typ_id = 0 AND ziel.level_id = 0

UNION ALL
/* JZG 95-0-0 TOP5 Kommentar */
SELECT 95::INTEGER METRIK_ID
	, vis0.zero AS TYP_ID
	, vis0.zero AS LEVEL_ID
	, vis0.mandant_id
	, vis0.nb_id
	, vis0.wup_id
	, vis0.wrg_id
	, vis0.gj
	, NULL
	, NULL
	, NULL
	, NULL
	, NULL
	, NULL
	, NULL
	, NULL
	, NULL
	, NULL
	, NULL
	, NULL
	, NULL
	, ziel.kommentar_vj AS KOMM_VJ
	, NULL
	, NULL
	, NULL
	, NULL
FROM vis_main vis0
LEFT JOIN ziel
	ON ziel.mandant_id = vis0.mandant_id AND ziel.wup_id = vis0.wup_id AND ziel.wrg_id = vis0.wrg_id /* TOP Kommentar VJ */
	AND ziel.metrik_id = 95 AND ziel.typ_id = 0 AND ziel.level_id = 0
;