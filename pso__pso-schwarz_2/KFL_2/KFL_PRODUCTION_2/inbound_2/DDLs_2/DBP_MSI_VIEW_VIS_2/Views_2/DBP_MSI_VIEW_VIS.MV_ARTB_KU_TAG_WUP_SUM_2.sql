CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_ARTB_KU_TAG_WUP_SUM_2 
AS

/* 
	FAKT-AGGREGAT Umsatz / Kunde pro Tag_2 - Markt
	vorhandene view >> neues Aggregat vis_tag_ums_kundewup
	Datenumfang: 5 GJ
	2010KW28 Anpassung (inkl 3stellige WG)
	2025-05-07 kum Spalten entfernt
*/

SELECT v01.mandant_id
, v01.nb_id
, v01.wup_id
, v01.wrg_id              AS umsatz_wrg
, v01.dat
, v01.kjwo
, v01.kjmo
, v01.ums_netto           AS umsatz_netto
, v01.ums_netto_wvj       AS umsatz_netto_vj
, v01.ums_netto_wvvj      AS umsatz_netto_vvj
, v01.ums_netto_kvj       AS umsatz_netto_kvj
, v01.ums_netto_kvvj      AS umsatz_netto_kvvj
, v01.ums_netto_plan      AS umsatz_netto_plan
, v01.anz_kunde           AS kunde_anz
, v01.anz_kunde_wvj       AS kunde_anz_vj
, v01.anz_kunde_kvj       AS kunde_anz_kvj
, v01.anz_offen           AS offen_anz
, v01.anz_offen_wvj       AS offen_anz_vj
, v01.anz_offen_wvvj      AS offen_anz_vvj
, v01.anz_offen_kvj       -- NEUE SPALTE
, v01.anz_offen_kvvj      -- NEUE SPALTE

, ums_netto_plan          AS bv_summe
, 0.922 * ums_netto_plan  AS bv_uebern
, 0.02 * ums_netto_plan   AS bv_geaendert
, 0.024 * ums_netto_plan  AS bv_man_bestell
, 0.985 * ums_netto_plan  AS bv_summe_o_aufteiler
, 0.015 * ums_netto_plan  AS bv_bestell_aufteiler
, 0.95                    AS uebernahmequote_national
, 0.9088                  AS uebernahmequote_neu_national
, 0.77                    AS autodispoquote_national

, ums_netto_plan          AS art_gesamt_anz
, 0.7 * ums_netto_plan    AS art_m_dispotag_anz
, 0.6 * ums_netto_plan    AS art_autodispo_anz
, 0.5 * ums_netto_plan    AS art_autodispo_m_dispotag_anz
, 0.000673 * ums_netto_plan AS zaehlauftrag_anz
, 0.00058 * ums_netto_plan  AS zaehlauftrag_gezaehlt_anz
, 0.8577                    AS bearbeitungsquote_national
, 7.83                      AS ausnahmen_pro_10000_national
-- Dummy_2 FWWS

FROM dbp_msi_v_view.v_vis_tag_umsatz_kunde_wup_2 v01
;