CREATE OR REPLACE VIEW DBP_VIEW.V_ANGEBOT_TYP_SPR_ZU_1 (
   mandant_id                               COMMENT 'Mandant_1 im DWH'
  ,spr_id                                   COMMENT 'ID der Sprache'
  ,angebot_typ_cd                           COMMENT 'Alphanumerischer Code des Angebotstyps'
  ,angebot_typ_bez                          COMMENT 'Sprachabhängige Bezeichnung des Angebotstyps.'
)
COMMENT = 'Tabelle für sprachabhängige Bezeichnungen der Angebotstypen.'
 AS 
    SELECT 
        mandant_id,
        spr_id,
        angebot_typ_cd,
        angebot_typ_bez
FROM DBP_DATA.ANGEBOT_TYP_SPR_ZU_1 ;