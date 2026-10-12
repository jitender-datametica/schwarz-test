CREATE OR REPLACE VIEW DBP_VIEW.V_KAMPAGNE_RHYTHMUS_TYP_SPR_ZU (
   mandant_id                               COMMENT 'Mandant im DWH.'
  ,kampagne_rhythmus_typ_id                 COMMENT 'Numerischer Code zur Kennzeichnung der Wiederholungshäufigkeit der Kampagne.'
  ,spr_id                                   COMMENT 'ID der DWH-Sprache, z.B. 22 = Deutsch, 24 = Englisch, etc.'
  ,kampagne_rhythmus_typ_bez                COMMENT 'Bezeichnung der Art der Wiederholungshäufigkeit der Kampagne in unterschiedlichen Sprachen.'
)
COMMENT = 'Sprachabhängige Bezeichnungen des Rhythmustyps der Kampagne - manuell versorgt.'
 AS 
    SELECT 
        mandant_id,
        kampagne_rhythmus_typ_id,
        spr_id,
        kampagne_rhythmus_typ_bez

FROM DBP_DATA.KAMPAGNE_RHYTHMUS_TYP_SPR_ZU ;