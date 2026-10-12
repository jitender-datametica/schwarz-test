create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_VIEW.V_PROJEKT_STATUS_SPR_ZU_2(
	MANDANT_ID COMMENT 'Mandant_2 im DWH',
	SPR_ID COMMENT 'ID der Sprache',
	PROJEKT_STATUS_ID COMMENT 'ID des Projektstatus.',
	PROJEKT_STATUS_BEZ COMMENT 'Sprachabhängige Bezeichnung des Projektstatus.'
) COMMENT='Tabelle für sprachabhängige Bezeichnungen der Projektstatus.'
 as 
    SELECT 
        mandant_id,
        spr_id,
        projekt_status_id,
        projekt_status_bez

FROM DBP_DATA.PROJEKT_STATUS_SPR_ZU_2 ;
