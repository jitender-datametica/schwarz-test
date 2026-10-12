create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_VIEW.V_CRM_MAGICWORD_SPR_ZU_2(
	CRM_MAGICWORD_ID,
	MANDANT_ID,
	SPR_ID,
	CRM_MAGICWORD_BEZ
) as 
    SELECT 
        crm_magicword_id
        ,mandant_id
        ,spr_id
        ,crm_magicword_bez


FROM DBP_DATA.crm_magicword_spr_zu_2 ;
