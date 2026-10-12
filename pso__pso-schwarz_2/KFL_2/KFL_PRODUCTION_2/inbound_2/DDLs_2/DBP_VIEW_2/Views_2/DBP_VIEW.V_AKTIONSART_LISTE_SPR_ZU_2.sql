create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_VIEW.V_AKTIONSART_LISTE_SPR_ZU_2(
	MANDANT_ID COMMENT 'Mandant_2 im DWH',
	AKTIONSART_LISTE_ID COMMENT 'Enthält als kommaseparierte Textliste die Art_2 der Aktion_2(en) als ID, die verwendet wurde(n).',
	SPR_ID COMMENT 'ID der Sprache',
	AKTIONSART_LISTE_BEZ COMMENT 'Enthält als kommaseparierte Textliste die Bezeichnung der Aktionsarte(n).'
) COMMENT='AIS - Sprachabhängige Bezeichnungen der Aktionsarten.'
 as 
    SELECT 
        mandant_id,
        aktionsart_liste_id,
        spr_id,
        aktionsart_liste_bez

FROM DBP_DATA.AKTIONSART_LISTE_SPR_ZU_2 ;
