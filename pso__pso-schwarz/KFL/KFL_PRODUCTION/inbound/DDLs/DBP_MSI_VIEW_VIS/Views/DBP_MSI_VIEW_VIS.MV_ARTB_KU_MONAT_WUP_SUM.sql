CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_ARTB_KU_MONAT_WUP_SUM
AS

/*
	FAKT-AGGREGAT Umsatz /Kunde / Personal pro Monat - Markt
	vorhandene view >> neues Aggregat vis_monat_ums_kunde_pers_wup
	2010KW07 Review
	2010KW28 3stellige WG / neues Aggregat
	2025-05-23 ssch0611 : Review (kum Spalten entfernt) [AP0263159]
*/

SELECT v01.mandant_id
	, v01.nb_id
	, v01.wup_id
	, v01.kjmo
	, v01.wrg_id AS umsatz_wrg
	, v01.ums_netto AS umsatz_netto
	, v01.ums_netto_kvj AS umsatz_netto_vj
	, v01.ums_netto_kvvj AS umsatz_netto_vvj
	, v01.ums_netto_plan AS umsatz_netto_plan
	, v01.anz_kunde AS kunde_anz
	, v01.anz_kunde_kvj AS kunde_anz_vj
	, v01.anz_offen AS offen_anz
	, v01.anz_offen_kvj AS offen_anz_vj
	, v01.anz_offen_kvvj AS offen_anz_vvj
	, v01.anz_kunde_kvvj -- NEUE SPALTE
	, v01.pers_kosten AS pk_ker
	, v01.pers_kosten_kvj AS pk_ker_vj
	, v01.pers_kosten_plan AS pk_ker_plan
	, v01.rohertrag AS rohertrag
	, v01.rohertrag_kvj AS rohertrag_vj
	, v01.rohertrag_plan AS rohertrag_plan
	, v01.pers_std AS pers_stunden
	, v01.pers_std_plan AS pers_stunden_plan
	, v01.pers_std_kvj AS pers_stunden_vj
	, v01.pers_auq AS pers_kranktage
	, v01.pers_auq_kvj AS pers_kranktage_vj
	, CASE WHEN v01.pers_auq <> 0 THEN 1 ELSE 0 END AS pers_anz
	, CASE WHEN v01.pers_auq_kvj <> 0 THEN 1 ELSE 0 END AS pers_anz_vj
	, v01.pers_fluq AS pers_austritte
	, v01.pers_fluq_kvj AS pers_austritte_vj
	, CASE WHEN v01.pers_fluq <> 0 THEN 1 ELSE 0 END AS pers_anz_tage
	, CASE WHEN v01.pers_fluq_kvj <> 0 THEN 1 ELSE 0 END AS pers_anz_tage_vj
	, v01.ums_netto AS ums_n_ker
	, v01.ums_netto_plan AS ums_n_ker_plan
	, v01.ums_netto_kvj AS ums_n_ker_vj
	, v01.ums_netto_kvvj AS ums_n_ker_vvj
	, v01.pers_kosten AS pers_kosten
	, v01.pers_kosten_kvj AS pers_kosten_vj
	, 0.00 AS pk_ker_vvj
	, 0.00 AS rohertrag_vvj
	, CASE WHEN v01.ums_netto_plan = 0 THEN 1 ELSE (0.9 * v01.ums_netto_plan) / v01.ums_netto_plan END AS buchungsquote
	, 0.9488 AS buchungsquote_national
	, 0.0074 * v01.anz_kunde_kvj AS we_nicht_gemeldet_anz
	, v01.anz_kunde_kvj AS we_geb_rechnung_anz
	, 0.0055 AS we_quote_national
	, 0.0157 * v01.anz_kunde_kvj AS wa_nicht_gemeldet_anz
	, v01.anz_kunde_kvj AS wa_geb_gutschrift_anz
	, 0.017 AS wa_quote_national
FROM dbp_msi_v_view.v_vis_monat_ums_kunde_pers_wup v01
;