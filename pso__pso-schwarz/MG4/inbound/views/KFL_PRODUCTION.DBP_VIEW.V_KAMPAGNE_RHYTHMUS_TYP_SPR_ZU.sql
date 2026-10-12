create or replace view KFL_PRODUCTION.DBP_VIEW.V_KAMPAGNE_RHYTHMUS_TYP_SPR_ZU(
	MANDANT_ID COMMENT 'Mandant im DWH.',
	KAMPAGNE_RHYTHMUS_TYP_ID COMMENT 'Numerischer Code zur Kennzeichnung der Wiederholungshäufigkeit der Kampagne.',
	SPR_ID COMMENT 'ID der DWH-Sprache, z.B. 22 = Deutsch, 24 = Englisch, etc.',
	KAMPAGNE_RHYTHMUS_TYP_BEZ COMMENT 'Bezeichnung der Art der Wiederholungshäufigkeit der Kampagne in unterschiedlichen Sprachen.'
) COMMENT='Sprachabhängige Bezeichnungen des Rhythmustyps der Kampagne - manuell versorgt.'
 as 
    SELECT 
        mandant_id,
        kampagne_rhythmus_typ_id,
        spr_id,
        kampagne_rhythmus_typ_bez

FROM DBP_DATA.KAMPAGNE_RHYTHMUS_TYP_SPR_ZU ;