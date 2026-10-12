create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_EK_KUN.MV_CRM_L_EBENE_2(
	EBENE_2_ID,
	NUMBER_LEVEL_2,
	EBENE_1_ID
) as
   SELECT
   -- STRY0048932 Umzug aus KMR nach EK_KUNDE / sschuecke 30.03.2026
    ebene_2_id
   ,MAX(number_level_2) AS number_level_2
   --Ebene 1 ist Elternteil zu Ebene 2, deshalb müssen gleiche ebene_2_id immer die gleiche ebene_1_id haben, sonst Hierarchie in der Tabelle von der Quelle nicht richtig hinterlegt
   ,MAX(ebene_1_id) AS ebene_1_id

   FROM DBP_DATA.CRM_L_THEMENBAUM_LV2
   GROUP BY ebene_2_id;
