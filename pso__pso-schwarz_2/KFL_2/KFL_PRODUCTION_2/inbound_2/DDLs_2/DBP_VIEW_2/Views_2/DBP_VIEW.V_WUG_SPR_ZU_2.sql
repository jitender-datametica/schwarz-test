create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_VIEW.V_WUG_SPR_ZU_2(
	ARTHIERTYP_ID COMMENT 'Artikel_2 - Hierarchie - Typ - ID: kennzeichnet, ob es sich um eine_2 Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt',
	MANDANT_ID COMMENT 'Mandant_2 im DWH',
	WG_ID COMMENT 'ID der Warengruppe',
	SPR_ID COMMENT 'ID der Sprache',
	WUG_ID COMMENT 'ID der Warenuntergruppe',
	WUG_BEZ COMMENT 'Warenuntergruppe - Bezeichnung aus SAP Retail.'
) as 
    SELECT 
        arthiertyp_id,
        mandant_id,
        wg_id,
        spr_id,
        wug_id,
        wug_bez

FROM DBP_DATA.WUG_SPR_ZU_2 ;
