create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_VIEW.V_ABSCHRIFTGRUPPE_2(
	MANDANT_ID,
	ABSCHRIFTGRUPPE_ID,
	ABSCHRIFTGRUPPE_EBENE_KZ
) as 
    SELECT 
        mandant_id,
        abschriftgruppe_id,
        abschriftgruppe_ebene_kz
FROM DBP_DATA.ABSCHRIFTGRUPPE_2 ;
