--==============================================================
-- Table: kampagne_nachricht_vorlage_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: kampagne_nachricht_vorlage_1
   generated from Powerdesigner on Samstag, 12. Oktober 2024 16:01:47
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.KAMPAGNE_NACHRICHT_VORLAGE_1 (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_1 im DWH.',
   nachricht_vorlage_id                VARCHAR(100)     NOT NULL COMMENT 'Vom Quellsystem generierte ID der Nachrichtenvorlage (GUID).',
   kommunikationskanal_id              NUMBER(38,0)     NOT NULL COMMENT 'Kennung des Kommunikationskanals, für den die Nachrichtenvorlage bestimmt ist, z. B. 1=E-Mail, 2=Push-Benachrichtigung, 3=SMS.',
   nachricht_vorlage_name              VARCHAR(500)     COMMENT 'Technische Beschreibung für die Nachrichtenvorlage; es handelt sich um einen internen Namen für den Fachbereich.',
   nachricht_vorlage_titel_txt         VARCHAR(4000)    COMMENT 'Titel der Nachrichtenvorlage, z. B. Betreff einer E-Mail. Gilt nur für E-Mail und Push-Benachrichtigung.',
   nachricht_vorlage_subtitel_txt      VARCHAR(500)     COMMENT 'Untertitel der Nachrichtenvorlage. Sie wird nur für Push-Benachrichtigungen befüllt.',
   nachricht_vorlage_txt               VARCHAR(4000)    COMMENT 'Text der Nachrichtenvorlage. Es handelt sich um die Vorschau für E-Mails und die Nachricht für Push-Benachrichtigungen und SMS.',
   nachricht_vorlage_url_txt           VARCHAR(2000)    COMMENT 'In-App-Navigation Link-URL, die in der Nachrichtenvorlage enthalten sein soll. Sie wird nur für Push-Benachrichtigungen befüllt.',
   nachricht_vorlage_bild_id           VARCHAR(100)     COMMENT 'Kennung des Bildes, das in der Nachrichtenvorlage verwendet werden soll. Sie wird nur für Push-Benachrichtigungen befüllt.',
   nachricht_subvorlage_txt            VARCHAR(500000)  COMMENT 'Semi-strukturierter Text, der die möglichen Varianten der Subvorlage einer Vorlage enthält. Die tatsächlich verwendeten Varianten stehen als Liste in der Nachricht.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_KAMPAGNE_NACHRICHT_VORLAGE PRIMARY KEY (mandant_id, nachricht_vorlage_id, kommunikationskanal_id) NOT ENFORCED
)  COMMENT = 'Die Tabelle enthält wiederverwendbare Vorlagen für Marketingbotschaften, die in verschiedenen Kommunikationskanälen wie E-Mail, Push-Benachrichtigungen und SMS verwendet werden können.';
