CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_ARTB_KU_WOCHE_WUP_SUM 
AS

/*
	FAKT-AGGREGAT DUMMY FWWS pro Woche / Markt
	vorhandene view >> neues Aggregat vis_tag_umsatz_kunde_wup
	2010KW28 Anpassung (inkl 3stellige WG)
	2025-05-23 ssch0611 : Review (keine kum Spalten) [AP0263159]
 */
 
SELECT v01.mandant_id
	, v01.nb_id
	, v01.wup_id
	, v01.wrg_id AS umsatz_wrg
	, v01.kjwo
	, SUM(v01.ums_netto_wvj) AS bv_summe
	, 0.922 * SUM(v01.ums_netto_plan) AS bv_uebern
	, 0.02 * SUM(v01.ums_netto_plan) AS bv_geaendert
	, 0.024 * SUM(v01.ums_netto_plan) AS bv_man_bestell
	, 0.985 * SUM(v01.ums_netto_plan) AS bv_summe_o_aufteiler
	, 0.015 * SUM(v01.ums_netto_plan) AS bv_bestell_aufteiler
	, 0.95 AS uebernahmequote_national
	, 0.9088 AS uebernahmequote_neu_national
	, 0.77 AS autodispoquote_national
	, SUM(v01.ums_netto_plan) AS art_gesamt_anz
	, 0.7 * SUM(v01.ums_netto_plan) AS art_m_dispotag_anz
	, 0.6 * SUM(v01.ums_netto_plan) AS art_autodispo_anz
	, 0.5 * SUM(v01.ums_netto_plan) AS art_autodispo_m_dispotag_anz
	, 0.000673 * SUM(v01.ums_netto_plan) AS zaehlauftrag_anz
	, 0.00058 * SUM(v01.ums_netto_plan) AS zaehlauftrag_gezaehlt_anz
	, 0.8577 AS bearbeitungsquote_national
	, 7.83 ASausnahmen_pro_10000_national
FROM dbp_msi_v_view.v_vis_tag_umsatz_kunde_wup v01

GROUP BY ALL
;