create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_GEKU.MV_CRM_L_PRIORITAET(
	CRM_PRIORITAET_ID
) as
-- 17.07.2019 twie: SPEC0059158 Lookup CRM Prioritaet

   SELECT

   crm_prioritaet_id

   FROM dbp_view.v_crm_l_prioritaet;