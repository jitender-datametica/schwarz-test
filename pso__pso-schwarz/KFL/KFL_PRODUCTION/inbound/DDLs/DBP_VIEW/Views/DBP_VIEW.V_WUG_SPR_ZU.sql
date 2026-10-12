create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_VIEW.V_WUG_SPR_ZU(
	ARTHIERTYP_ID COMMENT 'Artikel - Hierarchie - Typ - ID: kennzeichnet, ob es sich um eine Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt',
	MANDANT_ID COMMENT 'Mandant im DWH',
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

FROM DBP_DATA.WUG_SPR_ZU ;
