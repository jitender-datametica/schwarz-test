create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_GEKU.MV_CRM_L_STATUS_2(
	CRM_STATUS_ID
) as
-- 17.07.2019 twie: SPEC0059158 Lookup CRM Status_2

   SELECT

   crm_status_id

   FROM dbp_view.v_crm_l_status_2;