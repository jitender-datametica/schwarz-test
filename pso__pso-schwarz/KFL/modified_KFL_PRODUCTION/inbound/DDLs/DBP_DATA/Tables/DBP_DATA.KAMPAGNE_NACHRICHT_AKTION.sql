--==============================================================
-- Table: kampagne_nachricht_aktion
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: kampagne_nachricht_aktion
   generated from Powerdesigner on Samstag, 12. Oktober 2024 16:01:47
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.KAMPAGNE_NACHRICHT_AKTION (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH.',
   nachricht_workflow_id               VARCHAR(100)     NOT NULL COMMENT 'ID des Workflows, der die Interaktionen zum Kunde in einer Kampagne verarbeitet.',
   nachricht_vorlage_id                VARCHAR(100)     NOT NULL COMMENT 'Eindeutige Kennung der verwendeten Nachrichtenvorlage.',
   kommunikationskanal_id              INTEGER     NOT NULL COMMENT 'Kennung des Kommunikationskanals, über den die Nachricht versendet wurde, z. B. 1=E-Mail, 2=Push-Benachrichtigung, 3=SMS.',
   datzeit_nachricht_aktion            TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitpunkt, an dem der Empfänger die Aktion ausgeführt hat.',
   nachricht_aktion_typ_id             INTEGER     NOT NULL COMMENT 'ID, die die Art der ausgeführten Aktion angibt. 1 = Gesendet 2 = Blockiert 3 = Zugestellt 4 = Bounced 5 = Geöffnet 6 = Feedback Loop 7 = Link geklicked.',
   kampagne_id                         VARCHAR(100)     NOT NULL COMMENT 'Eindeutige Kennung der Kampagne, innerhalb derer die personalisierte Nachricht gesendet wird.',
   kampagne_kunde_id                   VARCHAR(100)     NOT NULL DEFAULT '-1' COMMENT 'Eindeutige Kennung des Kunden, an den die Nachricht gesendet wurde. Nicht alle Quelltabellen enthalten diese Information und müssen aus anderen Quelltabellen gefüllt werden, daher bedeutet ''-1'', dass kein passender Kunde gefunden wurde.',
   blockiert_typ_name                  VARCHAR(200)     COMMENT 'Kennzeichen, das den Grund für die Blockierung angibt, z. B. invalid-domain (für E-Mail), NoDeviceRegistration (für Push-Benachrichtigung).',
   bounce_typ_name                     VARCHAR(100)     COMMENT 'Kennzeichen, das den Grund für den Zustellfehler angibt, z. B. Hard, Soft. Hard-Bounces sind dauerhafte Zustellfehler, die in der Regel durch ungültige oder nicht mehr existierende E-Mail-Adressen verursacht werden. Soft-Bounces sind temporäre Zustellfehler, die meist durch vorübergehende Probleme auf der Empfängerseite verursacht werden, z.B. volle Postfächer. Ein Block-Bounce. wenn die Nachricht zugestellt und bounced ist, wird auch als Soft-Bounce eingeordnet.',
   zugestellt_fg                       INTEGER     COMMENT 'Flag, das anzeigt, ob eine Nachricht erfolgreich zugestellt wurde. In einigen Fällen kann eine zugestellte Nachricht wieder als nicht zugestellt gekennzeichnet werden. Für Aggregate sollte nur zugestellt_fg=1 gezählt werden.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_KAMPAGNE_NACHRICHT_AKTION PRIMARY KEY (mandant_id, nachricht_workflow_id, nachricht_vorlage_id, kommunikationskanal_id, datzeit_nachricht_aktion, nachricht_aktion_typ_id) NOT ENFORCED
)  COMMENT = 'Diese Tabelle enthält alle Aktionen, die in Bezug auf eine Kampagnennachricht aufgetreten sind. Jede Aktion (z. B. Senden, Blockieren, Zustellen, Öffnen, Klicken, usw.) wird hier gespeichert.';
