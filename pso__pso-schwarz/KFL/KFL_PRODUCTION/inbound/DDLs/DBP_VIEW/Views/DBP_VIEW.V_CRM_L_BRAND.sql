create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_VIEW.V_CRM_L_BRAND(
	CRM_BRAND_ID
) as 
    SELECT 
        crm_brand_id


FROM DBP_DATA.crm_l_brand ;
