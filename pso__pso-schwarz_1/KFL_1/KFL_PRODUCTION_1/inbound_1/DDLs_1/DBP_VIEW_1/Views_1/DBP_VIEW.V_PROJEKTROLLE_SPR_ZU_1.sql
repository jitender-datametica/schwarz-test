create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_VIEW.V_PROJEKTROLLE_SPR_ZU_1(
	MANDANT_ID COMMENT 'Mandant_1 im DWH',
	SPR_ID COMMENT 'ID der Sprache',
	PROJEKTROLLE_CD COMMENT 'Eindeutiger Code der Projektrolle.',
	PROJEKTROLLE_BEZ COMMENT 'Sprachabhängige Bezeichnung der Projektrolle.'
) COMMENT='Tabelle für sprachabhängige Bezeichnungen der Projektrollen.'
 as 
    SELECT 
        mandant_id,
        spr_id,
        projektrolle_cd,
        projektrolle_bez

FROM DBP_DATA.PROJEKTROLLE_SPR_ZU_1 ;
