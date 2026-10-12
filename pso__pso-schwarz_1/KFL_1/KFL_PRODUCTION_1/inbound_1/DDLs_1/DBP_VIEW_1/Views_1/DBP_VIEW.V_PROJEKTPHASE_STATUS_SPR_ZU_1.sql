create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_VIEW.V_PROJEKTPHASE_STATUS_SPR_ZU_1(
	MANDANT_ID COMMENT 'Mandant_1 im DWH',
	SPR_ID COMMENT 'ID der Sprache',
	PROJEKTPHASE_STATUS_ID COMMENT 'ID des Status_1 der Projektphase.',
	PROJEKTPHASE_STATUS_BEZ COMMENT 'Sprachabhängige Bezeichnung des Status_1 der Projektphase'
) COMMENT='Tabelle für sprachabhängige Bezeichnungen der Status_1 der Projektphasen.'
 as 
    SELECT 
        mandant_id,
        spr_id,
        projektphase_status_id,
        projektphase_status_bez

FROM DBP_DATA.PROJEKTPHASE_STATUS_SPR_ZU_1 ;
