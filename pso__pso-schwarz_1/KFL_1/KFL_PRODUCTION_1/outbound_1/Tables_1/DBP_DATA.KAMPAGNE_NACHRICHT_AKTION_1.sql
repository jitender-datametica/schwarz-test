--==============================================================
-- Table: kampagne_nachricht_aktion_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: kampagne_nachricht_aktion_1
   generated from Powerdesigner on Samstag, 12. Oktober 2024 16:01:47
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.kampagne_nachricht_aktion_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH.'),
nachricht_workflow_id STRING(100) NOT NULL
OPTIONS(description='ID des Workflows, der die Interaktionen zum Kunde in einer Kampagne_1 verarbeitet.'),
nachricht_vorlage_id STRING(100) NOT NULL OPTIONS(description='Eindeutige Kennung der verwendeten Nachrichtenvorlage.'),
kommunikationskanal_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Kennung des Kommunikationskanals, über den die Nachricht versendet wurde, z. B. 1=E-Mail, 2=Push-Benachrichtigung, 3=SMS.'),
datzeit_nachricht_aktion TIMESTAMP NOT NULL
OPTIONS(description='Zeitpunkt, an dem der Empfänger die Aktion_1 ausgeführt hat.'),
nachricht_aktion_typ_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='ID, die die Art_1 der ausgeführten Aktion_1 angibt. 1 = Gesendet 2 = Blockiert 3 = Zugestellt 4 = Bounced 5 = Geöffnet 6 = Feedback Loop 7 = Link geklicked.'),
kampagne_id STRING(100) NOT NULL
OPTIONS(description='Eindeutige Kennung der Kampagne_1, innerhalb derer die personalisierte Nachricht gesendet wird.'),
kampagne_kunde_id STRING(100) DEFAULT '-1' NOT NULL
OPTIONS(description='Eindeutige Kennung des Kunden, an den die Nachricht gesendet wurde. Nicht alle Quelltabellen enthalten diese Information und müssen aus anderen Quelltabellen gefüllt werden, daher bedeutet\'-1\', dass kein passender Kunde gefunden wurde.'),
blockiert_typ_name STRING(200)
OPTIONS(description='Kennzeichen, das den Grund für die Blockierung angibt, z. B. invalid-domain (für E-Mail), NoDeviceRegistration (für Push-Benachrichtigung).'),
bounce_typ_name STRING(100)
OPTIONS(description='Kennzeichen, das den Grund für den Zustellfehler angibt, z. B. Hard, Soft. Hard-Bounces sind dauerhafte Zustellfehler, die in der Regel durch ungültige oder nicht mehr existierende E-Mail-Adressen verursacht werden. Soft-Bounces sind temporäre_1 Zustellfehler, die meist durch vorübergehende Probleme auf der Empfängerseite verursacht werden, z.B. volle Postfächer. Ein Block-Bounce. wenn die Nachricht zugestellt und bounced ist, wird auch als Soft-Bounce eingeordnet.'),
zugestellt_fg BIGNUMERIC(38,0)
OPTIONS(description='Flag, das anzeigt, ob eine_1 Nachricht erfolgreich zugestellt wurde. In einigen Fällen kann eine_1 zugestellte Nachricht wieder als nicht zugestellt gekennzeichnet werden. Für Aggregate sollte nur zugestellt_fg=1 gezählt werden.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, nachricht_workflow_id, nachricht_vorlage_id, kommunikationskanal_id, datzeit_nachricht_aktion,
 nachricht_aktion_typ_id) NOT ENFORCED
)
OPTIONS(description='Diese Tabelle enthält alle Aktionen, die in Bezug auf eine_1 Kampagnennachricht aufgetreten sind. Jede Aktion_1 (z. B. Senden, Blockieren, Zustellen, Öffnen, Klicken, usw.) wird hier gespeichert.');