create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_GEKU.MV_CRM_L_PROZESS(
	CRM_PROZESS_ID
) as
-- 22.07.2019 twie: SPEC0059158 Lookup CRM Prozess

   SELECT

   crm_prozess_id

   FROM dbp_view.v_crm_l_prozess;