CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_ARTB_KU_TAG_WG_WUP_SUM_2 
AS

/*
	FAKT-AGGREGAT Umsatz / Kunde pro Tag_2 - WG / Markt
	vorhandene view >> neues Aggregat vis_tag_umsatz_wg_2
	2010KW28 Anpassung (inkl 3stellige WG)
	2025-05-08 kum Spalten entfernt
*/

SELECT v01.mandant_id
	, v01.nb_id
	, v01.wup_id
	, v01.wrg_id              AS umsatz_wrg
	, v01.arthiertyp_id
	, v01.wg_id
	, v01.dat
	, v01.kjwo
	, v01.kjmo
	, v01.ums_netto           AS umsatz_netto
	, v01.ums_netto_wvj       AS umsatz_netto_vj
	, v01.ums_netto_wvvj      AS umsatz_netto_vvj
	, v01.ums_netto_kvj       AS umsatz_netto_kvj
	, v01.ums_netto_kvvj      AS umsatz_netto_kvvj

FROM dbp_msi_v_view.v_vis_tag_umsatz_wg_2 v01
;