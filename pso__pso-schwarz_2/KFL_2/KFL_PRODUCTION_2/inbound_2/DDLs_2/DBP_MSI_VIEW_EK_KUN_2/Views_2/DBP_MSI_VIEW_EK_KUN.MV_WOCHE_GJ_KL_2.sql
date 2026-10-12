create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_EK_KUN.MV_WOCHE_GJ_KL_2(
	GJWO_KL,
	GJWO_KL_DAT_VON,
	GJWO_KL_DAT_BIS,
	AKT_GJWO_KL,
	AKT_GJWO_KL_KOMPLETT,
	AKT_GJ,
	GJ,
	AKT_GJ_KOMPLETT
) as
   SELECT
   -- STRY0048932 Umzug aus KMR nach EK_KUNDE / sschuecke 30.03.2026
    gjwo_kl
   ,gjwo_kl_dat_von
   ,gjwo_kl_dat_bis
   ,akt_gjwo_kl
   ,akt_gjwo_kl_komplett
   ,akt_gj
   ,SUBSTRING(CAST(CAST(gjwo_kl AS INTEGER) AS CHAR(6)), 1, 4)
   ,akt_gj_komplett
   FROM DBP_DATA.WOCHE_GJ_KL_2
   WHERE gjwo_kl > 200153;
