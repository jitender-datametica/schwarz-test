--==============================================================
-- Table: crm_hotline_anruf_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: crm_hotline_anruf_1
   generated from Powerdesigner on Dienstag, 20. Mai 2025 16:10:45
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.crm_hotline_anruf_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
crm_hotline_bereich_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='ID des Bereichs innerhalb der CRM-Hotline, an den der Anruf zugestellt wurde. Dieser Wert kategorisiert, welche Abteilung oder welches Team den Anruf entgegengenommen hat.'),
dat_anruf DATE NOT NULL OPTIONS(description='Anlagedatum des Tickets'),
anz_anruf BIGNUMERIC(38,0) OPTIONS(description='Anzahl der Anrufe.'),
anz_angenommen BIGNUMERIC(38,0) OPTIONS(description='Anzahl der Angenommene Anrufe.'),
anz_aufgelegt BIGNUMERIC(38,0) OPTIONS(description='Anzahl der Aufgelegte Anrufe.'),
anz_wartend BIGNUMERIC(38,0) OPTIONS(description='Anzahl der Anrufe die auf Wartend gesetzt würden.'),
anz_angenommen_unter_25_sek BIGNUMERIC(38,0)
OPTIONS(description='Anzahl der Anrufe, wo die Gesprächsdauer unter 25 Sekunden war.'),
anz_angenommen_ueber_25_sek BIGNUMERIC(38,0)
OPTIONS(description='Anzahl der Anrufe, wo die Gesprächsdauer über 25 Sekunden war.'),
zeit_durchschnitt_wartezeit TIME OPTIONS(description='Durchschnittliche Wartezeit bis den Anruf angenommen würde.'),
zeit_durchschnitt_wartezeit_vor_auflegen TIME
OPTIONS(description='Durchschnittliche Wartezeit bis den Anruf aufgelegt würde.'),
zeit_durchschnitt_gespraech TIME OPTIONS(description='Durchschnittliche Gesprächsdauer von Anruf.'),
zeit_durchschnitt_nachbearbeitung TIME OPTIONS(description='Durchschnittliche Erfassungszeit von Ticket ins System.'),
prz_servicelevel BIGNUMERIC(38,1)
OPTIONS(description='Prozentsatz der innerhalb eines definierten Zeitraums angenommenen Anrufe. Er berechnet sich im Quellsystem.'),
prz_erreichbarkeit BIGNUMERIC(38,1)
OPTIONS(description='Es zeigt die Anrufannahmequote in Prozent für die relevanten Hotline_bereiche. Sie quantifiziert das Verhältnis zwischen der Anzahl angenommener Anrufe und der Gesamtzahl der Anrufe.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, dat_anruf, crm_hotline_bereich_id) NOT ENFORCED
)
OPTIONS(description='Diese Tabelle erfasst detaillierte Kennzahlen zu Callcenter-Anrufen auf der Ebene Mandant_1, Bereiche und Anlagedatum. Die Tabelle speichert die Anzahl der Anrufe, angenommene, aufgelegte und wartende Anrufe. Diese Daten ermöglichen eine_1 umfassende Bewertung der Callcenter-Performance und Erreichbarkeit. Die Daten für Anrufe aus Deutschland stammen von dem System\'Voxtron\' und die Anrufe aus anderen Ländern über\'Telekom\' erfasst werden.  Dort gibt es nur eine_1 Telefonnummer, und der Kunde wird zu den entsprechenden Kollegen in den Bereichen weitergeleitet.');