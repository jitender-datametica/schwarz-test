create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_VIS.MV_WUP_UMLAGERUNG_1(
	MANDANT_ID COMMENT 'Mandant_1 im DWH',
	WUP_ID COMMENT 'ID des Warenumschlagsplatz der abgebenden bzw. empfangenden Filiale.',
	DAT COMMENT 'Datum der Verarbeitung der Umlagerung_1 bei der abgebenden bzw. empfangenden Filiale. Kann bei verzögerter Verarbeitung in wenigen Fällen vom Kalenderjahr des Beleges abweichen.',
	WRG_ID COMMENT 'Kurzbezeichnung der Währung, z.B. CZK, EUR',
	WA_WUP_ID COMMENT 'ID des Warenumschlagsplatz der abgebenden Filiale',
	WE_WUP_ID COMMENT 'ID des Warenumschlagsplatz der empfangenden Filiale',
	DAT_BUCHUNG_WA COMMENT 'Datum der Verarbeitung der Umlagerung_1 bei der abgebenden Filiale. Kann bei verzögerter Verarbeitung in wenigen Fällen vom Kalenderjahr des Beleges abweichen.',
	DAT_BUCHUNG_WE COMMENT 'Datum der Verarbeitung der Umlagerung_1 bei der empfangenden Filiale. Kann bei verzögerter Verarbeitung in wenigen Fällen vom Kalenderjahr des Beleges abweichen.',
	UMLAGERUNG_STATUS_KZ COMMENT 'Kennzeichen für den Status_1 der Umlagerung_1: W = Wareneingang gebucht, S = Storniert, O = Offen.',
	ANZ_BELEG_POS_WA COMMENT 'Anzahl der Buchungspositionen im Materialbeleg',
	ANZ_BELEG_POS_WE COMMENT 'Anzahl der Buchungspositionen im Materialbeleg',
	VK_BRUTTO_WA COMMENT 'Verkaufswert der Positionen der Umlagerung_1',
	VK_BRUTTO_WE COMMENT 'Verkaufswert der Positionen der Umlagerung_1',
	UML_STAT_STORNIERT_FG COMMENT 'Kennzeichen für stornierte Umlagerungen',
	UML_STAT_OFFEN_FG COMMENT 'Kennzeichen für offene, nicht bestätigte Umlagerungen',
	UML_WERT_GERING_FG COMMENT 'Kennzeichen für Umlagerungen mit einem geringfügigen Nettowert < 100 EUR'
) as







WITH 
uml AS (
	SELECT mandant_id
		, wa_lagerbew_beleg_id
		, wa_lagerbew_beleg_kj
		, wrg_id
		, wa_wup_id
		, we_wup_id
		, dat_buchung_wa
		, dat_buchung_we
		, umlagerung_status_kz
		, anz_beleg_pos
		, vk_brutto
	FROM dbp_view.v_umlagerung_1 
	),
wup_1 AS (
	SELECT mandant_id
		, wup_id
		, aktuell_wup_id
	FROM dbp_view.v_wup_1
	),
fact_aggregation AS (
	SELECT vis.mandant_id
		, wup.aktuell_wup_id AS wup_id
		, vis.dat
		, k.nach_wrg_id AS wrg_id 
		, wa_wup.aktuell_wup_id AS wa_wup_id
		, we_wup.aktuell_wup_id AS we_wup_id
		, COALESCE(wa.dat_buchung_wa, we.dat_buchung_wa) AS dat_buchung_wa
		, COALESCE(wa.dat_buchung_we, we.dat_buchung_we) AS dat_buchung_we
		, COALESCE(wa.umlagerung_status_kz, we.umlagerung_status_kz) AS umlagerung_status_kz
		, SUM(wa.anz_beleg_pos * -1) AS anz_beleg_pos_wa
		, SUM(we.anz_beleg_pos) AS anz_beleg_pos_we
		, SUM(wa.vk_brutto * -1 * k.umrechnungskurs) AS vk_brutto_wa
		, SUM(we.vk_brutto * k.umrechnungskurs) AS vk_brutto_we
	FROM dbp_msi_view_vis.mv_vis_tag_fakt_wup_1 vis
		LEFT OUTER JOIN uml AS wa
			ON vis.mandant_id = wa.mandant_id
				AND vis.wup_id = wa.wa_wup_id
				AND vis.dat = wa.dat_buchung_wa
				AND vis.wrg_id = wa.wrg_id
		LEFT OUTER JOIN uml AS we 
			ON vis.mandant_id = we.mandant_id
				AND vis.wup_id = we.we_wup_id
				AND vis.dat = we.dat_buchung_we
				AND vis.wrg_id = we.wrg_id
		INNER JOIN dbp_data.tag_1 zeit_1 
			ON zeit.dat = vis.dat
		INNER JOIN wup_1 AS wup_1 
			ON vis.mandant_id = wup.mandant_id
				AND vis.wup_id = wup.wup_id
		INNER JOIN wup_1 AS wa_wup 
			ON vis.mandant_id = wa_wup.mandant_id
				AND COALESCE(wa.wa_wup_id, we.wa_wup_id) = wa_wup.wup_id
		INNER JOIN wup_1 AS we_wup 
			ON vis.mandant_id = we_wup.mandant_id
				AND COALESCE(wa.we_wup_id, we.we_wup_id) = we_wup.wup_id
		INNER JOIN dbp_msi_view_vis.mv_kurs_umrechnung_1 k 
			ON vis.wrg_id = k.von_wrg_id
	GROUP BY vis.mandant_id
		, wup.aktuell_wup_id
		, vis.dat
		, k.nach_wrg_id 
		, wa_wup.aktuell_wup_id
		, we_wup.aktuell_wup_id
		, COALESCE(wa.dat_buchung_wa, we.dat_buchung_wa)
		, COALESCE(wa.dat_buchung_we, we.dat_buchung_we)
		, COALESCE(wa.umlagerung_status_kz, we.umlagerung_status_kz)
)
SELECT mandant_id
	, wup_id
	, dat
	, wrg_id
	, wa_wup_id
	, we_wup_id
	, dat_buchung_wa
	, dat_buchung_we
	, umlagerung_status_kz
	, ZEROIFNULL(anz_beleg_pos_wa) AS anz_beleg_pos_wa
	, ZEROIFNULL(anz_beleg_pos_we) AS anz_beleg_pos_we
	, ZEROIFNULL(vk_brutto_wa) AS vk_brutto_wa
	, ZEROIFNULL(vk_brutto_we) AS vk_brutto_we
	, IFF(umlagerung_status_kz = 'S', 1, 0) AS uml_stat_storniert_fg 
	, IFF(umlagerung_status_kz = 'O', 1, 0) AS uml_stat_offen_fg 
	, IFF(wrg_id = 'EUR' AND ABS(vk_brutto_wa) < 100 OR wrg_id <> 'EUR' AND ABS(vk_brutto_wa) * k.umrechnungskurs < 100, 1, 0) AS uml_wert_gering_fg 
FROM fact_aggregation
LEFT OUTER JOIN dbp_msi_view_vis.mv_kurs_umrechnung_1 k 
	ON wrg_id = k.von_wrg_id
		AND k.nach_wrg_id = 'EUR' 
WHERE (anz_beleg_pos_wa <> 0
	OR vk_brutto_wa <> 0
	OR anz_beleg_pos_we <> 0
	OR vk_brutto_we <> 0)
	AND wup_id = wa_wup_id 
;
