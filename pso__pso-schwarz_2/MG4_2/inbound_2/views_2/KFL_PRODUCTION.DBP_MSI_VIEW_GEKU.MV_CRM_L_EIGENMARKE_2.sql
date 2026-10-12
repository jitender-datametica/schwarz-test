create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_GEKU.MV_CRM_L_EIGENMARKE_2(
	CRM_EIGENMARKE_ID
) as
-- 17.07.2019 twie: SPEC0059158 Lookup CRM Eigenmarke

   SELECT

   crm_eigenmarke_id

   FROM dbp_view.v_crm_l_eigenmarke_2;