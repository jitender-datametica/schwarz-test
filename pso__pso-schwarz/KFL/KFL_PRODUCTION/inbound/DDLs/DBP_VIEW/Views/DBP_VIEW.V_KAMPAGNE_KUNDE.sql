CREATE OR REPLACE VIEW DBP_VIEW.V_KAMPAGNE_KUNDE (
   mandant_id                               COMMENT 'Mandant im DWH.'
  ,kampagne_kunde_id                        COMMENT 'Vom Quellsystem generierte ID des Kunden (GUID). Es ist der Empfänger der von Kampagnen gesendeten Nachrichten.'
)
COMMENT = 'Die Tabelle enthält die Nutzer, bzw. Kunden, an die im Zuge von Marketingkampagnen Nachrichten geschickt werden. Sie dient dazu, die Empfänger von verschiedenen Kommunikationspunkten wie E-Mails, Push-Benachrichtigungen und SMS zu definieren und zu verwalten.'
 AS 
    SELECT 
        mandant_id,
        kampagne_kunde_id

FROM DBP_DATA.KAMPAGNE_KUNDE ;