CREATE OR REPLACE VIEW DBP_VIEW.V_KAMPAGNE_RHYTHMUS_TYP_SPR_ZU_2 (
   mandant_id                               COMMENT 'Mandant_2 im DWH.'
  ,kampagne_rhythmus_typ_id                 COMMENT 'Numerischer Code zur Kennzeichnung der Wiederholungshäufigkeit der Kampagne.'
  ,spr_id                                   COMMENT 'ID der DWH-Sprache, z.B. 22 = Deutsch, 24 = Englisch, etc.'
  ,kampagne_rhythmus_typ_bez                COMMENT 'Bezeichnung der Art_2 der Wiederholungshäufigkeit der Kampagne_2 in unterschiedlichen Sprachen.'
)
COMMENT = 'Sprachabhängige Bezeichnungen des Rhythmustyps der Kampagne_2 - manuell versorgt.'
 AS 
    SELECT 
        mandant_id,
        kampagne_rhythmus_typ_id,
        spr_id,
        kampagne_rhythmus_typ_bez

FROM DBP_DATA.KAMPAGNE_RHYTHMUS_TYP_SPR_ZU_2 ;