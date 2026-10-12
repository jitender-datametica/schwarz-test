CREATE OR REPLACE VIEW DBP_VIEW.V_KOMMUNIKATIONSKANAL_SPR_ZU (
   mandant_id                               COMMENT 'Mandant im DWH'
  ,kommunikationskanal_id                   COMMENT 'Eindeutige Kennung des Kommunikationskanals'
  ,spr_id                                   COMMENT 'ID der DWH-Sprache, z.B. 22 ist Deutsch'
  ,kommunikationskanal_bez                  COMMENT 'Übersetzung des Kanalnamens oder der Kanalbeschreibung in die jeweilige Sprache, z. B. 1 = E-Mail, 2 = Push Notification, 3 = SMS'
)
COMMENT = 'Sprachabhängige Bezeichnungen der Kommunikationskanäle für Marketingkampagnen - manuell versorgt'
 AS 
    SELECT 
        mandant_id,
        kommunikationskanal_id,
        spr_id,
        kommunikationskanal_bez

FROM DBP_DATA.KOMMUNIKATIONSKANAL_SPR_ZU ;