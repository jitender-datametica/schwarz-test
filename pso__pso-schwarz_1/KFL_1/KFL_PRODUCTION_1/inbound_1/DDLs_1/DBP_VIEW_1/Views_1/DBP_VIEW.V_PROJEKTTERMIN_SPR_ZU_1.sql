create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_VIEW.V_PROJEKTTERMIN_SPR_ZU_1(
	MANDANT_ID COMMENT 'Mandant_1 im DWH',
	SPR_ID COMMENT 'ID der Sprache',
	PROJEKTTERMIN_CD COMMENT 'Code des Projekttermins.',
	PROJEKTTERMIN_BEZ COMMENT 'Sprachabhängige Bezeichnung des Projekttermins.'
) COMMENT='Tabelle für sprachabhängige Bezeichnungen der Projekttermine.'
 as 
    SELECT 
        mandant_id,
        spr_id,
        projekttermin_cd,
        projekttermin_bez

FROM DBP_DATA.PROJEKTTERMIN_SPR_ZU_1 ;
