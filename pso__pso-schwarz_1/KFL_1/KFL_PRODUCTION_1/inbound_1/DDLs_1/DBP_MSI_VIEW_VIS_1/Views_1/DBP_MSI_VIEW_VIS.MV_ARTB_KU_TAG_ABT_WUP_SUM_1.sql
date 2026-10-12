CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_ARTB_KU_TAG_ABT_WUP_SUM_1 
AS

/*
	FAKT-AGGREGAT Umsatz / Kunde pro Tag_1 - Abteilung / Markt
	vorhandene view >> neues Aggregat vis_tag_umsatz_wg_1
	2010KW28 Anpassung (inkl 3stellige WG)
	04.10.2010 AL: Quelltabelle von vis_tag_umsatz_wg_1 auf vis_tag_umsatz_abt_1 umgestellt
	2025-05-23 ssch0611 : Review (kum Spalten entfernt) [AP0263159]
*/

SELECT v01.mandant_id
	, v01.nb_id
	, v01.wup_id
	, v01.wrg_id AS umsatz_wrg
	, v01.arthiertyp_id
	, v01.abt_id
	, v01.dat
	, v01.kjmo
	, v01.kjwo
	, v01.ums_netto AS umsatz_netto
	, v01.ums_netto_wvj AS umsatz_netto_vj
	, v01.ums_netto_wvvj AS umsatz_netto_vvj
	, v01.ums_netto_kvj AS umsatz_netto_kvj
	, v01.ums_netto_kvvj AS umsatz_netto_kvvj
FROM dbp_msi_v_view.v_vis_tag_umsatz_abt_1 v01
;