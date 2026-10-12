create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_GEKU.MV_CRM_EIGENMARKE_SPR_ZU(
	CRM_EIGENMARKE_ID,
	CRM_EIGENMARKE_BEZ,
	CRM_EIGENMARKE_BEZ_CZ,
	CRM_EIGENMARKE_BEZ_PL,
	CRM_EIGENMARKE_BEZ_SK,
	CRM_EIGENMARKE_BEZ_HR,
	CRM_EIGENMARKE_BEZ_RO,
	CRM_EIGENMARKE_BEZ_BG
) as
-- 17.07.2019 twie: SPEC0059158 Sprachview CRM Eigenmarke

   SELECT

   v01.crm_eigenmarke_id
   ,MAX(CASE WHEN v01.spr_id =   22 THEN v01.crm_eigenmarke_bez ELSE NULL END)  AS crm_eigenmarke_bez   --standard=deutsch
   ,MAX(CASE WHEN v01.spr_id = 124 THEN v01.crm_eigenmarke_bez ELSE NULL END)  AS crm_eigenmarke_bez_cz
   ,MAX(CASE WHEN v01.spr_id =   90 THEN v01.crm_eigenmarke_bez ELSE NULL END)  AS crm_eigenmarke_bez_pl
   ,MAX(CASE WHEN v01.spr_id = 108 THEN v01.crm_eigenmarke_bez ELSE NULL END)  AS crm_eigenmarke_bez_sk
   ,MAX(CASE WHEN v01.spr_id =   65 THEN v01.crm_eigenmarke_bez ELSE NULL END)  AS crm_eigenmarke_bez_hr
   ,MAX(CASE WHEN v01.spr_id =   95 THEN v01.crm_eigenmarke_bez ELSE NULL END)  AS crm_eigenmarke_bez_ro
   ,MAX(CASE WHEN v01.spr_id =   18 THEN v01.crm_eigenmarke_bez ELSE NULL END)  AS crm_eigenmarke_bez_bg

   FROM dbp_view.v_crm_eigenmarke_spr_zu v01

   GROUP BY v01.crm_eigenmarke_id;