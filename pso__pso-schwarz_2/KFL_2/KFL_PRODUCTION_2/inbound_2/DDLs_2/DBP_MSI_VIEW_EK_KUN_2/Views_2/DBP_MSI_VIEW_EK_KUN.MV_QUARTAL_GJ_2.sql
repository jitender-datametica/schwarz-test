create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_EK_KUN.MV_QUARTAL_GJ_2(
	GJQU,
	AKT_GJQU,
	AKT_GJQU_KOMPLETT,
	GJ,
	AKT_GJ,
	AKT_GJ_KOMPLETT
) as
   SELECT
   -- STRY0048932 Umzug aus KMR nach EK_KUNDE / sschuecke 30.03.2026
    gjqu
   ,akt_gjqu
   ,akt_gjqu_komplett
   ,gj
   ,akt_gj
   ,akt_gj_komplett
   FROM DBP_DATA.QUARTAL_GJ_2
   WHERE gjqu > 200104;
