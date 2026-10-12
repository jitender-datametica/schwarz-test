create or replace TABLE KFL_PRODUCTION.DBP_DATA.KAMPAGNE_NACHRICHT_AKTION_DETAIL (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant im DWH.',
	NACHRICHT_WORKFLOW_ID VARCHAR(100) NOT NULL COMMENT 'ID des Workflows, der die Interaktionen zum Kunde in einer Kampagne verarbeitet.',
	NACHRICHT_VORLAGE_ID VARCHAR(100) NOT NULL COMMENT 'Eindeutige Kennung der verwendeten Nachrichtenvorlage.',
	KOMMUNIKATIONSKANAL_ID NUMBER(38,0) NOT NULL COMMENT 'Kennung des Kommunikationskanals, über den die Nachricht versendet wurde, z. B. 1=E-Mail, 2=Push-Benachrichtigung, 3=SMS.',
	DATZEIT_NACHRICHT_AKTION TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitpunkt, an dem der Empfänger die Aktion ausgeführt hat.',
	NACHRICHT_AKTION_TYP_ID NUMBER(38,0) NOT NULL COMMENT 'ID, die die Art der ausgeführten Aktion angibt, z. B. 1 = Link geklickt, 2 = Geöffnet, 3 = Feedback Loop.',
	PERSONALISIERTE_URL_NAME VARCHAR(1000) NOT NULL COMMENT 'Bezeichnung des Hyperlinks, auf den der Empfänger geklickt hat.',
	PERSONALISIERTE_URL_TXT VARCHAR(1000) NOT NULL COMMENT 'Personalisierte URL des Hyperlinks, auf den der Empfänger geklickt hat.',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_KAMPAGNE_NACHRICHT_AKTION_DETAIL primary key (MANDANT_ID, NACHRICHT_WORKFLOW_ID, NACHRICHT_VORLAGE_ID, KOMMUNIKATIONSKANAL_ID, DATZEIT_NACHRICHT_AKTION, NACHRICHT_AKTION_TYP_ID, PERSONALISIERTE_URL_NAME, PERSONALISIERTE_URL_TXT)
)COMMENT='Diese Tabelle dient zur Erfassung von Details zu Nachrichtenaktionen. Derzeit enthält sie nur geklickte personalisierte URLs in Nachrichten.'
;