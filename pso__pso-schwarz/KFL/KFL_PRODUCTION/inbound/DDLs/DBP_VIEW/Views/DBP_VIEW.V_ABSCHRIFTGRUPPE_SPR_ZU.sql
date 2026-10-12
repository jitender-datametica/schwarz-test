create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_VIEW.V_ABSCHRIFTGRUPPE_SPR_ZU(
	MANDANT_ID,
	SPR_ID,
	ABSCHRIFTGRUPPE_ID,
	ABSCHRIFTGRUPPE_BEZ
) as 
    SELECT 
        mandant_id,
        spr_id,
        abschriftgruppe_id,
        abschriftgruppe_bez
FROM DBP_DATA.ABSCHRIFTGRUPPE_SPR_ZU ;
