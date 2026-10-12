create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_VIEW.V_PROJEKTTYP_SPR_ZU(
	MANDANT_ID COMMENT 'Mandant im DWH',
	SPR_ID COMMENT 'ID der Sprache',
	PROJEKTTYP_ID COMMENT 'ID des Projekttyps',
	PROJEKTTYP_BEZ COMMENT 'Sprachabhängige Bezeichnung des Projekttyps'
) COMMENT='Tabelle für sprachabhängige Bezeichnungen der Projekttypen.'
 as 
    SELECT 
        mandant_id,
        spr_id,
        projekttyp_id,
        projekttyp_bez

FROM DBP_DATA.PROJEKTTYP_SPR_ZU ;
