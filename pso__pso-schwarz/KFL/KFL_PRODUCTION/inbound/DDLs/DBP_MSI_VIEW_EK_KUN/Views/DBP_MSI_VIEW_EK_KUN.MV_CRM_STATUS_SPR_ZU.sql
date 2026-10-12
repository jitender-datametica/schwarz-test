create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_EK_KUN.MV_CRM_STATUS_SPR_ZU(
	CRM_STATUS_ID,
	CRM_STATUS_BEZ,
	CRM_STATUS_BEZ_CZ,
	CRM_STATUS_BEZ_PL,
	CRM_STATUS_BEZ_SK,
	CRM_STATUS_BEZ_HR,
	CRM_STATUS_BEZ_RO,
	CRM_STATUS_BEZ_BG
) as
  SELECT
-- STRY0048932 Umzug aus KMR nach EK_KUNDE / sschuecke 30.03.2026
   v01.crm_status_id
   ,MAX(CASE WHEN v01.spr_id =   22 THEN v01.crm_status_bez ELSE NULL END)  AS crm_status_bez   --standard=deutsch
   ,MAX(CASE WHEN v01.spr_id = 124 THEN v01.crm_status_bez ELSE NULL END)  AS crm_status_bez_cz
   ,MAX(CASE WHEN v01.spr_id =   90 THEN v01.crm_status_bez ELSE NULL END)  AS crm_status_bez_pl
   ,MAX(CASE WHEN v01.spr_id = 108 THEN v01.crm_status_bez ELSE NULL END)  AS crm_status_bez_sk
   ,MAX(CASE WHEN v01.spr_id =   65 THEN v01.crm_status_bez ELSE NULL END)  AS crm_status_bez_hr
   ,MAX(CASE WHEN v01.spr_id =   95 THEN v01.crm_status_bez ELSE NULL END)  AS crm_status_bez_ro
   ,MAX(CASE WHEN v01.spr_id =   18 THEN v01.crm_status_bez ELSE NULL END)  AS crm_status_bez_bg

   FROM DBP_DATA.CRM_STATUS_SPR_ZU v01
   GROUP BY v01.crm_status_id;
