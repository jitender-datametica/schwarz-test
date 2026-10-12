CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_ARTB_KU_TAG_MANDANT_SUM 
AS

/*
	FAKT-AGGREGAT Umsatz / Kunde pro NB / Mandant
	vorhandene view >> neues Aggregat vis_tag_ums_kunde_wup
	Datenumfang: 5 GJ
	2010KW28 Anpassung (inkl 3stellige WG)
	2025-05-08 kum Spalten entfernt
*/

SELECT v01.mandant_id
	, v01.nb_id
	, v01.wrg_id              AS umsatz_wrg
	, v01.dat
	, v01.kjmo
	, v01.kjwo
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
	, v01.anz_offen_kvj       AS anz_offen_kvj
	, v01.anz_offen_kvvj      AS anz_offen_kvvj
FROM dbp_msi_v_view.v_vis_tag_umsatz_kunde_wup v01
;