create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_GEKU.MV_CRM_L_STATUS(
	CRM_STATUS_ID
) as
-- 17.07.2019 twie: SPEC0059158 Lookup CRM Status

   SELECT

   crm_status_id

   FROM dbp_view.v_crm_l_status;