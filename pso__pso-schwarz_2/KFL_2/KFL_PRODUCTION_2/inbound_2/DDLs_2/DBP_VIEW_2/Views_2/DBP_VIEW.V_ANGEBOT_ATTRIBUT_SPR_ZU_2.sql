CREATE OR REPLACE VIEW DBP_VIEW.V_ANGEBOT_ATTRIBUT_SPR_ZU_2 (
   mandant_id                               COMMENT 'Mandant_2 im DWH'
  ,spr_id                                   COMMENT 'ID der Sprache'
  ,angebot_attribut_id                      COMMENT 'ID des Attributs'
  ,angebot_attribut_bez                     COMMENT 'Sprachabhängige Bezeichnung des Attributs'
)
COMMENT = 'Tabelle für sprachabhängige Bezeichnungen der Attribute zum Angebot.'
 AS 
    SELECT 
        mandant_id,
        spr_id,
        angebot_attribut_id,
        angebot_attribut_bez
FROM DBP_DATA.ANGEBOT_ATTRIBUT_SPR_ZU_2 ;