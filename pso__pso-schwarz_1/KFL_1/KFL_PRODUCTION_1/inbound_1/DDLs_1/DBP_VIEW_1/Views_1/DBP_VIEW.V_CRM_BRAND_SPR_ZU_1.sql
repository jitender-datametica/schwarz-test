create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_VIEW.V_CRM_BRAND_SPR_ZU_1(
	CRM_BRAND_ID,
	MANDANT_ID,
	SPR_ID,
	CRM_BRAND_BEZ
) as 
    SELECT 
        crm_brand_id
        ,mandant_id
        ,spr_id
        ,crm_brand_bez


FROM DBP_DATA.crm_brand_spr_zu_1 ;
