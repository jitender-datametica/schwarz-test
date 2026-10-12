CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_ARTB_KU_MONAT_WG_WUP_SUM_2
AS

/*
	FAKT-AGGREGAT Monat_2 - Warengruppe / Markt
	vorhandene view >> neues Aggregat vis_monat_ums_wg
	2010KW28 Anpassung (inkl 3stellige WG)
	2025-05-23 ssch0611 : Review (kum Spalten entfernt) [AP0263159]
*/

SELECT v01.mandant_id
	, v01.nb_id
	, v01.wup_id
	, v01.wrg_id AS umsatz_wrg
	, v01.arthiertyp_id
	, v01.wg_id
	, v01.kjmo
	, v01.ums_netto AS umsatz_netto
	, v01.ums_netto_kvj AS umsatz_netto_vj
	, v01.ums_netto_kvvj AS umsatz_netto_vvj
FROM dbp_msi_v_view.v_vis_monat_umsatz_wg_2 v01
;