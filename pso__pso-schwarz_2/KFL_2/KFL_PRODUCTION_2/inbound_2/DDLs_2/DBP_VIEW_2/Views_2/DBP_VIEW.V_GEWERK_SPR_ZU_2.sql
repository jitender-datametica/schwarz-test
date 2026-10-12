create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_VIEW.V_GEWERK_SPR_ZU_2(
	MANDANT_ID COMMENT 'Mandant_2 im DWH',
	SPR_ID COMMENT 'ID der Sprache',
	GEWERK_ID COMMENT 'ID eines Gewerks , z.Bsp 3 = Baukosten',
	GEWERK_BEZ COMMENT 'Sprachabhängige Bezeichnung der Gewerke'
) COMMENT='Tabelle für sprachabhängige Bezeichnungen der Gewerke.'
 as 
    SELECT 
        mandant_id,
        spr_id,
        gewerk_id,
        gewerk_bez

FROM DBP_DATA.GEWERK_SPR_ZU_2 ;
