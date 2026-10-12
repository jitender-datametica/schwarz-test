create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_VIEW.V_PROJEKTPHASE_SPR_ZU_2(
	MANDANT_ID COMMENT 'Mandant_2 im DWH.',
	SPR_ID COMMENT 'ID der Sprache.',
	PROJEKTPHASE_ID COMMENT 'ID der Projektphase.',
	PROJEKTPHASE_BEZ COMMENT 'Sprachabhängige Bezeichnung der Projektphase.'
) COMMENT='Tabelle für sprachabhängige Bezeichnungen der Projektphasen.'
 as 
    SELECT 
        mandant_id,
        spr_id,
        projektphase_id,
        projektphase_bez

FROM DBP_DATA.PROJEKTPHASE_SPR_ZU_2 ;
