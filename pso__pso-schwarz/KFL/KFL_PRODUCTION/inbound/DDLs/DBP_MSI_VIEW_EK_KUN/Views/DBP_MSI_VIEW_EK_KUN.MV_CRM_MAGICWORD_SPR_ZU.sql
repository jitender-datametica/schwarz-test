create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_EK_KUN.MV_CRM_MAGICWORD_SPR_ZU(
	CRM_MAGICWORD_ID,
	CRM_MAGICWORD_BEZ
) as
   SELECT
   -- STRY0048932 Umzug aus KMR nach EK_KUNDE / sschuecke 30.03.2026
    v01.crm_magicword_id
   ,MAX(CASE WHEN v01.crm_magicword_id <> '-1' THEN v01.crm_magicword_bez  ELSE NULL END)  AS crm_magicword_bez

   FROM DBP_DATA.CRM_MAGICWORD_SPR_ZU v01
   GROUP BY v01.crm_magicword_id;
