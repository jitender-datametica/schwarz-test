CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_VIS_MONAT_FAKT_ABT(
	MANDANT_ID,
	NB_ID,
	WUP_ID,
	WRG_ID,
	ARTHIERTYP_ID,
	ABT_ID,
	KJMO,
	GJ,
	UMS_NETTO,
	UMS_NETTO_KVJ,
	UMS_NETTO_KVVJ,
	UMS_NETTO_PLAN

) AS

/*
	FAKT-AGGREGAT Umsatz (netto) pro Monat - Markt/Abteilung
	2011KW07 INITIAL
	2011KW37 Review
	2024-06-20 beisswenger : Filialumgliederung + Review [P1760-DWH]
	2025-05-23 ssch0611 : Review (kum Spalten entfernt) [AP0263159]
*/

SELECT v01.mandant_id
	, v01.nb_id
	, wup.aktuell_wup_id	AS wup_id
	, v01.wrg_id
	, v01.arthiertyp_id
	, v01.abt_id
	, v01.kjmo
	, v01.gj
	, v01.ums_netto
	, v01.ums_netto_kvj
	, v01.ums_netto_kvvj
	, v01.ums_netto_plan
FROM dbp_msi_v_view.v_vis_monat_umsatz_abt  v01

INNER JOIN dbp_view.v_wup wup
	ON v01.mandant_id = wup.mandant_id AND v01.wup_id = wup.wup_id
;