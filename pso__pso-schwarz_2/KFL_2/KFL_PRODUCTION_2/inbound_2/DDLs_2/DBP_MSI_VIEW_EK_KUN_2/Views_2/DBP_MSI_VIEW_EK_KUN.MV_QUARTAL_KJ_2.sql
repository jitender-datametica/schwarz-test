create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_EK_KUN.MV_QUARTAL_KJ_2(
	KJQU,
	AKT_KJQU,
	AKT_KJQU_KOMPLETT,
	KJ,
	AKT_KJ,
	AKT_KJ_KOMPLETT
) as
   SELECT
   -- STRY0048932 Umzug aus KMR nach EK_KUNDE / sschuecke 30.03.2026
    kjqu
   ,akt_kjqu
   ,akt_kjqu_komplett
   ,kj
   ,akt_kj
   ,akt_kj_komplett
   FROM DBP_DATA.QUARTAL_KJ_2
   WHERE kjqu>200104;
