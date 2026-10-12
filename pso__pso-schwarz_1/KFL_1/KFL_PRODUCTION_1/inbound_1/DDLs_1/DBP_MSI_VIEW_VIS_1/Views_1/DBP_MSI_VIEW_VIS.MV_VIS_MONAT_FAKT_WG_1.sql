create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_VIS.MV_VIS_MONAT_FAKT_WG_1(
	MANDANT_ID,
	NB_ID,
	WUP_ID,
	WRG_ID,
	ARTHIERTYP_ID,
	ABT_ID,
	WG_ID,
	KJMO,
	GJ,
	UMS_NETTO,
	UMS_NETTO_KVJ,
	UMS_NETTO_KVVJ,
	UMS_BRUTTO,
	UMS_BRUTTO_KVJ,
	MENGE,
	MENGE_KVJ,
	MENGE_KVVJ
) as










SELECT v01.mandant_id
	, v01.nb_id
	, wup.aktuell_wup_id	AS wup_id
	, v01.wrg_id
	, v01.arthiertyp_id
	, v01.abt_id
	, v01.wg_id
	, v01.kjmo
	, v01.gj
	, v01.ums_netto
	, v01.ums_netto_kvj
	, v01.ums_netto_kvvj
	, v01.ums_brutto
	, v01.ums_brutto_kvj
	, v01.menge_absatz		AS menge
	, v01.menge_absatz_kvj	AS menge_kvj
	, v01.menge_absatz_kvvj	AS menge_kvvj
FROM dbp_msi_v_view.v_vis_monat_umsatz_wg_1  v01

INNER JOIN dbp_view.v_wup_1 wup_1
	ON v01.mandant_id = wup.mandant_id AND v01.wup_id = wup.wup_id
;
