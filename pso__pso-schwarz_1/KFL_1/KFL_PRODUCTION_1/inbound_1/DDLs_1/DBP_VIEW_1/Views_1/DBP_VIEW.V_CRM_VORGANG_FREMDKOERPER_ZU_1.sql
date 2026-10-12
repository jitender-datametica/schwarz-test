create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_VIEW.V_CRM_VORGANG_FREMDKOERPER_ZU_1(
	CRM_VORGANG_ID,
	CRM_FREMDKOERPER_ID
) as 
    SELECT 
        crm_vorgang_id
        ,crm_fremdkoerper_id


FROM DBP_DATA.crm_vorgang_fremdkoerper_zu_1 ;
