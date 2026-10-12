--==============================================================
-- Table: crm_hotline_anruf_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: crm_hotline_anruf_2
   generated from Powerdesigner on Dienstag, 20. Mai 2025 16:10:45
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.CRM_HOTLINE_ANRUF_2 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_2 im DWH',
   crm_hotline_bereich_id              INTEGER     NOT NULL COMMENT 'ID des Bereichs innerhalb der CRM-Hotline, an den der Anruf zugestellt wurde. Dieser Wert kategorisiert, welche Abteilung oder welches Team den Anruf entgegengenommen hat.',
   dat_anruf                           DATE             NOT NULL COMMENT 'Anlagedatum des Tickets',
   anz_anruf                           INTEGER     COMMENT 'Anzahl der Anrufe.',
   anz_angenommen                      INTEGER     COMMENT 'Anzahl der Angenommene Anrufe.',
   anz_aufgelegt                       INTEGER     COMMENT 'Anzahl der Aufgelegte Anrufe.',
   anz_wartend                         INTEGER     COMMENT 'Anzahl der Anrufe die auf Wartend gesetzt würden.',
   anz_angenommen_unter_25_sek         INTEGER     COMMENT 'Anzahl der Anrufe, wo die Gesprächsdauer unter 25 Sekunden war.',
   anz_angenommen_ueber_25_sek         INTEGER     COMMENT 'Anzahl der Anrufe, wo die Gesprächsdauer über 25 Sekunden war.',
   zeit_durchschnitt_wartezeit         TIME(0)          COMMENT 'Durchschnittliche Wartezeit bis den Anruf angenommen würde.',
   zeit_durchschnitt_wartezeit_vor_auflegen TIME(0)          COMMENT 'Durchschnittliche Wartezeit bis den Anruf aufgelegt würde.',
   zeit_durchschnitt_gespraech         TIME(0)          COMMENT 'Durchschnittliche Gesprächsdauer von Anruf.',
   zeit_durchschnitt_nachbearbeitung   TIME(0)          COMMENT 'Durchschnittliche Erfassungszeit von Ticket ins System.',
   prz_servicelevel                    NUMBER(29,1)     COMMENT 'Prozentsatz der innerhalb eines definierten Zeitraums angenommenen Anrufe. Er berechnet sich im Quellsystem.',
   prz_erreichbarkeit                  NUMBER(29,1)     COMMENT 'Es zeigt die Anrufannahmequote in Prozent für die relevanten Hotline_bereiche. Sie quantifiziert das Verhältnis zwischen der Anzahl angenommener Anrufe und der Gesamtzahl der Anrufe.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_CRM_HOTLINE_ANRUF PRIMARY KEY (mandant_id, dat_anruf, crm_hotline_bereich_id) NOT ENFORCED
)  COMMENT = 'Diese Tabelle erfasst detaillierte Kennzahlen zu Callcenter-Anrufen auf der Ebene Mandant_2, Bereiche und Anlagedatum. Die Tabelle speichert die Anzahl der Anrufe, angenommene, aufgelegte und wartende Anrufe. Diese Daten ermöglichen eine_2 umfassende Bewertung der Callcenter-Performance und Erreichbarkeit. Die Daten für Anrufe aus Deutschland stammen von dem System ''Voxtron'' und die Anrufe aus anderen Ländern über ''Telekom'' erfasst werden.  Dort gibt es nur eine_2 Telefonnummer, und der Kunde wird zu den entsprechenden Kollegen in den Bereichen weitergeleitet.';
