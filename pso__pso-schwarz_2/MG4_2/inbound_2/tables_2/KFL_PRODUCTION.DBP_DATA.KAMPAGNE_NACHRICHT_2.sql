create or replace TABLE KFL_PRODUCTION.DBP_DATA.KAMPAGNE_NACHRICHT_2 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_2 im DWH.',
	NACHRICHT_WORKFLOW_ID VARCHAR(100) NOT NULL COMMENT 'ID des Workflows, der die Interaktionen zum Kunde in einer Kampagne_2 verarbeitet.',
	NACHRICHT_VORLAGE_ID VARCHAR(100) NOT NULL COMMENT 'Eindeutige Kennung der verwendeten Nachrichtenvorlage.',
	KOMMUNIKATIONSKANAL_ID NUMBER(38,0) NOT NULL COMMENT 'Kennung des Kommunikationskanals, über den die Nachricht versendet wurde, z. B. 1=E-Mail, 2=Push-Benachrichtigung, 3=SMS.',
	KAMPAGNE_ID VARCHAR(100) NOT NULL COMMENT 'Eindeutige Kennung der Kampagne_2, innerhalb derer die personalisierte Nachricht gesendet wird.',
	KAMPAGNE_KUNDE_ID VARCHAR(100) NOT NULL DEFAULT '-1' COMMENT 'Eindeutige Kennung des Kunden, an den die Nachricht gesendet wurde. Nicht alle Quelltabellen enthalten diese Information und müssen aus anderen Quelltabellen gefüllt werden, daher bedeutet ''-1'', dass kein passender Kunde gefunden wurde.',
	NACHRICHT_SUBVORLAGE_ID_LISTE_TXT VARCHAR(1000) COMMENT 'Enthält die Reihenfolge und IDs der verwendeten E-Mail-Subvorlagevarianten, z. B. \"2-null-2-2\", \"2-3\".',
	NACHRICHT_SUBVORLAGE_NAME_LISTE_TXT VARCHAR(4000) COMMENT 'Enthält die Reihenfolge und Namen zu den IDs der verwendeten E-Mail-Subvorlagevarianten, z. B. für \"2-null-2-3\" in nachricht_subvorlage_id_liste_txt könnte hier stehen \"Obst-default-Obst-Gemüse\".',
	EMAIL_DOMAIN_NAME VARCHAR(100) COMMENT 'Domain der E-Mail-Adresse des Empfängers.',
	BETRIEBSSYSTEM_NAME VARCHAR(100) COMMENT 'Betriebssystem des Mobilgeräts. Nur für Push-Benachrichtigungen.',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_KAMPAGNE_NACHRICHT primary key (MANDANT_ID, NACHRICHT_WORKFLOW_ID, NACHRICHT_VORLAGE_ID, KOMMUNIKATIONSKANAL_ID)
)COMMENT='Diese Tabelle enthält Details zu den gesendeten/blockierenden Nachrichten innerhalb einer Kampagne. Sie dient als Kopftabelle für alle gesendeten/blockierenden Nachrichten.'
;