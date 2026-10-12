create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_VIS.MV_WARENVERLUST_OWG_2(
	MANDANT_ID COMMENT 'Mandant_2 im DWH',
	WUP_ID COMMENT 'Der \""WUP_2\"" beinhaltet Märkte und Lager. WUP_2 = WarenUmschlagsPlatz. Mutter WUP_2 ID wird verwendet für Beziehung Lager zu Verteilzentrum.',
	OWG_HIST_ID COMMENT 'ID der Oberwarengruppe',
	HWG_HIST_ID COMMENT 'ID der Hauptwarengruppe',
	ABT_HIST_ID COMMENT 'Abteilungs-ID, negative Werte: im DWH generierte IDs; positive Werte: aus Stammdatensystem übernommen.',
	WRG_ID COMMENT 'Kurzbezeichnung der Währung, z.B. CZK, EUR',
	INVENTURART_ID COMMENT 'Inventurarten aus SAP. Unterscheidung, ob bsp. Jahres-, Frische- oder Sonderinventur. Siehe Inventurart_spr_zu.',
	DAT_INVENTUR_VON COMMENT 'Start des betrachteten Inventurzeitraums. Dieser Zeitraum unterliegt keiner festen zeitlichen Größe und kann sich je Land_2 unterscheiden.',
	DAT_INVENTUR_BIS COMMENT 'Ende des betrachteten Inventurzeitraums. Dieser Zeitraum unterliegt keiner festen zeitlichen Größe und kann sich je Land_2 unterscheiden.',
	GJ COMMENT 'Geschäftsjahr, dem Inventurzeitraum zugeordnet werden soll. 28.02.2024 kann beispielsweise in der Betrachtung zum Inventurzeitraum des GJ 2024 statt 2023 gehören.',
	CNT_INV COMMENT 'Anzahl an Inventuren',
	WV_UMSATZ_NETTO COMMENT 'Umsatz der betroffenen Inventur_2-Artikel_2 im definierten Inventur_2-Zeitraum je Betrieb (auf OWG-Ebene aggregiert)',
	WV_PREISABSCHRIFT_NETTO COMMENT 'Wert der Preisabschriften für die betroffenen Inventur_2-Artikel_2 im definierten Inventur_2-Zeitraum je Betrieb (auf OWG-Ebene aggregiert)',
	WV_TOTALABSCHRIFT_NETTO COMMENT 'Wert der Totalabschriften für die betroffenen Inventur_2-Artikel_2 im definierten Inventur_2-Zeitraum je Betrieb (auf OWG-Ebene aggregiert)',
	WV_MENGE_INVENTUR COMMENT 'Saldierte Inventur_2-Differenz-Mengen je Artikel_2 und Betrieb im definierten Inventur_2-Zeitraum (auf OWG-Ebene aggregiert)',
	WV_INVENTUR_NETTO_BASIS COMMENT 'Saldierte Inventur_2-Differenz-Werte je Artikel_2 und Betrieb im definierten Inventur_2-Zeitraum (auf OWG-Ebene aggregiert)',
	WV_INVENTUR_NETTO_KALK COMMENT 'Von der VT Landesorganisation geplante Inventurdifferenz-Werte im definierten Inventur_2-Zeitraum (nur auf OWG-Ebene vorhanden)',
	WV_INVENTUR_NETTO COMMENT 'Summe von saldierten und geplanten Inventurdifferenz-Werten im definierten Inventur_2-Zeitraum',
	WV_INVENTUR_DIEBSTAHL_NETTO COMMENT 'Betrag Diebstahl als Teilmenge der Inventur_2-Differenz-Werten (auf OWG-Ebene aggregiert)',
	WV_UMSATZ_NETTO_AUFG COMMENT 'Aufgelaufener Umsatz der betroffenen Inventur_2-Artikel_2 im definierten Inventur_2-Zeitraum je Betrieb (auf OWG-Ebene aggregiert)',
	WV_PREISABSCHRIFT_NETTO_AUFG COMMENT 'Aufgelaufener Wert der Preisabschriften für die betroffenen Inventur_2-Artikel_2 im definierten Inventur_2-Zeitraum je Betrieb (auf OWG-Ebene aggregiert)',
	WV_TOTALABSCHRIFT_NETTO_AUFG COMMENT 'Aufgelaufener Wert der Totalabschriften für die betroffenen Inventur_2-Artikel_2 im definierten Inventur_2-Zeitraum je Betrieb (auf OWG-Ebene aggregiert)',
	WV_MENGE_INVENTUR_AUFG COMMENT 'Aufgelaufene Saldierte Inventur_2-Differenz-Mengen je Artikel_2 und Betrieb im definierten Inventur_2-Zeitraum (auf OWG-Ebene aggregiert)',
	WV_INVENTUR_NETTO_AUFG COMMENT 'Aufgelaufene Summe von saldierten und geplanten Inventurdifferenz-Werten im definierten Inventur_2-Zeitraum (auf OWG-Ebene aggregiert)',
	WV_UMSATZ_NETTO_VJ_AUFG COMMENT 'Im VJ aufgelaufener Umsatz der betroffenen Inventur_2-Artikel_2 im definierten Inventur_2-Zeitraum je Betrieb (auf OWG-Ebene aggregiert)',
	WV_PREISABSCHRIFT_NETTO_VJ_AUFG COMMENT 'Im VJ aufgelaufener Wert der Preisabschriften für die betroffenen Inventur_2-Artikel_2 im definierten Inventur_2-Zeitraum je Betrieb (auf OWG-Ebene aggregiert)',
	WV_TOTALABSCHRIFT_NETTO_VJ_AUFG COMMENT 'Im VJ aufgelaufener Wert der Totalabschriften für die betroffenen Inventur_2-Artikel_2 im definierten Inventur_2-Zeitraum je Betrieb (auf OWG-Ebene aggregiert)',
	WV_MENGE_INVENTUR_VJ_AUFG COMMENT 'Im VJ aufgelaufene Saldierte Inventur_2-Differenz-Mengen je Artikel_2 und Betrieb im definierten Inventur_2-Zeitraum (auf OWG-Ebene aggregiert)',
	WV_INVENTUR_NETTO_VJ_AUFG COMMENT 'Im VJ aufgelaufene Summe von saldierten und geplanten Inventurdifferenz-Werten im definierten Inventur_2-Zeitraum (auf OWG-Ebene aggregiert)',
	WV_UMSATZ_NETTO_AUFG_DIFF COMMENT 'Absolute Differenz des aufgelaufenen Umsatzes vom aktuellem Jahr zum VJ (auf OWG-Ebene aggregiert)',
	WV_PREISABSCHRIFT_NETTO_AUFG_DIFF COMMENT 'Absolute Differenz des aufgelaufenen Werts der Preisabschriften vom aktuellem Jahr zum VJ (auf OWG-Ebene aggregiert)',
	WV_TOTALABSCHRIFT_NETTO_AUFG_DIFF COMMENT 'Absolute Differenz des aufgelaufenen Werts der Totalabschriften vom aktuellem Jahr zum VJ (auf OWG-Ebene aggregiert)',
	WV_MENGE_INVENTUR_AUFG_DIFF COMMENT 'Absolute Differenz der aufgelaufenen saldierten Inventur_2-Differenz-Mengen vom aktuellem Jahr zum VJ (auf OWG-Ebene aggregiert)',
	WV_INVENTUR_NETTO_AUFG_DIFF COMMENT 'Absolute Differenz der Summe von saldierten und geplanten Inventurdifferenz-Werten vom aktuellem Jahr zum VJ (auf OWG-Ebene aggregiert)',
	BETRAG_VK_NETTO_PLAN COMMENT 'Geplanter Umsatz je OWG und Markt',
	BETRAG_VK_NETTO_INVENTUR_DIFF_PLAN COMMENT 'Geplante Inventurdifferenz je OWG, Inventurart und Markt'
) as  






WITH 

facts_kalkulatorisch AS (
	SELECT i.mandant_id
		, wup.aktuell_wup_id AS wup_id
		, i.owg_id AS owg_hist_id
		, h.hwg_id AS hwg_hist_id
		, h.abt_id AS abt_hist_id
		, 'EUR' AS wrg_id
		, i.inventurart_id
		, i.dat_inventur_von
		, i.dat_inventur_bis
		, i.gj
		, SUM(i.betrag_vk_netto_inventur_diff_kalk) AS inventur_netto
	FROM dbp_view.v_inventur_warenverlust_kalk_2 i 
	INNER JOIN dbp_view.v_wup_2 wup_2 
		ON i.mandant_id = wup.mandant_id
			AND i.wup_id = wup.wup_id
	INNER JOIN dbp_data.owg_per_2 o 
		ON i.mandant_id = o.mandant_id
			AND i.owg_id = o.owg_id
			AND i.dat_inventur_bis BETWEEN o.dat_von AND o.dat_bis
			AND o.arthiertyp_id = 2
	INNER JOIN dbp_data.hwg_per_2 h 
		ON o.mandant_id = h.mandant_id
			AND o.hwg_id = h.hwg_id
			AND i.dat_inventur_bis BETWEEN h.dat_von AND h.dat_bis
			AND h.arthiertyp_id = 2
	GROUP BY i.mandant_id
		, wup.aktuell_wup_id
		, owg_hist_id
		, hwg_hist_id
		, abt_hist_id
		, wrg_id
		, i.inventurart_id
		, i.dat_inventur_von
		, i.dat_inventur_bis
		, i.gj
	), 

facts_warenverlust AS (
	SELECT mandant_id
		, wup_id
		, owg_hist_id
		, hwg_hist_id
		, abt_hist_id
		, wrg_id
		, inventurart_id 
		, dat_inventur_von
		, dat_inventur_bis
		, gj
		
		, COUNT(DISTINCT inventur_id) AS cnt_inv 
		, SUM(wv_umsatz_netto) AS wv_umsatz_netto
		, SUM(wv_preisabschrift_netto) AS wv_preisabschrift_netto
		, SUM(wv_totalabschrift_netto) AS wv_totalabschrift_netto
		, SUM(wv_menge_inventur) AS wv_menge_inventur
		, SUM(wv_inventur_netto) AS wv_inventur_netto_basis
		, SUM(wv_inventur_diebstahl_netto) AS wv_inventur_diebstahl_netto
	FROM dbp_msi_view_vis.mv_warenverlust_2 
	GROUP BY mandant_id 
		, wup_id
		, owg_hist_id
		, hwg_hist_id
		, abt_hist_id
		, wrg_id
		, inventurart_id 
		, dat_inventur_von
		, dat_inventur_bis
		, gj
	), 

facts_combined AS (
	SELECT w.mandant_id
		, w.wup_id
		, w.owg_hist_id
		, w.hwg_hist_id
		, w.abt_hist_id
		, w.wrg_id
		, w.inventurart_id
		, w.dat_inventur_von
		, w.dat_inventur_bis
		, w.gj
		, w.cnt_inv
		, w.wv_umsatz_netto
		, w.wv_preisabschrift_netto
		, w.wv_totalabschrift_netto
		, w.wv_menge_inventur
		, w.wv_inventur_netto_basis 
		, k.inventur_netto AS wv_inventur_netto_kalk 
		, ZEROIFNULL(w.wv_inventur_netto_basis) + ZEROIFNULL(wv_inventur_netto_kalk) AS wv_inventur_netto
		, w.wv_inventur_diebstahl_netto
	FROM facts_warenverlust w
	LEFT OUTER JOIN facts_kalkulatorisch k 
		ON w.mandant_id = k.mandant_id
			AND w.wup_id = k.wup_id
			AND w.owg_hist_id = k.owg_hist_id 
			AND w.hwg_hist_id = k.hwg_hist_id
			AND w.abt_hist_id = k.abt_hist_id
			AND w.wrg_id = k.wrg_id
			AND w.inventurart_id = k.inventurart_id
			AND w.dat_inventur_bis = k.dat_inventur_bis
			AND w.gj = k.gj
	),

facts_cumulated AS (
	SELECT mandant_id
		, wup_id
		, owg_hist_id
		, hwg_hist_id
		, abt_hist_id
		, wrg_id
		, inventurart_id
		, dat_inventur_von
		, dat_inventur_bis
		, gj
		, cnt_inv
		, wv_umsatz_netto
		, wv_preisabschrift_netto
		, wv_totalabschrift_netto
		, wv_menge_inventur
		, wv_inventur_netto_basis  
		, wv_inventur_netto_kalk
		, wv_inventur_netto
		, wv_inventur_diebstahl_netto
		, SUM(CASE WHEN inventurart_id IN (1, 2, 3, 4, 5) THEN ZEROIFNULL(wv_umsatz_netto) ELSE NULL END) OVER (
			PARTITION BY mandant_id, wup_id, wrg_id, owg_hist_id, gj, inventurart_id 
			ORDER BY dat_inventur_bis ASC ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
			) AS wv_umsatz_netto_aufg
		, SUM(CASE WHEN inventurart_id IN (1, 2, 3, 4, 5) THEN ZEROIFNULL(wv_preisabschrift_netto) ELSE NULL END) OVER (
			PARTITION BY mandant_id, wup_id, wrg_id, owg_hist_id, gj, inventurart_id 
			ORDER BY dat_inventur_bis ASC ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
			) AS wv_preisabschrift_netto_aufg
		, SUM(CASE WHEN inventurart_id IN (1, 2, 3, 4, 5) THEN ZEROIFNULL(wv_totalabschrift_netto) ELSE NULL END) OVER (
			PARTITION BY mandant_id, wup_id, wrg_id, owg_hist_id, gj, inventurart_id 
			ORDER BY dat_inventur_bis ASC ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
			) AS wv_totalabschrift_netto_aufg
		, SUM(CASE WHEN inventurart_id IN (1, 2, 3, 4, 5) THEN ZEROIFNULL(wv_menge_inventur) ELSE NULL END) OVER (
			PARTITION BY mandant_id, wup_id, wrg_id, owg_hist_id, gj, inventurart_id 
			ORDER BY dat_inventur_bis ASC ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
			) AS wv_menge_inventur_aufg
		, SUM(CASE WHEN inventurart_id IN (1, 2, 3, 4, 5) THEN ZEROIFNULL(wv_inventur_netto) ELSE NULL END) OVER (
			PARTITION BY mandant_id, wup_id, wrg_id, owg_hist_id, gj, inventurart_id 
			ORDER BY dat_inventur_bis ASC ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
			) AS wv_inventur_netto_aufg
		
		
		
		
	FROM facts_combined
	),

facts_mapped_previous_year AS (
	SELECT f.mandant_id
		, f.wup_id
		, f.owg_hist_id
		, f.hwg_hist_id
		, f.abt_hist_id
		, f.wrg_id
		, f.inventurart_id
		, f.dat_inventur_von
		, f.dat_inventur_bis
		, f.gj
		, f.cnt_inv
		, f.wv_umsatz_netto
		, f.wv_preisabschrift_netto
		, f.wv_totalabschrift_netto
		, f.wv_menge_inventur
		, f.wv_inventur_netto_basis
		, f.wv_inventur_netto_kalk
		, f.wv_inventur_netto
		, f.wv_inventur_diebstahl_netto
		
		, f.wv_umsatz_netto_aufg
		, f.wv_preisabschrift_netto_aufg
		, f.wv_totalabschrift_netto_aufg
		, f.wv_menge_inventur_aufg
		, f.wv_inventur_netto_aufg
		
		
		, CASE 
			WHEN f.inventurart_id IN (2, 3, 4, 5) THEN vji.wv_umsatz_netto_aufg
			WHEN f.inventurart_id IN (1) THEN vj.wv_umsatz_netto_aufg
			ELSE NULL 
			END AS wv_umsatz_netto_vj_aufg
		, CASE
			WHEN f.inventurart_id IN (2, 3, 4, 5) THEN vji.wv_preisabschrift_netto_aufg
			WHEN f.inventurart_id IN (1) THEN vj.wv_preisabschrift_netto_aufg
			ELSE NULL 
			END	AS wv_preisabschrift_netto_vj_aufg
		, CASE
			WHEN f.inventurart_id IN (2, 3, 4, 5) THEN vji.wv_totalabschrift_netto_aufg
			WHEN f.inventurart_id IN (1) THEN vj.wv_totalabschrift_netto_aufg
			ELSE NULL 
			END AS wv_totalabschrift_netto_vj_aufg
		, CASE
			WHEN f.inventurart_id IN (2, 3, 4, 5) THEN vji.wv_menge_inventur_aufg
			WHEN f.inventurart_id IN (1) THEN vj.wv_menge_inventur_aufg
			ELSE NULL 
			END AS wv_menge_inventur_vj_aufg
		, CASE
			WHEN f.inventurart_id IN (2, 3, 4, 5) THEN vji.wv_inventur_netto_aufg
			WHEN f.inventurart_id IN (1) THEN vj.wv_inventur_netto_aufg
			ELSE NULL 
			END AS wv_inventur_netto_vj_aufg
		
		, f.wv_umsatz_netto_aufg - wv_umsatz_netto_vj_aufg 					AS wv_umsatz_netto_aufg_diff
		, f.wv_preisabschrift_netto_aufg - wv_preisabschrift_netto_vj_aufg 	AS wv_preisabschrift_netto_aufg_diff
		, f.wv_totalabschrift_netto_aufg - wv_totalabschrift_netto_vj_aufg 	AS wv_totalabschrift_netto_aufg_diff
		, f.wv_menge_inventur_aufg - wv_menge_inventur_vj_aufg 				AS wv_menge_inventur_aufg_diff
		, f.wv_inventur_netto_aufg - wv_inventur_netto_vj_aufg 				AS wv_inventur_netto_aufg_diff
	FROM facts_cumulated f
	LEFT OUTER JOIN facts_cumulated vj 
		ON f.mandant_id = vj.mandant_id
			AND f.wup_id = vj.wup_id
			AND f.owg_hist_id = vj.owg_hist_id
			AND f.hwg_hist_id = vj.hwg_hist_id
			AND f.abt_hist_id = vj.abt_hist_id
			AND f.wrg_id = vj.wrg_id
			AND f.inventurart_id = vj.inventurart_id
			AND f.gj - 1 = vj.gj
			AND DATEADD(YEAR, -1, f.dat_inventur_bis) BETWEEN vj.dat_inventur_von AND vj.dat_inventur_bis 
	LEFT OUTER JOIN facts_cumulated vji 
		ON f.mandant_id = vji.mandant_id
			AND f.wup_id = vji.wup_id
			AND f.owg_hist_id = vji.owg_hist_id
			AND f.hwg_hist_id = vji.hwg_hist_id
			AND f.abt_hist_id = vji.abt_hist_id
			AND f.wrg_id = vji.wrg_id
			AND f.inventurart_id IN (2, 3, 4, 5)
			AND vji.inventurart_id = 1 
			AND f.gj - 1 = vji.gj
	),

jahres_beginn_ende AS (
	SELECT DISTINCT gj
		, MIN(dat) OVER (PARTITION BY gj) AS first_day_of_by
		, MAX(dat) OVER (PARTITION BY gj) AS last_day_of_by
	FROM dbp_view.v_tag_2
	),

planning_kpis AS (
	SELECT p.mandant_id
		, p.wup_id
		, p.nb_id
		, p.gj
		, j.first_day_of_by
		, j.last_day_of_by
		, p.inventurart_id
		, p.owg_id 
		, h.hwg_id
		, a.abt_id
		, p.wrg_id
		, p.betrag_vk_netto
		, p.betrag_vk_netto_inventur_diff_plan
	FROM dbp_view.v_inventur_plan_2 p
	LEFT OUTER JOIN  dbp_msi_view_vis.mv_owg_int_2 h 
		ON p.owg_id = h.owg_id 
	LEFT OUTER JOIN dbp_msi_view_vis.mv_hwg_int_2 a 
		ON h.hwg_id = a.hwg_id
	LEFT OUTER JOIN jahres_beginn_ende j
		ON p.gj = j.gj
	)
SELECT COALESCE(f.mandant_id, p.mandant_id) AS mandant_id
	, COALESCE(f.wup_id, p.wup_id) AS wup_id
	, COALESCE(f.owg_hist_id, p.owg_id) AS owg_hist_id
	, COALESCE(f.hwg_hist_id, p.hwg_id) AS hwg_hist_id
	, COALESCE(f.abt_hist_id, p.abt_id) AS abt_hist_id
	, COALESCE(f.wrg_id, p.wrg_id) AS wrg_id
	, COALESCE(f.inventurart_id, p.inventurart_id) AS inventurart_id
	, COALESCE(f.dat_inventur_von, p.first_day_of_by) AS dat_inventur_von
	, COALESCE(f.dat_inventur_bis, p.last_day_of_by) AS dat_inventur_bis 
	, COALESCE(f.gj, p.gj) AS gj
	, f.cnt_inv
	, f.wv_umsatz_netto
	, f.wv_preisabschrift_netto
	, f.wv_totalabschrift_netto
	, f.wv_menge_inventur
	, f.wv_inventur_netto_basis
	, f.wv_inventur_netto_kalk
	, f.wv_inventur_netto
	, f.wv_inventur_diebstahl_netto
	, f.wv_umsatz_netto_aufg
	, f.wv_preisabschrift_netto_aufg
	, f.wv_totalabschrift_netto_aufg
	, f.wv_menge_inventur_aufg
	, f.wv_inventur_netto_aufg
	, f.wv_umsatz_netto_vj_aufg
	, f.wv_preisabschrift_netto_vj_aufg
	, f.wv_totalabschrift_netto_vj_aufg
	, f.wv_menge_inventur_vj_aufg
	, f.wv_inventur_netto_vj_aufg
	, f.wv_umsatz_netto_aufg_diff
	, f.wv_preisabschrift_netto_aufg_diff
	, f.wv_totalabschrift_netto_aufg_diff
	, f.wv_menge_inventur_aufg_diff
	, f.wv_inventur_netto_aufg_diff
	, p.betrag_vk_netto AS betrag_vk_netto_plan
	, p.betrag_vk_netto_inventur_diff_plan
FROM facts_mapped_previous_year f
FULL OUTER JOIN planning_kpis p 
	ON f.mandant_id = p.mandant_id
		AND f.wup_id = p.wup_id
		AND f.gj = p.gj
		AND f.inventurart_id = p.inventurart_id
		AND f.wrg_id = p.wrg_id
		AND f.owg_hist_id = p.owg_id  
;
