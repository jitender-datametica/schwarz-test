create or replace view KFL_PRODUCTION.DBP_VIEW.V_CRM_MAGICWORD_SPR_ZU_1(
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


FROM DBP_DATA.crm_magicword_spr_zu_1 ;