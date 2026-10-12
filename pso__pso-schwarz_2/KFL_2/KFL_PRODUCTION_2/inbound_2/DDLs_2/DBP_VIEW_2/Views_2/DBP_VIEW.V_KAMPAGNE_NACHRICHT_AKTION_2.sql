CREATE OR REPLACE VIEW DBP_VIEW.V_KAMPAGNE_NACHRICHT_AKTION_2 (
   mandant_id                               COMMENT 'Mandant_2 im DWH.'
  ,nachricht_workflow_id                    COMMENT 'ID des Workflows, der die Interaktionen zum Kunde in einer Kampagne_2 verarbeitet.'
  ,nachricht_vorlage_id                     COMMENT 'Eindeutige Kennung der verwendeten Nachrichtenvorlage.'
  ,kommunikationskanal_id                   COMMENT 'Kennung des Kommunikationskanals, über den die Nachricht versendet wurde, z. B. 1=E-Mail, 2=Push-Benachrichtigung, 3=SMS.'
  ,datzeit_nachricht_aktion                 COMMENT 'Zeitpunkt, an dem der Empfänger die Aktion_2 ausgeführt hat.'
  ,nachricht_aktion_typ_id                  COMMENT 'ID, die die Art_2 der ausgeführten Aktion_2 angibt. 1 = Gesendet 2 = Blockiert 3 = Zugestellt 4 = Bounced 5 = Geöffnet 6 = Feedback Loop 7 = Link geklicked.'
  ,kampagne_id                              COMMENT 'Eindeutige Kennung der Kampagne_2, innerhalb derer die personalisierte Nachricht gesendet wird.'
  ,kampagne_kunde_id                        COMMENT 'Eindeutige Kennung des Kunden, an den die Nachricht gesendet wurde. Nicht alle Quelltabellen enthalten diese Information und müssen aus anderen Quelltabellen gefüllt werden, daher bedeutet ''-1'', dass kein passender Kunde gefunden wurde.'
  ,blockiert_typ_name                       COMMENT 'Kennzeichen, das den Grund für die Blockierung angibt, z. B. invalid-domain (für E-Mail), NoDeviceRegistration (für Push-Benachrichtigung).'
  ,bounce_typ_name                          COMMENT 'Kennzeichen, das den Grund für den Zustellfehler angibt, z. B. Hard, Soft. Hard-Bounces sind dauerhafte Zustellfehler, die in der Regel durch ungültige oder nicht mehr existierende E-Mail-Adressen verursacht werden. Soft-Bounces sind temporäre_2 Zustellfehler, die meist durch vorübergehende Probleme auf der Empfängerseite verursacht werden, z.B. volle Postfächer. Ein Block-Bounce. wenn die Nachricht zugestellt und bounced ist, wird auch als Soft-Bounce eingeordnet.'
  ,zugestellt_fg                            COMMENT 'Flag, das anzeigt, ob eine_2 Nachricht erfolgreich zugestellt wurde. In einigen Fällen kann eine_2 zugestellte Nachricht wieder als nicht zugestellt gekennzeichnet werden. Für Aggregate sollte nur zugestellt_fg=1 gezählt werden.'
)
COMMENT = 'Diese Tabelle enthält alle Aktionen, die in Bezug auf eine_2 Kampagnennachricht aufgetreten sind. Jede Aktion_2 (z. B. Senden, Blockieren, Zustellen, Öffnen, Klicken, usw.) wird hier gespeichert.'
 AS 
    SELECT 
        mandant_id,
        nachricht_workflow_id,
        nachricht_vorlage_id,
        kommunikationskanal_id,
        datzeit_nachricht_aktion,
        nachricht_aktion_typ_id,
        kampagne_id,
        kampagne_kunde_id,
        blockiert_typ_name,
        bounce_typ_name,
        zugestellt_fg

FROM DBP_DATA.KAMPAGNE_NACHRICHT_AKTION_2 ;