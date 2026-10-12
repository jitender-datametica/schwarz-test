create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_EK_KUN.MV_CRM_L_FOTO_FG_1(
	FOTO_FG
) as
   SELECT
   -- STRY0048932 Umzug aus KMR nach EK_KUNDE / sschuecke 30.03.2026
   flag AS foto_fg

   FROM DBP_DATA.FLAG_SPR_ZU_1  --keine Lookup vorhanden
   GROUP BY flag;
