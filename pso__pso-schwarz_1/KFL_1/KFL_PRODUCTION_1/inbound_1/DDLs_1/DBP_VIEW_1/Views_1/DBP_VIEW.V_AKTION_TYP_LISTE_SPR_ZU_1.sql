create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_VIEW.V_AKTION_TYP_LISTE_SPR_ZU_1(
	MANDANT_ID COMMENT 'Mandant_1 im DWH',
	AKTION_TYP_LISTE_ID COMMENT 'Enthält als kommaseparierte Textliste den Typ der Aktion_1(en) als ID, die verwendet wurde(n).',
	SPR_ID COMMENT 'ID der Sprache',
	AKTION_TYP_LISTE_BEZ COMMENT 'Enthält als kommaseparierte Textliste die Bezeichnung der Aktionstype(n).'
) COMMENT='AIS - Sprachabhängige Bezeichnungen der Aktionstypen.'
 as 
    SELECT 
        mandant_id,
        aktion_typ_liste_id,
        spr_id,
        aktion_typ_liste_bez

FROM DBP_DATA.AKTION_TYP_LISTE_SPR_ZU_1 ;
