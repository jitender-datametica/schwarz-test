create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_EK_KUN.MV_WOCHE_KJ_KL(
	KJWO_KL,
	KJWO_KL_DAT_VON,
	KJWO_KL_DAT_BIS,
	AKT_KJWO_KL,
	AKT_KJWO_KL_KOMPLETT,
	KJ,
	AKT_KJ,
	AKT_KJ_KOMPLETT
) as
   SELECT
   -- STRY0048932 Übernahme View im Zuge Umzug aus KMR nach EK_KUNDE / sschuecke 30.03.2026
    kjwo_kl
   ,kjwo_kl_dat_von
   ,kjwo_kl_dat_bis
   ,akt_kjwo_kl
   ,akt_kjwo_kl_komplett
   ,SUBSTRING(CAST(CAST(kjwo_kl AS INTEGER) AS CHAR(6)), 1, 4)
   ,akt_kj
   ,akt_kj_komplett
   FROM DBP_DATA.WOCHE_KJ_KL
   WHERE kjwo_kl > 200153;
