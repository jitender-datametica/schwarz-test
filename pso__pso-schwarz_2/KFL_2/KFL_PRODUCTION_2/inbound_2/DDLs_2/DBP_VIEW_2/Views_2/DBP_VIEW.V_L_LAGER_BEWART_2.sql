create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_VIEW.V_L_LAGER_BEWART_2(
	MANDANT_ID,
	LAGER_BEWART_ID,
	SYSTEM_ID,
	ABSCHRIFTGRUPPE_ID
) as 
    SELECT 
        mandant_id,
        lager_bewart_id,
        system_id,
        abschriftgruppe_id
FROM DBP_DATA.L_LAGER_BEWART_2 ;
