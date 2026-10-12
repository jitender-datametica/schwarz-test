create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_GEKU.MV_CRM_PRIORITAET_SPR_ZU_2(
	CRM_PRIORITAET_ID,
	CRM_PRIORITAET_BEZ,
	CRM_PRIORITAET_BEZ_CZ,
	CRM_PRIORITAET_BEZ_PL,
	CRM_PRIORITAET_BEZ_SK,
	CRM_PRIORITAET_BEZ_HR,
	CRM_PRIORITAET_BEZ_RO,
	CRM_PRIORITAET_BEZ_BG
) as
-- 17.07.2019 twie: SPEC0059158 Sprachview CRM Prioritaet

   SELECT

   v01.crm_prioritaet_id
   , MAX(CASE WHEN v01.spr_id =   22 THEN v01.crm_prioritaet_bez ELSE NULL END)  AS crm_prioritaet_bez   --standard=deutsch
   , MAX(CASE WHEN v01.spr_id = 124 THEN v01.crm_prioritaet_bez ELSE NULL END)  AS crm_prioritaet_bez_cz
   , MAX(CASE WHEN v01.spr_id =   90 THEN v01.crm_prioritaet_bez ELSE NULL END)  AS crm_prioritaet_bez_pl
   , MAX(CASE WHEN v01.spr_id = 108 THEN v01.crm_prioritaet_bez ELSE NULL END)  AS crm_prioritaet_bez_sk
   , MAX(CASE WHEN v01.spr_id =   65 THEN v01.crm_prioritaet_bez ELSE NULL END)  AS crm_prioritaet_bez_hr
   , MAX(CASE WHEN v01.spr_id =   95 THEN v01.crm_prioritaet_bez ELSE NULL END)  AS crm_prioritaet_bez_ro
   , MAX(CASE WHEN v01.spr_id =   18 THEN v01.crm_prioritaet_bez ELSE NULL END)  AS crm_prioritaet_bez_bg

   FROM dbp_view.v_crm_prioritaet_spr_zu_2 v01

   GROUP BY v01.crm_prioritaet_id;