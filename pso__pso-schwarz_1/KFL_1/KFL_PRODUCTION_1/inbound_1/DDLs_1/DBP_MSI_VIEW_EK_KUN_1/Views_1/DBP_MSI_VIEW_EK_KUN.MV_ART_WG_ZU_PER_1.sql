create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_EK_KUN.MV_ART_WG_ZU_PER_1(
	ART_ID,
	MANDANT_ID,
	ARTHIERTYP_ID,
	WUG_ID,
	WG_ID,
	DAT_VON,
	DAT_BIS
) as
   SELECT
   -- STRY0048932 Umzug aus KMR nach EK_KUNDE / sschuecke 30.03.2026
    v01.art_id
   ,v01.mandant_id
   ,v01.arthiertyp_id
   ,v01.wug_id
   ,v01.wg_id
   ,v01.dat_von
   ,v01.dat_bis
   FROM DBP_DATA.ART_WG_ZU_PER_1 v01

   WHERE v01.arthiertyp_id = 2
   AND v01.dat_bis = '9999-12-31';
