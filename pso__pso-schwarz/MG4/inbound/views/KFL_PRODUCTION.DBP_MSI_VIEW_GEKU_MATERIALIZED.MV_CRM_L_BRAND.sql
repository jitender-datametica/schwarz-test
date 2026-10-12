create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_GEKU_MATERIALIZED.MV_CRM_L_BRAND(
	CRM_BRAND_ID
) as
-- 10.05.2022 twie: SPEC0145413 Lookup CRM Marke

   SELECT
   crm_brand_id
   FROM dbp_view.v_crm_l_brand;