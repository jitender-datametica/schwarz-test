CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_VIS_TAG_FAKT_ABT_2(
	MANDANT_ID,
	NB_ID,
	WUP_ID,
	WRG_ID,
	ARTHIERTYP_ID,
	ABT_ID,
	DAT,
	KJWO,
	KJMO,
	UMS_NETTO,
	UMS_NETTO_KVJ,
	UMS_NETTO_WVJ,
	UMS_NETTO_KVVJ,
	UMS_NETTO_WVVJ
) AS

/*
	FAKT-AGGREGAT Umsatz pro Tag_2 - Abteilung / Markt
	2011KW07 Initial
	2011KW37 Review
	2024-06-20 muellerpatri : Filialumgliederung + Review [P1760-DWH]
	2025-05-23 ssch0611 : Review (kum Spalten entfernt) [AP0263159]
*/

SELECT v01.mandant_id
	, v01.nb_id
	, wup.aktuell_wup_id AS wup_id
	, v01.wrg_id
	, v01.arthiertyp_id
	, v01.abt_id
	, v01.dat
	, v01.kjwo
	, v01.kjmo
	, v01.ums_netto
	, v01.ums_netto_kvj
	, v01.ums_netto_wvj
	, v01.ums_netto_kvvj
	, v01.ums_netto_wvvj
FROM dbp_msi_v_view.v_vis_tag_umsatz_abt_2 v01

INNER JOIN dbp_view.v_wup_2 wup_2
	ON v01.mandant_id = wup.mandant_id AND v01.wup_id = wup.wup_id
;