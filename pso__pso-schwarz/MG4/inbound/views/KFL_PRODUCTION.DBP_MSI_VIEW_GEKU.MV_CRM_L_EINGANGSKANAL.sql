create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_GEKU.MV_CRM_L_EINGANGSKANAL(
	CRM_EINGANGSKANAL_ID
) as
-- 17.07.2019 twie: SPEC0059158 Lookup CRM Eingangskanal

   SELECT

   crm_eingangskanal_id

   FROM dbp_view.v_crm_l_eingangskanal;