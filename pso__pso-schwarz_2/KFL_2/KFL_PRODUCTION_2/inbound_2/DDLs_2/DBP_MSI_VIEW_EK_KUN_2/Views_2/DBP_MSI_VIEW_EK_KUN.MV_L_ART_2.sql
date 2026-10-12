create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_EK_KUN.MV_L_ART_2(
	ART_ID,
	MANDANT_ID,
	KL_ART_ID
) as
   SELECT
   -- STRY0048932 Umzug aus KMR nach EK_KUNDE / sschuecke 30.03.2026
    art_id
   ,mandant_id
   ,kl_art_id

   FROM DBP_DATA.ART_2;
