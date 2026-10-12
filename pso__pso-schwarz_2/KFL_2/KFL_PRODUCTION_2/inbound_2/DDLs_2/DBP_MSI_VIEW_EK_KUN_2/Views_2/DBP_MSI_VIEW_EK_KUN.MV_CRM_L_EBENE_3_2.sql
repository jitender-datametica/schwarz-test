create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_EK_KUN.MV_CRM_L_EBENE_3_2(
	EBENE_3_ID,
	NUMBER_LEVEL_3,
	EBENE_2_ID
) as
    SELECT
   -- STRY0048932 Umzug aus KMR nach EK_KUNDE / sschuecke 30.03.2026
    ebene_3_id
   ,MAX(number_level_3) AS number_level_3
   --Ebene 2 ist Elternteil zu Ebene 3, deshalb müssen gleiche ebene_3_id immer die gleiche ebene_2_id haben, sonst Hierarchie in der Tabelle von der Quelle nicht richtig hinterlegt
   ,MAX(ebene_2_id) AS ebene_2_id

   FROM DBP_DATA.CRM_L_THEMENBAUM_LV2_2
   GROUP BY ebene_3_id;
