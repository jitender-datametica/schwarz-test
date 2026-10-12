CREATE OR REPLACE VIEW DBP_VIEW.V_KAMPAGNE_NACHRICHT_AKTION_DETAIL_2 (
   mandant_id                               COMMENT 'Mandant_2 im DWH.'
  ,nachricht_workflow_id                    COMMENT 'ID des Workflows, der die Interaktionen zum Kunde in einer Kampagne_2 verarbeitet.'
  ,nachricht_vorlage_id                     COMMENT 'Eindeutige Kennung der verwendeten Nachrichtenvorlage.'
  ,kommunikationskanal_id                   COMMENT 'Kennung des Kommunikationskanals, über den die Nachricht versendet wurde, z. B. 1=E-Mail, 2=Push-Benachrichtigung, 3=SMS.'
  ,datzeit_nachricht_aktion                 COMMENT 'Zeitpunkt, an dem der Empfänger die Aktion_2 ausgeführt hat.'
  ,nachricht_aktion_typ_id                  COMMENT 'ID, die die Art_2 der ausgeführten Aktion_2 angibt, z. B. 1 = Link geklickt, 2 = Geöffnet, 3 = Feedback Loop.'
  ,personalisierte_url_name                 COMMENT 'Bezeichnung des Hyperlinks, auf den der Empfänger geklickt hat.'
  ,personalisierte_url_txt                  COMMENT 'Personalisierte URL des Hyperlinks, auf den der Empfänger geklickt hat.'
)
COMMENT = 'Diese Tabelle dient zur Erfassung von Details zu Nachrichtenaktionen. Derzeit enthält sie nur geklickte personalisierte URLs in Nachrichten.'
 AS 
    SELECT 
        mandant_id,
        nachricht_workflow_id,
        nachricht_vorlage_id,
        kommunikationskanal_id,
        datzeit_nachricht_aktion,
        nachricht_aktion_typ_id,
        personalisierte_url_name,
        personalisierte_url_txt

FROM DBP_DATA.KAMPAGNE_NACHRICHT_AKTION_DETAIL_2 ;