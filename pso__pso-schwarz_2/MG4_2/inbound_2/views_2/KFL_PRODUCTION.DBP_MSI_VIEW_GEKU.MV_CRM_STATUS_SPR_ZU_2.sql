create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_GEKU.MV_CRM_STATUS_SPR_ZU_2(
	CRM_STATUS_ID,
	CRM_STATUS_BEZ,
	CRM_STATUS_BEZ_CZ,
	CRM_STATUS_BEZ_PL,
	CRM_STATUS_BEZ_SK,
	CRM_STATUS_BEZ_HR,
	CRM_STATUS_BEZ_RO,
	CRM_STATUS_BEZ_BG
) as
-- 17.07.2019 twie: SPEC0059158 Sprachview CRM Status_2

   SELECT

   v01.crm_status_id
   , MAX(CASE WHEN v01.spr_id =   22 THEN v01.crm_status_bez ELSE NULL END)  AS crm_status_bez   --standard=deutsch
   , MAX(CASE WHEN v01.spr_id = 124 THEN v01.crm_status_bez ELSE NULL END)  AS crm_status_bez_cz
   , MAX(CASE WHEN v01.spr_id =   90 THEN v01.crm_status_bez ELSE NULL END)  AS crm_status_bez_pl
   , MAX(CASE WHEN v01.spr_id = 108 THEN v01.crm_status_bez ELSE NULL END)  AS crm_status_bez_sk
   , MAX(CASE WHEN v01.spr_id =   65 THEN v01.crm_status_bez ELSE NULL END)  AS crm_status_bez_hr
   , MAX(CASE WHEN v01.spr_id =   95 THEN v01.crm_status_bez ELSE NULL END)  AS crm_status_bez_ro
   , MAX(CASE WHEN v01.spr_id =   18 THEN v01.crm_status_bez ELSE NULL END)  AS crm_status_bez_bg

   FROM dbp_view.v_crm_status_spr_zu_2 v01

   GROUP BY v01.crm_status_id;