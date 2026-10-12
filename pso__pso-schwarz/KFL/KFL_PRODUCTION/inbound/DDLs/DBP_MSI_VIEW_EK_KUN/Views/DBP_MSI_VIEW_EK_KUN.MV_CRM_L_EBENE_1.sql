create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_EK_KUN.MV_CRM_L_EBENE_1(
	EBENE_1_ID,
	NUMBER_LEVEL_1
) as
   SELECT
   -- STRY0048932 Umzug aus KMR nach EK_KUNDE / sschuecke 30.03.2026
    ebene_1_id
   ,MAX(number_level_1) AS number_level_1

   FROM DBP_DATA.CRM_L_THEMENBAUM_LV2
   GROUP BY ebene_1_id;
