create or replace TABLE KFL_PRODUCTION.DBP_DATA.KAMPAGNE_NACHRICHT_AKTION_2 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_2 im DWH.',
	NACHRICHT_WORKFLOW_ID VARCHAR(100) NOT NULL COMMENT 'ID des Workflows, der die Interaktionen zum Kunde in einer Kampagne_2 verarbeitet.',
	NACHRICHT_VORLAGE_ID VARCHAR(100) NOT NULL COMMENT 'Eindeutige Kennung der verwendeten Nachrichtenvorlage.',
	KOMMUNIKATIONSKANAL_ID NUMBER(38,0) NOT NULL COMMENT 'Kennung des Kommunikationskanals, über den die Nachricht versendet wurde, z. B. 1=E-Mail, 2=Push-Benachrichtigung, 3=SMS.',
	DATZEIT_NACHRICHT_AKTION TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitpunkt, an dem der Empfänger die Aktion_2 ausgeführt hat.',
	NACHRICHT_AKTION_TYP_ID NUMBER(38,0) NOT NULL COMMENT 'ID, die die Art_2 der ausgeführten Aktion_2 angibt. 1 = Gesendet 2 = Blockiert 3 = Zugestellt 4 = Bounced 5 = Geöffnet 6 = Feedback Loop 7 = Link geklicked.',
	KAMPAGNE_ID VARCHAR(100) NOT NULL COMMENT 'Eindeutige Kennung der Kampagne_2, innerhalb derer die personalisierte Nachricht gesendet wird.',
	KAMPAGNE_KUNDE_ID VARCHAR(100) NOT NULL DEFAULT '-1' COMMENT 'Eindeutige Kennung des Kunden, an den die Nachricht gesendet wurde. Nicht alle Quelltabellen enthalten diese Information und müssen aus anderen Quelltabellen gefüllt werden, daher bedeutet ''-1'', dass kein passender Kunde gefunden wurde.',
	BLOCKIERT_TYP_NAME VARCHAR(200) COMMENT 'Kennzeichen, das den Grund für die Blockierung angibt, z. B. invalid-domain (für E-Mail), NoDeviceRegistration (für Push-Benachrichtigung).',
	BOUNCE_TYP_NAME VARCHAR(100) COMMENT 'Kennzeichen, das den Grund für den Zustellfehler angibt, z. B. Hard, Soft. Hard-Bounces sind dauerhafte Zustellfehler, die in der Regel durch ungültige oder nicht mehr existierende E-Mail-Adressen verursacht werden. Soft-Bounces sind temporäre_2 Zustellfehler, die meist durch vorübergehende Probleme auf der Empfängerseite verursacht werden, z.B. volle Postfächer. Ein Block-Bounce. wenn die Nachricht zugestellt und bounced ist, wird auch als Soft-Bounce eingeordnet.',
	ZUGESTELLT_FG NUMBER(38,0) COMMENT 'Flag, das anzeigt, ob eine_2 Nachricht erfolgreich zugestellt wurde. In einigen Fällen kann eine_2 zugestellte Nachricht wieder als nicht zugestellt gekennzeichnet werden. Für Aggregate sollte nur zugestellt_fg=1 gezählt werden.',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_KAMPAGNE_NACHRICHT_AKTION primary key (MANDANT_ID, NACHRICHT_WORKFLOW_ID, NACHRICHT_VORLAGE_ID, KOMMUNIKATIONSKANAL_ID, DATZEIT_NACHRICHT_AKTION, NACHRICHT_AKTION_TYP_ID)
)COMMENT='Diese Tabelle enthält alle Aktionen, die in Bezug auf eine_2 Kampagnennachricht aufgetreten sind. Jede Aktion_2 (z. B. Senden, Blockieren, Zustellen, Öffnen, Klicken, usw.) wird hier gespeichert.'
;