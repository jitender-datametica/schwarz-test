CREATE OR REPLACE TABLE kfl_production_dbp_data.kampagne_nachricht_vorlage_1 (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant_1 im DWH.'),
nachricht_vorlage_id STRING(100) NOT NULL
OPTIONS(description='Vom Quellsystem generierte ID der Nachrichtenvorlage (GUID).'),
kommunikationskanal_id INTEGER NOT NULL
OPTIONS(description='Kennung des Kommunikationskanals, für den die Nachrichtenvorlage bestimmt ist, z. B. 1=E-Mail, 2=Push-Benachrichtigung, 3=SMS.'),
nachricht_vorlage_name STRING(500)
OPTIONS(description='Technische Beschreibung für die Nachrichtenvorlage; es handelt sich um einen internen Namen für den Fachbereich.'),
nachricht_vorlage_titel_txt STRING(4000)
OPTIONS(description='Titel der Nachrichtenvorlage, z. B. Betreff einer E-Mail. Gilt nur für E-Mail und Push-Benachrichtigung.'),
nachricht_vorlage_subtitel_txt STRING(500)
OPTIONS(description='Untertitel der Nachrichtenvorlage. Sie wird nur für Push-Benachrichtigungen befüllt.'),
nachricht_vorlage_txt STRING(4000)
OPTIONS(description='Text der Nachrichtenvorlage. Es handelt sich um die Vorschau für E-Mails und die Nachricht für Push-Benachrichtigungen und SMS.'),
nachricht_vorlage_url_txt STRING(2000)
OPTIONS(description='In-App-Navigation Link-URL, die in der Nachrichtenvorlage enthalten sein soll. Sie wird nur für Push-Benachrichtigungen befüllt.'),
nachricht_vorlage_bild_id STRING(100)
OPTIONS(description='Kennung des Bildes, das in der Nachrichtenvorlage verwendet werden soll. Sie wird nur für Push-Benachrichtigungen befüllt.'),
nachricht_subvorlage_txt STRING(500000)
OPTIONS(description='Semi-strukturierter Text, der die möglichen Varianten der Subvorlage einer Vorlage enthält. Die tatsächlich verwendeten Varianten stehen als Liste in der Nachricht.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, nachricht_vorlage_id, kommunikationskanal_id) NOT ENFORCED
)
OPTIONS(description='Die Tabelle enthält wiederverwendbare Vorlagen für Marketingbotschaften, die in verschiedenen Kommunikationskanälen wie E-Mail, Push-Benachrichtigungen und SMS verwendet werden können.');