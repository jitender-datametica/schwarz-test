create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_VIEW.V_CRM_VORGANG_TOUCHPOINT_ZU(
	MANDANT_ID,
	CRM_VORGANG_ID,
	TOUCHPOINT_ID,
	TOUCHPOINT_COUNT
) as 
    SELECT 
        mandant_id
        ,crm_vorgang_id
        ,touchpoint_id
        ,touchpoint_count


FROM DBP_DATA.crm_vorgang_touchpoint_zu ;
