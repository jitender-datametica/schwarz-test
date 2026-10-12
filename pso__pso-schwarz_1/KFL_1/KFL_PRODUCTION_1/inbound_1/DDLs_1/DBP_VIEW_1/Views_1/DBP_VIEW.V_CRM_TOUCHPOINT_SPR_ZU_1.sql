create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_VIEW.V_CRM_TOUCHPOINT_SPR_ZU_1(
	MANDANT_ID,
	TOUCHPOINT_ID,
	SPR_ID,
	TOUCHPOINT_BEZ
) as 
    SELECT 
        mandant_id
        ,touchpoint_id
        ,spr_id
        ,touchpoint_bez


FROM DBP_DATA.crm_touchpoint_spr_zu_1 ;
