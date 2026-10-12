create or replace TABLE KFL_PRODUCTION.DBP_DATA.KAMPAGNE_NACHRICHT_VORLAGE (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant im DWH.',
	NACHRICHT_VORLAGE_ID VARCHAR(100) NOT NULL COMMENT 'Vom Quellsystem generierte ID der Nachrichtenvorlage (GUID).',
	KOMMUNIKATIONSKANAL_ID NUMBER(38,0) NOT NULL COMMENT 'Kennung des Kommunikationskanals, für den die Nachrichtenvorlage bestimmt ist, z. B. 1=E-Mail, 2=Push-Benachrichtigung, 3=SMS.',
	NACHRICHT_VORLAGE_NAME VARCHAR(500) COMMENT 'Technische Beschreibung für die Nachrichtenvorlage; es handelt sich um einen internen Namen für den Fachbereich.',
	NACHRICHT_VORLAGE_TITEL_TXT VARCHAR(4000) COMMENT 'Titel der Nachrichtenvorlage, z. B. Betreff einer E-Mail. Gilt nur für E-Mail und Push-Benachrichtigung.',
	NACHRICHT_VORLAGE_SUBTITEL_TXT VARCHAR(500) COMMENT 'Untertitel der Nachrichtenvorlage. Sie wird nur für Push-Benachrichtigungen befüllt.',
	NACHRICHT_VORLAGE_TXT VARCHAR(4000) COMMENT 'Text der Nachrichtenvorlage. Es handelt sich um die Vorschau für E-Mails und die Nachricht für Push-Benachrichtigungen und SMS.',
	NACHRICHT_VORLAGE_URL_TXT VARCHAR(2000) COMMENT 'In-App-Navigation Link-URL, die in der Nachrichtenvorlage enthalten sein soll. Sie wird nur für Push-Benachrichtigungen befüllt.',
	NACHRICHT_VORLAGE_BILD_ID VARCHAR(100) COMMENT 'Kennung des Bildes, das in der Nachrichtenvorlage verwendet werden soll. Sie wird nur für Push-Benachrichtigungen befüllt.',
	NACHRICHT_SUBVORLAGE_TXT VARCHAR(500000) COMMENT 'Semi-strukturierter Text, der die möglichen Varianten der Subvorlage einer Vorlage enthält. Die tatsächlich verwendeten Varianten stehen als Liste in der Nachricht.',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_KAMPAGNE_NACHRICHT_VORLAGE primary key (MANDANT_ID, NACHRICHT_VORLAGE_ID, KOMMUNIKATIONSKANAL_ID)
)COMMENT='Die Tabelle enthält wiederverwendbare Vorlagen für Marketingbotschaften, die in verschiedenen Kommunikationskanälen wie E-Mail, Push-Benachrichtigungen und SMS verwendet werden können.'
;