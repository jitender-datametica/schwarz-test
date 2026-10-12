create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_VIS.MV_VIS_TAG_FAKT_WG(
	MANDANT_ID,
	NB_ID,
	WUP_ID,
	WRG_ID,
	ARTHIERTYP_ID,
	ABT_ID,
	WG_ID,
	DAT,
	KJWO,
	KJMO,
	GJ,
	UMS_NETTO,
	UMS_NETTO_KVJ,
	UMS_NETTO_KVVJ,
	UMS_NETTO_WVJ,
	UMS_NETTO_WVVJ,
	UMS_NETTO_AF COMMENT 'Umsatz Netto Aktionsfrei',
	UMS_NETTO_AF_KVJ COMMENT 'Umsatz Netto Aktionsfrei zum VJ (Kalendertagsvergleich)',
	UMS_NETTO_AF_KVVJ COMMENT 'Umsatz Netto Aktionsfrei zum VVJ (Kalendertagsvergleich)',
	UMS_NETTO_AF_WVJ COMMENT 'Umsatz Netto Aktionsfrei zum VJ (Wochentagsvergleich)',
	UMS_NETTO_AF_WVVJ COMMENT 'Umsatz Netto Aktionsfrei zum VVJ (Wochentagsvergleich)',
	UMS_NETTO_AF_KVJ_ABW COMMENT 'Abweichung Umsatz Netto Aktionsfrei zum VJ (Kalendertagsvergleich)',
	UMS_NETTO_AF_KVVJ_ABW COMMENT 'Abweichung Umsatz Netto Aktionsfrei zum VVJ (Kalendertagsvergleich)',
	UMS_NETTO_AF_WVJ_ABW COMMENT 'Abweichung Umsatz Netto Aktionsfrei zum VJ (Wochentagsvergleich)',
	UMS_NETTO_AF_WVVJ_ABW COMMENT 'Abweichung Umsatz Netto Aktionsfrei zum VVJ (Wochentagsvergleich)',
	UMS_NETTO_SA COMMENT 'Umsatz Netto Sonderaktion',
	UMS_NETTO_SA_KVJ COMMENT 'Umsatz Netto Sonderaktion zum VJ (Kalendertagsvergleich)',
	UMS_NETTO_SA_KVVJ COMMENT 'Umsatz Netto Sonderaktion zum VVJ (Kalendertagsvergleich)',
	UMS_NETTO_SA_WVJ COMMENT 'Umsatz Netto Sonderaktion zum VJ (Wochentagsvergleich)',
	UMS_NETTO_SA_WVVJ COMMENT 'Umsatz Netto Sonderaktion zum VVJ (Wochentagsvergleich)',
	UMS_NETTO_SA_KVJ_ABW COMMENT 'Abweichung Umsatz Netto Sonderaktion zum VJ (Kalendertagsvergleich)',
	UMS_NETTO_SA_KVVJ_ABW COMMENT 'Abweichung Umsatz Netto Sonderaktion zum VVJ (Kalendertagsvergleich)',
	UMS_NETTO_SA_WVJ_ABW COMMENT 'Abweichung Umsatz Netto Sonderaktion zum VJ (Wochentagsvergleich)',
	UMS_NETTO_SA_WVVJ_ABW COMMENT 'Abweichung Umsatz Netto Sonderaktion zum VVJ (Wochentagsvergleich)',
	UMS_BRUTTO,
	UMS_BRUTTO_KVJ,
	UMS_BRUTTO_KVVJ,
	UMS_BRUTTO_WVJ,
	UMS_BRUTTO_WVVJ,
	MENGE,
	MENGE_KVJ,
	MENGE_KVVJ,
	MENGE_WVJ,
	MENGE_WVVJ,
	MENGE_AF COMMENT 'Menge abverkaufter Artikel Aktionsfrei',
	MENGE_AF_KVJ COMMENT 'Menge abverkaufter Artikel Aktionsfrei zum VJ (Kalendertagsvergleich)',
	MENGE_AF_KVVJ COMMENT 'Menge abverkaufter Artikel Aktionsfrei zum VVJ (Kalendertagsvergleich)',
	MENGE_AF_WVJ COMMENT 'Menge abverkaufter Artikel Aktionsfrei zum VJ (Wochentagsvergleich)',
	MENGE_AF_WVVJ COMMENT 'Menge abverkaufter Artikel Aktionsfrei zum VVJ (Wochentagsvergleich)',
	MENGE_AF_KVJ_ABW COMMENT 'Abweichung Menge abverkaufter Artikel Aktionsfrei zum VJ (Kalendertagsvergleich)',
	MENGE_AF_KVVJ_ABW COMMENT 'Abweichung Menge abverkaufter Artikel Aktionsfrei zum VVJ (Kalendertagsvergleich)',
	MENGE_AF_WVJ_ABW COMMENT 'Abweichung Menge abverkaufter Artikel Aktionsfrei zum VJ (Wochentagsvergleich)',
	MENGE_AF_WVVJ_ABW COMMENT 'Abweichung Menge abverkaufter Artikel Aktionsfrei zum VVJ (Wochentagsvergleich)',
	MENGE_SA COMMENT 'Menge abverkaufter Artikel Sonderaktion',
	MENGE_SA_KVJ COMMENT 'Menge abverkaufter Artikel Sonderaktion zum VJ (Kalendertagsvergleich)',
	MENGE_SA_KVVJ COMMENT 'Menge abverkaufter Artikel Sonderaktion zum VVJ (Kalendertagsvergleich)',
	MENGE_SA_WVJ COMMENT 'Menge abverkaufter Artikel Sonderaktion zum VJ (Wochentagsvergleich)',
	MENGE_SA_WVVJ COMMENT 'Menge abverkaufter Artikel Sonderaktion zum VVJ (Wochentagsvergleich)',
	MENGE_SA_KVJ_ABW COMMENT 'Abweichung Menge abverkaufter Artikel Sonderaktion zum VJ (Kalendertagsvergleich)',
	MENGE_SA_KVVJ_ABW COMMENT 'Abweichung Menge abverkaufter Artikel Sonderaktion zum VVJ (Kalendertagsvergleich)',
	MENGE_SA_WVJ_ABW COMMENT 'Abweichung Menge abverkaufter Artikel Sonderaktion zum VJ (Wochentagsvergleich)',
	MENGE_SA_WVVJ_ABW COMMENT 'Abweichung Menge abverkaufter Artikel Sonderaktion zum VVJ (Wochentagsvergleich)'
) as










SELECT vis.mandant_id
	, vis.nb_id
	, wup.aktuell_wup_id		AS wup_id
	, vis.wrg_id
	, vis.arthiertyp_id
	, vis.abt_id
	, vis.wg_id
	, vis.dat
	, vis.kjwo
	, vis.kjmo
	, vis.gj
	
	, vis.ums_netto
	, vis.ums_netto_kvj
	, vis.ums_netto_kvvj
	, vis.ums_netto_wvj
	, vis.ums_netto_wvvj
	
	, vis.ums_netto_af
	, vis.ums_netto_af_kvj
	, vis.ums_netto_af_kvvj
	, vis.ums_netto_af_wvj
	, vis.ums_netto_af_wvvj
	, NVL(vis.ums_netto_af - vis.ums_netto_af_kvj, 0)	AS ums_netto_af_kvj_abw
	, NVL(vis.ums_netto_af - vis.ums_netto_af_kvvj, 0)	AS ums_netto_af_kvvj_abw
	, NVL(vis.ums_netto_af - vis.ums_netto_af_wvj, 0)	AS ums_netto_af_wvj_abw
	, NVL(vis.ums_netto_af - vis.ums_netto_af_wvvj, 0)	AS ums_netto_af_wvvj_abw
	
	, vis.ums_netto_sa
	, vis.ums_netto_sa_kvj
	, vis.ums_netto_sa_kvvj
	, vis.ums_netto_sa_wvj
	, vis.ums_netto_sa_wvvj
	, NVL(vis.ums_netto_sa - vis.ums_netto_sa_kvj, 0)	AS ums_netto_sa_kvj_abw
	, NVL(vis.ums_netto_sa - vis.ums_netto_sa_kvvj, 0)	AS ums_netto_sa_kvvj_abw
	, NVL(vis.ums_netto_sa - vis.ums_netto_sa_wvj, 0)	AS ums_netto_sa_wvj_abw
	, NVL(vis.ums_netto_sa - vis.ums_netto_sa_wvvj, 0)	AS ums_netto_sa_wvvj_abw
	
	, vis.ums_brutto
	, vis.ums_brutto_kvj
	, vis_kvvj.ums_brutto		AS ums_brutto_kvvj 
	, vis.ums_brutto_wvj
	, vis_wvvj.ums_brutto		AS ums_brutto_wvvj 
	
	, vis.menge_absatz			AS menge
	, vis.menge_absatz_kvj		AS menge_kvj
	, vis_kvvj.menge_absatz		AS menge_kvvj 
	, vis.menge_absatz_wvj		AS menge_wvj
	, vis_wvvj.menge_absatz		AS menge_wvvj 
	
	, vis.menge_absatz_af		AS menge_af
	, vis.menge_absatz_af_kvj	AS menge_af_kvj
	, vis_kvvj.menge_absatz_af	AS menge_af_kvvj 
	, vis.menge_absatz_af_wvj	AS menge_af_wvj
	, vis_wvvj.menge_absatz_af	AS menge_af_wvvj 
	, NVL(menge_af - menge_af_kvj, 0)	AS menge_af_kvj_abw
	, NVL(menge_af - menge_af_kvvj, 0)	AS menge_af_kvvj_abw
	, NVL(menge_af - menge_af_wvj, 0)	AS menge_af_wvj_abw
	, NVL(menge_af - menge_af_wvvj, 0)	AS menge_af_wvvj_abw
	
	, vis.menge_absatz_sa		AS menge_sa
	, vis.menge_absatz_sa_kvj	AS menge_sa_kvj
	, vis_kvvj.menge_absatz_sa	AS menge_sa_kvvj 
	, vis.menge_absatz_sa_wvj	AS menge_sa_wvj
	, vis_wvvj.menge_absatz_sa	AS menge_sa_wvvj 
	, NVL(menge_sa - menge_sa_kvj, 0)	AS menge_sa_kvj_abw
	, NVL(menge_sa - menge_sa_kvvj, 0)	AS menge_sa_kvvj_abw
	, NVL(menge_sa - menge_sa_wvj, 0)	AS menge_sa_wvj_abw
	, NVL(menge_sa - menge_sa_wvvj, 0)	AS menge_sa_wvvj_abw
FROM dbp_msi_v_view.v_vis_tag_umsatz_wg vis 
INNER JOIN dbp_view.v_wup wup 
	ON vis.mandant_id = wup.mandant_id 
		AND vis.wup_id = wup.wup_id
LEFT JOIN dbp_msi_v_view.v_vis_tag_umsatz_wg vis_wvvj
	ON vis_wvvj.mandant_id = vis.mandant_id 
		AND vis_wvvj.wup_id = vis.wup_id 
		AND vis_wvvj.wrg_id = vis.wrg_id 
		AND vis_wvvj.wg_id = vis.wg_id 
		AND vis_wvvj.dat = (vis.dat - 728) 
LEFT JOIN dbp_msi_v_view.v_vis_tag_umsatz_wg vis_kvvj
	ON vis_kvvj.mandant_id = vis.mandant_id 
		AND vis_kvvj.wup_id = vis.wup_id 
		AND vis_kvvj.wrg_id = vis.wrg_id 
		AND vis_kvvj.wg_id = vis.wg_id 
		AND vis_kvvj.dat = Add_Months(vis.dat, -24) 
;
