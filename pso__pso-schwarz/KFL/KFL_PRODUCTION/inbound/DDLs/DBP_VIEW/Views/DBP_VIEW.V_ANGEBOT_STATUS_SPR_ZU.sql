CREATE OR REPLACE VIEW DBP_VIEW.V_ANGEBOT_STATUS_SPR_ZU (
   mandant_id                               COMMENT 'Mandant im DWH'
  ,spr_id                                   COMMENT 'ID der Sprache'
  ,angebot_status_id                        COMMENT 'ID des Angebotsstatus'
  ,angebot_status_bez                       COMMENT 'Sprachabhängige Bezeichnung des Angebotsstatus.'
)
COMMENT = 'Tabelle für sprachabhängige Bezeichnungen des Angebotsstatus.'
 AS 
    SELECT 
        mandant_id,
        spr_id,
        angebot_status_id,
        angebot_status_bez
FROM DBP_DATA.ANGEBOT_STATUS_SPR_ZU ;