create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_GEKU_MATERIALIZED.MV_CRM_MAGICWORD_SPR_ZU_1(
	CRM_MAGICWORD_ID,
	CRM_MAGICWORD_BEZ
) as





   SELECT

   v01.crm_magicword_id
   ,MAX(CASE WHEN v01.crm_magicword_id <> '-1' THEN v01.crm_magicword_bez  ELSE NULL END)  AS crm_magicword_bez

   FROM dbp_view.v_crm_magicword_spr_zu_1 v01

   GROUP BY v01.crm_magicword_id
   ;