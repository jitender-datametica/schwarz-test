CREATE OR REPLACE VIEW DBP_MSI_VIEW_AAD.MV_ART(
	MANDANT_ID,
	ART_ID,
	MWST_ID,
	KL_ART_ID,
	WG_ART_FG,
	GTIN_ID,
	DAT_VON,
	DAT_BIS
) AS
--15.06.2023 snik: SPEC0200542 Lookup Artikel
--08.08.2025 pkra: NSR5496236 change for art_id from v01.art_id to TRUNCATE(CASE WHEN mandant_id=1 THEN v01.art_id/100 ELSE v01.art_id/10 END,0) AS art_id

   SELECT
     v01.mandant_id
   , TRUNCATE(CASE WHEN mandant_id=1 THEN v01.art_id/100 ELSE v01.art_id/10 END,0) AS art_id
   , v01.mwst_id
   , v01.kl_art_id
   , v01.wg_art_fg
   , v01.gtin_id
   , v01.dat_von
   , v01.dat_bis   
   FROM dbp_view.v_art v01;