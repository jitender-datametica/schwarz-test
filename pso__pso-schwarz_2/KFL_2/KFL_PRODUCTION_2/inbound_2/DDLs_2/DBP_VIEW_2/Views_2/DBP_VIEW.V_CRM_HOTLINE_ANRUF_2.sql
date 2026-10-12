CREATE OR REPLACE VIEW DBP_VIEW.V_CRM_HOTLINE_ANRUF_2 (
   mandant_id                               COMMENT 'Mandant_2 im DWH'
  ,crm_hotline_bereich_id                   COMMENT 'ID des Bereichs innerhalb der CRM-Hotline, an den der Anruf zugestellt wurde. Dieser Wert kategorisiert, welche Abteilung oder welches Team den Anruf entgegengenommen hat.'
  ,dat_anruf                                COMMENT 'Anlagedatum des Tickets'
  ,anz_anruf                                COMMENT 'Anzahl der Anrufe.'
  ,anz_angenommen                           COMMENT 'Anzahl der Angenommene Anrufe.'
  ,anz_aufgelegt                            COMMENT 'Anzahl der Aufgelegte Anrufe.'
  ,anz_wartend                              COMMENT 'Anzahl der Anrufe die auf Wartend gesetzt würden.'
  ,anz_angenommen_unter_25_sek              COMMENT 'Anzahl der Anrufe, wo die Gesprächsdauer unter 25 Sekunden war.'
  ,anz_angenommen_ueber_25_sek              COMMENT 'Anzahl der Anrufe, wo die Gesprächsdauer über 25 Sekunden war.'
  ,zeit_durchschnitt_wartezeit              COMMENT 'Durchschnittliche Wartezeit bis den Anruf angenommen würde.'
  ,zeit_durchschnitt_wartezeit_vor_auflegen COMMENT 'Durchschnittliche Wartezeit bis den Anruf aufgelegt würde.'
  ,zeit_durchschnitt_gespraech              COMMENT 'Durchschnittliche Gesprächsdauer von Anruf.'
  ,zeit_durchschnitt_nachbearbeitung        COMMENT 'Durchschnittliche Erfassungszeit von Ticket ins System.'
  ,prz_servicelevel                         COMMENT 'Prozentsatz der innerhalb eines definierten Zeitraums angenommenen Anrufe. Er berechnet sich im Quellsystem.'
)
COMMENT = 'Diese Tabelle erfasst detaillierte Kennzahlen zu Callcenter-Anrufen auf der Ebene Mandant_2, Bereiche und Anlagedatum. Die Tabelle speichert die Anzahl der Anrufe, angenommene, aufgelegte und wartende Anrufe. Diese Daten ermöglichen eine_2 umfassende Bewertung der Callcenter-Performance und Erreichbarkeit. Die Daten für Anrufe aus Deutschland stammen von dem System ''Voxtron'' und die Anrufe aus anderen Ländern über ''Telekom'' erfasst werden.  Dort gibt es nur eine_2 Telefonnummer, und der Kunde wird zu den entsprechenden Kollegen in den Bereichen weitergeleitet.'
 AS 
    SELECT 
        mandant_id,
        crm_hotline_bereich_id,
        dat_anruf,
        anz_anruf,
        anz_angenommen,
        anz_aufgelegt,
        anz_wartend,
        anz_angenommen_unter_25_sek,
        anz_angenommen_ueber_25_sek,
        zeit_durchschnitt_wartezeit,
        zeit_durchschnitt_wartezeit_vor_auflegen,
        zeit_durchschnitt_gespraech,
        zeit_durchschnitt_nachbearbeitung,
        prz_servicelevel

FROM DBP_DATA.CRM_HOTLINE_ANRUF_2 ;