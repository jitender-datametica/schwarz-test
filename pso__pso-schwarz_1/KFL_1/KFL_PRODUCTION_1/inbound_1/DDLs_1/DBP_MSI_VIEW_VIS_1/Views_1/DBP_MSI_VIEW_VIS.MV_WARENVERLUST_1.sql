create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_VIS.MV_WARENVERLUST_1(
	MANDANT_ID COMMENT 'Mandant_1 im DWH',
	WUP_ID COMMENT 'Der \""WUP_1\"" beinhaltet Märkte und Lager. WUP_1 = WarenUmschlagsPlatz. Mutter WUP_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum.',
	ART_ID COMMENT 'Artikelnummer im DWH. Input: Artikel_1-ID einschließlich der Generationen-ID (9-stellig); Output: 7-stellige L&S-ID + Counter = 8-stellige Artikel_1-ID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_1 -> Counter +1.',
	WG_HIST_ID COMMENT 'ID der Warengruppe',
	OWG_HIST_ID COMMENT 'ID der Oberwarengruppe',
	HWG_HIST_ID COMMENT 'ID der Hauptwarengruppe',
	ABT_HIST_ID COMMENT 'Abteilungs-ID, negative Werte: im DWH generierte IDs; positive Werte: aus Stammdatensystem übernommen.',
	WRG_ID COMMENT 'Kurzbezeichnung der Währung, z.B. CZK, EUR',
	INVENTURART_ID COMMENT 'Inventurarten aus SAP. Unterscheidung, ob bsp. Jahres-, Frische- oder Sonderinventur. Siehe Inventurart_spr_zu.',
	DAT_INVENTUR_VON COMMENT 'Start des betrachteten Inventurzeitraums. Dieser Zeitraum unterliegt keiner festen zeitlichen Größe und kann sich je Land_1 unterscheiden.',
	DAT_INVENTUR_BIS COMMENT 'Ende des betrachteten Inventurzeitraums. Dieser Zeitraum unterliegt keiner festen zeitlichen Größe und kann sich je Land_1 unterscheiden.',
	GJ COMMENT 'Geschäftsjahr, dem Inventurzeitraum zugeordnet werden soll. 28.02.2024 kann beispielsweise in der Betrachtung zum Inventurzeitraum des GJ 2024 statt 2023 gehören.',
	INVENTUR_ID COMMENT 'Eindeutige hochgezählte Nummer über alle Felder des Excel-Uploads',
	WV_UMSATZ_NETTO COMMENT 'Umsatz der betroffenen Inventur_1-Artikel_1 im definierten Inventur_1-Zeitraum je Betrieb',
	WV_PREISABSCHRIFT_NETTO COMMENT 'Wert der Preisabschriften für die betroffenen Inventur_1-Artikel_1 im definierten Inventur_1-Zeitraum je Betrieb',
	WV_TOTALABSCHRIFT_NETTO COMMENT 'Wert der Totalabschriften für die betroffenen Inventur_1-Artikel_1 im definierten Inventur_1-Zeitraum je Betrieb',
	WV_INVENTUR_NETTO COMMENT 'Saldierte Inventur_1-Differenz-Werte je Artikel_1 und Betrieb im definierten Inventur_1-Zeitraum',
	WV_MENGE_INVENTUR COMMENT 'Saldierte Inventur_1-Differenz-Mengen je Artikel_1 und Betrieb im definierten Inventur_1-Zeitraum',
	WV_INVENTUR_DIEBSTAHL_NETTO COMMENT 'Betrag Diebstahl als Teilmenge der Inventur_1-Differenz-Werten',
	WV_UMSATZ_NETTO_AUFG COMMENT 'Aufgelaufener Umsatz der betroffenen Inventur_1-Artikel_1 im definierten Inventur_1-Zeitraum je Betrieb',
	WV_PREISABSCHRIFT_NETTO_AUFG COMMENT 'Aufgelaufener Wert der Preisabschriften für die betroffenen Inventur_1-Artikel_1 im definierten Inventur_1-Zeitraum je Betrieb',
	WV_TOTALABSCHRIFT_NETTO_AUFG COMMENT 'Aufgelaufener Wert der Totalabschriften für die betroffenen Inventur_1-Artikel_1 im definierten Inventur_1-Zeitraum je Betrieb',
	WV_INVENTUR_NETTO_AUFG COMMENT 'Aufgelaufene Saldierte Inventur_1-Differenz-Werte je Artikel_1 und Betrieb im definierten Inventur_1-Zeitraum',
	WV_MENGE_INVENTUR_AUFG COMMENT 'Aufgelaufene Saldierte Inventur_1-Differenz-Mengen je Artikel_1 und Betrieb im definierten Inventur_1-Zeitraum',
	WV_INVENTUR_DIEBSTAHL_NETTO_AUFG COMMENT 'Aufgelaufener Betrag Diebstahl als Teilmenge der Inventur_1-Differenz-Werten'
) as






WITH 

inventur_warenverlust_1 AS (
	SELECT mandant_id
		, inventur_id
		, wup_id
		, nb_id
		, inventurart_id
		, dat_inventur_von 
		, dat_inventur_bis
		, dat_inventur_buchung_von
		, dat_inventur_buchung_bis
		, gj
		, art_id
		, wg_id
		, owg_id
		, hwg_id
		, abt_id
		, loesch_fg	
		
		, IFF(ROW_NUMBER() OVER (
			PARTITION BY mandant_id, wup_id, abt_id, hwg_id, owg_id, wg_id, art_id, gj, inventurart_id
			ORDER BY dat_inventur_bis
			) = 1, 1, 0) AS first_row_fg 
		, DATEADD(DAY, 1, LAG(DAT_INVENTUR_BIS) IGNORE NULLS OVER (
			PARTITION BY mandant_id, wup_id, abt_id, hwg_id, owg_id, wg_id, art_id, gj, inventurart_id
			ORDER BY dat_inventur_bis
			)) AS dat_inventur_von_calc 
		, IFF(first_row_fg = 0 AND dat_inventur_von <> dat_inventur_von_calc, dat_inventur_von_calc, dat_inventur_von) AS dat_inventur_von_corr 
		
		
		
	FROM dbp_view.v_inventur_warenverlust_1 
	
	),
kumulation AS (
	SELECT w.mandant_id
		, wup.aktuell_wup_id AS wup_id
		, wd.art_id
		, wg.wg_id AS wg_hist_id
		, owg.owg_id AS owg_hist_id
		, hwg.hwg_id AS hwg_hist_id
		, hwg.abt_id AS abt_hist_id
		, k.nach_wrg_id AS wrg_id
		, w.inventurart_id 
		, w.dat_inventur_von_corr AS dat_inventur_von 
		, w.dat_inventur_bis
		, w.gj
		, w.inventur_id
		, wd.betrag_vk_netto * k.umrechnungskurs 							AS wv_umsatz_netto
		, wd.betrag_vk_netto_preisabschrift * k.umrechnungskurs 			AS wv_preisabschrift_netto
		, wd.betrag_vk_netto_totalabschrift * k.umrechnungskurs 			AS wv_totalabschrift_netto
		, wd.betrag_vk_netto_inventur_diff * k.umrechnungskurs 				AS wv_inventur_netto
		, wd.menge_inventur_diff 											AS wv_menge_inventur
		, wd.betrag_vk_netto_inventur_diff_diebstahl * k.umrechnungskurs 	AS wv_inventur_diebstahl_netto
		
		, SUM(ZEROIFNULL(wv_umsatz_netto)) OVER (
			PARTITION BY w.mandant_id, wup.aktuell_wup_id, k.nach_wrg_id, hwg.abt_id, hwg.hwg_id, owg.owg_id, wg.wg_id, wd.art_id, w.gj, w.inventurart_id 
			ORDER BY w.dat_inventur_bis ASC ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
			) AS wv_umsatz_netto_aufg
		, SUM(ZEROIFNULL(wv_preisabschrift_netto)) OVER (
			PARTITION BY w.mandant_id, wup.aktuell_wup_id, k.nach_wrg_id, hwg.abt_id, hwg.hwg_id, owg.owg_id, wg.wg_id, wd.art_id, w.gj, w.inventurart_id 
			ORDER BY w.dat_inventur_bis ASC ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
			) AS wv_preisabschrift_netto_aufg
		, SUM(ZEROIFNULL(wv_totalabschrift_netto)) OVER (
			PARTITION BY w.mandant_id, wup.aktuell_wup_id, k.nach_wrg_id, hwg.abt_id, hwg.hwg_id, owg.owg_id, wg.wg_id, wd.art_id, w.gj, w.inventurart_id 
			ORDER BY w.dat_inventur_bis ASC ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
			) AS wv_totalabschrift_netto_aufg
		, SUM(ZEROIFNULL(wv_inventur_netto)) OVER (
			PARTITION BY w.mandant_id, wup.aktuell_wup_id, k.nach_wrg_id, hwg.abt_id, hwg.hwg_id, owg.owg_id, wg.wg_id, wd.art_id, w.gj, w.inventurart_id 
			ORDER BY w.dat_inventur_bis ASC ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
			) AS wv_inventur_netto_aufg
		, SUM(ZEROIFNULL(wv_menge_inventur)) OVER (
			PARTITION BY w.mandant_id, wup.aktuell_wup_id, k.nach_wrg_id, hwg.abt_id, hwg.hwg_id, owg.owg_id, wg.wg_id, wd.art_id, w.gj, w.inventurart_id 
			ORDER BY w.dat_inventur_bis ASC ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
			) AS wv_menge_inventur_aufg
		, SUM(ZEROIFNULL(wv_inventur_diebstahl_netto)) OVER (
			PARTITION BY w.mandant_id, wup.aktuell_wup_id, k.nach_wrg_id, hwg.abt_id, hwg.hwg_id, owg.owg_id, wg.wg_id, wd.art_id, w.gj, w.inventurart_id 
			ORDER BY w.dat_inventur_bis ASC ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
			) AS wv_inventur_diebstahl_netto_aufg
	FROM inventur_warenverlust_1 w 
	INNER JOIN dbp_view.v_inventur_warenverlust_det_1 wd
		ON w.mandant_id = wd.mandant_id
			AND w.inventur_id = wd.inventur_id
	INNER JOIN dbp_view.v_wup_1 wup_1 
		ON w.mandant_id = wup.mandant_id
			AND w.wup_id = wup.wup_id
	INNER JOIN dbp_view.v_art_1 a 
		ON w.mandant_id = a.mandant_id
			AND wd.art_id = a.art_id
	INNER JOIN dbp_data.art_wg_zu_per_1 wgart 
		ON w.mandant_id = wgart.mandant_id
			AND wd.art_id = wgart.art_id
			AND w.dat_inventur_bis BETWEEN wgart.dat_von AND wgart.dat_bis
			AND wgart.arthiertyp_id = 2
	INNER JOIN dbp_data.wg_per_1 wg 
		ON wgart.mandant_id = wg.mandant_id
			AND wgart.wg_id = wg.wg_id
			AND w.dat_inventur_bis BETWEEN wg.dat_von AND wg.dat_bis
			AND wg.arthiertyp_id = 2
	INNER JOIN dbp_data.owg_per_1 owg 
		ON wgart.mandant_id = owg.mandant_id
			AND owg.owg_id = wg.owg_id
			AND w.dat_inventur_bis BETWEEN owg.dat_von AND owg.dat_bis
			AND owg.arthiertyp_id = 2
	INNER JOIN dbp_data.hwg_per_1 hwg 
		ON wgart.mandant_id = hwg.mandant_id
			AND hwg.hwg_id = owg.hwg_id
			AND w.dat_inventur_bis BETWEEN hwg.dat_von AND hwg.dat_bis
			AND hwg.arthiertyp_id = 2
	INNER JOIN dbp_msi_view_vis.mv_kurs_umrechnung_1 k 
		ON k.von_wrg_id = wd.wrg_id
	WHERE w.loesch_fg = 0
	)
SELECT mandant_id
	, wup_id
	, art_id
	, wg_hist_id
	, owg_hist_id
	, hwg_hist_id
	, abt_hist_id
	, wrg_id
	, inventurart_id
	, dat_inventur_von
	, dat_inventur_bis
	, gj
	, inventur_id
	, wv_umsatz_netto
	, wv_preisabschrift_netto
	, wv_totalabschrift_netto
	, wv_inventur_netto
	, wv_menge_inventur
	, wv_inventur_diebstahl_netto
	, wv_umsatz_netto_aufg
	, wv_preisabschrift_netto_aufg
	, wv_totalabschrift_netto_aufg
	, wv_inventur_netto_aufg
	, wv_menge_inventur_aufg
	, wv_inventur_diebstahl_netto_aufg
FROM kumulation 
;
