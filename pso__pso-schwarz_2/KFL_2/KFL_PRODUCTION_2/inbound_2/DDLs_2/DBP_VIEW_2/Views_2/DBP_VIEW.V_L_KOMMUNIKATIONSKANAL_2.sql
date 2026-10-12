CREATE OR REPLACE VIEW DBP_VIEW.V_L_KOMMUNIKATIONSKANAL_2 (
   mandant_id                               COMMENT 'Mandant_2 im DWH.'
  ,kommunikationskanal_id                   COMMENT 'Eindeutige Kennung des Kommunikationskanals, z. B. 1 = E-Mail, 2 = Push Notification, 3 = SMS.'
)
COMMENT = 'Die Tabelle enthält die verfügbaren Kommunikationskanäle für Marketingkampagnen.'
 AS 
    SELECT 
        mandant_id,
        kommunikationskanal_id

FROM DBP_DATA.L_KOMMUNIKATIONSKANAL_2 ;