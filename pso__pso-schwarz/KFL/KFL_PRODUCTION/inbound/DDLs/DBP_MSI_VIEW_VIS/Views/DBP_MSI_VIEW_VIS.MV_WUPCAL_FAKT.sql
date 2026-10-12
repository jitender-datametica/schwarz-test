CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_WUPCAL_FAKT (
	MANDANT_ID,
	NB_ID,
	WUP_ID,
	DAT,
	WRG_ID,
	KUNDEN_GESAMT_IST,
	KUNDEN_GESAMT_WVJ,
	KUNDEN_GESAMT_KVJ,
	KUNDEN_KCARD_IST,
	KUNDEN_KCARD_WVJ,
	KUNDEN_KCARD_KVJ,
	BONANZAHL_KUNDENKARTE_PAYBACK,
	BONANZAHL_KUNDENKARTE,
	BONANZAHL_FRISCHETHEKE_OHNE_FISCH,
	BONANZAHL,
	BONANZAHL_IMBISS,
	UMSATZ_BRUTTO_ODS_VERKAUF,
	UMSATZ_BRUTTO_ODS_KASSENABSCHLUSS,
	UMSATZ_NETTO_KCARD_IST COMMENT 'Umsatz netto mit Kaufland Loyalty Programm (kundenkarte_typ_id =2) auf Markt- und Tagebene - Ist',
	UMSATZ_NETTO_KCARD_KVJ COMMENT 'Umsatz netto mit Kaufland Loyalty Programm (kundenkarte_typ_id =2) auf Markt- und Tagebene - VJ zum Kalendertagsvergleich',
	UMSATZ_NETTO_KCARD_WVJ COMMENT 'Umsatz netto mit Kaufland Loyalty Programm (kundenkarte_typ_id =2) auf Markt- und Tagebene - VJ zum Wochentagsvergleich'
	) COMMENT = 'Marktkalender mit Ereignissen für Bonanzahl, Datenlieferung und Umsatz auf Basis von Ist, KT und WT'
AS 
/*
2025-08-06 tekin: Added column BETRAG_VK_NETTO_KUNDENKARTE for K Card Umsatzanteil
2025-08-12 tekin: added wrg_id and lookups for current store and exchange rate
*/
WITH 
wc AS (
	SELECT wcal.mandant_id
		, wcal.nb_id
		, wup.aktuell_wup_id AS wup_id
		, wcal.dat
		, wcal.wrg_id
		, bonanzahl_sug
		, bonanzahl_kundenkarte
		, bonanzahl_kundenkarte_payback
		, bonanzahl
		, bonanzahl_imbiss
		, bonanzahl_frischetheke_ohne_fisch
		, umsatz_brutto_ods_verkauf
		, umsatz_brutto_ods_kassenabschluss
		, betrag_vk_netto_kundenkarte
	FROM dbp_view.v_wupcal wcal -- PRIMARY KEY (mandant_id, wup_id, nb_id, dat)
	INNER JOIN dbp_view.v_wup wup
		ON wup.mandant_id = wcal.mandant_id
			AND wup.wup_id = wcal.wup_id
	)
SELECT
	wc_ist.mandant_id
	, wc_ist.nb_id
	, wc_ist.wup_id
	, wc_ist.dat
	, k.nach_wrg_id AS wrg_id
	/* Offizielle Kunden Filiale */
	, wc_ist.bonanzahl_sug AS kunden_gesamt_ist
	, wc_wvj.bonanzahl_sug AS kunden_gesamt_wvj
	, wc_kvj.bonanzahl_sug AS kunden_gesamt_kvj
	/* Kunden mit K-Card */
	, wc_ist.bonanzahl_kundenkarte - ZEROIFNULL(wc_ist.bonanzahl_kundenkarte_payback) AS kunden_kcard_ist
	, wc_wvj.bonanzahl_kundenkarte - ZEROIFNULL(wc_wvj.bonanzahl_kundenkarte_payback) AS kunden_kcard_wvj
	, wc_kvj.bonanzahl_kundenkarte - ZEROIFNULL(wc_kvj.bonanzahl_kundenkarte_payback) AS kunden_kcard_kvj
	/* Historie Payback / Kundenkarte */
	, wc_ist.bonanzahl_kundenkarte_payback
	, wc_ist.bonanzahl_kundenkarte
	/* Bons/Kunden Frischetheken (ohne Fisch) - Filialwettbewerb Theke */
	, wc_ist.bonanzahl_frischetheke_ohne_fisch
	/* Objekte Kassenabschluss (EOD) - nicht geprüft*/
	/* Bonanzahl (Gesamt) ungefiltert */
	, wc_ist.bonanzahl
	/* Bons/Kunden Imbiss */
	, wc_ist.bonanzahl_imbiss
	/* Umsatz (ODS) ohne WRG?! */
	, wc_ist.umsatz_brutto_ods_verkauf * k.umrechnungskurs AS umsatz_brutto_ods_verkauf
	, wc_ist.umsatz_brutto_ods_kassenabschluss * k.umrechnungskurs AS umsatz_brutto_ods_kassenabschluss
	, wc_ist.betrag_vk_netto_kundenkarte * k.umrechnungskurs AS umsatz_netto_kcard_ist
	, wc_kvj.betrag_vk_netto_kundenkarte * k.umrechnungskurs AS umsatz_netto_kcard_kvj
	, wc_wvj.betrag_vk_netto_kundenkarte * k.umrechnungskurs AS umsatz_netto_kcard_wvj
FROM wc AS wc_ist
LEFT JOIN wc AS wc_wvj
	ON wc_wvj.mandant_id = wc_ist.mandant_id 
		AND wc_wvj.wup_id = wc_ist.wup_id
		AND wc_wvj.dat = wc_ist.dat - 364
LEFT JOIN wc AS wc_kvj
	ON wc_kvj.mandant_id = wc_ist.mandant_id 
		AND wc_kvj.wup_id = wc_ist.wup_id
		AND wc_kvj.dat = ADD_MONTHS(wc_ist.dat, -12)
INNER JOIN dbp_msi_view_vis.mv_kurs_umrechnung k -- convert local currency to EUR 
	ON wc_ist.wrg_id = k.von_wrg_id
;

