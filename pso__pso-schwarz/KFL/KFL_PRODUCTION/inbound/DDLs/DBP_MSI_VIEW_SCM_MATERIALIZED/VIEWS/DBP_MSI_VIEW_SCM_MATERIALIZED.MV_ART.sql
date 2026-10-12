create or replace view DBP_MSI_VIEW_SCM_MATERIALIZED.MV_ART(
	ART_ID,
	INT_ART_ID,
	MANDANT_ID,
	MWST_ID,
	LAND_ID,
	REGION_ID,
	KL_ART_ID,
	KL_ART_ID_LANG,
	DAT_VON,
	DAT_BIS,
	LOESCH_ID,
	BIO_FG,
	WG_ART_FG,
	LEAD_ID,
	LEIST_ID,
	DISCOUNT_ID,
	VERPART_ID,
	ESB_ID,
	ALDI_ID,
	ZEK_ID,
	GEWART_ID,
	EIGENMARKE_ID,
	MUTTER_WB_ID,
	DISPLAY_ID,
	ARTIKELTYP_ID,
	SAISON_ID,
	BEST_MENGE_EINH_ID,
	LOESCHVORM_FG,
	MHD_ZEITRAUM,
	BASISMENGE_EINH_ID,
	ARTIKELART_ID,
	FAKTOR_NETTOINHALT,
	VERHANDLER_ID,
	POSTEN_KZ_SAP,
	LAGER_PROZENT,
	IPN_ID,
	ZEK_VAT_ID,
	IWT_ID
) as











SELECT
  v01.art_id
, v01.int_art_id
, v01.mandant_id
, v01.mwst_id
, v01.land_id
, v01.region_id
, CASE WHEN v01.kl_art_id = 0 THEN v01.art_id ELSE v01.kl_art_id END AS kl_art_id
, to_varchar(kl_art_id,'FM00000000') AS kl_art_id_lang
, v01.dat_von
, v01.dat_bis
, v01.loesch_id
, v01.bio_fg
, v01.wg_art_fg
, v01.lead_id
, (CASE WHEN v01.leist_id=' ' THEN 'keine' ELSE v01.leist_id END) AS leist_id
, v01.discount_id
, v01.verpart_id
, v01.esb_id
, v01.aldi_id
, v01.zek_id
, v01.gewart_id
, v01.eigenmarke_id
, v01.mutter_wb_id
, v01.display_id
, v01.artikeltyp_id
, v01.saison_id
, v01.best_menge_einh_id
, v01.loeschvorm_fg
, v01.mhd_zeitraum
, v01.basismenge_einh_id
, v01.artikelart_id
, v01.faktor_nettoinhalt
, v01.verhandler_id
, v01.posten_kz_sap
, (CAST(v01.lager_prozent AS DEC(6,3)) /100) AS lager_prozent
, v01.ipn_id
, v01.zek_vat_id
, v01.iwt_id

FROM dbp_view.v_art v01;