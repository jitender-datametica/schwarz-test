CREATE OR REPLACE VIEW kfl_production_dbp_view.v_kampagne_nachricht_vorlage_2 (mandant_id
OPTIONS(description='Mandant_2 im DWH.'), nachricht_vorlage_id
OPTIONS(description='Vom Quellsystem generierte ID der Nachrichtenvorlage (GUID).'), kommunikationskanal_id
OPTIONS(description='Kennung des Kommunikationskanals, für den die Nachrichtenvorlage bestimmt ist, z. B. 1=E-Mail, 2=Push-Benachrichtigung, 3=SMS.'),
nachricht_vorlage_name
OPTIONS(description='Technische Beschreibung für die Nachrichtenvorlage; es handelt sich um einen internen Namen für den Fachbereich.'),
nachricht_vorlage_titel_txt
OPTIONS(description='Titel der Nachrichtenvorlage, z. B. Betreff einer E-Mail. Gilt nur für E-Mail und Push-Benachrichtigung.'),
nachricht_vorlage_subtitel_txt
OPTIONS(description='Untertitel der Nachrichtenvorlage. Sie wird nur für Push-Benachrichtigungen befüllt.'),
nachricht_vorlage_txt
OPTIONS(description='Text der Nachrichtenvorlage. Es handelt sich um die Vorschau für E-Mails und die Nachricht für Push-Benachrichtigungen und SMS.'),
nachricht_vorlage_url_txt
OPTIONS(description='In-App-Navigation Link-URL, die in der Nachrichtenvorlage enthalten sein soll. Sie wird nur für Push-Benachrichtigungen befüllt.'),
nachricht_vorlage_bild_id
OPTIONS(description='Kennung des Bildes, das in der Nachrichtenvorlage verwendet werden soll. Sie wird nur für Push-Benachrichtigungen befüllt.'),
nachricht_subvorlage_txt
OPTIONS(description='Semi-strukturierter Text, der die möglichen Varianten der Subvorlage einer Vorlage enthält. Die tatsächlich verwendeten Varianten stehen als Liste in der Nachricht.'))
OPTIONS(DESCRIPTION = `DIE TABELLE ENTHÄLT WIEDERVERWENDBARE VORLAGEN FÜR MARKETINGBOTSCHAFTEN, DIE IN VERSCHIEDENEN KOMMUNIKATIONSKANÄLEN WIE E-MAIL, PUSH-BENACHRICHTIGUNGEN UND SMS VERWENDET WERDEN KÖNNEN.`)
AS SELECT mandant_id,
 nachricht_vorlage_id,
 kommunikationskanal_id,
 nachricht_vorlage_name,
 nachricht_vorlage_titel_txt,
 nachricht_vorlage_subtitel_txt,
 nachricht_vorlage_txt,
 nachricht_vorlage_url_txt,
 nachricht_vorlage_bild_id,
 nachricht_subvorlage_txt
FROM kfl_production_dbp_data.kampagne_nachricht_vorlage_2;