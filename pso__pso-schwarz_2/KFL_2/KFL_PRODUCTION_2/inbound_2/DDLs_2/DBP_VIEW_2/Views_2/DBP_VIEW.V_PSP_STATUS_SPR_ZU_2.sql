create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_VIEW.V_PSP_STATUS_SPR_ZU_2(
	MANDANT_ID COMMENT 'Mandant_2 im DWH',
	SPR_ID COMMENT 'ID der Sprache.',
	PSP_STATUS_ID COMMENT 'ID des Status_2 der PSP_NR / des Buchungselementes.',
	PSP_STATUS_BEZ COMMENT 'Sprachabhängige Bezeichnung des PSP Status.'
) COMMENT='Tabelle für sprachabhängige Bezeichnungen des Status_2 der PSP_NR / des Buchungselementes.'
 as 
    SELECT 
        mandant_id,
        spr_id,
        psp_status_id,
        psp_status_bez

FROM DBP_DATA.PSP_STATUS_SPR_ZU_2 ;
