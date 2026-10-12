create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_AAD.MV_ART_2(
	MANDANT_ID,
	ART_ID,
	MWST_ID,
	KL_ART_ID,
	WG_ART_FG,
	GTIN_ID,
	DAT_VON,
	DAT_BIS
) as
--15.06.2023 snik: SPEC0200542 Lookup Artikel_2
   SELECT
     v01.mandant_id
   , v01.art_id
   , v01.mwst_id
   , v01.kl_art_id
   , v01.wg_art_fg
   , v01.gtin_id
   , v01.dat_von
   , v01.dat_bis   
FROM dbp_view.v_art_2 v01;