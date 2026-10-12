create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_EK_KUN.MV_CRM_BRAND_SPR_ZU(
	CRM_BRAND_ID,
	CRM_BRAND_BEZ,
	CRM_BRAND_BEZ_CZ,
	CRM_BRAND_BEZ_PL,
	CRM_BRAND_BEZ_SK,
	CRM_BRAND_BEZ_HR,
	CRM_BRAND_BEZ_RO,
	CRM_BRAND_BEZ_BG
) as
   SELECT
   -- STRY0048932 Umzug aus KMR nach EK_KUNDE / sschuecke 30.03.2026
    v01.crm_brand_id
   ,MAX(v01.crm_brand_bez) AS crm_brand_bez   --standard=deutsch
   ,MAX(CASE WHEN v01.spr_id = 124 THEN v01.crm_brand_bez ELSE NULL END)  AS crm_brand_bez_cz
   ,MAX(CASE WHEN v01.spr_id =   90 THEN v01.crm_brand_bez ELSE NULL END)  AS crm_brand_bez_pl
   ,MAX(CASE WHEN v01.spr_id = 108 THEN v01.crm_brand_bez ELSE NULL END)  AS crm_brand_bez_sk
   ,MAX(CASE WHEN v01.spr_id =   65 THEN v01.crm_brand_bez ELSE NULL END)  AS crm_brand_bez_hr
   ,MAX(CASE WHEN v01.spr_id =   95 THEN v01.crm_brand_bez ELSE NULL END)  AS crm_brand_bez_ro
   ,MAX(CASE WHEN v01.spr_id =   18 THEN v01.crm_brand_bez ELSE NULL END)  AS crm_brand_bez_bg

   FROM DBP_DATA.CRM_BRAND_SPR_ZU v01
   GROUP BY v01.crm_brand_id;
