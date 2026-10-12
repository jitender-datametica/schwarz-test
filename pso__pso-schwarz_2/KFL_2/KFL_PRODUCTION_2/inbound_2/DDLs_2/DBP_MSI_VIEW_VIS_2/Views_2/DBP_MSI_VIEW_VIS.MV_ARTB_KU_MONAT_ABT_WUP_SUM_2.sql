CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_ARTB_KU_MONAT_ABT_WUP_SUM_2 
AS

/*
	FAKT-AGGREGAT Monat_2 - Abteilung / Markt
	vorhandene view >> neues Aggregat vis_monat_ums_kunde_pers_wup_2
	2009-07-29 Korrektur falsches Mapping TKS/Gastro
	2010KW28 3stellige WG / neues Aggregat
	2025-05-23 ssch0611 : Review (kum Spalten entfernt) [AP0263159]
*/

SELECT v01.mandant_id
	, v01.nb_id
	, v01.wup_id
	, v01.wrg_id	AS umsatz_wrg
	, v01.arthiertyp_id
	, v01.abt_id
	, v01.kjmo
	, v01.ums_netto				AS umsatz_netto
	, v01.ums_netto_kvj			AS umsatz_netto_vj
	, v01.ums_netto_kvvj		AS umsatz_netto_vvj
	, v01.ums_netto_plan		AS umsatz_netto_plan
	, 0.00 AS pers_kosten
	, 0.00 AS pers_kosten_vj
	, 0.00 AS pers_stunden
	, 0.00 AS pers_stunden_vj
	, 0.00 AS pers_stunden_plan
	, 0 AS pers_kranktage
	, 0 AS pers_kranktage_vj
	, 0 AS pers_anz
	, 0 AS pers_anz_vj
	, 0 AS pers_anz_tage
	, 0 AS pers_anz_tage_vj
FROM dbp_msi_v_view.v_vis_monat_umsatz_abt_2 v01
;