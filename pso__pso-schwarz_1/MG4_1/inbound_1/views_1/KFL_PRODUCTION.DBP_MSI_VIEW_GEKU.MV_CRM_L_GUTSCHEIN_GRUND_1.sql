create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_GEKU.MV_CRM_L_GUTSCHEIN_GRUND_1(
	CRM_GUTSCHEIN_GRUND_ID
) as
-- 17.07.2019 twie: SPEC0059158 Lookup CRM Gutschein_1 Grund

   SELECT

   crm_gutschein_grund_id

   FROM dbp_view.v_crm_l_gutschein_grund_1;