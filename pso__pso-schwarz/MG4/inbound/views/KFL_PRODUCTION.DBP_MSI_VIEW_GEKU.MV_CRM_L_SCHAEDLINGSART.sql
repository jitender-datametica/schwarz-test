create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_GEKU.MV_CRM_L_SCHAEDLINGSART(
	CRM_SCHAEDLINGSART_ID
) as
-- 17.07.2019 twie: SPEC0059158 Lookup CRM Schaedlingsart

   SELECT

   crm_schaedlingsart_id

   FROM dbp_view.v_crm_l_schaedlingsart;