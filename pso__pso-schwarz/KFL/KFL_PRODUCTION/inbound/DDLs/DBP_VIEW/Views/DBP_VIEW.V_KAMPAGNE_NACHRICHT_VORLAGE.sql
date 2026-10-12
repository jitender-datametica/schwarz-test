CREATE OR REPLACE VIEW DBP_VIEW.V_KAMPAGNE_NACHRICHT_VORLAGE (
   mandant_id                               COMMENT 'Mandant im DWH.'
  ,nachricht_vorlage_id                     COMMENT 'Vom Quellsystem generierte ID der Nachrichtenvorlage (GUID).'
  ,kommunikationskanal_id                   COMMENT 'Kennung des Kommunikationskanals, für den die Nachrichtenvorlage bestimmt ist, z. B. 1=E-Mail, 2=Push-Benachrichtigung, 3=SMS.'
  ,nachricht_vorlage_name                   COMMENT 'Technische Beschreibung für die Nachrichtenvorlage; es handelt sich um einen internen Namen für den Fachbereich.'
  ,nachricht_vorlage_titel_txt              COMMENT 'Titel der Nachrichtenvorlage, z. B. Betreff einer E-Mail. Gilt nur für E-Mail und Push-Benachrichtigung.'
  ,nachricht_vorlage_subtitel_txt           COMMENT 'Untertitel der Nachrichtenvorlage. Sie wird nur für Push-Benachrichtigungen befüllt.'
  ,nachricht_vorlage_txt                    COMMENT 'Text der Nachrichtenvorlage. Es handelt sich um die Vorschau für E-Mails und die Nachricht für Push-Benachrichtigungen und SMS.'
  ,nachricht_vorlage_url_txt                COMMENT 'In-App-Navigation Link-URL, die in der Nachrichtenvorlage enthalten sein soll. Sie wird nur für Push-Benachrichtigungen befüllt.'
  ,nachricht_vorlage_bild_id                COMMENT 'Kennung des Bildes, das in der Nachrichtenvorlage verwendet werden soll. Sie wird nur für Push-Benachrichtigungen befüllt.'
  ,nachricht_subvorlage_txt                 COMMENT 'Semi-strukturierter Text, der die möglichen Varianten der Subvorlage einer Vorlage enthält. Die tatsächlich verwendeten Varianten stehen als Liste in der Nachricht.'
)
COMMENT = 'Die Tabelle enthält wiederverwendbare Vorlagen für Marketingbotschaften, die in verschiedenen Kommunikationskanälen wie E-Mail, Push-Benachrichtigungen und SMS verwendet werden können.'
 AS 
    SELECT 
        mandant_id,
        nachricht_vorlage_id,
        kommunikationskanal_id,
        nachricht_vorlage_name,
        nachricht_vorlage_titel_txt,
        nachricht_vorlage_subtitel_txt,
        nachricht_vorlage_txt,
        nachricht_vorlage_url_txt,
        nachricht_vorlage_bild_id,
        nachricht_subvorlage_txt

FROM DBP_DATA.KAMPAGNE_NACHRICHT_VORLAGE ;