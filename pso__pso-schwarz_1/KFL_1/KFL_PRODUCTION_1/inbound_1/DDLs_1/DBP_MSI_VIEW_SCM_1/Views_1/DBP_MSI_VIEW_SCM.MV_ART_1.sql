CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_ART_1 (
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
) AS
-- AP0025499 - add artikeltyp_id column (aszu1204, 20180925) 
-- AP0025499 - new definiton for posten_id (aszu1204, 20181031)
-- AP0040334 - add verhandler_id column (mcie1607, 20190228)
-- AP0036544 - add posten_kz_sap column, remove posten_id (mcie1607, 20190304)
-- add lager_prozent (baranowska, 20200805)
-- 2020-09-03, AP0068964, nwag2310, removed join with mandant_1 and "eindeutig" column -> performance
-- 06.04.2021, srom0404, AP0077805, SPEC0108204 - Lieferantenmanagement
-- 04.11.2022, richternic, NSR3286224 hinzufuegen der zek_vat_id
-- 04.12.2023, dknop, AP0162072, SPEC0227498, adding iwt_id
-- 07.08.2024, dknop, adding kl_art_id_lang
--2025-08-07, dknop, adding INT_ART_ID
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
--, Cast( v01.art_id AS VARCHAR(15) )   || Trim(v02.mandant_kbez) AS eindeutig
FROM dbp_view.v_art_1 v01
--JOIN dbp_view.v_mandant_1 v02 ON v01.mandant_id = v02.mandant_id
;