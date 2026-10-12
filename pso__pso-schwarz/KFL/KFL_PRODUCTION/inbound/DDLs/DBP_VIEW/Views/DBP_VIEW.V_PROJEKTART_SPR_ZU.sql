create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_VIEW.V_PROJEKTART_SPR_ZU(
	MANDANT_ID COMMENT 'Mandant im DWH',
	SPR_ID COMMENT 'ID der Sprache',
	PROJEKTART_CD COMMENT 'Eindeutiger alphanumerischer Code der Projektart',
	PROJEKTART_BEZ COMMENT 'Sprachabhängige Bezeichnung der Projektart.'
) COMMENT='Tabelle für sprachabhängige Bezeichnungen der Projektarten.'
 as 
    SELECT 
        mandant_id,
        spr_id,
        projektart_cd,
        projektart_bez

FROM DBP_DATA.PROJEKTART_SPR_ZU ;
